// Created by ihdl
module dsp_top (
               
               // Clock and resets
               CLK125,           // System Clock
               CLKXTAL,          // Crystal clock for sm interface
               RESET_DSP,        // Reset for DSP  
               RESET_SM,         // Reset for serial managment interface
               // Serial Managment Interface
               SM_ADDRESS,       // Input Address for SM interface        
               SM_DATA_WRITE,    // Input data for SM interface 
               SM_WRITE,         // Input write strobe for SM interface
               SM_DATA_READ,     // Output data from SM interface
              
               // Analog Equalizer interface
               ADC_TIMING,       // input for T/2 timing recovery
               AEQ_CNT,          // Output to control AEQ
               
               // Signal detection
               SIGDET,           // Output asserted when signal from ADC 
               
               // Timing recovery Interface
               TIMING_MODE,      // Input to select between T or 1/2T
               TIMING_DN,        // Output to Phase Interpolator 
               TIMING_UP,        // Output to Phase Interpolator 
              
               // ADC + Base Line wander control
               ADC,              // Input from ADC 
               WANDER_CNT,       // Output to ADC to keep average power zero
              
`ifdef SPW_COSIM
               //Monitor signals for SPW co-sim
               MSE_MONITOR, 
               ERROR_DFE_MONITOR, 
               DFE_UNSLICE_MONITOR,
`endif

               // Assorted signals
               BASEFX_DIS,       // Input to changer slice for FX
               MSE_GOOD,         // Output to indicate MSE threshold
               SLICE_OUT        // output from DFE
               



               
                );

   // Resets and Clocks
   input          CLK125;
   input          CLKXTAL;
   input          RESET_DSP;
   input          RESET_SM;
   input [5:0]    ADC;
   input [2:0]    ADC_TIMING;
   input          BASEFX_DIS;
   input [2:0]    SM_ADDRESS;
   input [15:0]   SM_DATA_WRITE;
   input          SM_WRITE;



   output [4:0]   AEQ_CNT;
   output         MSE_GOOD;
   output         SIGDET;
   output [1:0]   SLICE_OUT;
   output [15:0]  SM_DATA_READ;
   output         TIMING_DN;
   output         TIMING_MODE;
   output         TIMING_UP;
   output [6:0]   WANDER_CNT;


  
`ifdef SPW_COSIM  
  // monitor points added for SPW co-simulation
   output [7:0]   MSE_MONITOR;
   output [10:0]  ERROR_DFE_MONITOR;
   output [10:0]  DFE_UNSLICE_MONITOR;
`endif



   reg [5:0]     adc_d1;
   reg [2:0]     adc_timing_d1, adc_timing_d2, adc_timing_d3, adc_timing_d4;
   reg [2:0]     adc_timing_d5, adc_timing_d6;

   reg        reset_dsp_d1;
   reg        reset_dsp_d2;
   reg        reset_sigdet_d1;
   reg        reset_sigdet_d2;

   wire           fast_update;      // change dfe updates to fast
   wire           blw_reset;        // reset for base line wander
   wire  [5:0]    timing_unq;
   wire  [10:0]   dfe_unslice;      // unsliced output from dfe
   reg   [5:0]    dfe_unslice_clip; // note cliping for dfe
   wire  [2:0]    slice_scale;      // scalce out of dfe
   wire  [6:0]    error_pre_dfe;
   reg   [10:0]   error_wander;
   wire  [10:0]   error_dfe;
   wire           signal_detect;    // asserted when ADC signal is detected
   
   // Timing recovery
   wire           timing_up_i;      // used to control phase interpolator
   wire           timing_dn_i;      // used to control phase interpolator


   // Serial Managment registers
   wire  [15:0]     sm_reg0;  //read from DSP
   wire  [15:0]     sm_reg1;  //read from DSP
   wire  [15:0]     sm_reg2;  //read from DSP
   wire  [15:0]     sm_reg3;  //write to DSP
   wire  [15:0]     sm_reg4;  //write to DSP
   wire  [15:0]     sm_reg5;  //write to DSP

   // test outputs of DSP (reg0..2)
   wire [7:0]     sm_mse;
   wire [9:0]     sm_coef;

   // test inputs to DSP (reg3..6)
   wire        sm_aeq_force;
   wire [4:0]  sm_aeq_force_val;
   wire [2:0]  sm_aeq_offset;
   wire [4:0]  sm_aeq_threshold;
   wire        sm_wander_disable;
   wire        sm_sigdet_disable;
   wire        sm_ff_freeze;
   wire [2:0]  sm_ff_cursor_init;
   wire        sm_fb_freeze;
   wire [1:0]  sm_ff_mu;
   wire [1:0]  sm_fb_mu;
   wire [4:0]  sm_coef_sel;     //bit 4 selects ff vs. fb
   wire [7:0]  sm_mse_good_thresh;
   wire [2:0]  sm_timing_lpf_shift;
   wire        sm_timing_unq_sel;   // 0:take pre-dfe/2T phase det. design
                                    // 1:post_dfe/1T phase det. design
   wire        sm_timing_disable;
   wire        sm_timing_mode;
   wire        sm_force_timing_up;
   wire [1:0]  sm_wander_shift;
   wire        sm_reset_dsp;


   wire        TIMING_MODE;
   reg         aeq_converge_d1, aeq_converge_d2;
   reg         blw_en_d1, blw_en_d2;
   reg         basefx_dis_d1;
   reg         basefx_dis_d2;
   wire        reset_aeq;
   wire [5:0]  adc_dfedelay;
   wire        blw_disable;


`ifdef SPW_COSIM
   assign        MSE_MONITOR         = i_dsp_dfe.fb_tap_0;
   assign        MSE_MONITOR         = sm_mse;
   assign        ERROR_DFE_MONITOR   = error_dfe;
   assign        DFE_UNSLICE_MONITOR = dfe_unslice;
`endif



//----------------------------------------------------------------------------
//   Equalizer control block
//----------------------------------------------------------------------------

   dsp_ecb i_dsp_ecb( .CLK125(CLK125),
                      .RESET_DSP(RESET_DSP),
                      .BLW_EN(BLW_EN),
                      .AEQ_CONVERGE(AEQ_CONVERGE)
                    );



//----------------------------------------------------------------------------
//  Clock Synchronisation 
//----------------------------------------------------------------------------


      // Resync to local clock
  always @(posedge CLK125 or posedge RESET_DSP) 
    if (RESET_DSP)
      begin
        reset_dsp_d2      <= 1'b0;
        reset_dsp_d1      <= 1'b0;
        aeq_converge_d2   <= 1'b0;
        aeq_converge_d1   <= 1'b0;
        blw_en_d2         <= 1'b0;
        blw_en_d1         <= 1'b0;
        basefx_dis_d2     <= 1'b0;
        basefx_dis_d1     <= 1'b0;
      end
   else
      begin
        reset_dsp_d2      <= reset_dsp_d1;
        reset_dsp_d1      <= RESET_DSP | sm_reset_dsp;
        aeq_converge_d2   <= aeq_converge_d1;
        aeq_converge_d1   <= AEQ_CONVERGE;
        blw_en_d2         <= blw_en_d1;
        blw_en_d1         <= BLW_EN;
        basefx_dis_d2     <= basefx_dis_d1;
        basefx_dis_d1     <= BASEFX_DIS;
      end

   // Resync to local clock & delay
   always @(posedge CLK125 or posedge RESET_DSP) 
   
    if (RESET_DSP)
       begin
          adc_d1        <= 1'b0;
          adc_timing_d6 <= 1'b0;
          adc_timing_d5 <= 1'b0;
          adc_timing_d4 <= 1'b0;
          adc_timing_d3 <= 1'b0;
          adc_timing_d2 <= 1'b0;
          adc_timing_d1 <= 1'b0;
       end
    else
      begin
        adc_d1        <= ADC;
        adc_timing_d6 <= adc_timing_d5;
        adc_timing_d5 <= adc_timing_d4;
        adc_timing_d4 <= adc_timing_d3;
        adc_timing_d3 <= adc_timing_d2;
        adc_timing_d2 <= adc_timing_d1;
        adc_timing_d1 <= ADC_TIMING;
   end

//----------------------------------------------------------------------------
//   Error 
//----------------------------------------------------------------------------


   dsp_mse i_dsp_mse(  .ERROR            (error_dfe),
                       .CLK              (CLK125),
                       .RESET            (RESET_DSP),
                       .MSE_GOOD_THRESH  (sm_mse_good_thresh),
                       .MSE              (sm_mse),
                       .MSE_GOOD         (MSE_GOOD)
                    );


//----------------------------------------------------------------------------
//   Decision Feedback Equalizer 
//----------------------------------------------------------------------------

   // change to slow updates at same time
   // blw is enabled
   
   dsp_dfe i_dsp_dfe(.ADC              (ADC),
                     .CLK              (CLK125),
                     .RESET            (RESET_DSP),
                     .FAST_UPDATE      (!BLW_EN),
                     .ERROR_OUT        (error_dfe),
                     .SLICE_OUT        (SLICE_OUT),
                     .SLICE_SCALE_OUT  (slice_scale),
                     .UNSLICE_OUT      (dfe_unslice),
                     .FF_FREEZE        (sm_ff_freeze),
                     .FF_FREEZE_CURSOR (sm_ff_freeze),
                     .FF_CURSOR_INIT   (sm_ff_cursor_init),
                     .FB_FREEZE        (sm_fb_freeze),
                     .FF_MU            (sm_ff_mu),
                     .FB_MU            (sm_fb_mu),
                     .COEF_SEL         (sm_coef_sel),
                     .COEF             (sm_coef),
                     .BASEFX_DIS       (basefx_dis_d2),
                     .ADC_DELAY        (adc_dfedelay)
                     );

   
   //clip dfe_unslice
   always @(dfe_unslice)
    if ((&dfe_unslice[10:7]) | (&(~dfe_unslice[10:7])))
         dfe_unslice_clip = dfe_unslice[7:2];      // no overflow
      else
         case(dfe_unslice[10])
            1'b0: dfe_unslice_clip = 6'b011111;    // overflow pos
            1'b1: dfe_unslice_clip = 6'b100000;    // overflow neg
         endcase


//----------------------------------------------------------------------------
//  Analog Equaliser Interface 
//----------------------------------------------------------------------------

   // Turn off aeq for fiber mode
   //assign reset_aeq = reset_dsp_d2 | ~basefx_dis_d2;

   dsp_aeq i_dsp_aeq ( .ADC           (adc_d1),
                       .CLK           (CLK125),
                       .RESET         (RESET_DSP),
                       .AEQ_CONVERGE  (aeq_converge_d2),
                       .AEQ_CONTROL   (AEQ_CNT),
                       .AEQ_FORCE     (sm_aeq_force),
                       .AEQ_FORCE_VAL (sm_aeq_force_val),
                       .AEQ_THRESHOLD (sm_aeq_threshold),
                       .AEQ_OFFSET    (sm_aeq_offset)
                     );


//----------------------------------------------------------------------------
//    Timing recovery 
//----------------------------------------------------------------------------
   
   assign timing_unq = sm_timing_unq_sel ? dfe_unslice_clip : adc_dfedelay;

   dsp_timing i_dsp_timing(.SLICE            (SLICE_OUT),
                           .UNSLICE          (timing_unq),
                           .ADC_TIMING       (adc_timing_d6),
                           .TIMING_MODE      (sm_timing_mode),
                           .CLK              (CLK125),
                           .RESET            (RESET_DSP),
                           .TIMING_UP        (timing_up_i),
                           .TIMING_DN        (timing_dn_i),
                           .FORCE_TIMING_UP  (sm_force_timing_up),
                           .TIMING_LPF_SHIFT (sm_timing_lpf_shift),
                           .T_SEL            (sm_timing_unq_sel)
                     );


   assign TIMING_DN =    timing_dn_i & SIGDET;
   assign TIMING_UP = ~(~timing_up_i & SIGDET);

//----------------------------------------------------------------------------
//    Baseline wander control 
//----------------------------------------------------------------------------

   
   assign error_pre_dfe = {slice_scale[2],slice_scale,3'b000}
                           -  {adc_dfedelay[5],adc_dfedelay};


   always @(posedge CLK125 or posedge RESET_DSP)
     begin      
   if (RESET_DSP)
      error_wander <= 11'd0;
   else
      error_wander <= {error_pre_dfe[6],error_pre_dfe[6],
                                      error_pre_dfe,2'b00};
     end


   assign blw_disable = sm_wander_disable | !BLW_EN;

   
   dsp_wander i_dsp_wander ( .ERROR         (error_wander),
                             .CLK           (CLK125),
                             .RESET         (RESET_DSP),
                             .DISABLE       (blw_disable),
                             .WANDER_OUT    (WANDER_CNT),
                             .WANDER_SHIFT  (sm_wander_shift)
                           );


//----------------------------------------------------------------------------
//   Signal detection 
//----------------------------------------------------------------------------
   
// This block asserts signal_detect when a signal if detected from the ADC
   
   
   dsp_signaldetect i_dsp_signaldetect ( .ADC     (adc_d1),
                                         .CLK     (CLK125),
                                         .RESET   (RESET_DSP),
                                         .SIGDET  (signal_detect)
                                       );


   // can disable the signal detection so SIGDET must work
   // in either mode
   
   assign SIGDET = signal_detect | sm_sigdet_disable;


//----------------------------------------------------------------------------
//    Serial managment Interface 
//----------------------------------------------------------------------------


   // read (from DSP)
   assign sm_reg0 = {2'b00,ADC_TIMING,dfe_unslice};
   assign sm_reg1 = {MSE_GOOD,WANDER_CNT,sm_mse};
   assign sm_reg2 = {SIGDET,AEQ_CNT,sm_coef};

   assign TIMING_MODE = sm_timing_mode;

   // write (to DSP)
   assign sm_aeq_force        = sm_reg3[15];
   assign sm_aeq_force_val    = sm_reg3[14:10];
   assign sm_aeq_offset       = sm_reg3[9:7];
   assign sm_aeq_threshold    = sm_reg3[6:2];
   assign sm_timing_mode      = sm_reg3[1] | ~basefx_dis_d2;
   assign sm_reset_dsp        = sm_reg3[0];
   assign sm_sigdet_disable   = sm_reg4[15];
   assign sm_wander_disable   = sm_reg4[14];
   assign sm_ff_freeze        = sm_reg4[13];
   assign sm_ff_cursor_init   = sm_reg4[12:10];
   assign sm_fb_freeze        = sm_reg4[9];
   assign sm_ff_mu            = sm_reg4[8:7];
   assign sm_fb_mu            = sm_reg4[6:5];
   assign sm_coef_sel         = sm_reg4[4:0];
   assign sm_mse_good_thresh  = sm_reg5[15:8];
   assign sm_wander_shift     = sm_reg5[7:6];
   assign sm_timing_lpf_shift = sm_reg5[5:3];
   assign sm_force_timing_up  = sm_reg5[2];
   assign sm_timing_disable   = sm_reg5[1];
   assign sm_timing_unq_sel   = sm_reg5[0];

   dsp_sm_interface i_dsp_sm_interface( .ADDRESS     (SM_ADDRESS),
                                        .DATA_READ   (SM_DATA_READ),
                                        .DATA_WRITE  (SM_DATA_WRITE),
                                        .WRITE       (SM_WRITE),
                                        .CLK         (CLKXTAL),
                                        .RESET       (RESET_SM),
                                        .REG0        (sm_reg0),
                                        .REG1        (sm_reg1),
                                        .REG2        (sm_reg2),
                                        .REG3        (sm_reg3),
                                        .REG4        (sm_reg4),
                                        .REG5        (sm_reg5)
                                      );

endmodule

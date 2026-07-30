// Created by ihdl
module dsp_dfe (
                // Inputs
                ADC,
                CLK,
                RESET,
                FAST_UPDATE,
                FF_FREEZE,
                FF_FREEZE_CURSOR,
                FF_CURSOR_INIT,
                FB_FREEZE,
                FF_MU,
                FB_MU,
                COEF_SEL,
                BASEFX_DIS,

                // Outputs
                SLICE_OUT,
                SLICE_SCALE_OUT,
                UNSLICE_OUT,
                ERROR_OUT,
                ADC_DELAY,
                COEF
                );

//
// I/O Declarations
//
input [5:0]   ADC;
input         CLK;
input         RESET;
input         FAST_UPDATE;
input         FF_FREEZE;
input         FF_FREEZE_CURSOR;
input [2:0]   FF_CURSOR_INIT;
input         FB_FREEZE;
input [1:0]   FF_MU;
input [1:0]   FB_MU;
input [4:0]   COEF_SEL;
input         BASEFX_DIS;

output [1:0]  SLICE_OUT;
output [2:0]  SLICE_SCALE_OUT;
output [10:0] UNSLICE_OUT;
output [10:0] ERROR_OUT;
output [5:0]  ADC_DELAY;
output [9:0]  COEF;

//
// I/O Type Declarations
//
wire  [5:0]   ADC;
wire          CLK;
wire          RESET;
wire          FAST_UPDATE;
wire          FF_FREEZE;
wire          FF_FREEZE_CURSOR;
wire  [2:0]   FF_CURSOR_INIT;
wire          FB_FREEZE;
wire  [1:0]   FF_MU;
wire  [1:0]   FB_MU;
wire  [4:0]   COEF_SEL;
wire          BASEFX_DIS;

wire  [1:0]   SLICE_OUT;
wire  [2:0]   SLICE_SCALE_OUT;
wire  [10:0]  UNSLICE_OUT;
reg   [10:0]  ERROR_OUT;  //11,3
reg   [5:0]   ADC_DELAY;
reg   [9:0]   COEF;

//
// Internal Signal Declarations
//

reg  [1:0]    decision_ff;  //2,0
reg  [10:0]   dfe_clip_ff;
reg  [10:0]   dfe_clip;
reg  [1:0]    decision;    //2,0
reg  [1:0]    sign_err;    //2,0
reg  [10:0]   scale_dec;   //11,3
reg  [10:0]   error_clip;  //11,3

wire          lt;
wire          gt;
wire          reset_dfe_coeff;
wire [7:0]    fb_tap_0;
wire [7:0]    ff_c1;
wire [7:0]    ff_c2;
wire [7:0]    ff_c4;
wire [7:0]    ff_c5;
wire [9:0]    ff_sout;
wire [9:0]    ff_cout;
wire [11:0]   fb_sout;
wire [11:0]   fb_cout;
wire [12:0]   s6_0;
wire [12:0]   c6_0;
wire [13:0]   s7_0;
wire [13:0]   c7_0;
wire [14:0]   s8_0;
wire [14:0]   c8_0;
wire [15:0]   dfe;
wire [11:0]   error;       //12,4
wire [9:0]    ff_c3;
wire [7:0]    fb_c0;
wire [7:0]    fb_c1;
wire [7:0]    fb_c2;
wire [7:0]    fb_c3;
wire [7:0]    fb_c4;
wire [7:0]    fb_c5;
wire [7:0]    fb_c6;
wire [7:0]    fb_c7;
wire [7:0]    fb_c8;
wire [7:0]    fb_c9;
wire [7:0]    fb_c10;
wire [7:0]    fb_c11;
wire [5:0]    adc_ffdelay;

//
// Parameter Declarations
//


//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign UNSLICE_OUT      = dfe_clip_ff;
   assign SLICE_OUT        = decision_ff;
   assign SLICE_SCALE_OUT  = scale_dec[7:5];

   dsp_ff i_dsp_ff(  .DIN           (ADC),
                     .ERROR         (sign_err),
                     .RESET         (RESET),
                     .CLK           (CLK),
                     .FAST_UPDATE   (FAST_UPDATE),
                     .SOUT          (ff_sout),
                     .COUT          (ff_cout),
                     .FREEZE        (FF_FREEZE),
                     .FREEZE_CURSOR (FF_FREEZE_CURSOR),
                     .CURSOR_INIT   (FF_CURSOR_INIT),
                     .MU            (FF_MU),
                     .C1            (ff_c1),
                     .C2            (ff_c2),
                     .C3            (ff_c3),
                     .C4            (ff_c4),
                     .C5            (ff_c5),
                     .DDELAY        (adc_ffdelay)
                  );

   dsp_fb i_dsp_fb( .DIN         (decision_ff),
                    .ERROR       (sign_err),
                    .CLK         (CLK),
                    .FAST_UPDATE (FAST_UPDATE),
                    .SOUT        (fb_sout),
                    .COUT        (fb_cout),
                    .TAP0        (fb_tap_0),
                    .RESET       (RESET),
                    .FREEZE      (FB_FREEZE),
                    .MU          (FB_MU),
                    .C0          (fb_c0),
                    .C1          (fb_c1),
                    .C2          (fb_c2),
                    .C3          (fb_c3),
                    .C4          (fb_c4),
                    .C5          (fb_c5),
                    .C6          (fb_c6),
                    .C7          (fb_c7),
                    .C8          (fb_c8),
                    .C9          (fb_c9),
                    .C10         (fb_c10),
                    .C11         (fb_c11));


   // level 6
   dsp_csa #(13) i_dsp_csa6_0({{2{ff_cout[9]}},ff_cout,1'b0},
                        {{3{ff_sout[9]}},ff_sout},
                        {fb_cout,1'b0},
                        c6_0,s6_0);

   // level 7
   dsp_csa #(14) i_dsp_csa7_0({c6_0,1'b0},
                        {s6_0[12],s6_0},
                        {fb_sout[11],fb_sout[11],fb_sout},
                        c7_0,s7_0);

   // level 8
   dsp_csa #(15) i_dsp_csa8_0({c7_0,1'b0},
                        {s7_0[13],s7_0},
                        {{7{fb_tap_0[7]}},fb_tap_0},
                        c8_0,s8_0);

   // final full adder
   assign     dfe = {c8_0,1'b0} + {s8_0[14],s8_0};

//------------------------------------------------------------------------------
// clip dfe sum
//------------------------------------------------------------------------------
//
   always @(dfe)
   begin : p_dfe_clip
      if ((&dfe[15:10]) | (&(~dfe[15:10])))
         dfe_clip = dfe[10:0];      // no overflow
      else
         case(dfe[15])
            1'b0: dfe_clip = 11'b01111111111;    // overflow pos
            1'b1: dfe_clip = 11'b10000000000;    // overflow neg
         endcase
     end // p_dfe_clip

   // slicer
   dsp_tc_less    #(16) less    (dfe, 16'b1111111111010000, lt);  // -0.375
   dsp_tc_greater #(16) greater (dfe, 16'b0000000000110000, gt);  // +0.375 or 0.00

//------------------------------------------------------------------------------
// In fiber mode only output 01 (> 0) or 00 (<= 0)
//------------------------------------------------------------------------------
//
   always @(gt or lt) 
      begin : p_decision
      if (gt)
         decision = 2'b01;
      else if (lt)
         decision = 2'b11;
      else
         decision = 2'b00;
      end // p_decision

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(posedge CLK or posedge RESET)
      begin : p_ERROR_OUT 
      if (RESET)
         begin
            decision_ff <= 1'b0;
            dfe_clip_ff <= 11'b0;
            ADC_DELAY   <= 6'h0;
            ERROR_OUT   <= 11'b0;
         end
      else
         begin
            decision_ff <= decision;
            dfe_clip_ff <= dfe_clip;
            ADC_DELAY   <= adc_ffdelay;
            ERROR_OUT   <= error_clip;
         end
      end // p_ERROR_OUT

//------------------------------------------------------------------------------
// Process error calculation
//------------------------------------------------------------------------------
//
   always @(decision_ff)
      begin : p_scale_dec
         case(decision_ff)
            2'b01: scale_dec = 11'b00001100000;  // +0.75
            2'b11: scale_dec = 11'b11110100000;  // -0.75
            2'b00: scale_dec = 11'b00000000000;  // 0
            2'b10: scale_dec = 11'b00000000000;
         endcase
      end // p_scale_dec

   assign error = {scale_dec[10],scale_dec} - {dfe_clip_ff[10],dfe_clip_ff};

   always @(error)
      begin : p_error_clip
         case(error[11:10])
            2'b01: error_clip = 11'b01111111111;    // overflow pos
            2'b10: error_clip = 11'b10000000000;    // overflow neg
            2'b00: error_clip = error[10:0];        // no overflow
            2'b11: error_clip = error[10:0];        // no overflow
         endcase
      end // p_error_clip

   always @(posedge CLK or posedge RESET)
      begin : p_sign_err
      if (RESET)
         sign_err <= 2'b00;
      else if (error == 12'b000000000000)
         sign_err <= 2'b00;
      else
         sign_err <= {error[11],1'b1};
      end // p_sign_err

//------------------------------------------------------------------------------
// Process COEF mux
//------------------------------------------------------------------------------
//
   always @(COEF_SEL or ff_c1 or ff_c2 or ff_c3 or
            ff_c4 or ff_c5 or
            fb_c0 or fb_c1 or fb_c2 or fb_c3 or
            fb_c4 or fb_c5 or fb_c6 or fb_c7 or
            fb_c8 or fb_c9 or fb_c10 or fb_c11)
      begin : p_COEF
         case(COEF_SEL)
            5'b00000 : COEF = 10'd0;
            5'b00001 : COEF = {ff_c1[7],ff_c1[7],ff_c1};
            5'b00010 : COEF = {ff_c2[7],ff_c2[7],ff_c2};
            5'b00011 : COEF =  ff_c3;
            5'b00100 : COEF = {ff_c4[7],ff_c4[7],ff_c4};
            5'b00101 : COEF = {ff_c5[7],ff_c5[7],ff_c5};
            5'b00110 : COEF = 10'd0;
            5'b00111 : COEF = 10'd0;
            5'b01000 : COEF = 10'b0000000000;
            5'b01001 : COEF = 10'b0000000000;
            5'b01010 : COEF = 10'b0000000000;
            5'b01011 : COEF = 10'b0000000000;
            5'b01100 : COEF = 10'b0000000000;
            5'b01101 : COEF = 10'b0000000000;
            5'b01110 : COEF = 10'b0000000000;
            5'b01111 : COEF = 10'b0000000000;
            5'b10000 : COEF = {fb_c0[7],fb_c0[7],fb_c0};
            5'b10001 : COEF = {fb_c1[7],fb_c1[7],fb_c1};
            5'b10010 : COEF = {fb_c2[7],fb_c2[7],fb_c2};
            5'b10011 : COEF = {fb_c3[7],fb_c3[7],fb_c3};
            5'b10100 : COEF = {fb_c4[7],fb_c4[7],fb_c4};
            5'b10101 : COEF = {fb_c5[7],fb_c5[7],fb_c5};
            5'b10110 : COEF = {fb_c6[7],fb_c6[7],fb_c6};
            5'b10111 : COEF = {fb_c7[7],fb_c7[7],fb_c7};
            5'b11000 : COEF = {fb_c8[7],fb_c8[7],fb_c8};
            5'b11001 : COEF = {fb_c9[7],fb_c9[7],fb_c9};
            5'b11010 : COEF = {fb_c10[7],fb_c10[7],fb_c10};
            5'b11011 : COEF = {fb_c11[7],fb_c11[7],fb_c11};
            5'b11100 : COEF = 10'b0000000000;
            5'b11101 : COEF = 10'b0000000000;
            5'b11110 : COEF = 10'b0000000000;
            5'b11111 : COEF = 10'b0000000000;
         endcase
      end // p_COEF

endmodule

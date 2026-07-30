// Created by ihdl
module dsp_signaldetect(
                        //Inputs
                        ADC,
                        CLK,
                        RESET,

                        //Outputs
                        SIGDET
                        );

//
// I/O Declarations
//
input   [5:0]     ADC;
input             CLK;
input             RESET;
output            SIGDET;

//
// I/O Type Declarations
//
wire    [5:0]     ADC;
wire              CLK;
wire              RESET;
reg               SIGDET;

//
// Internal Signal Declarations
//
reg               detpos;
reg               detneg;
reg    [13:0]     cpos;
reg    [13:0]     cneg;
wire              gthigh;
wire              gtlow;
wire              lthigh;
wire              ltlow;
reg    [13:0]     cpos_i_clip;
reg    [13:0]     cneg_i_clip;
reg    [14:0]     cpos_i;
reg    [14:0]     cneg_i;
reg    [5:0]      high_thresh_pos;
reg    [5:0]      high_thresh_neg;
wire   [5:0]      low_thresh_pos;
wire   [5:0]      low_thresh_neg;

//
// Parameter Declarations
//
// None

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   dsp_tc_greater #(6) i_gthigh (ADC, high_thresh_pos, gthigh);
   dsp_tc_less    #(6) i_ltlow  (ADC, low_thresh_pos,  ltlow);
   dsp_tc_greater #(6) i_gtlow  (ADC, low_thresh_neg,  gtlow);
   dsp_tc_less    #(6) i_lthigh (ADC, high_thresh_neg, lthigh);

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(SIGDET) 
      begin : p_high_thresh
      if (SIGDET)
         begin
         high_thresh_pos = 6'b001001;    // +0.375
         high_thresh_neg = 6'b110111;    // -0.375
         end
      else
         begin
         high_thresh_pos = 6'b001100;    // +0.28125
         high_thresh_neg = 6'b110100;    // -0.28125
         end
      end // p_high_thresh

   assign low_thresh_pos = 6'b000110;   // +0.1875
   assign low_thresh_neg = 6'b111010;   // -0.1875


//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(cpos or gthigh or ltlow) 
      begin :p_cpos_i
      if (gthigh)
         cpos_i = {1'b0,cpos} + 15'b000100000000000;
      else if (ltlow)
         cpos_i = {1'b0,cpos} - 15'b000000000000001;
      else
         cpos_i = {1'b0,cpos};
      end // p_cpos_i

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(cpos_i or gthigh or ltlow) 
      begin :p_cpos_i_clip
      if ((gthigh) & (cpos_i[14]))
         cpos_i_clip = 14'b11111111111111;
      else if ((ltlow) & (cpos_i[14]))
         cpos_i_clip = 14'b00000000000000;
      else
         cpos_i_clip = cpos_i[13:0];
      end // p_cpos_i_clip

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(cneg or lthigh or gtlow)
      begin : p_cneg_i
      if (lthigh)
         cneg_i = {1'b0,cneg} + 15'b000100000000000;
      else if (gtlow)
         cneg_i = {1'b0,cneg} - 15'b000000000000001;
      else
         cneg_i = {1'b0,cneg};
      end // p_cneg_i

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(cneg or cneg_i or lthigh or gtlow)
      begin : p_cneg_i_clip
      if ((lthigh) & (cneg_i[14]))
         cneg_i_clip = 14'b11111111111111;
      else if ((gtlow) & (cneg_i[14]))
         cneg_i_clip = 14'b00000000000000;
      else
         cneg_i_clip = cneg_i[13:0];
      end // p_cneg_i_clip

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(posedge CLK or posedge RESET)
     begin : p_cpos
     if (RESET)
        cpos <= 14'b00000000000000;
     else
        cpos <= cpos_i_clip;
     end // p_cpos

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(posedge CLK or posedge RESET)
     begin : p_cneg
     if (RESET) 
        cneg <= 14'b00000000000000;
     else
        cneg <= cneg_i_clip;
     end // p_cneg

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(posedge CLK or posedge RESET) 
      begin : p_detpos
      if (RESET)
         detpos <= 1'b0;
      else if (&cpos) 
         detpos <= 1;
      else if (~(|cpos)) 
         detpos <= 0;
      else
         detpos <= detpos;
      end // p_detpos

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(posedge CLK or posedge RESET)
      begin : p_detneg
      if (RESET)
         detneg <= 1'b0;
      else if (&cneg) 
         detneg <= 1;
      else if (~(|cneg)) 
         detneg <= 0;
      else       
         detneg <= detneg;
      end // p_detneg

//------------------------------------------------------------------------------
// Process...
//------------------------------------------------------------------------------
//
   always @(posedge CLK or posedge RESET) 
      begin : p_SIGDET
      if (RESET)
         SIGDET <= 1'b0;
      else
         SIGDET <= detpos & detneg;
      end // p_SIGDET

endmodule

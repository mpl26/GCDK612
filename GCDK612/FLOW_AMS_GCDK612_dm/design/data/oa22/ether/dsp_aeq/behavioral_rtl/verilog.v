// Created by ihdl
module dsp_aeq(ADC,CLK,RESET,AEQ_CONVERGE,AEQ_CONTROL,
               AEQ_FORCE,AEQ_FORCE_VAL,AEQ_THRESHOLD,
               AEQ_OFFSET);

input          CLK;
input          RESET;
input   [5:0]  ADC;              // Input from ADC
input          AEQ_CONVERGE;     // Why is this needed?
input          AEQ_FORCE;        // For test
input   [4:0]  AEQ_FORCE_VAL;    // For test
input   [4:0]  AEQ_THRESHOLD;    // Used to set threshold for comparison
input   [2:0]  AEQ_OFFSET;       // Offset for comparison

output   [4:0] AEQ_CONTROL;      // Control to Analogue block

reg    [5:0]   abs_adc;
wire    [6:0]   lpf_out;
wire   [5:0]   threshold1;
wire   [5:0]   threshold2;
wire   [5:0]   offset;
wire   [7:0]   acc_offset;
reg   [4:0]   acc_offset_clip;

wire       lt, gt;
reg      lt_ff, gt_ff, hold_ff;

reg   [17:0]   acc;
wire   [18:0]   acc_i;
reg   [17:0]   acc_i_clip;
reg   [18:0]   acc_update;
reg    [8:0]   counter;
reg       hold;


assign offset     = AEQ_CONVERGE ? 6'b000000 : {2'b00,AEQ_OFFSET,1'b0};
assign threshold1 = {1'b0,AEQ_THRESHOLD} + offset;
assign threshold2 = {1'b0,AEQ_THRESHOLD} - offset;

always @(ADC) 
begin 
   
   if (ADC == 6'b100000)
     abs_adc = 6'b011111;
   else
     abs_adc = ADC[5] ? -ADC : ADC;

end


dsp_aeq_lpf i_dsp_aeq_lpf ( .DIN(abs_adc),
                            .CLK(CLK),
                            .RESET(RESET),
                            .HOLD(hold),
                            .DOUT(lpf_out));



always @(posedge CLK or posedge RESET)
begin : p_dsp_aeq_counter

  if (RESET)
    counter <= 9'b000000000;
  else
    counter <= counter+1;

end 



// This process asserts the hold signal
// which is used by the low-pass filter

always @(counter or AEQ_CONVERGE or AEQ_OFFSET)
begin : p_dsp_aeq_hold

   if (AEQ_OFFSET == 3'b111)
      hold = ~AEQ_CONVERGE;
   else
      if ((counter == 9'b111111111) || (AEQ_CONVERGE))
         hold = 0;
      else
         hold = 1;

end


// Perform a comparison

dsp_tc_less    #(7) less    (lpf_out, {1'b0,threshold2}, lt);
dsp_tc_greater #(7) greater (lpf_out, {1'b0,threshold1}, gt);


// registers assorted signals

always @(posedge CLK or posedge RESET)
begin : p_dsp_aeq_register

   if (RESET) 
      begin
         hold_ff  <= 1'b0;
         lt_ff    <= 1'b0;
         gt_ff    <= 1'b0;
      end
  else
     begin
         hold_ff  <= hold;
         lt_ff    <= lt;
         gt_ff    <= gt;
   end

end



// This process calculates the new accumulated value

always @(hold_ff or lt_ff or gt_ff) 
begin : p_dsp_aeq_acc

  if (~hold_ff)
    case ({lt_ff,gt_ff})
      2'b00 : acc_update = 19'b0000000000000000000;
      2'b10 : acc_update = 19'b0000000000000000001;
      2'b01 : acc_update = 19'b1111111111111111111;
      2'b11 : acc_update = 19'b0000000000000000000;
    endcase
  else
    acc_update = 19'b0000000000000000000;

end



assign acc_i = {acc[17],acc} + acc_update;

// This process clips the accumulated value

always @(acc_i) 
begin : p_dsp_aeq_acc_i_clip

   case(acc_i[18:17])   
      2'b01: acc_i_clip = 18'b011111111111111111;  // overflow pos
      2'b10: acc_i_clip = 18'b100000000000000000;  // overflow neg
      2'b00: acc_i_clip = acc_i[17:0];             // no overflow
      2'b11: acc_i_clip = acc_i[17:0];             // no overflow
   endcase

end





always @(posedge CLK or posedge RESET) 
begin : p_dsp_aeq_reg_acc

   if (RESET)
      acc <= 18'b000000000000000000;
   else
      acc <= acc_i_clip;

end

assign acc_offset = AEQ_CONVERGE ? {acc[17],acc[17:11]}+8'b00000001 :
                                   {acc[17],acc[17:11]}+8'b00000010;

// This generates a cliped version of the accumulated value

always @(acc_offset) 
begin : p_dsp_aeq_acc_clip

   if (acc_offset[7])
      acc_offset_clip = 5'b00000;
   else
      if (acc_offset[6])
         acc_offset_clip = 5'b11111;
      else
         acc_offset_clip = acc_offset[5:1];

end

assign AEQ_CONTROL = AEQ_FORCE ? AEQ_FORCE_VAL : acc_offset_clip;

endmodule

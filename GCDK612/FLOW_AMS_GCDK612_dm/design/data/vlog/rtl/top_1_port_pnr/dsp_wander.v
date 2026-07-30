// Created by ihdl
module dsp_wander(ERROR,CLK,RESET,WANDER_OUT,WANDER_SHIFT,DISABLE);

input    [10:0]   ERROR;
input             CLK;
input             RESET;
input             DISABLE;
output   [6:0]    WANDER_OUT;
// test inputs
input    [1:0]    WANDER_SHIFT;



reg      [6:0]    WANDER_OUT;
reg      [14:0]   acc;
reg      [15:0]   acc_i;
reg      [14:0]   acc_i_clip;
reg               div2;
reg      [6:0]   acc_round_clip;

wire     [8:0]   acc_round;


always @(posedge CLK or posedge RESET)
begin
  if (RESET)
    div2 <= 0;
  else if (DISABLE)
    div2 <= 0;
  else
    div2 <= ~div2;
end

// Shift wander error & add to accumulator
always @(acc or ERROR or WANDER_SHIFT) 
begin
  case (WANDER_SHIFT) 
    2'b00 : acc_i = {acc[14],acc} + {ERROR[10],ERROR,4'b0};       //-3

    2'b01 : acc_i = {acc[14],acc} + {ERROR[10],ERROR[10],         //-4
                                     ERROR,3'b0};
    2'b10 : acc_i = {acc[14],acc} + {ERROR[10],ERROR[10],         //-5
                                     ERROR[10],ERROR,2'b0};
    2'b11 : acc_i = {acc[14],acc} + {ERROR[10],ERROR[10],         //-6
                                     ERROR[10],ERROR[10],ERROR,1'b0};
  endcase
end 


// Saturate overflows
always @(acc_i)
begin
  case(acc_i[15:14])
    2'b01: acc_i_clip = 15'b011111111111111;       // overflow pos
    2'b10: acc_i_clip = 15'b100000000000000;       // overflow neg
    2'b00: acc_i_clip = acc_i[14:0];               // no overflow
    2'b11: acc_i_clip = acc_i[14:0];               // no overflow
  endcase
end

// Update acc only every other cycle
always @(posedge CLK or posedge RESET) 
begin
   if (RESET)
      acc <= 15'b000000000000000;
   else if (DISABLE)
      acc <= 15'b000000000000000;
  else if (div2)
      acc <= acc_i_clip;
   else
      acc <= acc;
end

// It seems overflow saturation should occur only after rounding,
// However, this was originally coded such that saturation occurs twice
//assign acc_round = {acc[14],acc[14:7]} + 9'b00000001;
assign acc_round = {acc[14],acc[14:7]} + acc[7];

// Saturate overflows & clip to 7 bits
always @(acc_round)
begin
  case(acc_round[8:7])
    2'b01: acc_round_clip = 7'b0111111;        // overflow pos
    2'b10: acc_round_clip = 7'b1000000;        // overflow neg
    2'b00: acc_round_clip = acc_round[7:1];   // no overflow
    2'b11: acc_round_clip = acc_round[7:1];   // no overflow
  endcase
end

always @(posedge CLK or posedge RESET)
   
   if (RESET)
      WANDER_OUT <= 7'b0000000;
   else if (DISABLE)
      WANDER_OUT <= 7'b0000000;
   else
      WANDER_OUT <= acc_round_clip;

endmodule

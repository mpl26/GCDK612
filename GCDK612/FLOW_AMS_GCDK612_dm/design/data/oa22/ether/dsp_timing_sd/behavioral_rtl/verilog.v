// Created by ihdl
module dsp_timing_sd(SD_IN,CLK,RESET,SD_OUT);

input    [11:0]   SD_IN;
input             CLK;
input             RESET;
output   [1:0]    SD_OUT;

reg      [1:0]    SD_OUT;
reg      [11:0]   acc;
reg      [11:0]   fb;
reg      [11:0]   add1_clip;
wire     [12:0]   add1;
wire     [11:0]   acc_i;


assign add1 = {SD_IN[11],SD_IN} + {acc[11],acc};

always @(add1)
begin
  case(add1[12:11])
    2'b01: add1_clip = 12'b011111111111;  // overflow pos
    2'b10: add1_clip = 12'b100000000000;  // overflow neg
    2'b00: add1_clip = add1[11:0];        // no overflow
    2'b11: add1_clip = add1[11:0];        // no overflow
  endcase
end


dsp_tc_less    #(12) less    (add1_clip, 12'b110000000000, lt);  // -1024
dsp_tc_greater #(12) greater (add1_clip, 12'b010000000000, gt);  // +1024

always @(posedge CLK or posedge RESET) 
  if (RESET)
     SD_OUT <= 2'b00;
  else
     SD_OUT <= {lt,gt};

always @(lt or gt) 
begin
  case({lt,gt})  
      2'b01: fb = 12'b110000000000;    // UP out : fb -1024
      2'b00: fb = 12'b000000000000;    //  0
      2'b10: fb = 12'b010000000000;    // DN out : fb +1024
      2'b11: fb = 12'b000000000000;    // not used
  endcase
end

always @(posedge CLK or posedge RESET) 
begin
  if (RESET)
    acc <= 12'b000000000000;
  else
    acc <= acc_i;
end

assign acc_i = add1_clip + fb;

endmodule

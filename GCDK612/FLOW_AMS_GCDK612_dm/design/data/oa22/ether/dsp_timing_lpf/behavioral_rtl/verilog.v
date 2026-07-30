// Created by ihdl
module dsp_timing_lpf(LPF_IN,CLK,RESET,LPF_OUT,TIMING_LPF_SHIFT);

input    [6:0]    LPF_IN;
input             CLK;
input             RESET;
output   [11:0]   LPF_OUT;
// test
input    [2:0]    TIMING_LPF_SHIFT;

reg      [6:0]    in_buff;
reg      [20:0]   in_buff_shift;
reg      [22:0]   acc_i;
reg      [21:0]   acc_i_clip;
reg      [11:0]   lpf_out_i;
reg      [11:0]   LPF_OUT;
reg               no_overflow;
reg      [20:0]   add1;
wire     [21:0]   acc;
wire     [21:0]   add2;



always @(LPF_IN)
  in_buff   = LPF_IN;

always @(in_buff)
            in_buff_shift = {in_buff[6],in_buff[6],in_buff[6],in_buff[6],in_buff[6],
                  in_buff[6],in_buff[6],in_buff[6],in_buff[6],in_buff[6],
                  in_buff[6],in_buff[6],in_buff[6],in_buff[6],in_buff};  // -14

always @(posedge CLK or posedge RESET)
  if (RESET)
    add1 <= 21'd0;
  else
    add1 <= {in_buff,14'b0} - in_buff_shift;

assign add2 = {LPF_IN[6],LPF_IN,14'b0} - {add1[20],add1};

always @(posedge CLK or posedge RESET) 
begin
  if (RESET)
    acc_i <= 23'b0;
  else
    acc_i <= {acc[21],acc} + {add2[21],add2};
end

//clip
always @(acc_i)
begin
  case(acc_i[22:21]) 
    2'b01: acc_i_clip = 22'b0111111111111111111111;   // overflow pos
    2'b10: acc_i_clip = 22'b1000000000000000000000;   // overflow neg
    2'b00: acc_i_clip = acc_i[21:0];                  // no overflow
    2'b11: acc_i_clip = acc_i[21:0];                  // no overflow
  endcase
end

assign    acc = acc_i_clip;


always @(acc or TIMING_LPF_SHIFT) 
begin
  case (TIMING_LPF_SHIFT)  
    3'b000,3'b001,3'b010 : no_overflow = 1;
    3'b011 : no_overflow = (&acc[21:20]) | (&(~acc[21:20]));
    3'b100 : no_overflow = (&acc[21:19]) | (&(~acc[21:19]));
    3'b101 : no_overflow = (&acc[21:18]) | (&(~acc[21:18]));
    default: no_overflow = 1;
  endcase
end

//clip shifted output
always @(acc or no_overflow or TIMING_LPF_SHIFT)
begin
  if (no_overflow)
    case (TIMING_LPF_SHIFT)
      3'b000 : lpf_out_i = {acc[21],acc[21],acc[21:12]}; // shift +7
      3'b001 : lpf_out_i = {acc[21],acc[21:11]};         // shift +8
      3'b010 : lpf_out_i = acc[21:10];        // shift +9
      3'b011 : lpf_out_i = acc[20:9];         // shift +10
      3'b100 : lpf_out_i = acc[19:8];         // shift +11
      3'b101 : lpf_out_i = acc[18:7];         // shift +12
      default: lpf_out_i = {acc[21],acc[21],acc[21:12]}; // shift +7
    endcase
  else
    case(acc[21])
      1'b0: lpf_out_i = 12'b011111111111;    // overflow pos
      1'b1: lpf_out_i = 12'b100000000000;    // overflow neg
    endcase
end

always @(posedge CLK or posedge RESET) 
   if (RESET)
      LPF_OUT <= 12'h000;
   else
      LPF_OUT <= lpf_out_i;

endmodule

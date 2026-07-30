// Created by ihdl
module dsp_aeq_lpf(DIN,CLK,RESET,HOLD,DOUT);

input    [5:0]    DIN;
input             CLK;
input             RESET;
input             HOLD;
output   [6:0]    DOUT;

reg      [18:0]   acc;
reg      [18:0]   acc_i_clip;
reg      [6:0]    fb;
reg      [7:0]    sum;
wire     [19:0]   acc_i;

always @(posedge CLK or posedge RESET)
begin
   if (RESET)
      acc <= 19'b0000000000000000000;
   else if (HOLD)
      acc <= acc;
   else
      acc <= acc_i_clip;
end

assign acc_i = {acc[18],acc} +
               {sum[7],sum[7],sum[7],sum[7],sum[7],
                sum[7],sum[7],sum[7],sum[7],sum[7],sum[7],sum[7],sum};

always @(acc_i)
begin
  case(acc_i[19:18])
    2'b01: acc_i_clip = 19'b0111111111111111111;  // overflow pos
    2'b10: acc_i_clip = 19'b1000000000000000000;  // overflow neg
    2'b00: acc_i_clip = acc_i[18:0];              // no overflow
    2'b11: acc_i_clip = acc_i[18:0];              // no overflow
  endcase
end

always @(acc)
begin
  fb = acc[18:12];
end

always @(posedge CLK or posedge RESET)
   if (RESET)
      sum <= 8'h0;
   else
      sum <= {DIN[5],DIN,1'b0} - {fb[6],fb};

assign DOUT = acc[18:12];

endmodule

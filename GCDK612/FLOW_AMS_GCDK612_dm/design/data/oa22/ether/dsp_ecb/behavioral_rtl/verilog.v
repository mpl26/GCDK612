// Created by ihdl
module dsp_ecb (
                CLK125,
                RESET_DSP,
                BLW_EN,
                AEQ_CONVERGE
          );


//`define TAEQ   16'h9C40   // 200K symbols (8ns) = 40K of 40ns
//`define TBLW   16'hEA60   // 300K symbols of 8ns = 60k of 40ns
`define TAEQ   20'h30D40
`define TBLW   20'h493E0



input           CLK125;      // 25 MHz reference clock
input           RESET_DSP;   // DSP reset control

output           BLW_EN;      // Enable Base Line Wander
output           AEQ_CONVERGE;   // Analog Equalizer COnvergence Time

reg       BLW_EN;
reg       AEQ_CONVERGE;
reg [19:0]    count_en;   // BLW and AEQ counter

wire            CLK125;


//-----------------------------------------------------------//
// Enable Base Line Wander and AEQ Converged                 //
//-----------------------------------------------------------//
always   @(posedge CLK125 or posedge RESET_DSP) begin
   if (RESET_DSP) begin
      count_en     <= 20'b0;
      AEQ_CONVERGE <= 1'b1;
      BLW_EN       <= 1'b0;
   end
   else begin
      count_en <= (BLW_EN) ? count_en: count_en + 20'b1;
      if (count_en == `TAEQ) AEQ_CONVERGE <= 1'b0;
      if (count_en == `TBLW) BLW_EN       <= 1'b1;
   end
end

endmodule

`timescale 1ns / 10ps

// Verilog code for 250 MHz PLL on Shawnee.
//
// Initial guess at output clock period is 6 ns. Final output
// clock period is input clock period divided by 10.
//
// Rev 0.1, 7 April 2003 AD, kfugate

module PLL_250MHZ (CLK_250MHZ_PH, CP_ITEST_25u, CLK_25MHZ, DISABLE, 
           IEXT_25u, IEXT_100u, IPLY_25u, SIDDQ, VDD, VSS);
    output [10:0] CLK_250MHZ_PH;
    output CP_ITEST_25u;
    input CLK_25MHZ;
    input DISABLE;
    input IEXT_25u;
    input IEXT_100u;
    input IPLY_25u;
    input SIDDQ;
    input VDD;
    input VSS;

    reg [10:0] CLK_250MHZ_PH;
    reg locked;

    real num_fbdiv, num_refdiv, num_outdiv;
    real tp_REFCLK, cliff, td_CLKOUT, td_CLKOUT_p;

    wire en_power = VDD & (!VSS);
    wire en_bias = !(IEXT_25u) & !(IEXT_100u) & !(IPLY_25u);
    wire en_tot = !(SIDDQ) & !(DISABLE) & en_power & en_bias;

    wire CP_ITEST_25u = en_tot?1'b1:1'bz;

initial begin
        tp_REFCLK = 40;
        td_CLKOUT = 6;
        td_CLKOUT_p = 0.1818;
        cliff = 0;
        CLK_250MHZ_PH = 11'b11111000000;
end

always @(posedge en_tot) begin
        tp_REFCLK = 40;
        td_CLKOUT = 6;
        td_CLKOUT_p = 0.1818;
	CLK_250MHZ_PH = 11'b11111000000;
end

always @(posedge CLK_25MHZ) begin
        if (en_tot) begin
         if (locked) begin
          tp_REFCLK = $realtime - cliff;
          td_CLKOUT = tp_REFCLK/(10);
          td_CLKOUT_p = tp_REFCLK/(11*2*10); 
         end
         cliff = $realtime;
         if (cliff > 0) locked = 1;
        end
      //$display("%f", $time);
      //$display("  tp_REFCLK: %f", tp_REFCLK);
      //$display("  td_CLKOUT: %f", td_CLKOUT);
      //$display("  td_CLKOUT_p: %f", td_CLKOUT_p);
end

always #(td_CLKOUT_p) begin
        if (en_tot) begin
	 CLK_250MHZ_PH[0] <= !CLK_250MHZ_PH[0];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[6] <= !CLK_250MHZ_PH[6];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[1] <= !CLK_250MHZ_PH[1];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[7] <= !CLK_250MHZ_PH[7];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[2] <= !CLK_250MHZ_PH[2];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[8] <= !CLK_250MHZ_PH[8];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[3] <= !CLK_250MHZ_PH[3];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[9] <= !CLK_250MHZ_PH[9];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[4] <= !CLK_250MHZ_PH[4];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[10] <= !CLK_250MHZ_PH[10];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[5] <= !CLK_250MHZ_PH[5];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[0] <= !CLK_250MHZ_PH[0];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[6] <= !CLK_250MHZ_PH[6];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[1] <= !CLK_250MHZ_PH[1];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[7] <= !CLK_250MHZ_PH[7];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[2] <= !CLK_250MHZ_PH[2];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[8] <= !CLK_250MHZ_PH[8];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[3] <= !CLK_250MHZ_PH[3];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[9] <= !CLK_250MHZ_PH[9];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[4] <= !CLK_250MHZ_PH[4];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[10] <= !CLK_250MHZ_PH[10];
	 #td_CLKOUT_p
	 CLK_250MHZ_PH[5] <= !CLK_250MHZ_PH[5];
	end
end

endmodule

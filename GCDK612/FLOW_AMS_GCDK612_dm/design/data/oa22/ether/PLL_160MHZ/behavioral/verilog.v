`timescale 1ns / 10ps

// Verilog code for 160 MHz PLL on Shawnee.
// 
// Initial guess at output clock period is 6 ns. Final output
// clock period is input clock period divided by 6.4. 
// 
// Rev 0.1, 7 April 2003 AD, kfugate

module PLL_160MHZ (CLK_160MHZ, CP_ITEST_25u, CLK_25MHZ, DISABLE, IEXT_25u, 
           IEXT_100u, IPLY_25u, SIDDQ, VDD, VSS);
    output CLK_160MHZ;
    output CP_ITEST_25u;
    input CLK_25MHZ;
    input DISABLE;
    input IEXT_25u;
    input IEXT_100u;
    input IPLY_25u;
    input SIDDQ;
    input VDD;
    input VSS;

    reg CLK_160MHZ;
    reg locked;

    real num_fbdiv, num_refdiv, num_outdiv;
    real tp_REFCLK, cliff, td_CLKOUT;

    wire en_power = VDD & (!VSS);
    wire en_bias = !(IEXT_25u) & !(IEXT_100u) & !(IPLY_25u);
    wire en_tot = !(SIDDQ) & !(DISABLE) & en_power & en_bias;

    wire CP_ITEST_25u = en_tot?1'b1:1'bz; 

initial begin
	tp_REFCLK = 40;
	td_CLKOUT = 6;
	cliff = 0;
	CLK_160MHZ = 0;	
end

always @(posedge en_tot) begin
	tp_REFCLK = 40;
	td_CLKOUT = 6;
	CLK_160MHZ = 0; 
end

always @(posedge CLK_25MHZ) begin
	if (en_tot) begin
	 if (locked) begin
	  tp_REFCLK = $realtime - cliff;
	  td_CLKOUT = tp_REFCLK/(2*6.4);
	 end
	 cliff = $realtime;
	 if (cliff > 0) locked = 1;
	end
//	$display("%f", $time);
//	$display("  tp_REFCLK: %f", tp_REFCLK);
//	$display("  td_CLKOUT: %f", td_CLKOUT);
end

always #(td_CLKOUT) begin
	if (en_tot) begin
	 CLK_160MHZ <= !CLK_160MHZ;
	end
end

endmodule

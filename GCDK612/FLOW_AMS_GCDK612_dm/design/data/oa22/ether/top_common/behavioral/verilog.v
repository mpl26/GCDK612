// Verilog HDL for "Bonphyer_ms", "top_common" "behavioral"

module top_common (PHASE, PLL160, I_REXT_100, I_REXT_400_TX, I_RPOLY_100, 
           GNDA_250, VDDA_250, RBIAS, CLKXTAL, RBIAS_SENSE, SIDDQ, BGTRIM, 
           DISABLE10, DISABLE100, VDDA_160, GNDA_160);
    output [10:0] PHASE;
    output PLL160;
    output I_REXT_100;
    output I_REXT_400_TX;
    output I_RPOLY_100;
    input GNDA_250;
    input VDDA_250;
    inout RBIAS;
    input CLKXTAL;
    input RBIAS_SENSE;
    input SIDDQ;
    input [3:0] BGTRIM;
    input DISABLE10;
    input DISABLE100;
    input VDDA_160;
    input GNDA_160;

endmodule

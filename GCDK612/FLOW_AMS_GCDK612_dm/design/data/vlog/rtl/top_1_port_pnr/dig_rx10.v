// Created by ihdl
module dig_rx10 (
                 // Inputs
                 CLKPLL_IN,
                 POS_DETECT,
                 NEG_DETECT,
                 clk160_enable,
                 clk160n_enable,
                 txc2_5_enable,
                 RESET,
                 SLICER_MUX,
                 MR_RX10_PLL_MAX_ADJ_SHIFT,
                 MR_SYMBOL_MODE,
                 MR_POL_CORR_DISB,

                 //Outputs
                 RX10_PRESENT,
                 POS_LINK_PULSE,
                 NEG_LINK_PULSE,
                 MR_POL_REVERSED, 
                 DEC10_DATA_D1,
                 DEC10_RCLK10,
                 RCLK2_5_GOOD,
                 RX10_DV,
                 RX10_DATA,
                 RX10_ACTIVE,
                 RX10_RCLK2_5,
                 DEC10_RCLK_GOOD,
                 NEW_EDGE,
                 DEC10_DATA
                 ); 

input        CLKPLL_IN;                  // system clock either 125MHz/160MHz
input        POS_DETECT;  
input        NEG_DETECT;
input        clk160_enable;
input        clk160n_enable;
input        txc2_5_enable;              // 2.5 MHz Clock enable
input        RESET;
input        SLICER_MUX;
input [2:0]  MR_RX10_PLL_MAX_ADJ_SHIFT;
input        MR_SYMBOL_MODE;
input        MR_POL_CORR_DISB;

output       RX10_PRESENT;
output       POS_LINK_PULSE;
output       NEG_LINK_PULSE;
output       MR_POL_REVERSED;
output       DEC10_DATA_D1;
output       DEC10_RCLK10;
output       RCLK2_5_GOOD;
output       RX10_DV;
output [3:0] RX10_DATA;
output       RX10_ACTIVE;
output       RX10_RCLK2_5;
output       DEC10_RCLK_GOOD;
output       NEW_EDGE;
output       DEC10_DATA;



//
// I/O Type Declarations
//
wire         CLKPLL_IN;
wire         POS_DETECT;
wire         NEG_DETECT;
wire         clk160_enable;
wire         clk160n_enable;
wire         txc2_5_enable;
wire         RESET;
wire         SLICER_MUX;
wire  [2:0]  MR_RX10_PLL_MAX_ADJ_SHIFT;
wire         MR_SYMBOL_MODE;
wire         MR_POL_CORR_DISB;

wire         RX10_PRESENT;
wire         POS_LINK_PULSE;
wire         NEG_LINK_PULSE;
wire         MR_POL_REVERSED;
wire         DEC10_DATA_D1;
wire         DEC10_RCLK10;
wire         RCLK2_5_GOOD;
wire         RX10_DV;
wire [3:0]   RX10_DATA;
wire         RX10_ACTIVE;
wire         RX10_RCLK2_5;

//
// Internal Signal Declarations
//
wire         DEC10_DATA;
wire         DEC10_RCLK_GOOD;


//
// Parameter Declarations
//
// None


//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
// This module contains the PCS submodules

dig_rx10_squelch i_dig_rx10_squelch (
                          .POS_DETECT(POS_DETECT),
                          .NEG_DETECT(NEG_DETECT),
                          .RESET(RESET),
                          .CLKPLL_IN(CLKPLL_IN), 
                          .clk160_enable(clk160_enable),
                          .RX10_PRESENT(RX10_PRESENT),
                          .POS_LINK_PULSE(POS_LINK_PULSE),
                          .NEG_LINK_PULSE(NEG_LINK_PULSE)
                          );

dig_rx10_pol_rvrs i_dig_rx10_pol_rvrs (
                       .CLKPLL_IN(CLKPLL_IN), 
                       .POS_LINK_PULSE(POS_LINK_PULSE),
                       .NEG_LINK_PULSE(NEG_LINK_PULSE),
                       .clk160_enable(clk160_enable),
                       .txc2_5_enable(txc2_5_enable),
                       .MR_POL_CORR_DISB(MR_POL_CORR_DISB),
                       .RESET(RESET),
                       .MR_POL_REVERSED(MR_POL_REVERSED)
                       );

dig_rx10_manch_dec i_dig_rx10_manch_dec (
                           .SLICER_MUX(SLICER_MUX),
                           .MR_RX10_PLL_MAX_ADJ_SHIFT(MR_RX10_PLL_MAX_ADJ_SHIFT),
                           .RX10_PRESENT(RX10_PRESENT),
                           .CLKPLL_IN(CLKPLL_IN), 
                           .clk160_enable(clk160_enable),
                           .clk160n_enable(clk160n_enable),
                           .RESET(RESET),
                           .DEC10_RCLK10(DEC10_RCLK10),
                           .DEC10_DATA(DEC10_DATA),
                           .DEC10_RCLK_GOOD(DEC10_RCLK_GOOD),
                           .NEW_EDGE(NEW_EDGE)
                           );

dig_rx10_ser2par i_dig_rx10_ser2par (
                      .DEC10_DATA(DEC10_DATA),
                      .DEC10_RCLK_GOOD(DEC10_RCLK_GOOD),
                      .DEC10_RCLK10(DEC10_RCLK10),
                      .MR_SYMBOL_MODE(MR_SYMBOL_MODE),
                      .RESET(RESET),
                      .RX10_DV(RX10_DV),
                      .RX10_DATA(RX10_DATA),
                      .RX10_ACTIVE(RX10_ACTIVE),
                      .RX10_RCLK2_5(RX10_RCLK2_5),
                      .DEC10_DATA_D1(DEC10_DATA_D1),
                      .RCLK2_5_GOOD(RCLK2_5_GOOD)
                      );

endmodule

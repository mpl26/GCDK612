// Created by ihdl
module dig_rx10_manch_dec (
                           //Inputs
                           CLKPLL_IN,
                           SLICER_MUX,
                           MR_RX10_PLL_MAX_ADJ_SHIFT,
                           RX10_PRESENT,
                           clk160_enable,
                           clk160n_enable,
                           RESET,

                           //Outputs
                           DEC10_RCLK10,
                           DEC10_DATA,
                           DEC10_RCLK_GOOD,
                           NEW_EDGE
                           );

input       CLKPLL_IN;                 // system clock either 125MHz/160MHz
input       SLICER_MUX;
input [2:0] MR_RX10_PLL_MAX_ADJ_SHIFT;
input       RX10_PRESENT;
input       clk160_enable;             // 160MHz Clock enable
input       clk160n_enable;            // Negedge 160MHz Clock enable
input       RESET;

output      DEC10_RCLK10;
output      DEC10_DATA;
output      DEC10_RCLK_GOOD;
output      NEW_EDGE;

//
// I/O Type Declarations
//
wire        CLKPLL_IN;
wire        SLICER_MUX;
wire  [2:0] MR_RX10_PLL_MAX_ADJ_SHIFT;
wire        RX10_PRESENT;
wire        clk160_enable;
wire        clk160n_enable;
wire        RESET;

wire        DEC10_RCLK10;
wire        DEC10_DATA;
wire        DEC10_RCLK_GOOD;


//
// Internal Signal Declarations
//
wire [4:1]  PHASE_COUNT;
wire [4:0]  NEW_PHASE;
wire [4:0]  PHASE_SELECT;
wire        SAMPLE_SLICER_EVEN;
wire        SAMPLE_SLICER_ODD;
wire        PS_LATCH;
wire        NEW_EDGE;
//
// Parameter Declarations
//
// None


//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
dig_rx10_manch_dec_edge i_dig_rx10_manch_dec_edge (
                                   .SLICER_MUX(SLICER_MUX),
                                   .RX10_PRESENT(RX10_PRESENT),
                                   .CLKPLL_IN(CLKPLL_IN),
                                   .clk160_enable(clk160_enable),
                                   .clk160n_enable(clk160n_enable),
                                   .RESET(RESET),
                                   .SAMPLE_SLICER_EVEN(SAMPLE_SLICER_EVEN),
                                   .SAMPLE_SLICER_ODD(SAMPLE_SLICER_ODD),
                                   .PHASE_COUNT(PHASE_COUNT),
                                   .NEW_PHASE(NEW_PHASE),
                                   .NEW_EDGE(NEW_EDGE)
                                   );

dig_rx10_manch_dec_filter i_dig_rx10_manch_dec_filter(
                          .NEW_PHASE(NEW_PHASE),
                          .NEW_EDGE(NEW_EDGE),
                          .PHASE_COUNT(PHASE_COUNT),
                          .MR_RX10_PLL_MAX_ADJ_SHIFT(MR_RX10_PLL_MAX_ADJ_SHIFT),
                          .RX10_PRESENT(RX10_PRESENT),
                          .CLKPLL_IN(CLKPLL_IN),
                          .clk160_enable(clk160_enable),
                          .RESET(RESET),
                          .DEC10_RCLK10_GOOD(DEC10_RCLK_GOOD),
                          .PHASE_SELECT(PHASE_SELECT),
                          .PS_LATCH(PS_LATCH)
                                   );

dig_rx10_manch_dec_outwave i_dig_rx10_manch_dec_outwave ( 
                                   .SAMPLE_SLICER_EVEN(SAMPLE_SLICER_EVEN),
                                   .SAMPLE_SLICER_ODD(SAMPLE_SLICER_ODD),
                                   .PHASE_SELECT(PHASE_SELECT),
                                   .PS_LATCH(PS_LATCH),
                                   .PHASE_COUNT(PHASE_COUNT),
                                   .CLKPLL_IN(CLKPLL_IN),
                                   .clk160_enable(clk160_enable),
                                   .clk160n_enable(clk160n_enable),
                                   .RESET(RESET),
                                   .DEC10_RCLK10(DEC10_RCLK10), 
                                   .DEC10_DATA(DEC10_DATA)
                                   );

endmodule

// Created by ihdl
`timescale 1 ns / 1 ps

module dig_clk_pll_sel (
                        //Inputs
                        X_125, X_160, RPD_10_DISB, RPD_100_DISB,
                        pll125_locked, pll160_locked,
                        all_disb, RESETPLL, RESETREG,

                        //Outputs
                        x125_sel, x160_sel, prev_x125_sel, prev_x160_sel,
                        CLKPLL_SC
                        );

//
// I/O Declarations
//
input       X_125;            // 125MHz Clock
input       X_160;            // 160MHz Clock
input       RPD_10_DISB;      // 10BaseT mode disabled
input       RPD_100_DISB;     // 100BaseT-TX mode disabled
input       pll125_locked;    // Indicates PLL Lock
input       pll160_locked;    // Indicates PLL Lock
input       all_disb;           // PLL Powered down
input       RESETPLL;         // Reset
input       RESETREG;         // Hard reset

output       x125_sel;        // Indicates 125MHz clock selected
output       x160_sel;        // Indicates 160MHz clock selected
output [7:0] prev_x125_sel;   // Shift register of propagated select control
output [7:0] prev_x160_sel;   // Shift register of propagated select control
output       CLKPLL_SC;       // Combined PLL output (125 MHz or 160 MHz)

//
// I/O Type Declarations
//
wire        X_125;
wire        X_160;
wire        RPD_10_DISB;
wire        RPD_100_DISB;
wire        pll125_locked;
wire        pll160_locked;
wire        all_disb;

wire        RESETPLL;
wire        RESETREG;

reg         x125_sel;
reg         x160_sel;
reg [7:0]   prev_x125_sel;
reg [7:0]   prev_x160_sel;
wire        CLKPLL_SC;

//
// Internal Signal Declarations
//
reg [1:0]   prev_x125_sel_x160;
reg [1:0]   prev_x160_sel_x125;
reg [1:0]   prev_pll125_locked_x160;
reg [1:0]   prev_pll160_locked_x125;
reg [1:0]   prev_10disb_x125;
reg [1:0]   prev_100disb_x125;
reg [1:0]   prev_10disb_x160;
reg [1:0]   prev_100disb_x160;
reg [1:0]   meta_all_disbpll_sc; 
reg [1:0]   meta_reset_x160;
reg [1:0]   meta_reset_x125;

wire        RESET_X160_SYNCED;
wire        RESET_X125_SYNCED;

//
// Parameter Declarations
//
// None


//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
// Synchronise RESETPLL to X_160 and X_125.  This is required for resetting the
// PLL clock selection logic.
//------------------------------------------------------------------------------
//


  always @ (posedge X_160 or posedge RESETREG)
      begin : p_x160
      if (RESETREG)
         meta_reset_x160 <= 2'b11;
      else
         begin
         meta_reset_x160[0] <= RESETPLL;
         meta_reset_x160[1] <= meta_reset_x160[0];
         end
      end 

   assign RESET_X160_SYNCED = meta_reset_x160[1];

  always @ (posedge X_125 or posedge RESETREG)
      begin : p_x125
      if (RESETREG)
         meta_reset_x125 <= 2'b11;
      else
         begin
         meta_reset_x125[0] <= RESETPLL;
         meta_reset_x125[1] <= meta_reset_x125[0];
         end
      end

   assign RESET_X125_SYNCED = meta_reset_x125[1];
   
   
//------------------------------------------------------------------------------
// Synchronise  all_disb to CLKPLL_SC.  This is required for resetting the
// PLL clock selection logic.
//------------------------------------------------------------------------------
//

  always @ (posedge CLKPLL_SC or posedge RESETREG)
      begin : p_meta_all_disbpll_sc
      if (RESETREG)
         meta_all_disbpll_sc <= 2'b11;
      else
         meta_all_disbpll_sc <= {meta_all_disbpll_sc[0], all_disb};
      end // p_meta_all_disbpll_sc

//------------------------------------------------------------------------------
// The 125MHz clock selection logic
//
//------------------------------------------------------------------------------
//
  always @ (negedge X_125 or posedge RESET_X125_SYNCED)
      begin : p_x_125
      if (RESET_X125_SYNCED)
         begin
         prev_x160_sel_x125      <= 2'h0;
         prev_pll160_locked_x125 <= 2'h0;
         x125_sel                <= 1'b1;
         prev_x125_sel           <= 8'hff;
         prev_10disb_x125        <= 2'h3;
         prev_100disb_x125       <= 2'h0;
         end
      else
         begin
         prev_x160_sel_x125      <= {prev_x160_sel_x125[0], prev_x160_sel[0]};
         prev_10disb_x125        <= {prev_10disb_x125[0], RPD_10_DISB};
         prev_100disb_x125       <= {prev_100disb_x125[0],
                                     RPD_100_DISB };
         prev_pll160_locked_x125 <= {prev_pll160_locked_x125[0], pll160_locked};
         prev_x125_sel           <= {prev_x125_sel[6:0], x125_sel};
         x125_sel                <= ~meta_all_disbpll_sc[1] &
                                     (~prev_x160_sel_x125[1] &
                                      ~prev_100disb_x125[1] |
                                      x125_sel & (prev_10disb_x125[1] |
                                      ~prev_pll160_locked_x125));
         end
      end // p_x_125

//------------------------------------------------------------------------------
// The 160MHz clock selection logic
//
//------------------------------------------------------------------------------
//
   always @ (negedge X_160 or posedge RESET_X160_SYNCED)
      begin : p_x_160
      if (RESET_X160_SYNCED)
         begin
         x160_sel                <= 1'b0;
         prev_x160_sel           <= 8'h00;
         prev_x125_sel_x160      <= 2'h3;
         prev_pll125_locked_x160 <= 2'h0;
         prev_10disb_x160        <= 2'h3;
         prev_100disb_x160       <= 2'h0;
         end
      else
         begin
         prev_x125_sel_x160      <= {prev_x125_sel_x160[0], prev_x125_sel[0]};
         prev_10disb_x160        <= {prev_10disb_x160[0], RPD_10_DISB};
         prev_100disb_x160       <= {prev_100disb_x160[0],
                                     RPD_100_DISB};
         prev_pll125_locked_x160 <= {prev_pll125_locked_x160[0], pll125_locked};
         prev_x160_sel           <= {prev_x160_sel[6:0], x160_sel};
         x160_sel                <= ~meta_all_disbpll_sc[1] &
                                     (~prev_x125_sel_x160[1] &
                                      prev_100disb_x160[1] &
                                      ~prev_10disb_x160[1] |
                                      x160_sel & (prev_100disb_x160[1] |
                                     ~prev_pll125_locked_x160[1]));
         end
      end // p_x_160

   assign CLKPLL_SC = prev_x125_sel[7] & X_125 | prev_x160_sel[7] & X_160;

endmodule // dig_clk_pll_sel

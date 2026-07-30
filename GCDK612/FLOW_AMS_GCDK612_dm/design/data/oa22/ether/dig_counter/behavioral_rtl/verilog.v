// Created by ihdl
module dig_counter(
                   //Inputs
                   CLKPLL_IN,
                   clk160_enable,
                   count_reset,

                   //Outputs
                   count_end,
                  );
   
//
// I/O Declarations
//
input     CLKPLL_IN;       // system clock either 125MHz/160MHz
input     clk160_enable;   // 160 MHz Clock enable
input     count_reset;     // Counter reset 

output    count_end;       // Count expired

//
// I/O Type Declarations
//
wire      CLKPLL_IN;
wire      clk160_enable;
wire      count_reset;

reg       count_end;

//
// Internal Signal Declarations
//
reg [4:0] count_value;

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

//------------------------------------------------------------------------------
// A Counter that increments until reaching its maximum value. The count value 
// is held until a reset is performed. The controlling module dig_rx10_squelch
// will force the reset active during a system reset.
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge count_reset)
      begin : p_150n_count
      if (count_reset)
         begin
         count_value <= 5'd0;
         count_end   <= 1'b0;
         end
      else if (clk160_enable)
         begin
         if (count_value == 5'd23)
            begin
            count_end   <= 1'b1;
            count_value <= 5'd0;
            end
         else
            begin
            count_value <= count_value + 1;
            count_end   <= 1'b0;
            end
         end
      else
         begin
         count_value <= count_value;
         count_end   <= count_end;
         end
      end // p_150n_count

endmodule

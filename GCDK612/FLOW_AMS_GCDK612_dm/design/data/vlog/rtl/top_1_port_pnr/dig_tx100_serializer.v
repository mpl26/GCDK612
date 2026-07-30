// Created by ihdl
module dig_tx100_serializer (
                             //Inputs
                             BYPASS4B5B_DATA,
                             TXC25_ALIGN,
                             CLKPLL_IN,
                             clk125_enable,
                             RESET,

                             //Outputs
                             SERIALIZER_DATA
                             );

//
// I/O Declarations
//
input   [4:0]  BYPASS4B5B_DATA;    // 5-bit Parallel Data
input          TXC25_ALIGN;        // Alignment mark for 25 MHz serial data
input          CLKPLL_IN;          // System clock 125MHz or 160MHz
input          clk125_enable;      // 125MHz clock enable
input          RESET;              // System reset

output         SERIALIZER_DATA;    // Output Serial Data

//
// I/O Type Declarations
//
wire    [4:0]  BYPASS4B5B_DATA;
wire           TXC25_ALIGN;    
wire           CLKPLL_IN;
wire           clk125_enable;               
wire           RESET;          

reg            SERIALIZER_DATA;

//
// Internal Signal Declarations
//
reg     [2:0]  select_out;
reg            align;

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

//------------------------------------------------------------------------------
// Process is used to select the appropriate output from the symbol
//------------------------------------------------------------------------------
//
   always @(select_out or BYPASS4B5B_DATA)
      begin : p_SERIALIZER_DATA
      case (select_out)
         3'd0 :    SERIALIZER_DATA = BYPASS4B5B_DATA[0];
         3'd1 :    SERIALIZER_DATA = BYPASS4B5B_DATA[1];
         3'd2 :    SERIALIZER_DATA = BYPASS4B5B_DATA[2];
         3'd3 :    SERIALIZER_DATA = BYPASS4B5B_DATA[3];
         default : SERIALIZER_DATA = BYPASS4B5B_DATA[4];
      endcase
      end // p_SERIALIZER_DATA

//------------------------------------------------------------------------------
// Process selection control for appropriate output from the symbol
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_select_out
      if (RESET)
         begin
         select_out <= 3'd4;
         align      <= 1'b0;
         end
     else if (clk125_enable)
         begin 
         align <= TXC25_ALIGN ;
         if (align)
            select_out <= 3'd4;
         else if (select_out == 3'd0)
            select_out <= 3'd4;
         else
            select_out <= select_out - 1'b1;       
         end
     else
         begin
         select_out <= select_out;
         align      <= align;
         end
      end // p_select_out

endmodule

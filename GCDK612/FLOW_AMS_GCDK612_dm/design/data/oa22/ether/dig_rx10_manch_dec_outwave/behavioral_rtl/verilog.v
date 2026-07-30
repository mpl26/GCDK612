// Created by ihdl
module dig_rx10_manch_dec_outwave (
                                   //Inputs
                                   SAMPLE_SLICER_EVEN,
                                   SAMPLE_SLICER_ODD,
                                   PHASE_SELECT,
                                   PS_LATCH,
                                   PHASE_COUNT,
                                   CLKPLL_IN,
                                   clk160_enable,
                                   clk160n_enable,
                                   RESET,

                                   //Outputs
                                   DEC10_RCLK10,
                                   DEC10_DATA 
                                   );

input       SAMPLE_SLICER_EVEN;   //
input       SAMPLE_SLICER_ODD;    //
input [4:0] PHASE_SELECT;         // Phase select
input [4:1] PHASE_COUNT;          // Phase count
input       PS_LATCH;             // PS latch
input       CLKPLL_IN;            // system clock either 125MHz/160MHz
input       clk160_enable;        // 160MHz Clock enable
input       clk160n_enable;       // Negedge 160MHz Clock enable
input       RESET;                // system reset

output      DEC10_RCLK10;         // Recovered clock
output      DEC10_DATA;           // Recovered data

//
// I/O Type Declarations
//
wire        SAMPLE_SLICER_EVEN;
wire        SAMPLE_SLICER_ODD;
wire  [4:0] PHASE_SELECT;
wire  [4:1] PHASE_COUNT;
wire        PS_LATCH;
wire        CLKPLL_IN;
wire        clk160_enable;
wire        clk160n_enable;
wire        RESET;

wire        DEC10_RCLK10;
wire        DEC10_DATA;

//
// Internal Signal Declarations
//
reg        dec_clk10_even;
reg        dec_clk10_odd;
reg        dec_data_even;
reg        dec_data_odd;
reg [3:0]  diff;
reg [4:0]  int_phase_select;
reg [3:0]  int_clk_out; 

//
// Parameter Declarations
//
// None

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign DEC10_RCLK10  =  (dec_clk10_even | dec_clk10_odd);
   assign DEC10_DATA    =   dec_data_even | dec_data_odd;
 
//------------------------------------------------------------------------------
// This process is used to determine the difference between the internal phase
// select and the phase count
//------------------------------------------------------------------------------
//
   always @(int_phase_select or PHASE_COUNT or diff)
      begin : p_diff
      diff = int_phase_select[4:1] - PHASE_COUNT[4:1];
      int_clk_out = diff + 4'd3;
      end // p_diff

//------------------------------------------------------------------------------
// 
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_even
      if (RESET)
         begin
         dec_clk10_even   <=1'b0;
         dec_data_even    <=1'b0;
         int_phase_select <= 5'd0;
         end
      else if (clk160_enable)
         begin
         if (int_phase_select[0])
            begin
            dec_clk10_even <= int_clk_out[3];
            if ({dec_clk10_even,int_clk_out[3]} == 2'b01)
               dec_data_even <= SAMPLE_SLICER_EVEN;
            end
         else
            begin
            dec_clk10_even <= 1'b0;
            if (int_clk_out == 4'd15)
               dec_data_even <= 1'b0;
            end
         if (PS_LATCH)
            int_phase_select <= PHASE_SELECT;
         end
      else
         begin
         dec_clk10_even   <= dec_clk10_even;
         dec_data_even    <= dec_data_even;
         int_phase_select <= int_phase_select;
         end
      end // p_even

//------------------------------------------------------------------------------
// 
//------------------------------------------------------------------------------
//
   always @(negedge CLKPLL_IN or posedge RESET)
      begin : p_odd
      if (RESET)
         begin
         dec_clk10_odd <=1'b0;
         dec_data_odd  <= 1'b0;
         end
      else if (clk160n_enable)
         begin
         if (!int_phase_select[0])
            begin
            dec_clk10_odd <= int_clk_out[3];
            if ({dec_clk10_odd,int_clk_out[3]} == 2'b01)
               dec_data_odd <= SAMPLE_SLICER_ODD;
            end
         else
            begin
            dec_clk10_odd <= 1'b0;
            if (int_clk_out == 4'd15)
               dec_data_odd <= 1'b0;
            end
         end
      else
         begin
         dec_clk10_odd <= dec_clk10_odd;
         dec_data_odd  <= dec_data_odd;
         end
      end // p_odd

endmodule

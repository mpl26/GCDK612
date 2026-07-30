// Created by ihdl
module dig_rx10_manch_dec_edge(
                                //Inputs
                                SLICER_MUX,
                                RX10_PRESENT,
                                CLKPLL_IN,
                                clk160_enable,
                                clk160n_enable,
                                RESET,

                                //Outputs
                                SAMPLE_SLICER_EVEN,
                                SAMPLE_SLICER_ODD,
                                PHASE_COUNT,
                                NEW_PHASE,
                                NEW_EDGE
                                );

input        SLICER_MUX;
input        RX10_PRESENT;          // Receive data present
input        CLKPLL_IN;             // System clock either 125MHz/160MHz
input        clk160_enable;         // 160MHz Clock enable
input        clk160n_enable;        // Negedge 160MHz Clock enable
input        RESET;                 // System reset

output       SAMPLE_SLICER_EVEN;
output       SAMPLE_SLICER_ODD;
output [4:1] PHASE_COUNT;
output [4:0] NEW_PHASE;
output       NEW_EDGE;


//
// I/O Type Declarations
//
wire        SLICER_MUX;
wire        RX10_PRESENT;
wire        CLKPLL_IN;
wire        clk160_enable;
wire        clk160n_enable;
wire        RESET;

wire        SAMPLE_SLICER_EVEN;
wire        SAMPLE_SLICER_ODD;
reg [4:1]   PHASE_COUNT;
reg [4:0]   NEW_PHASE;
reg         NEW_EDGE;

//
// Internal Signal Declarations
//
reg         curr_slicer_even_n;
reg         curr_slicer_odd_n;
reg         prev_slicer_even_n;
reg         prev_slicer_odd_n;
reg         edge_found;
reg         even_edge_found;
reg         odd_edge_found;

//
// Parameter Declarations
//
// None

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

assign SAMPLE_SLICER_EVEN = !prev_slicer_even_n;
assign SAMPLE_SLICER_ODD  = !prev_slicer_odd_n;

//------------------------------------------------------------------------------
// Register "even" data at positive edge of 160 MHz clock
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_slicer_even
      if (RESET)
         begin
         curr_slicer_even_n <= 1'b0;
         prev_slicer_even_n <= 1'b0;
         even_edge_found <= 1'b0;
         end
      else if (clk160_enable)
         begin
         curr_slicer_even_n <= !(SLICER_MUX | !RX10_PRESENT);
         prev_slicer_even_n <= curr_slicer_even_n;
         if (edge_found)
            even_edge_found <= 1'b1;
         else
            even_edge_found <= 1'b0;
         end
      else
         begin
         curr_slicer_even_n <= curr_slicer_even_n;
         prev_slicer_even_n <= prev_slicer_even_n;
         even_edge_found    <= even_edge_found;
         end
      end // p_slicer_even

//------------------------------------------------------------------------------
// Register "odd" data at negative edge of 160 MHz clock
//------------------------------------------------------------------------------
//
   always @(negedge CLKPLL_IN or posedge RESET)
      begin : p_slicer_odd
      if (RESET)
         begin
         curr_slicer_odd_n <= 1'b0;
         prev_slicer_odd_n <= 1'b0;
         odd_edge_found <= 1'b0;
         end
      else if (clk160n_enable)
         begin
         curr_slicer_odd_n <= !(SLICER_MUX | !RX10_PRESENT);
         prev_slicer_odd_n <= curr_slicer_odd_n;
         if (edge_found)
            odd_edge_found <= 1'b1;
         else
            odd_edge_found <= 1'b0;
         end
      else
         begin
         curr_slicer_odd_n <= curr_slicer_odd_n;
         prev_slicer_odd_n <= prev_slicer_odd_n;
         odd_edge_found    <= odd_edge_found;
         end
      end // p_slicer_odd

//------------------------------------------------------------------------------
// Find edge
//------------------------------------------------------------------------------
//
   always @(prev_slicer_even_n or prev_slicer_odd_n)
      begin : p_edge_found
      edge_found = prev_slicer_even_n ^ prev_slicer_odd_n;
      end // p_edge_found

//------------------------------------------------------------------------------
// Set new phase and align to CLK160
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_NEW_PHASE
      if (RESET)
         begin
         NEW_PHASE <= 5'd0;
         NEW_EDGE  <= 1'b0;
         end
      else if (clk160_enable)
         begin
	      if (even_edge_found == 1'b1)
            begin
               NEW_PHASE <= {PHASE_COUNT[4:1],1'b0};
               NEW_EDGE <= 1'b1;
            end
	      else if (odd_edge_found == 1'b1)
           begin
            NEW_PHASE <= {PHASE_COUNT[4:1],1'b1};
            NEW_EDGE <= 1'b1;
           end
         else
            begin
               NEW_EDGE  <= 1'b0;
               NEW_PHASE <= NEW_PHASE;
            end
         end
      else
         begin
            NEW_PHASE <= NEW_PHASE;
            NEW_EDGE  <= NEW_EDGE;
         end
      end

//------------------------------------------------------------------------------
// Phase Counter
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_PHASE_COUNT
      if (RESET)
         PHASE_COUNT <= 4'd0;
      else if (clk160_enable)
         PHASE_COUNT <= PHASE_COUNT + 4'd1;
      else
         PHASE_COUNT <= PHASE_COUNT;
      end // p_PHASE_COUNT

endmodule

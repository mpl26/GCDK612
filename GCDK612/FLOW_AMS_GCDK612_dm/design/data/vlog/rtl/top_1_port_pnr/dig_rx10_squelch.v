// Created by ihdl
module dig_rx10_squelch (
                         //Inputs
                         CLKPLL_IN,
                         POS_DETECT,
                         NEG_DETECT,
                         RESET,
                         clk160_enable,

                         //Outputs
                         RX10_PRESENT,
                         POS_LINK_PULSE,
                         NEG_LINK_PULSE,
                         );

//
// I/O Declarations
//
input     CLKPLL_IN;              // system clock either 125MHz/160MHz
input     POS_DETECT;             // Positive Analog Comparator Output
input     NEG_DETECT;             // Negative Analog Comparator Output
input     RESET;                  // System Reset
input     clk160_enable;          // 160 MHz Clock enable
   
output    RX10_PRESENT;           // A data signal is being received
output    POS_LINK_PULSE;         // At least one positive pulse received
output    NEG_LINK_PULSE;         // At least one negative pulse received

//
// I/O Type Declarations
//
wire      CLKPLL_IN;
wire      POS_DETECT;
wire      NEG_DETECT;
wire      RESET;     
wire      clk160_enable;

reg       RX10_PRESENT;
reg       POS_LINK_PULSE;
reg       NEG_LINK_PULSE;

//
// Internal Signal Declarations
//
reg       prev1_pos_detect;
reg       prev2_pos_detect;
reg       prev1_neg_detect;
reg       prev2_neg_detect;
reg       count_150_reset;
reg [3:0] state;
wire      count_150_end;

//
// Parameter Declarations
//
`define sq_idle          4'd0
`define sq_first_pos_on  4'd1
`define sq_first_pos_off 4'd2
`define sq_first_neg_on  4'd3
`define sq_first_neg_off 4'd4
`define sq_data_pos_on   4'd5
`define sq_data_pos_off  4'd6
`define sq_data_neg_on   4'd7
`define sq_data_neg_off  4'd8

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

//------------------------------------------------------------------------------
// 150nS counter module instantiation
//------------------------------------------------------------------------------
//
dig_counter i_dig_counter(
                          .CLKPLL_IN(CLKPLL_IN),
                          .clk160_enable(clk160_enable),

                          .count_reset(count_150_reset),
                          .count_end(count_150_end)
                          );

//------------------------------------------------------------------------------
// This process is looking for synchronising the POS_DETECT, NEG_DETECT signals
// into the 160MHz clock domain
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_sync_detect
      if (RESET)
         begin
         prev1_pos_detect <= 1'b0;
         prev2_pos_detect <= 1'b0;
         prev1_neg_detect <= 1'b0;
         prev2_neg_detect <= 1'b0;
         end
      else if (clk160_enable)
         begin
         prev1_pos_detect <= POS_DETECT;
         prev2_pos_detect <= prev1_pos_detect;
         prev1_neg_detect <= NEG_DETECT;
         prev2_neg_detect <= prev1_neg_detect;
         end
      else
         begin
         prev1_pos_detect <= prev1_pos_detect;
         prev2_pos_detect <= prev2_pos_detect;
         prev1_neg_detect <= prev1_neg_detect;
         prev2_neg_detect <= prev2_neg_detect;
         end
      end // p_edge_detect

//------------------------------------------------------------------------------
// State machine 
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_sm
      if (RESET)
         begin
         state           <= `sq_idle;
         RX10_PRESENT    <= 1'b0;
         count_150_reset <= 1'b1;
         end
      else if (clk160_enable)
         case (state)
         `sq_idle: begin
                   count_150_reset <= 1'b1;
                   if (prev2_pos_detect)
                      state <= `sq_first_pos_on;
                   end

         `sq_first_pos_on: begin
                           count_150_reset <= 1'b0;
                           if (count_150_end)
                              state <= `sq_idle;
                           else if (!prev2_pos_detect)
                              state <= `sq_first_pos_off;
                           end

         `sq_first_pos_off: begin
                            if (prev2_neg_detect)
                               begin
                               state <= `sq_first_neg_on;
                               count_150_reset <= 1'b1;
                               end
                            else if (count_150_end)
                               state <= `sq_idle;
                            end

         `sq_first_neg_on: begin
                           count_150_reset <= 1'b0;
                           if (count_150_end)
                              state <= `sq_idle;
                           else if (!prev2_neg_detect)
                              state <= `sq_first_neg_off;
                           end

         `sq_first_neg_off: begin
                            if (prev2_pos_detect)
                               begin
                               state <= `sq_data_pos_on;
                               RX10_PRESENT <= 1'b1;
                               count_150_reset <= 1'b1;
                               end
                            else if (count_150_end)
                               state <= `sq_idle;
                            end

         `sq_data_pos_on: begin
                          count_150_reset <= 1'b0;
                          if (count_150_end)
                             begin
                             state <= `sq_idle;
                             RX10_PRESENT <= 1'b0;
                             end
                          else if (!prev2_pos_detect)
                             state <= `sq_data_pos_off;
                          end

         `sq_data_pos_off: begin
                           if (prev2_neg_detect)
                              begin
                              state <= `sq_data_neg_on;
                              count_150_reset <= 1'b1;
                              end
                           else if (count_150_end)
                              begin
                              state <= `sq_idle;
                              RX10_PRESENT <= 1'b0;
                              end
                           end

         `sq_data_neg_on: begin
                          count_150_reset <= 1'b0;
                          if (count_150_end)
                             begin
                             state <= `sq_idle;
                             RX10_PRESENT <= 1'b0;
                             end
                          else if (!prev2_neg_detect)
                             state <= `sq_data_neg_off;
                          end

         `sq_data_neg_off: begin
                           if (prev2_pos_detect)
                              begin
                              state <= `sq_data_pos_on;
                              count_150_reset <= 1'b1;
                              end
                           else if (count_150_end)
                              begin
                              state <= `sq_idle;
                              RX10_PRESENT <= 1'b0;
                              end
                           end
          endcase
     else
         begin
         state           <= state;
         RX10_PRESENT    <= RX10_PRESENT;
         count_150_reset <= count_150_reset;
         end
     end // p_sm

//------------------------------------------------------------------------------
// Generate positive link detect signal
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_POS_LINK_PULSE
      if (RESET)
         POS_LINK_PULSE <= 1'b0;
      else if (clk160_enable & prev2_pos_detect)
         POS_LINK_PULSE <= 1'b1;
      else if (clk160_enable)
         POS_LINK_PULSE <= 1'b0;
      else
         POS_LINK_PULSE <= POS_LINK_PULSE;
      end // p_POS_LINK_PULSE

//------------------------------------------------------------------------------
// Generate negative link detect signal  		     
//------------------------------------------------------------------------------
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_NEG_LINK_PULSE
      if (RESET)
         NEG_LINK_PULSE <= 1'b0;
      else if (clk160_enable & prev2_neg_detect)
         NEG_LINK_PULSE <= 1'b1;
      else if (clk160_enable)
         NEG_LINK_PULSE <= 1'b0;
      else
         NEG_LINK_PULSE <= NEG_LINK_PULSE;
      end // p_NEG_LINK_PULSE

endmodule

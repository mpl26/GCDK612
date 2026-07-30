// Created by ihdl
module dig_rx10_manch_dec_filter (
                                  //Inputs
                                  NEW_PHASE,
                                  NEW_EDGE,
                                  PHASE_COUNT,
                                  MR_RX10_PLL_MAX_ADJ_SHIFT,
                                  RX10_PRESENT,
                                  CLKPLL_IN,
                                  clk160_enable,
                                  RESET,

                                  //Outputs
                                  DEC10_RCLK10_GOOD,
                                  PHASE_SELECT,
                                  PS_LATCH
                                  );

//
// I/O Declarations
//
input  [4:0] NEW_PHASE;                  // New phase value
input        NEW_EDGE;                   // New edge detected
input  [4:1] PHASE_COUNT;                // Phase count
input  [2:0] MR_RX10_PLL_MAX_ADJ_SHIFT;  // DPLL filter width
input        RX10_PRESENT;               // Data stream present
input        CLKPLL_IN;                  // system clock either 125MHz/160MHz
input        clk160_enable;              // 160 MHz Clock enable
input        RESET;                      // Reset

output       DEC10_RCLK10_GOOD;          // A vaild 10MHz Clock
output [4:0] PHASE_SELECT;               // Phase select
output       PS_LATCH;                   // Phase latched

//
// I/O Type Declarations
//
wire   [4:0] NEW_PHASE;
wire         NEW_EDGE;
wire   [4:1] PHASE_COUNT;              
wire   [2:0] MR_RX10_PLL_MAX_ADJ_SHIFT;
wire         RX10_PRESENT;             
wire         CLKPLL_IN;
wire         clk160_enable;
wire         RESET;
                  
reg          DEC10_RCLK10_GOOD;
reg    [4:0] PHASE_SELECT;
reg          PS_LATCH;

//
// Internal Signal Declarations
//
reg    [9:0] scaled_phase_diff;
reg    [9:0] prev_full_phase_select;
reg    [9:0] full_phase_select;
reg    [4:0] phase_diff;
reg    [2:0] diff_shift;
reg    [7:0] wait2shift_count;
reg    [7:0] new_wait_count;
reg    [5:0] prev_phase_select_round;

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

//------------------------------------------------------------------------------
// This process round to zero
//------------------------------------------------------------------------------
//
   always @ (prev_full_phase_select)
      begin
      if (!prev_full_phase_select[9])
         prev_phase_select_round = prev_full_phase_select[9:5] ;
      else
         prev_phase_select_round = prev_full_phase_select[9:5] + (prev_full_phase_select[4:0]==5'h00 ? 1'b0 : 1'b1) ;
      end

//------------------------------------------------------------------------------
// This process is a 1st order PLL with an adaptive BW
//------------------------------------------------------------------------------
//
   always @(prev_full_phase_select or scaled_phase_diff or diff_shift or
            phase_diff or NEW_PHASE or PHASE_SELECT or MR_RX10_PLL_MAX_ADJ_SHIFT
            or PHASE_COUNT or DEC10_RCLK10_GOOD or prev_phase_select_round)
      begin : p_scaled_phase_diff

      // Calculate 4-bit difference in phase   
      // prev_full_phase_select[9:5] is a shifted "right" and truncated version
      // of prev_full_phase_select so has an inherent gain of 1/32.
      phase_diff = (NEW_PHASE - prev_phase_select_round);

      // When data comes in extra edges are shifted by 180deg.
      // Problems can occur if jitter is large enough to shift good edges.
      if (DEC10_RCLK10_GOOD == 1'b1)
         phase_diff[4] = phase_diff[3];
     
      // Perform variable bit shift for phase difference 
      casex (diff_shift) //synopsys full_case parallel_case
         3'd0: begin
               scaled_phase_diff[9:5] = phase_diff;
               scaled_phase_diff[4:0] = 5'b0;
               end
          
         3'd1: begin
               scaled_phase_diff[9] = phase_diff[4];
               scaled_phase_diff[8:4] = phase_diff;
               scaled_phase_diff[3:0] = 4'b0;
               end
    
         3'd2: begin
               scaled_phase_diff[9:8] = {2{phase_diff[4]}};
               scaled_phase_diff[7:3] = phase_diff;
               scaled_phase_diff[2:0] = 3'b0;
               end
    
         3'd3: begin
               scaled_phase_diff[9:7] = {3{phase_diff[4]}};
               scaled_phase_diff[6:2] = phase_diff;
               scaled_phase_diff[1:0] = 2'b0;
               end
    
         3'd4: begin
               scaled_phase_diff[9:6] = {4{phase_diff[4]}};
               scaled_phase_diff[5:1] = phase_diff;
               scaled_phase_diff[0]   = 1'b0;
               end
          
         3'd5: begin
               scaled_phase_diff[9:5] = {5{phase_diff[4]}};
               scaled_phase_diff[4:0] = phase_diff;
               end

         3'd6: begin
               scaled_phase_diff[9:5] = {5{phase_diff[4]}};
               scaled_phase_diff[4:0] = phase_diff;
               end

         3'd7: begin
               scaled_phase_diff[9:5] = {5{phase_diff[4]}};
               scaled_phase_diff[4:0] = phase_diff;
               end
      
      endcase  

      //  Update phase change for bit-center transition
      full_phase_select = prev_full_phase_select + scaled_phase_diff;

      if (PHASE_COUNT[4:1] == (PHASE_SELECT[4:1] + 4'd1))
         PS_LATCH = 1'd1;
      else
         PS_LATCH = 1'd0;

      end // p_scaled_phase_diff
  
//------------------------------------------------------------------------------
// This process....
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_cont
      if (RESET)
         begin
         prev_full_phase_select <= 10'd0;
         PHASE_SELECT           <= 5'd0;
         DEC10_RCLK10_GOOD      <= 1'b0;
         diff_shift             <= 3'd0;
         wait2shift_count       <= 8'd2;
         new_wait_count         <= 8'd1;
         end
      else if (clk160_enable & (!RX10_PRESENT))
         begin
         DEC10_RCLK10_GOOD      <= 1'b0;
         diff_shift             <= 3'd0;
         prev_full_phase_select <= 10'd0;
         wait2shift_count       <= 8'd2;
         new_wait_count         <= 8'd1;
         end
      else if (clk160_enable & (NEW_EDGE == 1'b1))
         begin
         prev_full_phase_select <= full_phase_select;
         // Round up
         PHASE_SELECT <= full_phase_select[9:5] + full_phase_select[4]; 
         if (wait2shift_count == 8'd1 & 
            (diff_shift == MR_RX10_PLL_MAX_ADJ_SHIFT))
            DEC10_RCLK10_GOOD <= 1'b1;
         else if (wait2shift_count == 8'd1)
            begin
            diff_shift <= diff_shift + 3'd1;
            wait2shift_count <= new_wait_count;
            new_wait_count <= 8'd1;
            end
         else
            wait2shift_count <= wait2shift_count - 8'd1;
         end
      else
         // Do Nothing
         begin
         prev_full_phase_select <= prev_full_phase_select;
         PHASE_SELECT           <= PHASE_SELECT;
         DEC10_RCLK10_GOOD      <= DEC10_RCLK10_GOOD;
         diff_shift             <= diff_shift;
         wait2shift_count       <= wait2shift_count;
         new_wait_count         <= new_wait_count;
         end
      end // p_cont

endmodule

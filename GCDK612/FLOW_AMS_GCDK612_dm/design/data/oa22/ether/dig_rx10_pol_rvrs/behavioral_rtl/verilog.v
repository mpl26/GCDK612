// Created by ihdl
module dig_rx10_pol_rvrs (
                          //Inputs
                          CLKPLL_IN,
                          POS_LINK_PULSE,
                          NEG_LINK_PULSE,
                          clk160_enable,
                          txc2_5_enable,
                          MR_POL_CORR_DISB,
                          RESET,

                          //Outputs
                          MR_POL_REVERSED
                          );

//
// I/O Declarations
//
input        CLKPLL_IN;         // system clock either 125MHz/160MHz
input        POS_LINK_PULSE;    // Positive Link Activity Indication
input        NEG_LINK_PULSE;    // Negative Link Activity Indication
input        clk160_enable;     // 160 MHz Clock enable
input        txc2_5_enable;     // 2.5 MHz Clock enable
input        MR_POL_CORR_DISB;  // Disable polarity correction
input        RESET;             // System Reset

output       MR_POL_REVERSED;   // Reverse incoming polarity from RX channel

//
// I/O Type Declarations
//
wire         CLKPLL_IN;
wire         POS_LINK_PULSE;  
wire         NEG_LINK_PULSE;  
wire         clk160_enable;
wire         txc2_5_enable;
wire         MR_POL_CORR_DISB;
wire         RESET;           

reg          MR_POL_REVERSED;

//
// Internal Signal Declarations
//

reg          next_MR_POL;
reg [2:0]    neg_pulse_count;      // No of negative link pulses in a row
reg [2:0]    next_neg_pulse_count;
reg [2:0]    eof_count;            // No of negative EOFs in a row
reg [2:0]    next_eof_count;
reg [4:0]    count_150ns;          // 150nsec timer for separation and pulse
                                   // width measurements
reg          start_150ns;          // Start the 150 ns timer
reg          expired_150ns;        // 150 nsec timer has expired
reg [18:0]   count_128ms;          // 128 msec timer for silence measurement
reg          start_128ms;          // Start the 128 ms timer
reg [3:0]    state;
reg [3:0]    next_state;
wire         expired_128ms;        // 128 msec timer has expired

//
// Parameter Declarations
//
`define	sm_normal              4'b0000 
`define	neg_active             4'b0001
`define	neg_inactive           4'b0011
`define	neg_eof                4'b0010
`define	rvrs_neg_active        4'b0110
`define	count_neg_pulse        4'b0111
`define	pos_active             4'b0101
`define	rvrs_neg_inactive      4'b0100
`define rvrs_pos_signal_active 4'b1100
`define	rvrs_pos_pulse_active  4'b1101
`define	rvrs_pos_inactive      4'b1111
`define	rvrs_neg_active_again  4'b1110

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

//------------------------------------------------------------------------------
// This process increments the state machine sequence...
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_next_state
      if (RESET)
         begin
         state           <= `sm_normal;
         MR_POL_REVERSED <= 1'b0;
         neg_pulse_count <= 3'd0;
         eof_count       <= 3'd0;
         end
      else if (clk160_enable)
         if (!MR_POL_CORR_DISB)
            begin
            state           <= next_state;
            MR_POL_REVERSED <= next_MR_POL;
            neg_pulse_count <= next_neg_pulse_count;
            eof_count       <= next_eof_count;
            end
      else
         begin
         state           <= state;
         MR_POL_REVERSED <= MR_POL_REVERSED;
         neg_pulse_count <= neg_pulse_count;
         eof_count       <= eof_count;
         end
      end // p_next_state

//------------------------------------------------------------------------------
// This is a combinational process for the determination of the next state
//------------------------------------------------------------------------------
//
   always @(MR_POL_REVERSED or state or neg_pulse_count or eof_count or
            NEG_LINK_PULSE or POS_LINK_PULSE or expired_150ns or
            expired_128ms)
      begin : p_comb
      next_MR_POL          = MR_POL_REVERSED;
      next_state           = state;
      next_neg_pulse_count = neg_pulse_count;
      next_eof_count       = eof_count;
      start_150ns          = 1'b0;
      start_128ms          = 1'b0;

      if (state == `sm_normal)
         begin
         if (NEG_LINK_PULSE)
            begin
            start_150ns          = 1'b1;
            next_neg_pulse_count = neg_pulse_count + 3'd1;
            next_state           = `neg_active;
            end
         end

      if (state == `neg_active)
         begin
         start_150ns = 1'b0;
         if (!NEG_LINK_PULSE && !expired_150ns)
            next_state = `neg_inactive;
         else if (expired_150ns)
            begin
            next_eof_count = eof_count + 3'd1;
            next_state     = `neg_eof;
            end
         end

      if (state == `neg_eof)
         begin
         if (eof_count == 3'd4)
            begin
            next_MR_POL = 1'b1;
            next_state = `rvrs_neg_active;
            end
         else if (!NEG_LINK_PULSE)
            next_state = `sm_normal;
         end

      if (state == `neg_inactive)
         begin
         if (POS_LINK_PULSE)
            begin
            next_neg_pulse_count = 3'd0;
            start_150ns          = 1'b1; // Positive EOF detection timer
            next_state           = `pos_active;
            end
         else if (NEG_LINK_PULSE)
            begin
            if (neg_pulse_count == 3'd7)
               begin
               next_MR_POL = 1'b1;
               next_state  = `rvrs_neg_active;
               end
            else
               begin
               next_neg_pulse_count = neg_pulse_count + 3'd1;
               next_state           = `count_neg_pulse;
               end
            end
         end

      if (state == `count_neg_pulse)
         begin
         if (!NEG_LINK_PULSE)
            next_state = `neg_inactive;
         end

      if (state == `pos_active)
         begin
         start_150ns = 1'b0;
         if (!POS_LINK_PULSE)
            begin
            next_state = `sm_normal;
            if (expired_150ns)
               next_eof_count = 3'd0;
            end
         end

      if (state == `rvrs_neg_active)
         begin
         if (!NEG_LINK_PULSE)
            begin
            next_state = `rvrs_neg_inactive;
            start_150ns = 1'b1;
            start_128ms = 1'b1;
            end
         end

      if (state == `rvrs_neg_inactive)
         begin
         start_150ns = 1'b0;
         start_128ms = 1'b0;
         if (NEG_LINK_PULSE)
            next_state = `rvrs_neg_active;
         if (POS_LINK_PULSE)
            begin
            if (!expired_150ns)
               begin
               start_150ns = 1'b1;
               next_state  = `rvrs_pos_signal_active;
               end
            if (expired_150ns && !expired_128ms)
               next_state = `rvrs_pos_pulse_active;
            end
         else
            if (expired_150ns && expired_128ms)
               begin
               next_state           = `sm_normal;
               next_MR_POL          = 1'b0;
               next_neg_pulse_count = 3'd0;
               next_eof_count       = 3'd0;
               end
         end

      if (state == `rvrs_pos_signal_active)
         begin
         start_150ns = 1'b0;
         if (!POS_LINK_PULSE && !expired_150ns)
            begin
            next_state  = `rvrs_neg_inactive;
            start_150ns = 1'b1;
            start_128ms = 1'b1;
            end
         if (expired_150ns)
            begin
            next_state           = `sm_normal;
            next_MR_POL          = 1'b0;
            next_neg_pulse_count = 3'd0;
            next_eof_count       = 3'd0;
            end
         end

      if (state == `rvrs_pos_pulse_active)
         begin
         if (!POS_LINK_PULSE)
            begin
            next_state  = `rvrs_pos_inactive;
            start_150ns = 1'b1;                // Post pos pulse gap timer
            end
         end

      if (state == `rvrs_pos_inactive)
         begin
         start_150ns = 1'b0;
         if (expired_150ns)
            begin
            next_state           = `sm_normal;
            next_MR_POL          = 1'b0;
            next_neg_pulse_count = 3'd0;
            next_eof_count       = 3'd0;
            end
         else if (NEG_LINK_PULSE)
            next_state = `rvrs_neg_active_again;
         end

      if (state == `rvrs_neg_active_again)
         begin
         if (!NEG_LINK_PULSE)
            begin
            next_state = `rvrs_neg_inactive;
            start_150ns = 1'b1;
            start_128ms = 1'b1;
            end
         end
      end // p_comb

//------------------------------------------------------------------------------
// This is a  process for the counting the 150nS time period
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_count_150ns
      if (RESET)
         begin
         count_150ns   <= 5'd0;
         expired_150ns <= 1'b0;
         end
      else if (clk160_enable)
         if (!MR_POL_CORR_DISB)
            begin
            if (start_150ns)
               begin
               count_150ns <= 5'd0;
               expired_150ns <= 1'b0;
               end
            else if (count_150ns == 5'd22)
               expired_150ns <= 1'b1;
            else
               count_150ns <= count_150ns + 5'd1;
            end 
      else
         begin
         count_150ns   <= count_150ns;
         expired_150ns <= expired_150ns;
         end
      end // p_count_150ns

//------------------------------------------------------------------------------
// This is a  process for the counting the 128mS time period
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_128ms_count
      if (RESET)
         count_128ms <= 19'd0;
      else if (txc2_5_enable)
         begin
         if (start_128ms)
            count_128ms <= 19'd0;
         else if (!MR_POL_CORR_DISB & (count_128ms != 19'd320_000))
            count_128ms <= count_128ms + 19'd1;
         else
            count_128ms <= count_128ms;
         end
      else
         count_128ms <= count_128ms;
      end // p_128ms_count

   assign expired_128ms = (count_128ms == 19'd320_000);

endmodule

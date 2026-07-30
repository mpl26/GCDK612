// Created by ihdl
module dig_rxtx_col(
                    //Inputs
                    CLKPLL_IN,
                    TXEN,
                    MR_ISOLATE_TX,
                    txc2_5_enable,
                    clk10_enable,
                    clk10n_enable,
                    MR_100MBS,
                    MR_FULL_DUPLEX,
                    MR_SQE_ENAB,
                    MR_REPEATER,
                    MR_REPEATER_COL_DISB,
                    MR_DIG_LOOP_BACK_ENAB,
                    MR_COL_TEST,
                    LINK_DOWN,
                    RX10_ACTIVE,
                    RX10_PRESENT,
                    RX100_ACTIVE,
                    TX10_ACTIVE,
                    TX100_ACTIVE,
                    JABBER_DETECTED,
                    RESET,

                    //Output
                    COL
                    );

input           CLKPLL_IN;             // system clock either 125MHz/160MHz
input           TXEN;                  // Transmit Enable
input           MR_ISOLATE_TX;         // 1= Don't respond to TXEN
input           txc2_5_enable;         // 2.5 MHz Clock enable
input           clk10_enable;          // 10MHz Clock enable
input           clk10n_enable;         // Inverted 10MHz Clock enable
input           MR_100MBS;             // 100 Mb/s mode selected
input           MR_FULL_DUPLEX;        // Full Duplex operation selected
input           MR_SQE_ENAB;           // Enable the SQE Test Function
input           MR_REPEATER;           // Repeater mode selected
input           MR_REPEATER_COL_DISB;  // Disable normal COL gen repeater
input           MR_DIG_LOOP_BACK_ENAB; // Analog Loopback (no COL generated)
input           MR_COL_TEST;           // COL with TXEN if dig loopbk
input           LINK_DOWN;             // Link is down
input           RX10_ACTIVE;           // 10 Mb/s receive data is active
input           RX10_PRESENT;          // 10 Mb/s receive signal is present
input           RX100_ACTIVE;          // 100 Mb/s receive data is present
input           TX10_ACTIVE;           // 10 Mb/s transmit path is active
input           TX100_ACTIVE;          // 100 Mb/s transmit path is active
input           JABBER_DETECTED;       // Jabber condition is active
input           RESET;                 // System Reset

output          COL;                   // Collision Detected

//
// I/O Type Declarations
//
wire            CLKPLL_IN;
wire            TXEN;                 
wire            MR_ISOLATE_TX;        
wire            txc2_5_enable;
wire            clk10_enable;
wire            clk10n_enable;
wire            MR_100MBS;
wire            MR_FULL_DUPLEX;
wire            MR_SQE_ENAB;
wire            MR_REPEATER;
wire            MR_REPEATER_COL_DISB;
wire            MR_DIG_LOOP_BACK_ENAB;
wire            MR_COL_TEST;
wire            LINK_DOWN;
wire            RX10_ACTIVE;
wire            RX10_PRESENT;
wire            RX100_ACTIVE;
wire            TX10_ACTIVE;
wire            TX100_ACTIVE;
wire            JABBER_DETECTED;
wire            RESET;

wire            COL;                  

//
// Internal Signal Declarations
//
wire            col_link;       // Collision assertion for link down
reg             col_gen;        // SQE Test (generated) collision signal
reg             col_test;       // Collision test based on register 0.7
reg             prev_txen;      // Previous value of TXEN
reg             count_enab;     // Bit clock count enable
reg [4:0]       sqe_count;      // Number of bit-times after falling TXEN
wire            sqetest_enable; // 1= Generate 5 usec COL pulse after transmit
wire            int_txen;

//
// Parameter Declarations
//
// None

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign int_txen = TXEN & !MR_ISOLATE_TX;
   assign sqetest_enable = !MR_100MBS && !MR_FULL_DUPLEX &&
                          (!MR_REPEATER || (MR_REPEATER && 
                           !MR_REPEATER_COL_DISB)) &&
                           !LINK_DOWN && MR_SQE_ENAB;
   assign col_link = !MR_FULL_DUPLEX && !MR_100MBS && LINK_DOWN;
   assign COL = col_link || col_gen || col_test || 
               (!MR_DIG_LOOP_BACK_ENAB && ((!MR_REPEATER && !MR_FULL_DUPLEX &&
               ((!MR_100MBS && RX10_ACTIVE && RX10_PRESENT && TX10_ACTIVE) ||
               (MR_100MBS && RX100_ACTIVE && TX100_ACTIVE))) ||
               (!MR_FULL_DUPLEX && JABBER_DETECTED)));

//------------------------------------------------------------------------------
// This process is used to set the col_gen signal.
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_col_gen
      if (RESET)
         col_gen <= 1'b0;
      else if (clk10_enable)
         begin
         if (sqetest_enable)
            begin
            if (sqe_count == 5'd10)
               col_gen <= 1'b1;
            if (sqe_count == 5'd20)
               col_gen <= 1'b0;
            end
         else
            col_gen <= 1'b0;
         end
      else 
         col_gen <= col_gen;
      end //p_col_gen

//------------------------------------------------------------------------------
// This process synchronises int_txen to CLK2_5
// Added Reset into the process (JM V1.6)
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_prev_txen
      if (RESET)
         prev_txen <= 1'b0;
      else if (txc2_5_enable)
         prev_txen <= int_txen;
      else
         prev_txen <= prev_txen;
      end // p_prev_txen

//------------------------------------------------------------------------------
// This process sets the count_enab and col_test control signals
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_count_enab
      if (RESET)
         begin
         count_enab <= 1'b0;
         col_test   <= 1'b0;
         end
      else if (txc2_5_enable)
         begin
         if (prev_txen && !int_txen)
            count_enab <= 1'b1;
         if (sqe_count == 5'd20)
            count_enab <= 1'b0;
         if (MR_DIG_LOOP_BACK_ENAB & MR_COL_TEST)
            col_test <= int_txen;
         else
            col_test <= 1'b0;
         end
      else
         begin
         count_enab <= count_enab;
         col_test   <= col_test;
         end
      end //p_count_enab

//------------------------------------------------------------------------------
// This process counts clocks when enabled to determine if a col_gen should be
// issued
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_sqe_count
      if (RESET)
         sqe_count <= 5'd0;
      else if (clk10n_enable)
         if (count_enab)
            sqe_count <= sqe_count +5'd1;
         else
            sqe_count <= 5'd0;
      else
         sqe_count <= sqe_count;
      end //p_sqe_count

endmodule

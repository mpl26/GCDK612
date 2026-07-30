// Created by ihdl
module dig_rxtx10_link(
                       // Inputs
                       CLKPLL_IN,
                       TXEN,
                       MR_ISOLATE_TX,
                       AN_TXEN,
                       txc2_5_enable,
                       clk10n_enable,
                       clkfastd8_enable,
                       MR_LINK_TEST_DISB,
                       MR_DIG_LOOP_BACK_ENAB,
                       MR_FAST_LINK,
                       RX10_ACTIVE,
                       POS_LINK_PULSE,
                       NEG_LINK_PULSE,
                       MR_POL_REVERSED,
                       clk160_enable,
                       RESET,

                       //Outputs 
                       LINE_DRIVER10_ENAB,
                       LINK_GEN_PULSE,
                       LINK_DOWN
                       );

input     CLKPLL_IN;             // system clock either 125MHz/160MHz
input     TXEN;                  // Transmit Enable
input     MR_ISOLATE_TX;         // Don't respond to TXEN
input     AN_TXEN;               // Autoneg line driver enable
input     txc2_5_enable;         // 2.5 MHz Clock enable
input     clk10n_enable;         // Inverted 10MHz Clock enable
input     clkfastd8_enable;      // Fast clock divided by 8 clock enable
input     MR_LINK_TEST_DISB;     // Disable link integrity test function
input     MR_DIG_LOOP_BACK_ENAB; // Disable link integrity test when active
input     MR_FAST_LINK;          // Reduced time between link pulses test mode
input     RX10_ACTIVE;           // 10 Mb/s receive data is present
input     POS_LINK_PULSE;        // Positive link pulse from Squelch Block
input     NEG_LINK_PULSE;        // Negative link pulse from Squelch Block
input     MR_POL_REVERSED;       // Polarity has been detected as reversed
input     clk160_enable;         // 160 MHz Clock enable
input     RESET;                 // System Reset

output    LINE_DRIVER10_ENAB;    // Enable 10 Mb/s line driver
output    LINK_GEN_PULSE;        // Link Gen Pulse to 10BT Digital Filter
output    LINK_DOWN;             // Link is down

//
// I/O Type Declarations
//
wire      CLKPLL_IN;
wire      TXEN;                 
wire      MR_ISOLATE_TX;        
wire      AN_TXEN;
wire      txc2_5_enable;
wire      clk10n_enable;
wire      clkfastd8_enable;
wire      MR_LINK_TEST_DISB;
wire      MR_DIG_LOOP_BACK_ENAB;
wire      RX10_ACTIVE;
wire      POS_LINK_PULSE;
wire      NEG_LINK_PULSE;
wire      LINK_PULSE;
wire      MR_POL_REVERSED;
wire      clk160_enable;
wire      RESET;

wire      LINE_DRIVER10_ENAB;   
reg       LINK_GEN_PULSE;       
reg       LINK_DOWN;            

//
// Internal Signal Declarations
//
reg [14:0]  txen_count;          // 0 to 30,000 cycles of 2.5 MHz clock
reg         expired_12ms;        // 12 msec timer has expired
reg         pulse_gen;           // Link gen pulse generated
reg [2:0]   pulse_count;         // 0-4 cycles of 10 MHz clock
reg         curr_txen;           //
reg         prev1_txen;          //
reg         prev2_txen;          //
reg         prev_link_pulse;     // Previous value of LINK_PULSE
reg         prev1_rx10_active;   // Previous value of RX10_ACTIVE
reg         prev2_rx10_active;   //
reg [14:0]  min_timer;           // Minimum timer's count
reg [18:0]  max_timer;           // Maximum timer's count
reg [2:0]   lp_count;            // # of pulses counted
reg         stretched;           //
reg         prev_stretched;      //
reg         stretched_in;        //
wire        pulse_reset;         //
wire        lp_reset;            // Link pulse counter reset
wire        min_expired;         // Minimum separation time expired
wire        max_expired;         // Maximum separation time expired
wire        minmax_reset;        // Reset signal for both min and max timers
wire        int_txen;            //
wire [14:0] txen_max_count;      // count value at which point link transmitted
wire [14:0] min_count;           // minimum count value

//
// Parameter Declarations
//
`define mint_value 15'd10_000  // 4 msec, can handle up to 7 msec
`define mint_fast  15'd00_100  // min counter value for fast link test mode
`define maxt_value 19'd160_000 // 64 msec, can handle up to 150 msec
`define maxt_fast  19'd1600    // 0.64 msec, max time between links in fast test
`define lpmax      3'd4        // No of good link pulses needed to

`define txen_norm  15'd30_000  // 12msec between transmitted links
`define txen_fast  15'd00_250  // 0.1msec between links (fast link test mode)

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign int_txen = TXEN & !MR_ISOLATE_TX;
   assign minmax_reset = (!LINK_DOWN && prev1_rx10_active) ||
                         (!LINK_DOWN && stretched && min_expired) ||
                         (!LINK_DOWN && max_expired && !stretched &&
                          !prev1_rx10_active) ||
                         (LINK_DOWN && min_expired && !stretched &&
                          prev_stretched) ||
                         (LINK_DOWN && !prev1_rx10_active && max_expired) ||
                         (LINK_DOWN && !min_expired && !stretched &&
                          prev_stretched) ||
                          MR_LINK_TEST_DISB || MR_DIG_LOOP_BACK_ENAB;
   assign LINE_DRIVER10_ENAB = expired_12ms || curr_txen ||
                                prev2_txen || AN_TXEN;
   assign min_expired = MR_FAST_LINK ? (min_timer == `mint_fast) : (min_timer == `mint_value);
   assign max_expired = MR_FAST_LINK ? (max_timer == `maxt_fast) : (max_timer == `maxt_value);
   assign lp_reset = (!LINK_DOWN ||
                     (LINK_DOWN && !prev1_rx10_active && max_expired) ||
                     (LINK_DOWN && !min_expired && LINK_PULSE));

   assign txen_max_count = MR_FAST_LINK ? `txen_fast : `txen_norm;
   assign min_count = MR_FAST_LINK ? `mint_fast : `mint_value;
   assign LINK_PULSE = MR_POL_REVERSED ? NEG_LINK_PULSE : POS_LINK_PULSE;

//------------------------------------------------------------------------------
// This process is 12mS counter
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_expired_12ms
      if (RESET)
         begin
         expired_12ms <= 1'b0;
         txen_count   <= 15'd0;
         end
      else if (txc2_5_enable)
         begin
         if (int_txen)
            begin
            expired_12ms <= 1'b0;
            txen_count <= 15'd0;
            end
         else
            begin
            if (!MR_LINK_TEST_DISB | MR_FAST_LINK)
//               if (txen_count == 15'd30000)
               if (txen_count == txen_max_count)
                  begin
                  expired_12ms <= 1'b1;
                  txen_count <= 15'd0;
                  end
               else
                  begin
                  expired_12ms <= 1'b0;
                  txen_count <= txen_count + 15'd1;
                  end
            end
         end
      else
         begin
         expired_12ms <= expired_12ms;
         txen_count   <= txen_count;
         end

      end // p_expired_12ms

//------------------------------------------------------------------------------
// This process is a pulse counter.
//------------------------------------------------------------------------------
//
   assign pulse_reset = (RESET || !expired_12ms);

   always @(posedge CLKPLL_IN or posedge pulse_reset)
      begin : p_pulse_count
      if (pulse_reset)
         pulse_count <= 3'd0;
      else if (clk10n_enable)
         pulse_count <= pulse_count +3'd1;
      else
         pulse_count <= pulse_count;
      end //p_pulse_count

//------------------------------------------------------------------------------
// This process is sets the LINK_GEN_PULSE.
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_LINK_GEN_PULSE
      if (RESET)
         LINK_GEN_PULSE <= 1'b0;
      else if (clkfastd8_enable)
         begin
         if (pulse_count == 3'd2)
            LINK_GEN_PULSE <= 1'b1;
         else
            LINK_GEN_PULSE <= 1'b0;
         end
      else
         LINK_GEN_PULSE <= LINK_GEN_PULSE;
      end // p_LINK_GEN_PULSE

//------------------------------------------------------------------------------
// This process is syncronises the int_txen to the CLKPLL_IN when the
// 2.5MHz clock enable is active.
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_txen
      if (RESET)
         begin
         curr_txen  <= 1'b0;
         prev1_txen <= 1'b0;
         prev2_txen <= 1'b0;
         end
      else if (txc2_5_enable)
         begin
         prev2_txen <= prev1_txen;
         prev1_txen <= curr_txen;
         curr_txen  <= int_txen;
         end
      else
         begin
         prev2_txen <= prev2_txen;
         prev1_txen <= prev1_txen;
         curr_txen  <= curr_txen;
         end
      end // p_txen


//------------------------------------------------------------------------------
// These processes is the min_timer
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_min_timer
      if (RESET)
         min_timer <= 15'd0;
      else if (txc2_5_enable)
         if (minmax_reset)
            min_timer <= 15'd0;
         else if (min_timer < min_count)
            min_timer <= min_timer + 15'd1;
      else
         min_timer <= min_timer;
      end // p_min_timer

//------------------------------------------------------------------------------
// These processes is the max_timer
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_max_timer
      if (RESET)
         max_timer <= 19'd0;
      else if (txc2_5_enable)
         if (minmax_reset)
            max_timer <= 19'd0;
         else
            if (max_timer < `maxt_value)
               max_timer <= max_timer + 19'd1;
      else
         max_timer <= max_timer;
      end //p_max_timer

//------------------------------------------------------------------------------
// These processes counts link pulses
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_lp_count
      if (RESET)
         lp_count <= 3'd0;
      else if (clk160_enable)
         if (lp_reset)
            lp_count <= 3'd0;
         else
            if (LINK_PULSE && !prev_link_pulse)
               lp_count <= lp_count +3'd1;
      else
         lp_count <= lp_count;
      end //p_lp_count

//------------------------------------------------------------------------------
// This processes determines the state of the link
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_LINK_DOWN
      if (RESET)
         LINK_DOWN <= 1'b1;

      // Previously, use of a clock enable meant LINK_DOWN was not being 
      // deasserted correctly; since LINK_PULSE and lp_count change on
      // CLKPLL_IN, whilst LINK_DOWN is off 2.5MHz clock.
      // Hence enable removed.
      else 
         begin
         if (!LINK_DOWN && max_expired && !LINK_PULSE && !prev1_rx10_active)
            LINK_DOWN <= 1'b1;
         if ((LINK_DOWN && prev2_rx10_active && !prev1_rx10_active) ||
             (LINK_DOWN && lp_count == `lpmax && !prev1_rx10_active) ||
             (MR_LINK_TEST_DISB) ||(MR_DIG_LOOP_BACK_ENAB))

            LINK_DOWN <= 1'b0;
         end


      end //p_LINK_DOWN

//------------------------------------------------------------------------------
// This processes synchronises RX10_ACTIVE with CLK2_5
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_rx10_active
      if (RESET)
         begin
         prev1_rx10_active <= 1'b0;
         prev2_rx10_active <= 1'b0;
         end
      else if (txc2_5_enable)
         begin
         prev1_rx10_active <= RX10_ACTIVE;
         prev2_rx10_active <= prev1_rx10_active;
         end
      else
         begin
         prev1_rx10_active <= prev1_rx10_active;
         prev2_rx10_active <= prev2_rx10_active;
         end
      end //p_rx10_active

//------------------------------------------------------------------------------
// This processes stores the link pulse status
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_prev_link_pulse
      if (RESET)
         prev_link_pulse <= 1'b0;
      else if (clk160_enable)
         prev_link_pulse <= LINK_PULSE;
      else
         prev_link_pulse <= prev_link_pulse;
      end // p_prev_link_pulse

//------------------------------------------------------------------------------
// These processes are used to stretch a link pulse
//------------------------------------------------------------------------------
//
   always @(LINK_PULSE or stretched or prev_stretched)
      begin : p_stretched_in
      case ({LINK_PULSE, stretched, prev_stretched})
         3'b000: stretched_in = 1'b0;
         3'b001: stretched_in = 1'b0;
         3'b010: stretched_in = 1'b1;
         3'b011: stretched_in = 1'b0;
         3'b100: stretched_in = 1'b1;
         3'b101: stretched_in = 1'b0;
         3'b110: stretched_in = 1'b1;
         3'b111: stretched_in = 1'b1;
      endcase
      end // p_stretched_in

   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_stretched
      if (RESET)
         stretched <= 1'b0;
      else if (clk160_enable)
         stretched <= stretched_in;
      else
         stretched <= stretched;
      end //p_stretched

   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_prev_pos
      if (RESET)
         prev_stretched <= 1'b0;
      else if (txc2_5_enable)
         prev_stretched <= stretched;
      else
         prev_stretched <= prev_stretched;
      end //p_prev_pos



//------------------------------------------------------------------------------
endmodule

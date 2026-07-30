// Created by ihdl
module dig_tx10_jabber(
                       //Inputs
                       CLKPLL_IN,
                       TXEN,
                       MR_ISOLATE_TX,
                       MR_JABBER_ENAB,
                       MR_FAST_JABBER,

                       txc2_5_enable,
                       txc2_5n_enable,
                       RESET,

                       //Outputs
                       JABBER_DETECTED
                       );

//
// I/O Declarations
//
input         CLKPLL_IN;       // system clock either 125MHz/160MHz
input         TXEN;            // Transmit Enable
input         MR_ISOLATE_TX;   // Don't respond to TXEN
input         MR_JABBER_ENAB;  // Enable this block
input         MR_FAST_JABBER;  // Fast jabber test mode
input         txc2_5_enable;   // 2.5 MHz Clock enable
input         txc2_5n_enable;  // Inverted 2.5 MHz Clock enable
input         RESET;           // System RESET, active high

output        JABBER_DETECTED; // Jabber condition detected

//
// I/O Type Declarations
//
wire          CLKPLL_IN;
wire          TXEN;          
wire          MR_ISOLATE_TX; 
wire          MR_JABBER_ENAB;
wire          txc2_5_enable;
wire          txc2_5n_enable;
wire          RESET;         

reg           JABBER_DETECTED;

//
// Internal Signal Declarations
//
reg           unjab_done;   // 1= unjab time has expired
reg   [13:0]  t5count;      // 5 msec timer counter
reg   [20:0]  t524count;    // 524 msec timer counter
wire          int_txen;
wire          t5reset;
wire          t524reset;
wire  [20:0]  idle_time;    // idle time after jabber detected
wire  [13:0]  jab_max;      // time before jabber detected

//
// Parameter Declarations
//
`define norm_idle 21'h140000 // 525msec idle time in normal operation
`define fast_idle 21'h000520 // 0.525msec fast idle time
`define norm_jab  14'h30D4   // 5ms normal jabber detect time
`define fast_jab  14'h04E2   // 0.5msec fast jabber detect time

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign int_txen  = TXEN & !MR_ISOLATE_TX;
   assign t5reset  = (RESET | ~int_txen | !MR_JABBER_ENAB | unjab_done);
   assign t524reset = (RESET | ~JABBER_DETECTED | unjab_done);

   assign idle_time = MR_FAST_JABBER ? `fast_idle : `norm_idle;
   assign jab_max   = MR_FAST_JABBER ? `fast_jab  : `norm_jab;

//------------------------------------------------------------------------------
// This process is a counter
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge t5reset)
      begin : p_t5count
      if (t5reset)
         t5count <= 14'd0;
      else if (txc2_5_enable & !JABBER_DETECTED)
         t5count <= t5count + 14'd1;
      else
         t5count <= t5count;
      end // p_t5count

//------------------------------------------------------------------------------
// Process to select between 10BaseT or 100BaseT outputs
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge t524reset)
      begin : p_t524count
      if (t524reset)
         t524count <= 21'd0;
      else if (txc2_5_enable & (t524count < idle_time))
            t524count <= t524count + 21'd1;
      else
            t524count <= t524count;
      end // p_t524count

//------------------------------------------------------------------------------
// This process is used to control the jabber destected indicator
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_JABBER_DETECTED
      if (RESET)
         JABBER_DETECTED <= 1'b0;
      else if (txc2_5n_enable)
         begin
//         if (t5count >= 18'h3C000)
         if (t5count >= jab_max)
            JABBER_DETECTED <= 1'b1;
         if (unjab_done)
            JABBER_DETECTED <= 1'b0;
         end
      else
         JABBER_DETECTED <= JABBER_DETECTED;
      end // p_JABBER_DETECTED

//------------------------------------------------------------------------------
// This process is used to indicate that the jabber is complete
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin
      if (RESET)
         unjab_done <= 1'b0;
      else if (txc2_5_enable)
         begin
         if (unjab_done)
            unjab_done <= 1'b0;
//         else if (t524count >= 21'h140000 && !TXEN)
         else if (t524count >= idle_time && !TXEN)
            unjab_done <= 1'b1;
         end
      else 
         unjab_done <= unjab_done;
      end

endmodule

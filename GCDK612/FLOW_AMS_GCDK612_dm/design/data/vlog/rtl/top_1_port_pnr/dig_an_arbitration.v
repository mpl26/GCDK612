// Created by ihdl
module dig_an_arbitration (

         // Inputs
         CLKPLL_IN,
         clk12_5_enable,
         ACK_FINISHED,
         FLP_RECEIVE_IDLE,
         L100_LINK_STATUS,
         L10_LINK_STATUS,
         MR_ADV_ABILITY,
         MR_AUTONEG_ENABLE,
         MR_RESTART_NEGOTIATION,
         MR_NEXT_PAGE_LOADED,
         NLP_LINK_STATUS,
         RCV_DONE,
         RESET,
         TX_MR_AN_NP,
         RX_LINK_CODE_WORD,
         MR_NP_ABLE,
         TIMEOUT,
         MR_FORCE_TIMER,
         
         // Outputs
         COMPLETE_ACK,                   
         L100_LINK_CONTROL,              
         L10_LINK_CONTROL,               
         MR_AUTONEG_COMPLETE,            
         MR_DUPLEX_MODE,
         MR_LP_AUTONEG_ABLE,
         MR_NO_COMMON_MODE,
         MR_PAGE_RX,
         MR_PARALLEL_DETECTION_FAULT,
         MR_REMOTE_FAULT,
         NLP_LINK_CONTROL,
         RECEIVE_ENABLE,
         SELECT_160MHZ,
         TRANSMIT_ENABLE,
         TX_LINK_CODE_WORD,
         MR_BASE_PAGE,
         MR_LP_NP_ABLE,
         MR_AN_NP_LCW_TOGGLE,
         arb_intl_bus,
         AN_ACTIVE,
         AN_ACTIVE_XTND
         );


// I/O Declarations
// Inputs
input          CLKPLL_IN;              // System clock 125MHz/160MHz
input          clk12_5_enable;         // 12.5MHz Clock enable
input          ACK_FINISHED;           // Set when specified number of FLPs with
                                       // ACK bit set have been transmitted.
input          FLP_RECEIVE_IDLE;       // Set when receiving 'idles' from Link
                                       // Partner (i.e. no A/N occurring).
input [1:0]    L100_LINK_STATUS;       // Status of 100Mbs PMA.
input          L10_LINK_STATUS;        // Status of 10Mbps PMA.
input [13:0]   MR_ADV_ABILITY;         // Local Device abilities.
input          MR_AUTONEG_ENABLE;      // Flag to start A/N process.
input          MR_RESTART_NEGOTIATION; // Strobed to restart A/N process.
input          MR_NEXT_PAGE_LOADED;    // Flagged when A/N Next Page Transmit
                                       // Reg (Reg7) is written to.
input          MR_NP_ABLE;             // Local Device has a Next Page to send.
input          NLP_LINK_STATUS;        // LINK_STATUS from dig_an_linktest;
                                       // set when linktest is in LinkTestPass
                                       // state (linkpulses being received).
                                       // i.e. Link Partner is 10BASE-T able.
input          RCV_DONE;               // FLP/LCW has been received OK.
input          RESET;                  // External Master Reset.
input [15:0]   RX_LINK_CODE_WORD;      // Received Link Code Word.
input [15:0]   TX_MR_AN_NP;            // A/N Next Page Transmit Reg (Reg7).
input          TIMEOUT;                // Input from dig_an_receive;
                                       // 'nlp_test_max_timer' has expired.
input          MR_FORCE_TIMER;         // Mux/Debug flag: use short timer
                                       // values to speed up tests.
                                       
                                       
// Outputs
output         COMPLETE_ACK;                 // Flag set if FSM is in 
                                             // CompleteAcknowledge state and 
                                             // is about to send LCW with ACK-
                                             // bit set.
output [1:0]   L100_LINK_CONTROL;            // 2-bit flag indicates link status
                                             // for 100Mbps comms as OK, READY
                                             // or FAIL.
output         L10_LINK_CONTROL;             // Flag indicates link status
                                             // for 10Mbps comms as OK, READY
                                             // or FAIL.
output         MR_AN_NP_LCW_TOGGLE;          // NEXT PAGE link code word toggle 
                                             // bit value.
output         MR_AUTONEG_COMPLETE;          // Flag set to indicate that A/N is
                                             // complete.
output         MR_BASE_PAGE;                 // Flag set if the LCW currently
                                             // being transmitted by Local
                                             // Device is a Base Page LCW.
output         MR_DUPLEX_MODE;               // Flag is set if device is FULL
                                             // DUPLEX.
output         MR_LP_AUTONEG_ABLE;           // Flag set if Link Partner is able
                                             // to perform A/N.
output         MR_LP_NP_ABLE;                // Flag set if Link Partner is able
                                             // to perform NEXT PAGE exchange.
output         MR_NO_COMMON_MODE;            // Flag set if Local Device and
                                             // Link Partner have no common
                                             // comms rate (e.g. LD=100, LP=10).
output         MR_PAGE_RX;                   // Flag set if a New Page has
                                             // been received.
output         MR_PARALLEL_DETECTION_FAULT;  // Flag set if none or more than 1
                                             // potential Link Partner reported
                                             // READY when 'autoneg_wait_timer'
                                             // expires.
output         MR_REMOTE_FAULT;              // Optional - NOT implemented.
output         NLP_LINK_CONTROL;             // LINK_CONTROL signal to
                                             // dig_an_linktest.
output         RECEIVE_ENABLE;               // Flag indicating FSM is in an
                                             // ACKNOWLEDGE detect, ABILITY
                                             // detect, or NEXT PAGE state.
                                             // i.e. Talking or waiting to
                                             // talk...
output         SELECT_160MHZ;                // Flag true for 10Mbps operation
                                             // (160MHz PLL); false for 100Mbps
                                             // (125MHz PLL).
output         TRANSMIT_ENABLE;              // Flag indicating FSM is in an
                                             // ACKNOWLEDGE detect, ABILITY
                                             // detect, or NEXT PAGE state.

output [15:0]  TX_LINK_CODE_WORD;            // Next LCW to be transmitted. 

output [7:0]   arb_intl_bus;                 // Mux/Debug bus of internal
                                             // dig_an_arbitration signals.
output         AN_ACTIVE;                    // Flag to indicate that A/N is in
                                             // progress (up to link control enabled).
output         AN_ACTIVE_XTND;               // Flag to indicate that A/N is in
                                             // progress (up to 
                                             // MR_AUTONEG_COMPLETE).
 

// I/O Definitions
// Inputs
wire           CLKPLL_IN;              // System clock
wire           clk12_5_enable;         // 12.5MHz clock enable
wire           ACK_FINISHED;           // Set when specified number of FLPs with
                                       // ACK bit set have been transmitted.
wire           FLP_RECEIVE_IDLE;       // Set when receiving 'idles' from Link 
                                       // Partner (i.e. no A/N occurring). 
wire  [1:0]    L100_LINK_STATUS;       // Status of 100Mbs PMA.
wire           L10_LINK_STATUS;        // Status of 10Mbps PMA.
wire  [13:0]   MR_ADV_ABILITY;         // Local Device abilities.
wire           MR_AUTONEG_ENABLE;      // Flag to perform A/N process.
wire           MR_RESTART_NEGOTIATION; // Strobed to restart A/N process.
wire           MR_NEXT_PAGE_LOADED;    // Flagged when A/N Next Page Transmit
                                       // Reg (Reg7) is written to.
wire           MR_NP_ABLE;             // Local Device is Next Page able and has
                                       // a page to send.
wire           NLP_LINK_STATUS;        // LINK_STATUS from dig_an_linktest;
                                       // set when linktest is in LinkTestPass
                                       // state (linkpulses being received).
                                       // i.e. Link Partner is 10BASE-T able.
wire           RCV_DONE;               // FLP/LCW has been received OK.
wire           RESET;                  // External Master Reset.
wire  [15:0]   RX_LINK_CODE_WORD;      // Received Link Code Word.
wire  [15:0]   TX_MR_AN_NP;            // A/N Next Page Transmit Reg (Reg7). 
wire           TIMEOUT;                // Input from dig_an_receive;
                                       // 'nlp_test_max_timer' has expired. 
wire           MR_FORCE_TIMER;         // Mux/Debug flag: use short timer
                                       // values to speed up tests.


// Outputs
reg   [1:0]    L100_LINK_CONTROL;      // Control signal for 100Mbps PMA.
reg            L10_LINK_CONTROL;       // Control signal for 10Mpbs PMA.
reg            NLP_LINK_CONTROL;       // Control signal for Linktest function.
reg            SELECT_160MHZ;          // Change PLL to 160MHz for 10Mbps link.

reg            MR_AUTONEG_COMPLETE;          // Link established through A/N.
reg            MR_DUPLEX_MODE;               // Chosen ability is Full Duplex.
reg            MR_LP_AUTONEG_ABLE;           // Link Partner is A/N-able.
reg            MR_NO_COMMON_MODE;            // Devices share no common ability.
reg            MR_PAGE_RX;                   // New Page has been received.
reg            MR_PARALLEL_DETECTION_FAULT;  // Parallel Detection failed.
reg            MR_REMOTE_FAULT;              // Optional - NOT implemented.
//wire           AN_ACTIVE;              // Flag to indicate that A/N is in
                                       // progress.
reg            AN_ACTIVE;              // Flag to indicate that A/N is in
                                       // progress (up to link control enabled).
reg            AN_ACTIVE_XTND;         // Flag to indicate that A/N is in
                                       // progress (up to MR_AN_COMPLETE).

wire           MR_LP_NP_ABLE;          // Flag set if Link Partner is able
                                       // to perform NEXT PAGE exchange.
wire           MR_BASE_PAGE;           // Flag set if the LCW currently
                                       // being transmitted by Local
                                       // Device is a Base Page LCW.
wire           MR_AN_NP_LCW_TOGGLE;    // NEXT PAGE link code word toggle
                                       // is set to Local Device's tx_toggle.
wire           COMPLETE_ACK;           // Flag set when state is:  
                                       //    CompleteAcknowledge.
wire           RECEIVE_ENABLE;         // Flags are both set when state is:
wire           TRANSMIT_ENABLE;        //    AcknowledgeDetect_d 
                                       // or AcknowledgeDetect_d2
                                       // or AbilityDetect
                                       // or AcknowledgeDetect
                                       // or CompleteAcknowledge
                                       // or NextPageWait_toggle
                                       // or NextPageWait.
 
// TX_LINK_CODE_WORD is next LCW to be transmitted.
// It is continuously constructed from:
//   tx_lcw_reg[15,13:0] and transmit_ack (as bit 14 [ACK bit]).
wire  [15:0]   TX_LINK_CODE_WORD;

wire  [7:0]    arb_intl_bus;           // Mux/Debug bus of internal
                                       // dig_an_arbitration signals.





// timer defs, per 802.3u-1995 Table 28-8, based on a CLK period of 80 nS.
// each of these timers fully time out before any other timer is started,
// so only one register is used to implement all three.
//
// par_LFI_Timer_160_Max is the counter/timer value required to give duration 
// of 880.80384ms, at clock period of 62.5ns, when PLL switched to 160MHz.
//
parameter par_Arbitration_Timer_Size      = 25;
parameter par_Autoneg_Wait_Timer_Max      = 25'h0900000; // 754.97472ms
parameter par_Break_Link_Timer_Max        = 25'h1018000; // 1350.0416ms
parameter par_Link_Fail_Inhibit_Timer_Max = 25'h0a80000; // 880.80384ms
parameter par_LFI_Timer_160_Max           = 25'h0d70a3d; // 880.80384ms@160MHz

// Reduced-length timer parameters to speed up testing.
// Use MR_FORCE_TIMER signal to control which parameters are used.
parameter par_force_AW_Timer_Max       = 25'h0152bec; // 111ms (was 754.97472ms) 
// 25'h000186a; // 0.5ms (was 754.97472ms)
// 
parameter par_force_BL_Timer_Max       = 25'h000186a; // 0.5ms (was 1350.0416ms)

// Shortened link_fail_inhibit_timer value chosen to give enough space for
// L10_LINK_STATUS to be set (4 NLP idles, spaced at 12ms, must be received).
parameter par_force_LFI_Timer_Max      = 25'h00b71b0; // 60ms (was 880.80384ms)
parameter par_force_LFI_Timer_160_Max  = 25'h00ea600; // 60ms @ 160MHz


// Link Control encodings
parameter par_LC_Disable               = 2'b00; // Disable.
parameter par_LC_Scan_For_Carrier      = 2'b01; // Set to Scan for Carrier.
parameter par_LC_Enable                = 2'b11; // Enable.

// Link Status encodings
parameter par_LS_Fail                  = 2'b00; // FAIL - no connection.
parameter par_LS_Ready                 = 2'b01; // READY - link available.
parameter par_LS_OK                    = 2'b11; // OK - link active.

// state variable values
parameter par_AutoNegotiationEnable    = 5'b00000; // Reset/Idle state.
parameter par_TransmitDisable          = 5'b00001; // Disable all PMAs.
parameter par_TransmitDisable_t        = 5'b00010; // Timer state.
parameter par_AbilityDetect            = 5'b00011; // Detect Link Partner.
parameter par_AcknowledgeDetect        = 5'b00100; // Detect ACK bit set
parameter par_AcknowledgeDetect_d      = 5'b10101; // in FLP/LCW response from
parameter par_AcknowledgeDetect_d2     = 5'b00101; // Link Partner.
parameter par_CompleteAcknowledge      = 5'b00110; // Complete new page exchage.
parameter par_LinkStatusCheck          = 5'b00111; // Priority Resolution.
parameter par_LinkStatusCheck_t        = 5'b01000; // Timer state.
parameter par_ParallelDetectionFault   = 5'b01001; // Parallel Detect fail.
parameter par_ChangePLLFrequency       = 5'b01010; // Set PLL for 10 or 100Mbps.
// N.B. unecessary ChangePLLFrequency_t state = 5'b01011 was removed.
parameter par_FlpLinkGoodCheck         = 5'b01100; // Check Link established.
parameter par_FlpLinkGoodCheck_t       = 5'b01101; // Timer state.
parameter par_FlpLinkGood              = 5'b01110; // Link Established.
parameter par_NextPageWait_toggle      = 5'b10000; // Set Next Page Toggle bit. 
parameter par_NextPageWait             = 5'b10001; // Receive Next Page FLP/LCW.




// Internal declarations
reg            np_loaded_sync;         // MR_NEXT_PAGE_LOADED synchronizer
reg   [1:0]    l100_link_status_reg0;  // L100_LINK_STATUS synchronizer (i).
reg   [1:0]    l100_link_status_reg1;  // L100_LINK_STATUS synchronizer (ii).
reg   [1:0]    l10_link_status_reg;    // L10_LINK_STATUS synchronizer.
reg            prev_l10_link_control;  // Previous L10_LINK_CONTROL value.
reg   [2:0]    restart_negotiation;    // MR_RESTART_NEGOTIATION sync/edge det
reg   [par_Arbitration_Timer_Size-1:0]  timer; // Counter for all timer signals.
reg   [4:0]    state;                  // state machine control reg
reg   [1:0]    match_sr;               // Ability Match shift-register.
reg   [15:0]   rx_lcw_reg;             // Copy of RX_LINK_CODE_WORD (set in
                                       // RCV_DONE process). 
reg   [15:0]   ability_match_lcw_reg;  // Received LCW describing Link Partner 
                                       // ability.
reg   [15:0]   base_shadw;             // 'rx_lcw_reg' with ACK bit set as 
                                       // 'don't care' (x).
reg            rx_valid_reg;           // Set when LCW received in certain
                                       // states.
reg            transmit_ack;           // output as TX_LINK_CODE_WORD[14]
reg            tx_toggle;              // TX_LINK_CODE_WORD[11]
reg            rx_toggle;              // RX_LINK_CODE_WORD[11]
reg            mr_np_loaded;           // Local flag indicating TX_MR_AN_NP has
                                       // been written to.
reg            mr_np_loaded_rst;       // Reset for local NP loaded register.
reg            base_page;              // Currently transmitted LCW = Base Page.
reg            desire_np;              // Local Device desires to exchange Next
                                       // Page data.
reg            mr_lp_np_able;          // Set if Link Partner is Next-Page able.
reg            timeout1;               // Local copy of TIMEOUT input.
reg   [15:0]   tx_lcw_reg;             // Register in which LCW to be
                                       // transmitted is 'built'.
reg   [13:0]   adv_ability;
reg            ne_np;                  // Set if Local Device is Next Page able
                                       // AND wishes to engage in Next Page
                                       // exchange. 
reg            lp_np;                  // Set if Link Partner is Next Page able
                                       // AND wishes to engage in Next Page
                                       // exchange. 

reg            autoneg_wait_timer_done;      // Set when timer has expired.
reg            break_link_timer_done;        // Set when timer has expired.
reg            link_fail_inhibit_timer_done; // Set when timer has expired.


// Wires
wire           np_loaded_rst;          // Reset for local mr_np_loaded flag.
wire           single_link_ready;      // Set when only one Link Partner is
                                       // trying to connect to Local Device.
wire           initialize;             // Internal reset for state machine.


//------------------------------------------------------------------------------
// Output Assign statements.
//------------------------------------------------------------------------------
// COMPLETE_ACK set true when in CompleteAcknowledge state.
assign COMPLETE_ACK =   (state == par_CompleteAcknowledge);

assign RECEIVE_ENABLE = ((state == par_AbilityDetect) |
                         (state == par_AcknowledgeDetect) |
                         (state == par_AcknowledgeDetect_d) | 
                         (state == par_AcknowledgeDetect_d2) |
                         (state == par_CompleteAcknowledge) |
                         (state == par_NextPageWait_toggle) |
                         (state == par_NextPageWait));

assign TRANSMIT_ENABLE = ((state == par_AbilityDetect) |
                          (state == par_AcknowledgeDetect) |
                          (state == par_AcknowledgeDetect_d) |
                          (state == par_AcknowledgeDetect_d2) |
                          (state == par_CompleteAcknowledge) |
                          (state == par_NextPageWait_toggle) |
                          (state == par_NextPageWait));

// Bit 15 of TX_LINK_CODE_WORD represents NP ability.
// transmit_ack represents the Acknowledge bit.
assign TX_LINK_CODE_WORD   = {tx_lcw_reg[15],transmit_ack,tx_lcw_reg[13:0]}; 

assign MR_LP_NP_ABLE       = mr_lp_np_able;
assign MR_AN_NP_LCW_TOGGLE = tx_toggle;
assign MR_BASE_PAGE        = base_page;
 

// A/N Mux/Debug system uses arb_intl_bus to route internal signals from
// dig_an_arbitration.v up to chip-level.
// mr_np_loaded, nrx_toggle, single_link_ready and state signals are being 
// routed...
assign arb_intl_bus        = { mr_np_loaded,
                               rx_toggle,
                               single_link_ready, 
                               state
                             };


//------------------------------------------------------------------------------
// Internal Assign statements
//------------------------------------------------------------------------------

// 'initialize' is an internal reset for the FSM - sending it back to
// the AutoNegotiationEnable (cf. idle) state from all other states.
//
// Since it is set active most of the time, it could be considered 'active
// low'.
//
// For initialize to be disabled and the FSM to be active, autoneg_enable[1] 
// must be set - this indicates that it is a flag that is kept on throughout
// the A/N process.
//
// initialize is active until autoneg_enable[1] is set (1 whole cycle after
// autoneg_enable is set), or when restart_negotiation=2'b01 (i.e. restart
// freshly triggered).
assign   initialize        = ( (~restart_negotiation[2] &
                                restart_negotiation[1]) | 
                               ~MR_AUTONEG_ENABLE );  // +edge detection




// np_loaded_rst is a local reset controlled by the local mr_np_loaded_rst flag.
// They form part of local tracking of MR_NEXT_PAGE_LOADED register.
assign np_loaded_rst = mr_np_loaded_rst;



// single_link_ready is a status flag indicating that flp_receive_idle is true 
// and ONLY ONE of the following indications is being received:
//    1) link_status_[NLP] = READY 
//    2) link_status_[TX]  = READY 
//    3) link_status_[T4]  = READY <<----T4 NOT APPLICABLE to this design.
// 
// and since:
//    l100_link_status_reg1 is a 2-cycle delayed version of L100_LINK_STATUS 
//    input.
// 
// and:
//    par_LS_Fail  = 2'b00
//    par_LS_Ready = 2'b01
//    par_LS_OK    = 2'b11

// and:
//    flp_receive_idle = 1 means Receive FSM is in IDLE, LINK PULSE DETECT or
//                         LINK PULSE COUNT state.
//    flp_receive_idle = 0 means Receive FSM is in any other state.
//
 assign   single_link_ready = ( (l100_link_status_reg1 == par_LS_Ready) ^
                                NLP_LINK_STATUS) &
                                FLP_RECEIVE_IDLE;
                                

//------------------------------------------------------------------------------
// Mux timer limits according to MR_FORCE_TIMER, to allow tests to be speeded 
// up.
//------------------------------------------------------------------------------
always @(MR_FORCE_TIMER or timer or SELECT_160MHZ)
begin:   p_force_timer

   // Mux other timer limits.
   if (MR_FORCE_TIMER==1'b1)
      begin
         autoneg_wait_timer_done  = (timer >= par_force_AW_Timer_Max);
         break_link_timer_done    = (timer >= par_force_BL_Timer_Max);
         
         // link_fail_inhibit_timer is dependent on PLL frequency, so require
         // separate values for 125MHx and 160 Mhz settings:
         if (SELECT_160MHZ == 1'b1)
            // 160MHz for 10Mbps.
            link_fail_inhibit_timer_done = 
                                    (timer >= par_force_LFI_Timer_160_Max);
         else
            // 125MHz for 100Mbps.
            link_fail_inhibit_timer_done = (timer >= par_force_LFI_Timer_Max);
      end
   
   else
      begin
         autoneg_wait_timer_done  = (timer >= par_Autoneg_Wait_Timer_Max);
         break_link_timer_done    = (timer >= par_Break_Link_Timer_Max);
  
         // link_fail_inhibit_timer is dependent on PLL frequency, so require
         // separate values for 125MHx and 160 Mhz settings:
         if (SELECT_160MHZ == 1'b1)
            // 160MHz for 10Mbps.
            link_fail_inhibit_timer_done = (timer >= par_LFI_Timer_160_Max);
         else
            // 125MHz for 100Mbps.
            link_fail_inhibit_timer_done = 
                                 (timer >= par_Link_Fail_Inhibit_Timer_Max);
      end


end   // p_force_timer



//------------------------------------------------------------------------------
// Arbitration State Machine
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge RESET )
begin: p_arbitration_fsm

   if(RESET==1'b1) 
      begin
         state                         <= par_AutoNegotiationEnable;
         MR_AUTONEG_COMPLETE           <= 1'b0;    // A/N not complete.
         MR_DUPLEX_MODE                <= 1'b0;    // Duplex mode disabled.
         MR_LP_AUTONEG_ABLE            <= 1'b0;    // LP not A/N-able.
         MR_NO_COMMON_MODE             <= 1'b0;    // No Common Mode detected.
         MR_PAGE_RX                    <= 1'b0;    // New Page not received.
         MR_PARALLEL_DETECTION_FAULT   <= 1'b0;    // No Parallel Detection
                                                   // fault.
         MR_REMOTE_FAULT               <= 1'b0;    // No Remote Fault (optional
                                                   // - not implemented).
         SELECT_160MHZ                 <= 1'b0;    // 125 MHz PLL for A/N.
         desire_np                     <= 1'b0;    // No Next Page exchange
                                                   // desired.
         restart_negotiation           <= 3'b000;  // Don't restart A/N.
         transmit_ack                  <= 1'b0;    // Transmit FLPs without
                                                   // ACK bit set.
         tx_lcw_reg                    <= 16'h0000;// Reset local register 
                                                   // for LCWs to be
                                                   // transmitted. 
         mr_lp_np_able                 <= 1'b0;    // Link Partner not Next
                                                   // Page able.
         base_page                     <= 1'b0;    // Transmitted FLP is not a
                                                   // Base Page.
         adv_ability                   <= 14'd0;   // Local register for Base
                                                   // Page abilities of Local
                                                   // Device. 
         ability_match_lcw_reg         <= 16'd0;   // Register for link code 
                                                   // words received during 
                                                   // Ability match process.
         base_shadw                    <= 16'd0;   // Received Base Page.
         
         mr_np_loaded_rst              <= 1'b0;    // Reset for local NP loaded
                                                   // register.
                                                   
         
         
         // Toggle bits for Next Page exchange.
         tx_toggle                     <= 1'b0;      // Local Device Toggle bit.
         rx_toggle                     <= 1'b0;      // Link Partner Toggle bit.
         ne_np                         <= 1'b0;      // Local Device NP bit.
         lp_np                         <= 1'b0;      // Link Partner NP bit.

         // Disable PMAs.
         L100_LINK_CONTROL             <= par_LC_Disable;   // Disable 100Mbps.
         L10_LINK_CONTROL              <= 1'b0;             // Disable 10Mbps.
         NLP_LINK_CONTROL              <= 1'b0;             // Disable Linktest.
         
         // Reset local link status registers.
         l100_link_status_reg1         <= 2'b00;      // 100Mbps PMA status 1.
         l100_link_status_reg0         <= 2'b00;      // 100Mbps PMA status 0.
         l10_link_status_reg           <= 2'b00;      // 10Mbps PMA status.

      end
   
   
   else if (clk12_5_enable)
      begin
         
         // Single case statement for FSM and outputs.
         case (state)
         
//------------------------------------------------------------------------------
// 'Idle' state, awaiting activation of A/N process.
//------------------------------------------------------------------------------
         par_AutoNegotiationEnable: // Initialisation.
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
                  
               else
                  // Next State
                  state <= par_TransmitDisable;
                  
               // Outputs
               MR_AUTONEG_COMPLETE        <= 1'b0; // A/N in progress.
               MR_DUPLEX_MODE             <= 1'b0; // Duplex mode disabled.
               MR_LP_AUTONEG_ABLE         <= 1'b0; // LP not A/N-able.
               MR_NO_COMMON_MODE          <= 1'b0; // No Common Mode detected.
               MR_PAGE_RX                 <= 1'b0; // New Page not received.
               MR_PARALLEL_DETECTION_FAULT<= 1'b0; // No Parallel Detection
                                                   // fault.
               MR_REMOTE_FAULT            <= 1'b0; // No Remote Fault (optional
                                                   // - not implemented). 
               SELECT_160MHZ     <= 1'b0;          // Use 125 MHz for A/N.
               tx_lcw_reg[13:0]  <= MR_ADV_ABILITY;// Load ability Base Page
               tx_lcw_reg[15]    <= MR_NP_ABLE;    // for FLP transmission.
               adv_ability       <= MR_ADV_ABILITY;// Local Ability register.
               base_shadw        <= 16'd0;        // Initialise local
                                                   // received Base Page 
                                                   // register. 


               // When A/N is enabled, disable 10Mbps PMA and Linktest function.
               L10_LINK_CONTROL  <= 1'b0;          // Disable 10Mbps PMA.
               NLP_LINK_CONTROL  <= 1'b0;          // Disable Linktest function.

               // 100Mpbs is the default mode, and link_detection (non A/N)
               // requires that a link is brought up once MSE_GOOD is set.
               // For 100Mbps, the link status cannot become OK unless the link
               // control is set (see dig_rxtx100_linkmonitor.v).
               // Hence, if A/N is not enabled, L100_LINK_CONTROL is enabled.
               // 
               // When A/N is started by setting bit 0.12, autoneg_enable will
               // take the value 2'b01, and then 2'b11 (it is a 2-bit
               // shift-register).  This will cause L100_LINK_CONTROL to be 
               // DISABLEd. 
               //
               if (MR_AUTONEG_ENABLE == 1'b1)          
                  // A/N enabled, so disable L100_LINK_CONTROL at start of 
                  // A/N process.
                  L100_LINK_CONTROL <= par_LC_Disable;
               else
                  // A/N not enabled, so allow 100Mbps to be used.                                   
                  L100_LINK_CONTROL <= par_LC_Enable; 
               
            end



//------------------------------------------------------------------------------
// Disable transmission from Local Device so that existing or prospective Link
// Partner(s) will break off connection due to timeout.
//------------------------------------------------------------------------------
         par_TransmitDisable:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
                  
               else
                  begin
                     // Next State
                     state <= par_TransmitDisable_t;
                  
                     // Outputs
                     MR_AUTONEG_COMPLETE  <= 1'b0;    // A/N in progress.
                     MR_DUPLEX_MODE       <= 1'b0;    // Duplex mode disabled.  
                     MR_NO_COMMON_MODE    <= 1'b0;    // No Common Mode
                                                      // detected.
                     MR_PAGE_RX           <= 1'b0;    // New Page not received.
                     
                     // Disable 100 and 10Mpbs PMAs.
                     L100_LINK_CONTROL    <= par_LC_Disable; // Disable 100Mbps.
                     L10_LINK_CONTROL     <= 1'b0;           // Disable 10Mbps.
                     
                     // Enable Linktest function, to check for NLPs/10Mbps link.
                     NLP_LINK_CONTROL     <= 1'b0;    // Disable Linktest
                                                      // function.
                     
                     SELECT_160MHZ        <= 1'b0;    // 125 MHz for A/N.
                     transmit_ack         <= 1'b0;    // Do not set ACK bit in
                                                      // transmitted LCWs.
                     mr_np_loaded_rst     <= 1'b1;    // Clear A/N Next Page 
                                                      // transmit reg.
                  end
            end



//------------------------------------------------------------------------------
// Timer state for Transmit Disable.
//------------------------------------------------------------------------------
         par_TransmitDisable_t:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
               
               else
                  if (break_link_timer_done == 1'b1)
                     // Next State
                     state <= par_AbilityDetect;
                  else
                     // Next State
                     state <= par_TransmitDisable_t;
            end



//------------------------------------------------------------------------------
// Ability detect:
// 
// Setup local device to look for Link Partner and determine its abilities from
// received link code word or determine Link Partner by reception of NLPs.
// 
// Remain in this state until match_sr=2'b11, indicating that two or more 
// matching, consecutive LCWs have been received (regardless of ACK bit value), 
// or until it is determined that NLPs are being received.
//
// The ack_finished signal is implemented as an input from the Transmit 
// function, indicating that the final remaining_ack_count LCWs with ACK bit set
// have been transmitted.
// IEEE 802.3, Figure 28-16 indicates that ack_finished is an output from this 
// arbitration module.  Functionality does not seem affected by this difference.
// 
//------------------------------------------------------------------------------
         par_AbilityDetect:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
               
               else
                  // Local Device has received three consecutive LCWs that match
                  // each other.
                  if (match_sr == 2'b11)  // ability_match is true.
                     // Next State
                     state <= par_AcknowledgeDetect;
                  
                  else
                     // Start Parallel Detection...
                     // 10BASE-T OR 100BASE-TX Link Partner is READY.
                     //
                     // NLP_LINK_STATUS=1 means NLPs are being received - so
                     // 10Mbps link is operational.
                     // If l100 status is 'READY' then 100Mbps link is
                     // operational. 
                     if ( (NLP_LINK_STATUS==1'b1) |
                        ( l100_link_status_reg1==par_LS_Ready) )
                        // Next State
                        state <= par_LinkStatusCheck;
                     
                     else
                        // Next State
                        state <= par_AbilityDetect;

            
               // Outputs
               L100_LINK_CONTROL    <= par_LC_Scan_For_Carrier;
               NLP_LINK_CONTROL     <= 1'b1; // Enable Linktest function.
               // N.B. 802.3, Fig 28-16 indicates only these 2 are enabled 
               // i.e. L10_LINK_CONTROL is not enabled.

               tx_lcw_reg[13:0]     <= adv_ability;      // Load up Base Page
                                                         // data.
               tx_toggle            <= adv_ability[11];  // Has no meaning for
                                                         // Base Page.
               base_page            <= 1'b1;             // LCW to be
                                                         // transmitted is a
                                                         // Base Page.
               MR_LP_AUTONEG_ABLE   <= 1'b0;             // Link Partner not
                                                         // A/N able.
               mr_lp_np_able        <= 1'b0;             // LP not NP able.
               desire_np            <= 1'b0;             // LP doesn't desire
                                                         // NP exchange.
               MR_PAGE_RX           <= 1'b0;             // New Page not
                                                         // received.
            end
            

      
//------------------------------------------------------------------------------
// FLPs have been received from the Link Partner, advertising its abilities.
// It has been determined that the devices are compatible (Ability match OK).
// The Local Device should now send back FLPs with the ACKNOWLEDGE bit set, 
// to indicate that it received the Link Partner's FLPS OK. 
//------------------------------------------------------------------------------
         par_AcknowledgeDetect:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
               else
                  // Next State
                  state <= par_AcknowledgeDetect_d;
            
            
               // Outputs
               // FLPs have been received, so Link Partner is A/N-able.
               MR_LP_AUTONEG_ABLE    <= 1'b1;
               
               // Disable 100Mbps link control.
               L100_LINK_CONTROL     <= par_LC_Disable;
               
               // Prevents Linktest function looking for NLPs/10Mbps link.
               NLP_LINK_CONTROL      <= 1'b0;           
               
               // Transmit LCWs with ACK bit set.
               transmit_ack          <= 1'b1; 
                
               // A/N Next Page transmit register not reset.
               mr_np_loaded_rst      <= 1'b0;

               // Base page from Link Partner stored following successful
               // ability match (Ack bit disregarded).
               //
               // ability_match_lcw_reg is used later for Acknowledge and
               // Consistency checks. It is created from rx_lcw_reg so that all
               // the three checks all reference the same received LCW value. 
               // 
               ability_match_lcw_reg <= {rx_lcw_reg[15],1'bx,
                                         rx_lcw_reg[13:0]};
                                         
               // Base page from Link Partner stored following successful
               // ability match (ACK bit disregarded).
               if (base_page == 1'b1)
                  base_shadw <= {rx_lcw_reg[15],1'bx,
                                 rx_lcw_reg[13:0]};
               
               else // Maintain existing value.
                  base_shadw <= base_shadw; 

            end



//------------------------------------------------------------------------------
// Spacer state to allow assignments of AcknowledgeDetect state to be applied,
// before they are read/checked in AcknowledgeDetect_d2.
// 
// match_sr is reset to zero in this state.
// Three consecutive, matching received LCWs will thus be needed to complete the 
// Acknowledge and Consistency match checks.
// 
//------------------------------------------------------------------------------
         par_AcknowledgeDetect_d:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
               else
                  // Next State
                  state <= par_AcknowledgeDetect_d2;
            end



//------------------------------------------------------------------------------
// Check for 3 consecutive, matching, received LCWs (with ACK bit set) to 
// complete the acknowledge and consistency match checks.
// 
// 3 consecutive, matching LCWs required for ability match.
// 3 consecutive, matching LCWs required for acknowledge and consistency match.
// = 6 consecutive LCWs (i.e. 6 consecutive FLPs) must be received.
//
// This corresponds to the receiver's FLP count, where a value of 6 or more 
// (received FLPs) indicates that the Link Partner supports A/N.
//
//------------------------------------------------------------------------------
         par_AcknowledgeDetect_d2:  
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;

               else
                  // match_sr == 2'b11 indicates that 3 matching LCWs have been
                  // consecutively received (with ACK bit set).
                  // N.B.  match_sr has been reset since Ability match.
                  //
                  // Comparison is made against ability_match_lcw_reg, to ensure
                  // that received LCWs are same as those used to do Ability
                  // check. 
                  //
                  // Acknowledge match and Consistency match both good, so
                  // go on to complete acknowledgement process.
                  if ( (match_sr == 2'b11) &
                       ({rx_lcw_reg[15],rx_lcw_reg[13:0]} ==
                        {ability_match_lcw_reg[15],
                         ability_match_lcw_reg[13:0]}) )
                     // Next State
                     state <= par_CompleteAcknowledge;
 
                  else
                     // Acknowledge match but NO Consistency match,
                     // OR now receiving Idles from A/N Link Partner 
                     // (indicating that link has been lost or FLPs are not
                     // being received)... so disable transmission.
                     if (( (match_sr == 2'b11) &
                           ({rx_lcw_reg[15],rx_lcw_reg[13:0]} !=
                            {ability_match_lcw_reg[15],
                             ability_match_lcw_reg[13:0]})) |
                           (FLP_RECEIVE_IDLE == 1'b1) )
                        // Next State
                        state <= par_TransmitDisable;
 
                     else
                        // Maintain current state.
                        state <= par_AcknowledgeDetect_d2;
            end
               
     

//------------------------------------------------------------------------------
// Complete Acknowledge:
//
// Process where acknowledgement of Link Partner and its abilities is completed.
// Priority Resolution and Next Page exchange are handled in this process.
//
//------------------------------------------------------------------------------
         par_CompleteAcknowledge:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
                              
               else
                  // Remain in this state until acknowledge process is finished.
                  if (ACK_FINISHED == 1'b0)
                     // Next State
                     state <= par_CompleteAcknowledge;
                     
                  else
                     // Next Page exchange desired...
                     if ( (MR_NP_ABLE == 1'b1) & 
                          (desire_np == 1'b1) & 
                          (mr_lp_np_able == 1'b1) & 
                          (mr_np_loaded == 1'b1) & 
                          ((ne_np == 1'b1) | (lp_np == 1'b1)) )
                        // Next State
                        state <= par_NextPageWait_toggle;
                     
                     else     
                        // Neither device is Next Page able or desires to 
                        // engage in Next Page exchange OR both have
                        // Next Page ability but no intent to do an exchange.
                        if (((MR_NP_ABLE == 1'b0) |
                             (desire_np == 1'b0) | 
                             (mr_lp_np_able ==1'b0)) |
                            ((MR_NP_ABLE == 1'b1) &
                             (mr_lp_np_able == 1'b1) &
                             (ne_np == 1'b0) & 
                             (lp_np == 1'b0)) ) 
                             
                            begin
                            
                            // 100Mbps common mode. 
                            if ((base_shadw[8:7] & adv_ability[8:7]) != 2'b00)
                               // Next State...
                               state <=  par_FlpLinkGoodCheck;          

                            else 
                               // 10Mbps common mode. 
                               if ((base_shadw[6:5] & adv_ability[6:5])!=2'b00)
                                  // Next State...
                                  state <= par_ChangePLLFrequency; 
                                  
                               else
                                  // No common mode.
                                  // Return to renegotiation (TransmitDisable)
                                  // via FLPLinkGoodCheck state.
                                  // Since no PMA is enabled, this is a safe
                                  // path...
                                  state <=  par_FlpLinkGoodCheck;          
                            
                            end
                                                                 
                        else
                              // Next State...Remain in current state.
                              state <=  par_CompleteAcknowledge;
                              
                              
            // Outputs
            if (base_page == 1'b1) 
               begin
                  // NP bit of Link Partner base page indicates if it is capable
                  // of/wants to perform Next Page exchange. 
                  mr_lp_np_able     <= base_shadw[15];
                  
                  // desire_np indicates whether the Local Device wishes to 
                  // engage in Next Page exchange.
                  // Thus MR_NP_ABLE, which is primarily used to indicate that
                  // Local Device is CAPABLE of Next Page exchange, must be
                  // set by management to determine whether or not exchange 
                  // is desired.
                  desire_np         <= MR_NP_ABLE;

                  // 'No Common Mode' exists between devices if none of their
                  // advertised abilities match (bits A4:A0 of Technology
                  // Ability Field).
                  MR_NO_COMMON_MODE <= (
                              (base_shadw[9:5] & tx_lcw_reg[9:5]) == 5'b00000);
 
                  // bit [8] is the 100BASE-TX Full Duplex ability indicator.
                  // bits [8:6] are [100BASE-TX(fd),100BASE-TX,10BASE-T(fd)].
                  // Duplex mode is set if Local Device and Link Partner both
                  // have 100BASE-TX(fd) or 10BASE-T(fd) abilities).
                  MR_DUPLEX_MODE    <= (
                              ((base_shadw[8] & tx_lcw_reg[8]) == 1'b1) |
                              ((base_shadw[8:6] & tx_lcw_reg[8:6]) == 3'b001));
               end

                  
            else // Maintain existing values.                   
               begin
                  mr_lp_np_able     <= mr_lp_np_able;
                  desire_np         <= desire_np;
                  MR_NO_COMMON_MODE <= MR_NO_COMMON_MODE;
                  MR_DUPLEX_MODE    <= MR_DUPLEX_MODE;
               end
               
                      

            // When the CompleteAcknowledge state is entered, the Link Partner's
            // transmitted Toggle bit should be captured once.  This is achieved
            // by using the value of MR_PAGE_RX as a condition.   The NP bit of
            // both devices is also captured.
            if(MR_PAGE_RX == 1'b0) 
               begin
                  rx_toggle   <= rx_lcw_reg[11];   // Set rx_toggle bit.
                  lp_np       <= rx_lcw_reg[15];   // Capture LP's NP intention.
                  ne_np       <= tx_lcw_reg[15];   // Capture LD's NP intention.
               end
               
            else
               // Maintain existing values.
               begin
                  rx_toggle   <= rx_toggle;
                  lp_np       <= lp_np;   
                  ne_np       <= ne_np;   
               end
               
            // New Page has been received (i.e. Acknowledge and Consistency
            // matches are true and received LCW written to mr_lp_adv_ability 
            // via RX_LINK_CODE_WORD).  Now that this has been set, the values
            // of rx_toggle, lp_np and ne_np captured above cannot be
            // overwritten.
            MR_PAGE_RX <= 1'b1; 
            
         end



//------------------------------------------------------------------------------
// Spacer state used to invert the current value of tx_toggle and stop ACK bit
// being set in transmitted FLPs.
//------------------------------------------------------------------------------
         par_NextPageWait_toggle:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
               
               else
                  // Next State
                  state <= par_NextPageWait;
                  
                  
               // Outputs      
               tx_toggle <= ~tx_toggle;   // Invert tx_toggle value.
               transmit_ack <= 1'b0;      // Send FLPs without ACK bit set.
            
            end
                  



//------------------------------------------------------------------------------
// Next Page Process:
//
// Next Page LCW is constructed using A/N NP transmit register (Reg7) and
// tx_toggle bit.  This is now transmitted in the FLPs. 
//
// Since FLP is a Next Page, the base_page flag is reset.
// Since still in first NP cycle, the MR_PAGE_RX flag is reset.
// Since the A/N NP transmit register has been read, it should be reset.
//
// If three matching, consecutive FLP/LCWs are received (ignoring ACK bit), and
// the two devices toggle settings are correctly synchronized,  then the FSM 
// moves to the AcknowledgeDetect state.
//
// If FLP idles are received, the Link Partner is no longer attempting to
// negotiate, so break off and return to the TransmitDisable state.
//
//------------------------------------------------------------------------------
         par_NextPageWait:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;

               else
                  if ((match_sr == 2'b11) &  //ability match
                     ((rx_toggle ^ rx_lcw_reg[11]) == 1'b1))
                     // Next State
                     state <= par_AcknowledgeDetect;

                  else
                     if (FLP_RECEIVE_IDLE == 1'b1)
                        // Next State
                        state <= par_TransmitDisable;

                     else
                        // Next State
                        state <= par_NextPageWait;


               // Outputs
               MR_PAGE_RX        <= 1'b0;    // New Page not received.
               base_page         <= 1'b0;    // NP is not Base Page.
               mr_np_loaded_rst  <= 1'b1;    // Reset A/N Next Page transmit
                                             // register. 

               // Transmitted FLP constructed from A/N Next Page transmit
               // register and Toggle bit.
               tx_lcw_reg[15:12] <= TX_MR_AN_NP[15:12];  
               tx_lcw_reg[11]    <= tx_toggle;
               tx_lcw_reg[10:0]  <= TX_MR_AN_NP[10:0];

            end




//------------------------------------------------------------------------------
// Parallel Detection process:
//------------------------------------------------------------------------------
         par_LinkStatusCheck:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;

               else
                  // Checked against UNH-IOL test guidelines and 802.3 spec.
                  //
                  // Timer is started (reset) in this state. Transmission is
                  // also disabled, so Local Device doesn't send out FLPs.
                  //
                  // If no SINGLE link is ready immediately then the 
                  // ParallelDetectionFault state is entered (where all links
                  // are disabled and the mr_parallel_detection_fault flag is
                  // set).
                  //               
                  // If no single link is READY, 
                  if (single_link_ready == 1'b0)
                     // Next State
                     state <= par_ParallelDetectionFault;
 
                  else
                     // Next State
                     state <= par_LinkStatusCheck_t;
            end
                     


//------------------------------------------------------------------------------
// Parallel Detection timer state.
//
// If only one link is indicating READY then wait for timer to expire.
// If single link is still READY after expiry and is a 100Mbps link, then move 
// on to FLPLinkGoodCheck state.
//
// If the link is not to a 100Mbps Link Partner, change PLL frequency for 10Mbps
// operation (move to ChangePLLFrequency state).
//------------------------------------------------------------------------------
         par_LinkStatusCheck_t:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
 
               else
                  // Single link no longer ready during timer state...
                  if (single_link_ready == 1'b0)
                     // Next State
                     state <= par_ParallelDetectionFault;
 
                  else
                     // Wait for timer to expire...
                     if (autoneg_wait_timer_done == 1'b0)
                        // Next State
                        state <= par_LinkStatusCheck_t;

                     else
                        // If 10Mbps link is NOT READY or Local Device doesn't 
                        // have 10Mbps half duplex ability...
                        // ...it's a 100Mbps link or No Common Mode...
                        if ((NLP_LINK_STATUS & adv_ability[5]) == 1'b0)
                           // Next State
                           state <= par_FlpLinkGoodCheck;
 
                        else
                           // If link is 10Mbps and Local Device has 10Mbps
                           // ability, change PLL frequency for 10Mbps 
                           // operation.
                           // Next State
                           state <= par_ChangePLLFrequency;



               // Outputs
               
               // For Parallel Detection, 'No Common Mode' exists between 
               // devices if a 10Mbps Link Partner is READY (NLP Link Status
               // is true) but Local Device doesn't support HALF-DUPLEX
               // 10BASE-T operation    OR    a 100BASE-TX Link Partner is 
               // READY but Local Device doesn't support HALF-DUPLEX 100BASE-TX.
               // 
               // "NLP_LINK_STATUS" = link from 10BASE-T device is READY.
               // "tx_lcw_reg[5]" = Tech Ability field bit A0 = 10BASE-T HD.
               // 
               // "l100_link_status_reg1 == par_LS_Ready" = link from 100BASE-TX
               // Link Partner is READY.
               // "tx_lcw_reg[7]" = Tech Ability field bit A2 = 100BASE-TX HD.
               //
               // THERE IS NO PROVISION MADE FOR 100BASE-T4 because this device
               // implementation does not support it!
               //  
               MR_NO_COMMON_MODE <= ( (NLP_LINK_STATUS & 
                                       ~tx_lcw_reg[5]) |
                                      ((l100_link_status_reg1 == par_LS_Ready) &
                                       ~tx_lcw_reg[7]));
            
            end
                     


         
//------------------------------------------------------------------------------
// Parallel Detection Fault:
//
// If a single link was not READY in the LinkStatusCheck(_t) states, flag a
// Parallel Detection fault and disable all link controls.
// Return to Ability Detect state to try to reconnect to a single link.
//
//------------------------------------------------------------------------------
         par_ParallelDetectionFault:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
               
               else
                  // Wait for Link Controls to be disabled...
                  if ( (NLP_LINK_STATUS == 1'b1) | 
                       (l100_link_status_reg1 != par_LS_Fail) )
                     // Next State
                     state <= par_ParallelDetectionFault;
               
                  else
                     // Next State
                     state <= par_AbilityDetect;
                     
               
               // Outputs
               L100_LINK_CONTROL    <= par_LC_Disable;
               NLP_LINK_CONTROL     <= 1'b0;    // disable.
               
               // MR_PARALLEL_DETECTION_FAULT is reset in the 
               // AutoNegotiationEnable state and at Reset.
               // The Autoneg Expansion register which holds its value (Reg6)
               // is cleared when read (dig_regs.v).
               MR_PARALLEL_DETECTION_FAULT <= 1'b1;
 
            end
   


//------------------------------------------------------------------------------
// PLL is run at different frequencies for 10 and 100Mbps operation.
//
// 10Mbps   : PLL frequency = 160MHz.
// 100Mbps  : PLL frequency = 125MHz.
//
// Since operation is going to be at 10Mbps, SELECT_160MHZ is set.
//
//------------------------------------------------------------------------------
         par_ChangePLLFrequency:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
                  
               else
                  // Next State
                    state <= par_FlpLinkGoodCheck;
                  
               
               // Outputs
               SELECT_160MHZ     <= 1'b1;   // Switch to 160 MHz PLL.
            end




//------------------------------------------------------------------------------
// Priority Resolution Process:
//
// Used to determine Highest Common Denominator (HCD) technology to be enabled.
//
// Priority is determined based on data rate - 100Mbps ability takes precedence
// over 10Mbps ability.  
// The MR_DUPLEX_MODE flag completes the prioritization - full-duplex ability 
// takes precedence over half-duplex.
//
// Thus the overall prioritization for this device is:
//    100BASE-TX full duplex
//    100BASE-TX
//     10BASE-T full duplex
//     10BASE-T
//
//
// The resolution process ensures that enabling of the 10 and 100Mbps PMAs is
// mutually exclusive, and that the two cannot be enabled at once.
//
//
// The signal flp_link_good is not implemented in this module, as shown in IEEE
// 802.3, Figure 28-16, but the functionality is included when assigning the 
// values of TRANSMIT_ENABLE and RECEIVE_ENABLE.  i.e. on reaching the
// FLPLinkGood state, indicate that the A/N process is complete and set 
// Transmit and Receive functions to their Idle states.
//
//------------------------------------------------------------------------------
         par_FlpLinkGoodCheck:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
                  
               else
                  // Next State
                  state <= par_FlpLinkGoodCheck_t;
               
               
               // Outputs
               
               // If 100Mbps is highest common ability, enable 100BASE-TX PMA.
               //
               // base_shadw[8:7] = Tech ability field [A3:A2] = 100BASE-TXfd
               // and 100BASE-TX (respectively).
               // If lp and adv abilities match AND lp's autoneg facility is 
               // enabled OR 
               // adv ability is 100mbps and lp's autoneg is switched off AND
               // device is set to run at 100mbps (~160MHz means PLL is set to
               // 125MHz for A/N)...
               
               
               // If Link Partner is not A/N-able, then resolution is by 
               // Parallel Detection, and so only valid if Local Device has
               // half-duplex ability.
               if ( ((|(base_shadw[8:7] & adv_ability[8:7]) & 
                      MR_LP_AUTONEG_ABLE) |
                     (adv_ability[7] & ~MR_LP_AUTONEG_ABLE)) & 
                     ~SELECT_160MHZ &
                     ~MR_NO_COMMON_MODE)
                     
                  // Enable 100BASE-T link control.
                  L100_LINK_CONTROL <= par_LC_Enable; 
                  
               else   
                  // Disable 100BASE-TX PMA.
                  L100_LINK_CONTROL <= par_LC_Disable;     
                      
                      
               // If 10Mbps mode is selected, and a common mode exists...
               // If Link Parnter is A/N-able, then enable 10Mbps link control
               // for either full-duplex or half-duplex ability.
               // If Link Partner is A/N-UNABLE, then link resolution has been
               // attempted by Parallel Detection, so only enable 10Mbps link 
               // control if Local Device has half-duplex ability (802.3, 
               // 28.2.3.1, Note 2).
               L10_LINK_CONTROL  <= (( (|(base_shadw[6:5] & adv_ability[6:5]) & 
                                        MR_LP_AUTONEG_ABLE) |
                                        (adv_ability[5] & 
                                        ~MR_LP_AUTONEG_ABLE) ) &
                                         SELECT_160MHZ &
                                         ~MR_NO_COMMON_MODE);
               
               // Disable NLP link control - switch off Linktest function.
               // (since only used during autonegotiation process).
               NLP_LINK_CONTROL  <= 1'b0;    // disable


            end


//------------------------------------------------------------------------------
// FlpLinkGoodCheck timer state:
// Type of connection (10 or 100Mbps) is irrelevant.
//------------------------------------------------------------------------------
         par_FlpLinkGoodCheck_t: //Type of connection (10 or 100) is irrelevant.
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
                  
               else
                  // If 10Mbps enabled and link status is OK, OR
                  // 100Mbps link enabled AND link status is OK.
                  if ((L10_LINK_CONTROL && l10_link_status_reg[1]) | 
                      ((L100_LINK_CONTROL == par_LC_Enable) &
                       (l100_link_status_reg1 == par_LS_OK)) )
                     // Next State
                     state <= par_FlpLinkGood;
               
                  else
                     // Timer used when link is first established to determine 
                     // accuracy of a FAIL or READY link_status condition.
                     // Link is considered FAILED if link timer expires before
                     // link has not moved to OK status.
                     
                     // Link is in FAIL or READY status when timer expires, 
                     // so back to TransmitDisable state.
                     if (link_fail_inhibit_timer_done == 1'b1)
                       // Next State
                        state <= par_TransmitDisable;
                        
                     else
                        // Wait for timer/link status to change.
                        // Next State
                        state <= par_FlpLinkGoodCheck_t;   
             
            end
                    
                    
                     
                    
//------------------------------------------------------------------------------
// Operational Link State:
//
// The link has been negotiated and enabled; transmission of data between Local
// Device and Link Partner can now take place.
//
// The Autonegotiation process is flagged as being complete.
//
// When the link status changes to FAIL, the FSM returns to the TransmitDisable
// state.
//
// The signal flp_link_good is not implemented in this module, as shown in IEEE
// 802.3, Figure 28-16, but the functionality is included when assigning the 
// values of TRANSMIT_ENABLE and RECEIVE_ENABLE.  i.e. on reaching the
// FLPLinkGood state, indicate that the A/N process is complete and set 
// Transmit and Receive functions to their Idle states.
//
//------------------------------------------------------------------------------
         par_FlpLinkGood:
            begin
               if (initialize == 1'b1)
                  // Next State
                  state <= par_AutoNegotiationEnable;
                  
               else
                  // Link status remains OK, so maintain present state.
                  if ((L10_LINK_CONTROL && l10_link_status_reg[1]) | 
                      ((L100_LINK_CONTROL == par_LC_Enable) &
                       (l100_link_status_reg1 == par_LS_OK)) )
                     // Next State
                     state <= par_FlpLinkGood;
                  
                  else
                     // Return to TransmitDisable state if link status 
                     // becomes FAIL or READY (802.3 only specifies FAIL).
                     // Next State
                     state <= par_TransmitDisable;
                     
               // Outputs
               MR_AUTONEG_COMPLETE <= 1'b1;     // A/N is now complete.
  
            end
            
            

//------------------------------------------------------------------------------
// Default state - 'idle'.
//------------------------------------------------------------------------------
         default:
                  state <= par_AutoNegotiationEnable;
   

      endcase  // end of arbitration FSM



//------------------------------------------------------------------------------
// Input Synchronizers used in FSM
//
// autoneg_enable: MR_AUTONEG_ENABLE should be a FLAG that is set for the 
// duration of the A/N process, in order to keep autoneg_enable[1] set.  This 
// will prevent 'initialize' from becoming active (save for a 'restart').
//
// restart_negotiation: MR_RESTART_NEGOTIATION need only be a single-cycle 
// strobe in order to activate 'initialize' (after one cycle), which resets the 
// A/N process.  2 bit shift also implements meta-stability.
//
// The l100_link_status_regX registers appear to be 'delay' registers, to hold
// the input value of L100_LINK_STATUS for 1 and 2 cycles (respectively).  
// l100_link_status_reg0 <- previous value of L100_LINK_STATUS.
// l100_link_status_reg1 <- value of L100_LINK_STATUS 2 cycles ago.
// 
// Similarly, the l10_link_status_reg register acts as a mini shift register to
// hold 2 cycles-worth of previous L10_LINK_STATUS values.
// 
//------------------------------------------------------------------------------
      
      restart_negotiation     <= {restart_negotiation[1:0],
                                  MR_RESTART_NEGOTIATION};
      l100_link_status_reg0   <= L100_LINK_STATUS;
      l100_link_status_reg1   <= l100_link_status_reg0;
      l10_link_status_reg     <= {l10_link_status_reg[0],L10_LINK_STATUS};
      end 

   else
      begin
      state                       <= state;
      MR_AUTONEG_COMPLETE         <= MR_AUTONEG_COMPLETE;
      MR_DUPLEX_MODE              <= MR_DUPLEX_MODE;
      MR_LP_AUTONEG_ABLE          <= MR_LP_AUTONEG_ABLE;    
      MR_NO_COMMON_MODE           <= MR_NO_COMMON_MODE;    
      MR_PAGE_RX                  <= MR_PAGE_RX;    
      MR_PARALLEL_DETECTION_FAULT <= MR_PARALLEL_DETECTION_FAULT;    
      MR_REMOTE_FAULT             <= MR_REMOTE_FAULT;    
      SELECT_160MHZ               <= SELECT_160MHZ;    
      desire_np                   <= desire_np;    
      restart_negotiation         <= restart_negotiation;  
      transmit_ack                <= transmit_ack;    
      tx_lcw_reg                  <= tx_lcw_reg;
      mr_lp_np_able               <= mr_lp_np_able;    
      base_page                   <= base_page;    
      adv_ability                 <= adv_ability;   
      ability_match_lcw_reg       <= ability_match_lcw_reg;   
      tx_toggle                   <= tx_toggle;    
      rx_toggle                   <= rx_toggle;    
      L100_LINK_CONTROL           <= L100_LINK_CONTROL;
      L10_LINK_CONTROL            <= L10_LINK_CONTROL;          
      NLP_LINK_CONTROL            <= NLP_LINK_CONTROL;          
      l100_link_status_reg1       <= l100_link_status_reg1; 
      l100_link_status_reg0       <= l100_link_status_reg0;
      l10_link_status_reg         <= l10_link_status_reg;
      end

end // p_arbitration_fsm




//------------------------------------------------------------------------------
// Control of: - timeout1
//             - match_sr
//             - rx_valid_reg
//             - rx_lcw_reg
//             - timer
//
// timeout1 is a local copy of TIMEOUT input. It is set in certain states to
//          prevent match_sr from incrementing, i.e. to prevent FLPs from being
//          detected if the Receive funciton timed out (setting TIMEOUT = 1).
//
// match_sr is a 2 bit shift register used as part of Ability, Acknowledge and
//          Consistency matches, to indicate 3 consecutive, matching LCWs
//          have been received (regardless of LCW content). 
//
// rx_valid_reg is set if an FLP is successfully received by the A/N Receive
//              function.
//
// rx_lcw_reg is a local register storing the last received link code word 
//            (rx_link_code_word).
//
//
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge RESET )
begin: p_controllers

   if(RESET)
      begin 
         timeout1     <= 1'b0;   
         match_sr     <= 2'b00;  
         rx_lcw_reg   <= 16'd0;  
         rx_valid_reg <= 1'b0;
      end   
   
   else if (clk12_5_enable)
      begin
         if( (state == par_TransmitDisable) | 
             (state == par_ParallelDetectionFault) |
             (state == par_AcknowledgeDetect) |  
             (TIMEOUT == 1'b1)) 
            begin
               match_sr     <= 2'b00;  // Fault,busy or timeout state.
               rx_valid_reg <= 1'b0;
    
               if (TIMEOUT == 1'b1)
                  // Local timeout1 follows master TIMEOUT.
                  timeout1 <= 1'b1;
               
               else
                  // Maintain existing value. 
                  timeout1 <= timeout1;
                  
            end
            
            
         else
            if (RCV_DONE == 1'b1)   // RCV_DONE is a strobe.
               begin
                  // match_sr is a LSB->MSB shift-register which is fed a '1' if
                  // two consecutive, received LCWs match.  The comparison 
                  // includes the ACK bit and also checks for timeout and the
                  // AcknowledgeDetect_d state. 
                  //
                  // This test forms the basis of the Ability, Acknowledge and
                  // Consistency tests that are carried out.
                  //
                  // (rx_lcw_reg[14] & RX_LINK_CODE_WORD[14]) checks that ACK
                  // bit is set (required for Acknowledge Match).
                  // 
                  // The (state != par_AcknowledgeDetect_d2) condition allows
                  // the (rx_lcw_reg[14] & RX_LINK_CODE_WORD[14]) condition 
                  // to be overridden.  Hence the logic provides a valid 
                  // match_sr value for the Ability Match.
                  //                  
                  match_sr <= 
                        {match_sr[0], 
                         (rx_valid_reg &
                         (({RX_LINK_CODE_WORD[15],RX_LINK_CODE_WORD[13:0]} ==
                          {rx_lcw_reg[15],rx_lcw_reg[13:0]}) & 
                          !timeout1 ) &
                         ((state != par_AcknowledgeDetect_d2) |    
                          (rx_lcw_reg[14] & 
                          RX_LINK_CODE_WORD[14]) ))};
   
                  rx_lcw_reg   <= RX_LINK_CODE_WORD;  // Put newly received LCW 
                                                      // into 'internal' 
                                                      // register.
                  rx_valid_reg <= 1'b1;               // LCW received OK.
               
               
                  // If already on, timeout1 is reset when RCV_DONE is set, 
                  // i.e another FLP has been received (which means the timeout
                  // condition must be over).
                  if (timeout1 == 1'b1)
                     timeout1 <= 1'b0;
               
                  else 
                     timeout1 <= timeout1;
               end
    
            else // Maintain existing values.
               begin
                  match_sr       <= match_sr;
                  rx_lcw_reg     <= rx_lcw_reg;
                  rx_valid_reg   <= rx_valid_reg;  
               end
      end    

   else
      begin 
      timeout1     <= timeout1;   
      match_sr     <= match_sr;  
      rx_lcw_reg   <= rx_lcw_reg;  
      rx_valid_reg <= rx_valid_reg;
      end   

end // p_controllers


   
//------------------------------------------------------------------------------
// timer is a counter variable used to implement the various counters with the
//       Arbitration module.  None of the counters overlap, so a single variable
//       can be used. 
//------------------------------------------------------------------------------
always @(posedge CLKPLL_IN or posedge RESET)
   begin: p_timer
      
      if (RESET==1'b1)
         timer <= {par_Arbitration_Timer_Size{1'b0}}; // Reset timer.
         
      else if (clk12_5_enable)
         if ( (state == par_AutoNegotiationEnable) |
              (state == par_TransmitDisable) |
              (state == par_LinkStatusCheck) |
              (state == par_ChangePLLFrequency) |
              (state == par_FlpLinkGoodCheck)
            )
            timer <= {par_Arbitration_Timer_Size{1'b0}};   // Reset timer.
   
         else
            if (!(autoneg_wait_timer_done &&
                  break_link_timer_done &&
                  link_fail_inhibit_timer_done) )
               // Increment counter.
               timer <= timer + {{(par_Arbitration_Timer_Size-1){1'b0}},1'b1}; 
            
            else
               // Maintain present value.
               timer <= timer; 
      else
         timer <= timer; 

   end //p_timer
//------------------------------------------------------------------------------





//------------------------------------------------------------------------------
// CONTINUAL UPDATE OF MR_NEXT_PAGE_LOADED on every clock. 
//------------------------------------------------------------------------------
always @ (posedge CLKPLL_IN or posedge RESET)
begin: p_np_loaded_sync  

   if (RESET==1'b1)
      np_loaded_sync <= 1'b0;
   else if (clk12_5_enable)
      np_loaded_sync <= MR_NEXT_PAGE_LOADED;
   else
      np_loaded_sync <= np_loaded_sync;

end   // p_np_loaded_sync



//------------------------------------------------------------------------------
// Local flag indicating state of A/N Next Page transmit register (Reg 7).
//------------------------------------------------------------------------------
always @ (posedge CLKPLL_IN or posedge np_loaded_rst)
begin: p_mr_np_loaded 
 
   if (np_loaded_rst)
      mr_np_loaded <= 1'b0;
   else if (clk12_5_enable) 
      mr_np_loaded <= (mr_np_loaded | np_loaded_sync);
   else
      mr_np_loaded <= mr_np_loaded;

end   // p_mr_np_loaded


   
//------------------------------------------------------------------------------
// AN_ACTIVE and AN_ACTIVE_XTND:
//
// 802.3 Figure 28-16, Arbitration state diagram uses two signals to indicate
// that A/N is complete, in 2 different places !:
//    - flp_link_good, generated in FlpLinkGoodCheck state.
//    - mr_autoneg_complete, generated in FlpLinkGood state.
// 
// Hence it seems fair to use two separate signals to indicate A/N completion
// at different times.  This justifies the uses of the following signals
// (N.B. 802.3 naming not used due to legacy issues - not worth changing
// at the moment):
//    - AN_ACTIVE = A/N process is active up until FlpLinkGoodCheck state.
//    - AN_ACTIVE_XTND = A/N process is active up until FlpLinkGood state.
//
//------------------------------------------------------------------------------
// AN_ACTIVE signal indicates that A/N process is active up until 
// FlpLinkGoodCheck state.
// It is used by dig_reset to control the PMD disable signals, to 
// allow the correct pll to be activated for the resolved link speed
// (i.e. 10 or 100).
//------------------------------------------------------------------------------
always @ (initialize or L100_LINK_CONTROL or L10_LINK_CONTROL)
begin: p_an_active
   if ((initialize == 1'b1) |
       ((L100_LINK_CONTROL == par_LC_Enable) |
        (L10_LINK_CONTROL  == 1'b1)))
       AN_ACTIVE = 1'b0;
   else
       AN_ACTIVE = 1'b1;
end   // p_an_active


//------------------------------------------------------------------------------
// AN_ACTIVE XTND signal indicates that A/N process is active up until 
// FlpLinkGood state.
// It is used by dig_clk.v to keep the A/N clk12_5_ctrl signal
// active long enough for the link to be established.
//------------------------------------------------------------------------------
always @ (initialize or MR_AUTONEG_COMPLETE)
begin: p_an_active_xtnd
   if ((initialize == 1'b1) | (MR_AUTONEG_COMPLETE == 1'b1))
      AN_ACTIVE_XTND = 1'b0;
   else
      AN_ACTIVE_XTND = 1'b1;
end   // p_an_active_xtnd


   

//------------------------------------------------------------------------------
endmodule   // dig_an_arbitration

// Created by ihdl
module dig_an_autonegotiation (
      
         // Inputs
         CLKPLL_IN,
         clk12_5_enable,
         clkfast_enable,
         LINK10_DOWN, 
         L100_LINK_STATUS,
         MR_ADV_ABILITY, 
         MR_AUTONEG_ENABLE, 
         MR_NEXT_PAGE_LOADED,
         MR_NP_ABLE, 
         MR_RESTART_NEGOTIATION, 
         NEG_DETECT, 
         POS_DETECT, 
         RESET,
         TX_MR_AN_NP,
         MR_FORCE_TIMER,
         MR_FAST_LINK,

         // Outputs
         L10_LINK_CONTROL,
         L100_LINK_CONTROL, 
         LINK_DET,
         MR_AN_NP_LCW_TOGGLE, 
         MR_AUTONEG_COMPLETE, 
         MR_BASE_PAGE,
         MR_DUPLEX_MODE, 
         MR_LP_ADV_ABILITY, 
         MR_LP_AUTONEG_ABLE,
         MR_LP_NP_ABLE, 
         MR_NO_COMMON_MODE, 
         MR_PAGE_RX,
         MR_PARALLEL_DETECTION_FAULT, 
         MR_REMOTE_FAULT, 
         SELECT_160MHZ, 
         TXD,
         TXE, 
         T_PULSE,
         an_debug_bus,
         AN_ACTIVE,
         AN_ACTIVE_XTND
         );



// I/O Declarations
// Inputs
input          CLKPLL_IN;                    // System clock 125MHz/160MHz
input          clk12_5_enable;               // 12.5MHz Clock enable
input          clkfast_enable;               // clkfast enable.
input          LINK10_DOWN;                  // Inverted status of 10Mbps PMA.
input          MR_AUTONEG_ENABLE;            // Flag to start A/N process.
input          MR_NEXT_PAGE_LOADED;          // Flagged when A/N Next Page 
                                             // Transmit Reg (Reg7) is written
                                             // to.
input          MR_NP_ABLE;                   // Local Device is Next Page able
                                             // and has a page to send.
input          MR_RESTART_NEGOTIATION;       // Strobed to restart A/N process.
input          NEG_DETECT;                   // Negative analog comparator 
                                             // output.
input          POS_DETECT;                   // Positive analog comparator
                                             // output.
input          RESET;                        // External reset.
input [13:0]   MR_ADV_ABILITY;               // Local Device abilities.
input [15:0]   TX_MR_AN_NP;                  // A/N Next Page Transmit Reg 
                                             // (Reg7).
input [1:0]    L100_LINK_STATUS;             // Status of 100Mbs PMA.
input          MR_FORCE_TIMER;               // Mux/Debug flag: use short timer
                                             // values to speed up tests.
input          MR_FAST_LINK;               // Mux/Debug: use tx10 short timer.


// Outputs 
output         L10_LINK_CONTROL;             // Flag indicates link status
                                             // for 10Mbps comms as OK, READY
                                             // or FAIL.
output         LINK_DET;                     // Set if  Link is detected/
                                             // connected.
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
output         SELECT_160MHZ;                // Flag true for 10Mbps operation
                                             // (160MHz PLL); false for
                                             // 100Mbps (125MHz).
output         TXD;                          // Transmit data.
output         TXE;                          // Transmit enable.
output         T_PULSE;                      // Flag indicating that LCW is 
                                             // being transmitted.
output [1:0]   L100_LINK_CONTROL;            // 2-bit flag indicates link status
                                             // for 100Mbps comms as OK, READY
                                             // or FAIL.
output [15:0]  MR_LP_ADV_ABILITY;            // Received Base Page LCW from
                                             // Link Partner, advertising its
                                             // abilities. 
output [15:0]  an_debug_bus;                 // Mux/Debug bus of signals from
                                             // within A/N modules.
output         AN_ACTIVE;                    // Flag to indicate that A/N is in
                                             // progress (until link control is 
                                             // enabled).
output         AN_ACTIVE_XTND;               // Flag to indicate that A/N is in
                                             // progress (until
                                             // MR_AUTONEG_COMPLETE is set).


// I/O Definitions
// Inputs
wire           CLKPLL_IN;                    // System clock
wire           clk12_5_enable;               // 12.5MHz clock enable
wire           clkfast_enable;               // clkfast enable
wire           LINK10_DOWN;                  // Inverted status of 10Mbps PMA.
wire           MR_AUTONEG_ENABLE;            // Flag to start A/N process.
wire           MR_NEXT_PAGE_LOADED;          // Flagged when A/N Next Page 
                                             // Transmit Reg (Reg7) is written
                                             // to.
wire           MR_NP_ABLE;                   // Local Device is Next Page able
                                             // and has a page to send.
wire           MR_RESTART_NEGOTIATION;       // Strobed to restart A/N process.
wire           NEG_DETECT;                   // Negative analog comparator 
                                             // output.
wire           POS_DETECT;                   // Positive analog comparator
                                             // output.
wire           RESET;                        // External reset.
wire  [13:0]   MR_ADV_ABILITY;               // Local Device abilities.
wire  [15:0]   TX_MR_AN_NP;                  // A/N Next Page Transmit Reg 
                                             // (Reg7).
wire  [1:0]    L100_LINK_STATUS;             // Status of 100Mbs PMA.
wire           MR_FORCE_TIMER;               // Mux/Debug flag: use short timer
                                             // values to speed up tests.
wire           MR_FAST_LINK;               // Mux/Debug: use tx10 short timer.
           
                                             
// Outputs
wire           L10_LINK_CONTROL;             // Flag indicates link status
                                             // for 10Mbps comms as OK, READY
                                             // or FAIL.
wire           LINK_DET;                     // Set if  Link is detected/
                                             // connected.
wire           MR_AN_NP_LCW_TOGGLE;          // NEXT PAGE link code word toggle 
                                             // bit value.
wire           MR_AUTONEG_COMPLETE;          // Flag set to indicate that A/N is
                                             // complete.
wire           MR_BASE_PAGE;                 // Flag set if the LCW currently
                                             // being transmitted by Local
                                             // Device is a Base Page LCW.
wire           MR_DUPLEX_MODE;               // Flag is set if device is FULL
                                             // DUPLEX.
wire           MR_LP_AUTONEG_ABLE;           // Flag set if Link Partner is able
                                             // to perform A/N.
wire           MR_LP_NP_ABLE;                // Flag set if Link Partner is able
                                             // to perform NEXT PAGE exchange.
wire           MR_NO_COMMON_MODE;            // Flag set if Local Device and
                                             // Link Partner have no common
                                             // comms rate (e.g. LD=100, LP=10).
wire           MR_PAGE_RX;                   // Flag set if a New Page has
                                             // been received.
wire           MR_PARALLEL_DETECTION_FAULT;  // Flag set if none or more than 1
                                             // potential Link Partner reported
                                             // READY when 'autoneg_wait_timer'
                                             // expires.
wire           MR_REMOTE_FAULT;              // Optional - NOT implemented.
wire           SELECT_160MHZ;                // Flag true for 10Mbps operation
                                             // (160MHz PLL); false for
                                             // 100Mbps (125MHz).
wire           TXD;                          // Transmit data.
wire           TXE;                          // Transmit enable.
wire           T_PULSE;                      // Flag indicating that LCW is 
                                             // being transmitted.
wire   [1:0]   L100_LINK_CONTROL;            // 2-bit flag indicates link status
                                             // for 100Mbps comms as OK, READY
                                             // or FAIL.
wire   [15:0]  MR_LP_ADV_ABILITY;            // Received Base Page LCW from
                                             // Link Partner, advertising its
                                             // abilities. 
wire   [15:0]  an_debug_bus;                 // Mux/Debug bus of signals from
                                             // within A/N modules.
wire           AN_ACTIVE;                    // Flag to indicate that A/N is in
                                             // progress (until link control is 
                                             // enabled).
wire           AN_ACTIVE_XTND;               // Flag to indicate that A/N is in
                                             // progress (until
                                             // MR_AUTONEG_COMPLETE is set).
                                             

// Internal wires
wire           ack_finished;                 // Set when specified number of
                                             // FLPs with ACK bit set have been
                                             // transmitted.
wire           flp_receive_idle;             // Set while system waits for/tries
                                             // to recognise an FLP burst.
wire           nlp_link_status;              // LINK_STATUS from dig_an_linktest
                                             // set when linktest is in 
                                             // LinkTestPass state (linkpulses 
                                             // being received) i.e. Link 
                                             // Partner is 10BASE-T able.
wire           rcv_done;                     // Set when link code word has 
                                             // been successfully decoded from
                                             // FLP burst.
wire           timeout;                      // Set if FLP burst does not arrive
                                             // within given time frame.
wire           complete_ack;                 // Strobe to count/don't count 
                                             // LCWs with ACK bit set.
wire           nlp_link_control;             // LINK_CONTROL signal to
                                             // dig_an_linktest.
wire           receive_enable;               // Flag indicating FSM is in an
                                             // ACKNOWLEDGE detect, ABILITY
                                             // detect, or NEXT PAGE state.
                                             // i.e. Talking or waiting to
                                             // talk...
wire           transmit_enable;              // Flag indicating FSM is in an
                                             // ACKNOWLEDGE detect, ABILITY
                                             // detect, or NEXT PAGE state.
wire  [15:0]   tx_link_code_word;            // Link Code Word to be
                                             // transmitted.
wire  [7:0]    arb_intl_bus;                 // Mux/Debug bus of internal
                                             // dig_an_arbitration signals.
wire           td_autoneg;                   // Signal to MDI to transmit a 
                                             // (Link Integrity Test) pulse.
wire           linkpulse;                    // Strobe indicating that a valid 
                                             // link pulse has been received.
wire           L10_LINK_STATUS;              // Status of 10Mbps PMA.

 
//------------------------------------------------------------------------------
// an_debug_bus for Mux/Debug system.
//
// Encapsulate the desired 'internal' debug signals from the various A/N modules
// into a single output, for routing to chip-level (via top_digital.v) as part
// of Mux/Debug system.
//
// Desired signals that are already outputs of this module are not included in
// the bus, and are picked up individually at the appropriate level.
//
//------------------------------------------------------------------------------
assign an_debug_bus = { rcv_done,
                        arb_intl_bus,
                        tx_link_code_word[14],
                        td_autoneg,
                        ack_finished,
                        flp_receive_idle,
                        timeout,
                        nlp_link_status,
                        linkpulse
                      };
                  

//------------------------------------------------------------------------------
// L10_LINK_STATUS is the inverted state of LINK10_DOWN.
//
// i.e. Since LINK10_DOWN=1'b0 indicates that a 10BASE-T PMA link is up, the
//      assignment is inverted so that L10_LINK_STATUS=1'b1 also indicates the 
//      link is up.
//
//------------------------------------------------------------------------------
assign L10_LINK_STATUS = !LINK10_DOWN;





                                             
//------------------------------------------------------------------------------
// Module Instantiations
//------------------------------------------------------------------------------

// Arbitration Module
dig_an_arbitration i_dig_an_arbitration( 
      
         // Inputs
         .CLKPLL_IN(CLKPLL_IN), 
         .clk12_5_enable(clk12_5_enable), 
         .ACK_FINISHED(ack_finished), 
         .FLP_RECEIVE_IDLE(flp_receive_idle),
         .L100_LINK_STATUS(L100_LINK_STATUS), 
         .L10_LINK_STATUS(L10_LINK_STATUS), 
         .MR_ADV_ABILITY(MR_ADV_ABILITY),
         .MR_AUTONEG_ENABLE(MR_AUTONEG_ENABLE), 
         .MR_RESTART_NEGOTIATION(MR_RESTART_NEGOTIATION), 
         .MR_NEXT_PAGE_LOADED(MR_NEXT_PAGE_LOADED), 
         .MR_NP_ABLE(MR_NP_ABLE),
         .NLP_LINK_STATUS(nlp_link_status),
         .RCV_DONE(rcv_done), 
         .RESET(RESET), 
         .RX_LINK_CODE_WORD(MR_LP_ADV_ABILITY),
         .TX_MR_AN_NP(TX_MR_AN_NP), 
         .TIMEOUT(timeout),
         .MR_FORCE_TIMER(MR_FORCE_TIMER), 

         // Outputs
         .COMPLETE_ACK(complete_ack), 
         .L100_LINK_CONTROL(L100_LINK_CONTROL),
         .L10_LINK_CONTROL(L10_LINK_CONTROL), 
         .MR_AUTONEG_COMPLETE(MR_AUTONEG_COMPLETE), 
         .MR_DUPLEX_MODE(MR_DUPLEX_MODE),
         .MR_LP_AUTONEG_ABLE(MR_LP_AUTONEG_ABLE),
         .MR_NO_COMMON_MODE(MR_NO_COMMON_MODE), 
         .MR_PAGE_RX(MR_PAGE_RX),
         .MR_PARALLEL_DETECTION_FAULT(MR_PARALLEL_DETECTION_FAULT), 
         .MR_REMOTE_FAULT(MR_REMOTE_FAULT), 
         .NLP_LINK_CONTROL(nlp_link_control),
         .RECEIVE_ENABLE(receive_enable), 
         .SELECT_160MHZ(SELECT_160MHZ), 
         .TRANSMIT_ENABLE(transmit_enable),
         .TX_LINK_CODE_WORD(tx_link_code_word), 
         .MR_LP_NP_ABLE(MR_LP_NP_ABLE), 
         .MR_BASE_PAGE(MR_BASE_PAGE),
         .MR_AN_NP_LCW_TOGGLE(MR_AN_NP_LCW_TOGGLE),
         .arb_intl_bus(arb_intl_bus),
         .AN_ACTIVE(AN_ACTIVE),         
         .AN_ACTIVE_XTND(AN_ACTIVE_XTND)         
         );
    
         

// Autonegotiation Transmitter          
dig_an_transmit i_dig_an_transmit( 
      
         // Inputs
         .CLKPLL_IN(CLKPLL_IN), 
         .clk12_5_enable(clk12_5_enable), 
         .COMPLETE_ACK(complete_ack),
         .RESET(RESET), 
         .TRANSMIT_ENABLE(transmit_enable), 
         .TX_LINK_CODE_WORD(tx_link_code_word),
         .MR_FORCE_TIMER(MR_FORCE_TIMER), 

         // Outputs
         .ACK_FINISHED(ack_finished), 
         .TD_AUTONEG(td_autoneg), 
         .T_PULSE(T_PULSE) 
         );
         
         
         
// Autonegotiation Receiver          
dig_an_receive i_dig_an_receive ( 

         // Inputs
         .CLKPLL_IN(CLKPLL_IN), 
         .clk12_5_enable(clk12_5_enable), 
         .LINKPULSE(linkpulse), 
         .RESET(RESET), 
         .RECEIVE_ENABLE(receive_enable), 
         .MR_FORCE_TIMER(MR_FORCE_TIMER), 

         // Outputs
         .FLP_RECEIVE_IDLE(flp_receive_idle), 
         .RCV_DONE(rcv_done), 
         .RX_LINK_CODE_WORD(MR_LP_ADV_ABILITY),
         .TIMEOUT(timeout) 
         );
    
         
         
// Autonegotiation Transmit/Receive at 10Mbps         
dig_an_txrx10 i_dig_an_txrx10 ( 
         
         // Inputs  
         .CLKPLL_IN(CLKPLL_IN),
         .clkfast_enable(clkfast_enable), 
         .clk12_5_enable(clk12_5_enable), 
         .NEG_DETECT(NEG_DETECT),
         .POS_DETECT(POS_DETECT), 
         .RESET(RESET), 
         .TD_AUTONEG(td_autoneg), 

         // Outputs
         .LINKPULSE(linkpulse), 
         .TXD(TXD), 
         .TXE(TXE)
         );
 
         
         
// Autonegotiation Linktest         
dig_an_linktest i_dig_an_linktest ( 

         // Inputs
         .CLKPLL_IN(CLKPLL_IN), 
         .clk12_5_enable(clk12_5_enable), 
         .LINK_CONTROL(nlp_link_control),
         .LINK_TEST_RCV(linkpulse), 
         .RESET(RESET), 
         .L100_LINK_STATUS(L100_LINK_STATUS), 
         .L10_LINK_STATUS(L10_LINK_STATUS),
         .MR_FAST_LINK(MR_FAST_LINK),


         // Outputs
         .LINK_STATUS(nlp_link_status), 
         .LINK_DET(LINK_DET)
         );
         
         
//------------------------------------------------------------------------------
endmodule

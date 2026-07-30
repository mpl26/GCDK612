// Created by ihdl
`timescale 1 ns / 1 ps

module dig_regs ( 
                  //Inputs
                  CLKXTAL, REG_ENAB, REG_R_NW, REG_ADDR, REG_DIN, RESETREG,
                  SM_DATA_READ, MR_RESET_DONE, MR_AN_COMPLETE, 
                  MR_AN_LP_ABILITY, MR_AN_DUPLEX_MODE,
                  MR_AN_NP_LCW_TOGGLE, MR_PARALLEL_DETECTION_FAULT, 
                  MR_PAGE_RX, MR_LP_AN_ABLE,
                  MRAN_REMOTE_FAULT, SELECT_160MHZ,
                  MR_NO_COMMON_MODE, MR_POL_REVERSED,
                  LINK_DOWN_10, LINK_DOWN_100, JABBER_DETECTED,
                  ANDIS_I, AN_ACTIVE, L10_LINK_CONTROL, 
                  L100_LINK_CONTROL, MDIX, TX_AMP_TRIM, TX_SLP_TRIM,
                  PHY, CLKPLL_IN, RESETPLL,

                  //Outputs
                  REG_DOUT, SM_DATA_WRITE, SM_WRITE, 
                  MR_RESET_TO_RCB, MR_DIG_LOOP_BACK_ENAB_pll, MR_100MBS,
                  MR_100MBS_pll, MR_AN_ENAB, MR_AN_ENAB_pll,
                  MR_POWER_DOWN, MR_ISOLATE_TX_pll, MR_AN_RESTART,
                  MR_FULL_DUPLEX_pll, MR_COL_TEST_pll,
                  MR4_REMOTE_FAULT_pll, MR_FLOW_CTL_pll, MR_TAF_100FULL_pll,
                  MR_TAF_100HALF_pll, MR_TAF_10FULL_pll, MR_TAF_10HALF_pll,
                  MR_SELECTOR_pll,
                  MR_AN_NP, MR_NEXT_PAGE_LOADED_pll,
                  MR_RXTX_TEST_pll, MR_MII_LOOP_BACK_DISB_pll,
                  MR_SQE_ENAB_pll, MR_JABBER_ENAB_pll, MR_LINK_TEST_DISB_pll,
                  MR_SYMBOL_MODE, MR_SYMBOL_MODE_pll, MR_ALIGN_DISB,
                  MR_BYPASS_SCRAMBLER, MR_BYPASS_SCRAMBLER_pll,
                  MR_TP_DISC, MR_BYPASS10TX_FILTER_pll, 
                  MR_BYPASS10RX_FILTER, MR_SQUELCH_RANGE, MR_SQUELCH_DISB,
                  MR_POL_CORR_DISB_pll, MR_RX10_PLL_MAX_ADJ_SHIFT_pll,
                  MR_MII100_LOOP_BACK_ENAB_pll, MR_MSE_NORESET_pll, 
                  MR_NP_ENAB, MR_MDIX_DISB, MR_MDIX_FORCE, TX_AMPTRIM,
                  TX_SLOPETRIM, TEST_MODE, MR_SCRAMBLER_SEED_pll, 
                  MR_SCRAMBLER_LOAD,
                  MR_PHY, MR_ERR_THRESH_pll, MR_ERR_TIMER_pll, MDINT,
                  MR_FEF_DISB_pll,
                  MR_FORCE_TIMER,
                  MR_TEST_MODE,
                  MR_FAST_LINK,
                  MR_FAST_JABBER,
                  MR_FAST_MSE
                  );
//
// I/O Declarations
//
input          CLKXTAL;                       // Clock for the registers module
input          REG_ENAB;                      // 
input          REG_R_NW;                      //
input [4:0]    REG_ADDR;                      //
input [15:0]   REG_DIN;                       //
input [15:0]   SM_DATA_READ;                  //
input          RESETREG;                      //
input          MR_RESET_DONE;                 //
input          MR_AN_COMPLETE;                //
input [15:0]   MR_AN_LP_ABILITY;              //
input          MR_AN_NP_LCW_TOGGLE;           //
input          MR_AN_DUPLEX_MODE;             //
input          MR_PARALLEL_DETECTION_FAULT;   //
input          MR_PAGE_RX;                    //
input          MR_LP_AN_ABLE;                 //
input          MRAN_REMOTE_FAULT;             //
input          SELECT_160MHZ;                 //
input          MR_NO_COMMON_MODE;             //
input          MR_POL_REVERSED;               //
input          LINK_DOWN_10;                  //
input          LINK_DOWN_100;                 //
input          JABBER_DETECTED;               //
input          ANDIS_I;                       // Auto-Negotiation disable
input          AN_ACTIVE;                     // Auto-Negotiation active
input          L10_LINK_CONTROL;              //
input [1:0]    L100_LINK_CONTROL;             //
input          MDIX;                          //
input [1:0]    TX_AMP_TRIM;                   // Transmit slope trim
input [1:0]    TX_SLP_TRIM;                   // Transmit amplitude trim   
input [4:0]    PHY;                           // PHY address
input          CLKPLL_IN;                     // System clock
input          RESETPLL;                      // System reset

output [15:0]  REG_DOUT;                      // Register output value
output [15:0]  SM_DATA_WRITE;                 // Reg 24to29 data input
output         SM_WRITE;                      // Reg 24to29 write
output         MR_RESET_TO_RCB;               // Master reset for digital logic
output         MR_DIG_LOOP_BACK_ENAB_pll;     // Loop back sync'ed to CLKPLL_IN
output         MR_100MBS;                     // 100Mbps mode
output         MR_100MBS_pll;                 // 100Mbps mode sync'ed CLKPLL_IN
output         MR_AN_ENAB;                    // Auto-Negotiate enable
output         MR_AN_ENAB_pll;                // AN enable sync'ed CLKPLL_IN
output         MR_POWER_DOWN;                 // Power down mode
output         MR_ISOLATE_TX_pll;             // Mii Disconnected
output         MR_AN_RESTART;                 // Auto-Negotiate restart
output         MR_FULL_DUPLEX_pll;            // Full Duplex mode
output         MR_COL_TEST_pll;               // Enable collision test signal
output         MR4_REMOTE_FAULT_pll;          // Indicate remote fault
output         MR_FLOW_CTL_pll;               // Indicate flow control
output         MR_TAF_100FULL_pll;            // 100Base-T Full duplex capable
output         MR_TAF_100HALF_pll;            // 100Base-T Half duplex capable
output         MR_TAF_10FULL_pll;             // 10Base-T Full duplex capable
output         MR_TAF_10HALF_pll;             // 10Base-T Half duplex capable
output [4:0]   MR_SELECTOR_pll;               // Selector field
output         MR_RXTX_TEST_pll;              // RXTX regardless of status
output         MR_MII_LOOP_BACK_DISB_pll;     // Disable MII loopback
output         MR_SQE_ENAB_pll;               // SEQ (10Base-T) enabled
output         MR_JABBER_ENAB_pll;            // Enable Jabber detection
output         MR_LINK_TEST_DISB_pll;         // Disable 10Base-T integrity test
output         MR_SYMBOL_MODE;                // Bypass 4B5B encode/decoder
output         MR_SYMBOL_MODE_pll;            // Bypass 4B5B encode/decoder
output         MR_ALIGN_DISB;                 // Unaligned mode
output         MR_BYPASS_SCRAMBLER;           // Scrambler bypassed
output         MR_BYPASS_SCRAMBLER_pll;       // Scrambler bypassed
output         MR_TP_DISC;                    // Twisted pair disable
output         MR_BYPASS10TX_FILTER_pll;      // 10Base-T TX filter bypass
output         MR_BYPASS10RX_FILTER;          // 10Base-T RX filter bypass
output [1:0]   MR_SQUELCH_RANGE;              // Squelch level
output         MR_SQUELCH_DISB;               // 10Base-T RX squelch disabled
output         MR_POL_CORR_DISB_pll;          // Rx polarity correction disabled
output [2:0]   MR_RX10_PLL_MAX_ADJ_SHIFT_pll; // 10BT clock recovery bandwidth
output         MR_MII100_LOOP_BACK_ENAB_pll;  // MII loopback enabled
output         MR_MSE_NORESET_pll;            // No DSP reset due to MSE value
output         MR_NP_ENAB;                    // Next Page function enabled
output [15:0]  MR_AN_NP;                      // AN Next Page Tx register 
output         MR_NEXT_PAGE_LOADED_pll;       // Indicate AN NP Tx reg write
output         MR_MDIX_DISB;                  // Disable MDIX autocorrection
output         MR_MDIX_FORCE;                 // Force polarity of BI
output [1:0]   TX_AMPTRIM;                    // Tx amplitude control
output [1:0]   TX_SLOPETRIM;                  // Tx slope control
output [2:0]   TEST_MODE;                     // Test mode
output [4:0]   MR_SCRAMBLER_SEED_pll;         // scrambler seed
output         MR_SCRAMBLER_LOAD;             // Indicates scrambler seed write
output [4:0]   MR_PHY;                        // PHY override value
output [4:0]   MR_ERR_THRESH_pll;             // Error threshold reset level
output [9:0]   MR_ERR_TIMER_pll;              // Error timer reset
output         MDINT;                         // Management interface interrupt
output         MR_FEF_DISB_pll;               // Far end fault disabled
output         MR_FORCE_TIMER;                // Shorted timer values to speed 
                                              // up tests.
output [14:0]  MR_TEST_MODE;                  // A/N test mode selection.
output         MR_FAST_LINK;                  // reduced time between links test
output         MR_FAST_JABBER;                // reduced jabber time test
output         MR_FAST_MSE;                   // Sets fast MSE_GOOD count from
                                              // 10msecs to 1msec


//
// I/O Type Declarations
//
wire           CLKXTAL;                      
wire           REG_ENAB;                    
wire           REG_R_NW;                    
wire  [4:0]    REG_ADDR;                    
wire  [15:0]   REG_DIN;                     
wire  [15:0]   SM_DATA_READ;                
wire           RESETREG;                    
wire           MR_RESET_DONE;               
wire           MR_AN_COMPLETE;              
wire  [15:0]   MR_AN_LP_ABILITY;            
wire           MR_AN_NP_LCW_TOGGLE;         
wire           MR_AN_DUPLEX_MODE;           
wire           MR_PARALLEL_DETECTION_FAULT; 
wire           MR_PAGE_RX;                  
wire           MR_LP_AN_ABLE;               
wire           MRAN_REMOTE_FAULT;           
wire           SELECT_160MHZ;               
wire           MR_NO_COMMON_MODE;           
wire           MR_POL_REVERSED;             
wire           LINK_DOWN_10;                
wire           LINK_DOWN_100;               
wire           JABBER_DETECTED;
wire           ANDIS_I;
wire           AN_ACTIVE;                   
wire           L10_LINK_CONTROL;            
wire  [1:0]    L100_LINK_CONTROL;           
wire           MDIX;                        
wire  [1:0]    TX_AMP_TRIM;                 
wire  [1:0]    TX_SLP_TRIM;                 
wire  [4:0]    PHY;                         
wire           CLKPLL_IN;
wire           RESETPLL;


reg    [15:0]  REG_DOUT;                   
reg    [15:0]  SM_DATA_WRITE;              
wire           SM_WRITE;                   
reg            MR_RESET_TO_RCB;            
wire           MR_DIG_LOOP_BACK_ENAB_pll;      
reg            MR_100MBS;                  
wire           MR_100MBS_pll;
reg            MR_AN_ENAB;                 
wire           MR_AN_ENAB_pll;
reg            MR_POWER_DOWN;
wire           MR_ISOLATE_TX_pll;
reg            MR_AN_RESTART;              
wire           MR_FULL_DUPLEX_pll;             
wire           MR_COL_TEST_pll;                
wire           MR4_REMOTE_FAULT_pll;           
wire           MR_FLOW_CTL_pll;                
wire           MR_TAF_100FULL_pll;             
wire           MR_TAF_100HALF_pll;
wire           MR_TAF_10FULL_pll;
wire           MR_TAF_10HALF_pll;
reg    [4:0]   MR_SELECTOR_pll;                
wire           MR_RXTX_TEST_pll;               
wire           MR_MII_LOOP_BACK_DISB_pll;      
wire           MR_SQE_ENAB_pll;                
wire           MR_JABBER_ENAB_pll;             
wire           MR_LINK_TEST_DISB_pll;          
reg            MR_SYMBOL_MODE;
wire           MR_SYMBOL_MODE_pll;
reg            MR_ALIGN_DISB;              
reg            MR_BYPASS_SCRAMBLER;        
wire           MR_BYPASS_SCRAMBLER_pll;
reg            MR_TP_DISC;                 
wire           MR_BYPASS10TX_FILTER_pll;       
reg            MR_BYPASS10RX_FILTER;       
reg    [1:0]   MR_SQUELCH_RANGE;           
reg            MR_SQUELCH_DISB;            
wire           MR_POL_CORR_DISB_pll;           
reg    [2:0]   MR_RX10_PLL_MAX_ADJ_SHIFT_pll;  
wire           MR_MII100_LOOP_BACK_ENAB_pll;   
wire           MR_MSE_NORESET_pll;             
reg            MR_NP_ENAB;                 
wire   [15:0]  MR_AN_NP;                   
wire           MR_NEXT_PAGE_LOADED_pll;        
wire           MR_MDIX_DISB;               
wire           MR_MDIX_FORCE;              
wire   [1:0]   TX_AMPTRIM;                 
wire   [1:0]   TX_SLOPETRIM;               
reg    [2:0]   TEST_MODE;                  
reg    [4:0]   MR_SCRAMBLER_SEED_pll;          
reg            MR_SCRAMBLER_LOAD;          
reg    [4:0]   MR_PHY;                     
reg    [4:0]   MR_ERR_THRESH_pll;              
reg    [9:0]   MR_ERR_TIMER_pll;               
wire           MDINT;                      
wire           MR_FEF_DISB_pll;                
reg            MR_FORCE_TIMER;                // Shorted timer values to speed 
                                              // up tests.
reg    [14:0]  MR_TEST_MODE;                  // A/N test mode selection.
reg            MR_FAST_LINK;
reg            MR_FAST_JABBER;
reg            MR_FAST_MSE;

//
// Internal Signal Declarations
//
reg [3:0]      MR_PAR_DETECT_TAF;      // Technology detected by Parallel
                                       // Detection.
reg            MR_AN_NP_MORE ;
reg            MR_AN_NP_MSG_PAGE ;
reg            MR_AN_NP_ACK2 ;
reg [10:0]     MR_AN_NP_MESSAGE ;
reg            mr_link_status;
reg            mr_jabber_status;
reg            prev_enab;
reg [1:0]      prev_jabber_detected;
reg [1:0]      prev_remote_fault;
reg            rd1_going;
reg            rd6_going;
reg            rd16_going;
reg            wr7_done;
reg            wr20_done;
reg            prev1_reg_enab;
reg            prev2_reg_enab;
reg            prev3_reg_enab;
reg            prev1_reg_r_nw;
reg            prev1_mr_page_rx;
reg            prev2_mr_page_rx;
reg            prev3_mr_page_rx;
reg            prev_l10_link_control;
reg [15:0]     int_mr_an_lp_ability;
reg [4:0]      int_mr_an_exp;
reg [15:0]     int_mr_an_lp_np;
reg            mr1_remote_fault;
reg            int_no_common_mode;
reg            prev_full_duplex;
reg            trim_reg_enab;
reg            ack_rcvd_intr_enab;
reg            page_rx_intr_enab;
reg            link_chgd_intr_enab;
reg            an_chgd_intr_enab;
reg            par_det_fault_intr_enab;
reg            rmt_fault_intr_enab;
reg            jabber_intr_enab;
reg            ack_rcvd_intr;
reg            page_rx_intr;
reg            link_chgd_intr;
reg            an_chgd_intr;
reg            par_det_fault_intr;
reg            rmt_fault_intr;
reg            jabber_intr;
reg            ack_rcvd_intr_pend;
reg            page_rx_intr_pend;
reg            link_chgd_intr_pend;
reg            an_chgd_intr_pend;
reg            par_det_fault_intr_pend;
reg            rmt_fault_intr_pend;
reg            jabber_intr_pend;
reg            link_status_pend_cl; 
reg            link_status_pend_set;
reg            mr1_remote_fault_pend;
reg            mr_jabber_status_pend;
reg            int_mr_an_exp_pend;
reg [1:0]      prev_an_active;
reg [1:0]      prev_int_link_down;
reg            np_loaded_del;
reg [10:0]     rsvd_21_15_5;
reg            int_r_nw ;
reg            MR_DIG_LOOP_BACK_ENAB;
reg            MR_ISOLATE_TX;
reg            MR_FULL_DUPLEX;
reg            MR_COL_TEST;
reg            MR4_REMOTE_FAULT;
reg            MR_FLOW_CTL;
reg            MR_TAF_100FULL;
reg            MR_TAF_100HALF;
reg            MR_TAF_10FULL;
reg            MR_TAF_10HALF;
reg [4:0]      MR_SELECTOR;
reg            MR_NEXT_PAGE_LOADED;
reg            MR_RXTX_TEST;
reg            MR_MII_LOOP_BACK_DISB;
reg            MR_MSE_NORESET;
reg            MR_SQE_ENAB;
reg            MR_JABBER_ENAB;
reg            MR_LINK_TEST_DISB;
reg            MR_BYPASS10TX_FILTER;
reg            MR_POL_CORR_DISB;
reg [2:0]      MR_RX10_PLL_MAX_ADJ_SHIFT;
reg [4:0]      MR_SCRAMBLER_SEED;          
reg [4:0]      MR_PHASE_ADJ;
reg [4:0]      MR_ERR_THRESH;
reg [9:0]      MR_ERR_TIMER;               
reg            MR_FEF_DISB;
wire           MR_AN_NP_MORE_pll;
wire           MR_AN_NP_MSG_PAGE_pll;
wire           MR_AN_NP_ACK2_pll;
reg  [10:0]    MR_AN_NP_MESSAGE_pll;
reg  [1:0]     meta_MR_DIG_LOOP_BACK_ENAB;  // synchronisation register
reg  [1:0]     meta_MR_100MBS;              // synchronisation register
reg  [1:0]     meta_MR_AN_ENAB;             // synchronisation register
reg  [1:0]     meta_MR_ISOLATE_TX;          // synchronisation register
reg  [1:0]     meta_MR_FULL_DUPLEX;         // synchronisation register
reg  [1:0]     meta_MR_COL_TEST;            // synchronisation register
reg  [1:0]     meta_MR4_REMOTE_FAULT;       // synchronisation register
reg  [1:0]     meta_MR_FLOW_CTL;            // synchronisation register
reg  [1:0]     meta_MR_TAF_100FULL;         // synchronisation register
reg  [1:0]     meta_MR_TAF_100HALF;         // synchronisation register
reg  [1:0]     meta_MR_TAF_10FULL;          // synchronisation register
reg  [1:0]     meta_MR_TAF_10HALF;          // synchronisation register
reg  [4:0]     meta1_MR_SELECTOR_pll;       // synchronisation register
reg  [1:0]     meta_MR_NEXT_PAGE_LOADED;    // synchronisation register
reg  [1:0]     meta_MR_RXTX_TEST;           // synchronisation register
reg  [1:0]     meta_MR_MII_LOOP_BACK_DISB;  // synchronisation register
reg  [1:0]     meta_MR_MSE_NORESET;         // synchronisation register
reg  [1:0]     meta_MR_SQE_ENAB;            // synchronisation register
reg  [1:0]     meta_MR_JABBER_ENAB;         // synchronisation register
reg  [1:0]     meta_MR_LINK_TEST_DISB;      // synchronisation register
reg  [1:0]     meta_MR_SYMBOL_MODE;         // synchronisation register
reg  [1:0]     meta_MR_BYPASS_SCRAMBLER;    // synchronisation register
reg  [1:0]     meta_MR_BYPASS10TX_FILTER;   // synchronisation register
reg  [1:0]     meta_MR_POL_CORR_DISB;       // synchronisation register
reg  [2:0]     meta_MR_RX10_PLL_MAX_ADJ_SHIFT_pll; // synchronisation register
reg  [4:0]     meta_MR_SCRAMBLER_SEED_pll;  // synchronisation register
reg  [4:0]     meta_MR_ERR_THRESH_pll;      // synchronisation register
reg  [9:0]     meta_MR_ERR_TIMER_pll;       // synchronisation register
reg  [1:0]     meta_MR_FEF_DISB;            // synchronisation register
reg  [1:0]     meta_MR_AN_NP_MORE;          // synchronisation register
reg  [1:0]     meta_MR_AN_NP_MSG_PAGE;      // synchronisation register
reg  [1:0]     meta_MR_AN_NP_ACK2;          // synchronisation register
reg  [10:0]    meta_MR_AN_NP_MESSAGE;       // synchronisation register
reg  [4:0]     meta_1_REG_ADDR;             // synchronisation register
reg  [4:0]     REG_ADDR_synced;             // synchronisation register


wire           trigger_prx_intr;
wire           trigger_ack_intr;
wire           trigger_pdf_intr;
wire           trigger_rf_intr;
wire           trigger_jabber_intr;
wire           init_an;
wire           int_enab;
wire           int_enab_done;
wire           rd1_done;
wire           rd6_done;
wire           rd16_done;
wire           int_link_down;
wire [15:0]    reg00;
wire [15:0]    reg01;
wire [15:0]    reg04;
wire [15:0]    reg05;
wire [15:0]    reg06;
wire [15:0]    reg07;
wire [15:0]    reg16;
wire [15:0]    reg17;
wire [15:0]    reg18;
wire [15:0]    reg19;
wire [15:0]    reg20;
wire [15:0]    reg21;
wire [15:0]    reg23;
wire [15:0]    reg30;
wire [15:0]    reg31;
wire           trigger_an_chgd_intr;
reg  [4:0]     int_mr_an_exp_input;
wire [4:0]     int_mr_an_exp_hold;
reg  [1:0]     tx_amptrim;
reg  [1:0]     tx_slopetrim;
reg            mr_mdix_disb;
reg            mr_mdix_force;


//
// Parameter Declarations
//
parameter par_phy_id1         = 16'h001a ;
parameter par_phy_id2         = 16'b001000_010000_0000;

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign trigger_prx_intr = ~prev3_mr_page_rx & prev2_mr_page_rx;
   assign trigger_ack_intr = trigger_prx_intr & MR_AN_LP_ABILITY[14];
   assign trigger_pdf_intr = trigger_prx_intr & MR_PARALLEL_DETECTION_FAULT;
   assign trigger_rf_intr = ~prev_remote_fault[1] & prev_remote_fault[0];
   assign trigger_jabber_intr = ~prev_jabber_detected[1] &
                                 prev_jabber_detected[0];
   assign int_enab = ~prev3_reg_enab & prev2_reg_enab;
   assign int_enab_done = prev3_reg_enab & ~prev2_reg_enab;
   assign rd1_done = rd1_going & int_enab_done;
   assign rd6_done = rd6_going & int_enab_done;
   assign rd16_done = rd16_going & int_enab_done;
   assign SM_WRITE = prev_enab & !int_r_nw & (REG_ADDR_synced[4:3] == 2'b11);
   assign MR_MII100_LOOP_BACK_ENAB_pll = ~MR_MII_LOOP_BACK_DISB_pll;
   assign MR_AN_NP = {MR_AN_NP_MORE_pll, 1'b0, MR_AN_NP_MSG_PAGE_pll,
                      MR_AN_NP_ACK2_pll, MR_AN_NP_LCW_TOGGLE,
                      MR_AN_NP_MESSAGE_pll};
   assign MDINT = |{ack_rcvd_intr, page_rx_intr, link_chgd_intr,
                    an_chgd_intr, par_det_fault_intr, rmt_fault_intr,
                    jabber_intr};
   assign TX_AMPTRIM = trim_reg_enab ? tx_amptrim : TX_AMP_TRIM ;
   assign TX_SLOPETRIM = trim_reg_enab ? tx_slopetrim : TX_SLP_TRIM ;
   assign MR_MDIX_DISB = mr_mdix_disb | ~MR_AN_ENAB ;
   assign MR_MDIX_FORCE = mr_mdix_force & MR_AN_ENAB ;

//------------------------------------------------------------------------------
// This process....
//------------------------------------------------------------------------------
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_prev_enab
      if (RESETREG)
         begin
         prev_enab          <= 1'b0;
         end
      else
         begin
         prev_enab          <= int_enab;
         end
      end // p_prev_enab

//------------------------------------------------------------------------------
// This should be the master self clearing reset for the all digital
// logic in the system. 
//------------------------------------------------------------------------------
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_reset_reg
      if (RESETREG)
         MR_RESET_TO_RCB  <= 1'b0;
      else if (!MR_RESET_DONE)         
         MR_RESET_TO_RCB <= 1'b0;      
      else if (int_enab & !int_r_nw &(REG_ADDR_synced == 5'd0))
         MR_RESET_TO_RCB <= REG_DIN[15];
      else
         MR_RESET_TO_RCB <= MR_RESET_TO_RCB;
      end

//------------------------------------------------------------------------------
// This process is for writing/reading register bits
//------------------------------------------------------------------------------
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_write_reg
      if (RESETREG)
         begin
         // Writable register 0 bits
         MR_DIG_LOOP_BACK_ENAB <= 1'b0;
         MR_100MBS             <= 1'b1;
         MR_AN_ENAB            <= ~ANDIS_I;
         MR_POWER_DOWN         <= 1'b0;
         MR_ISOLATE_TX         <= 1'b0;
         MR_AN_RESTART         <= 1'b0;
         MR_FULL_DUPLEX        <= 1'b1;
         MR_COL_TEST           <= 1'b0;

         // Writable register 4 bits
         MR_NP_ENAB            <= 1'b1;
         MR4_REMOTE_FAULT      <= 1'b0;
         MR_FLOW_CTL           <= 1'b0;
         MR_TAF_100FULL        <= 1'b1;
         MR_TAF_100HALF        <= 1'b1;
         MR_TAF_10FULL         <= 1'b1;
         MR_TAF_10HALF         <= 1'b1;
         MR_SELECTOR           <= 5'b00001;

         // Writable register 7 bits
         MR_AN_NP_MORE         <= 1'b0;
         MR_AN_NP_MSG_PAGE     <= 1'b1;
         MR_AN_NP_ACK2         <= 1'b0;
         MR_AN_NP_MESSAGE      <= 11'b00000000001;

         // Writable register 16 bits
         ack_rcvd_intr_enab      <= 1'b0;
         page_rx_intr_enab       <= 1'b0;
         link_chgd_intr_enab     <= 1'b0;
         an_chgd_intr_enab       <= 1'b0;
         par_det_fault_intr_enab <= 1'b0;
         rmt_fault_intr_enab     <= 1'b0;
         jabber_intr_enab        <= 1'b0;
         
         // Writable register 18 bits
         MR_FEF_DISB           <= 1'b0;
         MR_MII_LOOP_BACK_DISB <= 1'b1;
         mr_mdix_disb          <= 1'b0;
         mr_mdix_force         <= 1'b1;
         MR_JABBER_ENAB        <= 1'b1;
         MR_LINK_TEST_DISB     <= 1'b0;
         MR_POL_CORR_DISB      <= 1'b0;
         MR_ALIGN_DISB         <= 1'b0;
         MR_SYMBOL_MODE        <= 1'b0;
         MR_BYPASS_SCRAMBLER   <= 1'b0;
         MR_TP_DISC            <= 1'b0;
         MR_RXTX_TEST          <= 1'b0;

         // Writable register 19 bits
         MR_BYPASS10TX_FILTER      <= 1'b0;
         MR_BYPASS10RX_FILTER      <= 1'b0;
         MR_SQUELCH_RANGE          <= 2'b10;
         MR_SQUELCH_DISB           <= 1'b0;
         MR_SQE_ENAB               <= 1'b0;
         MR_RX10_PLL_MAX_ADJ_SHIFT <= 3'd5;

         // Writable register 20 bits
         trim_reg_enab            <= 1'b0;
         MR_PHASE_ADJ             <= 3'b101;
         tx_amptrim               <= TX_AMP_TRIM;
         tx_slopetrim             <= TX_SLP_TRIM;
         TEST_MODE                <= 3'b000;
         MR_SCRAMBLER_SEED        <= PHY;

         // Writable register 21 bits
         rsvd_21_15_5             <= 11'b00000000000;
         MR_PHY                   <= PHY;

         // Writable register 23 bits
         MR_ERR_THRESH            <= 5'b01010;
         MR_ERR_TIMER             <= 10'h3e8;
         MR_MSE_NORESET           <= 1'b0;

         // Writable register 24-29
         SM_DATA_WRITE <= 16'b0;
         
         // Writable register 30 bits
         MR_TEST_MODE             <= 15'd0;
         MR_FORCE_TIMER           <= 1'b0;

         // Writable register 31 bits
         MR_FAST_MSE              <= 1'b0;
         MR_FAST_LINK             <= 1'b0;
         MR_FAST_JABBER           <= 1'b0;

         // Internal control signals
         rd1_going  <= 1'b0;
         rd6_going  <= 1'b0;
         rd16_going <= 1'b0;
         wr7_done   <= 1'b0;
         wr20_done  <= 1'b0;
         
         // MR_PAR_DETECT_TAF
         MR_PAR_DETECT_TAF <= 4'b0;
         
         end
 
      else 
         begin

         //Reads from register 1,6 and 16
         if (int_enab & int_r_nw)
            begin
            case (REG_ADDR_synced)      //synopsys parallel_case
               5'd1:  begin
                      rd1_going <= 1'b1;
                      end

               5'd6:  begin
                      rd6_going <= 1'b1;
                      end

               5'd16: begin
                      rd16_going <= 1'b1;
                      end

           endcase
           end // if (int_enab & REG_R_NW)



         // Writes to register 
         if (int_enab & !int_r_nw)
            case (REG_ADDR_synced)       //synopsys parallel_case
               5'd0: begin
                     MR_DIG_LOOP_BACK_ENAB <= REG_DIN[14];
                     MR_AN_ENAB            <= REG_DIN[12];
                     MR_POWER_DOWN         <= REG_DIN[11];
                     MR_ISOLATE_TX         <= REG_DIN[10];
                     MR_COL_TEST           <= REG_DIN[7];

                     if (!REG_DIN[12])
                        // If A/N is not enabled, set data rate and 
                        // duplex mode according to 0.13 and 0.8
                        // Also, set 0.9 to zero, as a reset cannot 
                        // occur (22.2.4.1.7). Hence user input to 
                        // 0.9 will have no effect.
                        begin
                        MR_100MBS      <= REG_DIN[13];
                        MR_FULL_DUPLEX <= REG_DIN[8];
                        MR_AN_RESTART  <= 1'b0;
                        end
                     
                     else
                        begin
                        MR_100MBS      <= MR_100MBS;
                        MR_FULL_DUPLEX <= MR_FULL_DUPLEX;
                        MR_AN_RESTART  <= REG_DIN[9];
                        end
                        
                     end  

               5'd4: begin
                     MR_NP_ENAB       <= REG_DIN[15];
                     MR4_REMOTE_FAULT <= REG_DIN[13];
                     MR_FLOW_CTL      <= REG_DIN[10];
                     MR_TAF_100FULL   <= REG_DIN[8];
                     MR_TAF_100HALF   <= REG_DIN[7];
                     MR_TAF_10FULL    <= REG_DIN[6];
                     MR_TAF_10HALF    <= REG_DIN[5];
                     MR_SELECTOR      <= REG_DIN[4:0];
                     end

               5'd7: begin
                     MR_AN_NP_MORE     <= REG_DIN[15];
                     MR_AN_NP_MSG_PAGE <= REG_DIN[13];
                     MR_AN_NP_ACK2     <= REG_DIN[12];
                     MR_AN_NP_MESSAGE  <= REG_DIN[10:0];
                     wr7_done <= 1'b1;
                     end

               5'd16: begin
                      ack_rcvd_intr_enab      <= REG_DIN[14];
                      page_rx_intr_enab       <= REG_DIN[13];
                      link_chgd_intr_enab     <= REG_DIN[12];
                      an_chgd_intr_enab       <= REG_DIN[11];
                      par_det_fault_intr_enab <= REG_DIN[10];
                      rmt_fault_intr_enab     <= REG_DIN[9];
                      jabber_intr_enab        <= REG_DIN[8];
                      end

               5'd18: begin
                      MR_FEF_DISB            <= REG_DIN[14];
                      MR_MII_LOOP_BACK_DISB  <= REG_DIN[13];
                      mr_mdix_disb           <= REG_DIN[12];
                      mr_mdix_force          <= REG_DIN[11];
                      MR_JABBER_ENAB         <= REG_DIN[10];
                      MR_LINK_TEST_DISB      <= REG_DIN[9];
                      MR_POL_CORR_DISB       <= REG_DIN[8];
                      MR_ALIGN_DISB          <= REG_DIN[7];

                      if (MR_100MBS)
                         begin
                         MR_SYMBOL_MODE      <= REG_DIN[6];
                         MR_BYPASS_SCRAMBLER <= REG_DIN[5];
                         end

                      MR_TP_DISC             <= REG_DIN[4];
                      MR_RXTX_TEST           <= REG_DIN[3] ;
                      end

               5'd19: begin
                      MR_BYPASS10TX_FILTER      <= REG_DIN[15];
                      MR_BYPASS10RX_FILTER      <= REG_DIN[14];
                      MR_SQUELCH_RANGE          <= REG_DIN[13:12];
                      MR_SQUELCH_DISB           <= REG_DIN[11];
                      MR_SQE_ENAB               <= REG_DIN[10];
                      MR_RX10_PLL_MAX_ADJ_SHIFT <= REG_DIN[9:7];
                      end

               5'd20: begin
                      trim_reg_enab     <= REG_DIN[15];
                      MR_PHASE_ADJ      <= REG_DIN[14:12];
                      tx_amptrim        <= REG_DIN[11:10];
                      tx_slopetrim      <= REG_DIN[9:8];
                      TEST_MODE         <= REG_DIN[7:5];
                      MR_SCRAMBLER_SEED <= REG_DIN[4:0];
                      wr20_done         <= 1'b1;
                      end

               5'd21: begin
                      rsvd_21_15_5 <= REG_DIN[15:5];
                      MR_PHY       <= REG_DIN[4:0];
                      end

               5'd23: begin
                      MR_ERR_THRESH  <= REG_DIN[15:11];
                      MR_ERR_TIMER   <= REG_DIN[10:1];
                      MR_MSE_NORESET <= REG_DIN[0];
                      end

               5'd24: begin
                      SM_DATA_WRITE <= REG_DIN[15:0];
                      end

               5'd25: begin
                      SM_DATA_WRITE <= REG_DIN[15:0];
                      end

               5'd26: begin
                      SM_DATA_WRITE <= REG_DIN[15:0];
                      end

               5'd27: begin
                      SM_DATA_WRITE <= REG_DIN[15:0];
                      end

               5'd28: begin
                      SM_DATA_WRITE <= REG_DIN[15:0];
                      end

               5'd29: begin
                      SM_DATA_WRITE <= REG_DIN[15:0];
                      end

               5'd30: begin
                      MR_TEST_MODE     <= REG_DIN[15:1];
                      MR_FORCE_TIMER   <= REG_DIN[0];
                      end                    
               5'd31: begin
                      MR_FAST_MSE      <= REG_DIN[2];
                      MR_FAST_LINK     <= REG_DIN[1];
                      MR_FAST_JABBER   <= REG_DIN[0];
                      end
            endcase


         else
         begin  // non-MII writes to regs - mainly A/N
            
            // Self-reset MR_AN_RESET (bit 0.9) once A/N process indicates that
            // it has started.
            // Use (meta) stabilized versions to check +edge of AN_ACTIVE.
            if (prev_an_active[0] & ~prev_an_active[1])
               MR_AN_RESTART <= 1'b0;
            else
               MR_AN_RESTART <= MR_AN_RESTART;
 
 
            // Update with A/N values when 10 or 100 Link Control is 'ENABLE'd.
            // The HCD technology enabled through Parallel Detection shall only
            // be enabled in half duplex mode (IEEE 802.3, 28.2.3.1).
 
            if (MR_AN_ENAB & ~prev_an_active[1] & prev_an_active[0])
            begin
               // A/N has just been enabled or restarted.
               // Load dig_regs with A/N values.
               MR_FULL_DUPLEX    <= MR_AN_DUPLEX_MODE;
               MR_100MBS         <= !SELECT_160MHZ;
            end
 
            else
            begin
               // A/N is active and dig_regs is updated with resolved technology
               // when a link is established.
               if (MR_AN_ENAB & prev_an_active[1])
               begin
 
                  // Set values for 100Mbps.
                  if (L100_LINK_CONTROL == 2'b11)
                  begin
                     MR_FULL_DUPLEX    <= MR_AN_DUPLEX_MODE;
                     MR_100MBS         <= !SELECT_160MHZ;
                     // Link Partner is 100 half duplex.
                     MR_PAR_DETECT_TAF <= 4'b0100;
                  end
 
                  else
                  begin
                     // Set values for 10Mbps.
                     if (!prev_l10_link_control & L10_LINK_CONTROL)
                     begin
                        MR_FULL_DUPLEX    <= MR_AN_DUPLEX_MODE;
                        MR_100MBS         <= !SELECT_160MHZ;
                        // Link Partner is 10 half duplex.
                        MR_PAR_DETECT_TAF <= 4'b0001;
                     end

                     else
                     begin
                        // Maintain values
                        MR_FULL_DUPLEX    <= MR_FULL_DUPLEX;
                        MR_100MBS         <= MR_100MBS;
                        MR_PAR_DETECT_TAF <= MR_PAR_DETECT_TAF;
                     end
                  end
 
               end
            end
         
         end // non-MII writes to regs - mainly A/N
                                          
               
         if (!(!prev3_reg_enab & prev2_reg_enab))
            begin
            wr7_done  <= 1'b0;
            wr20_done <= 1'b0;
            end

         if (int_enab_done)
            begin
            rd1_going  <= 1'b0;
            rd6_going  <= 1'b0;
            rd16_going <= 1'b0;
            end
      

         end
      end // p_write_reg

//------------------------------------------------------------------------------
// These assignments form the register bits
//------------------------------------------------------------------------------

   // Form control Register @ address 00
   assign reg00 [15]  = !MR_RESET_DONE;
   assign reg00 [14]  = MR_DIG_LOOP_BACK_ENAB;
   assign reg00 [13]  = MR_100MBS;
   assign reg00 [12]  = MR_AN_ENAB;       // Starts A/N process.
   assign reg00 [11]  = MR_POWER_DOWN;
   assign reg00 [10]  = MR_ISOLATE_TX;
   assign reg00 [9]   = MR_AN_RESTART;    // Restarts A/N process.
   assign reg00 [8]   = MR_FULL_DUPLEX;
   assign reg00 [7]   = MR_COL_TEST;
   assign reg00 [6:0] = 7'b0;

   // Form control Register @ address 01
   assign reg01 [15:6] = 10'b0111_1000_01;  // operation modes supported
   assign reg01 [5]    = MR_AN_COMPLETE;
   assign reg01 [4]    = mr1_remote_fault;
   assign reg01 [3]    = 1'b1;              // AN ability
   assign reg01 [2]    = mr_link_status;
   assign reg01 [1]    = mr_jabber_status;
   assign reg01 [0]    = 1'b1;             //Extended register capability

   // Form control Register @ address 04
   assign reg04 [15]    = MR_NP_ENAB;
   assign reg04 [14]    = 1'b0;              // Reserved
   assign reg04 [13]    = MR4_REMOTE_FAULT;
   assign reg04 [12:11] = 2'b00;             // Reserved
   assign reg04 [10]    = MR_FLOW_CTL;
   assign reg04 [9]     = 1'b0;              // 10Base-T4 not supported
   assign reg04 [8]     = MR_TAF_100FULL;
   assign reg04 [7]     = MR_TAF_100HALF;
   assign reg04 [6]     = MR_TAF_10FULL;
   assign reg04 [5]     = MR_TAF_10HALF;
   assign reg04 [4:0]   = MR_SELECTOR;

   // Form control Register @ address 05
   assign reg05 = int_mr_an_lp_ability;

   // Form control Register @ address 06
   assign reg06 [15:5] = 11'd0;
   assign reg06 [4:0]  = int_mr_an_exp;

   // Form control Register @ address 07
   assign reg07 [15]   = MR_AN_NP_MORE;
   assign reg07 [14]   = 1'b0;
   assign reg07 [13]   = MR_AN_NP_MSG_PAGE;
   assign reg07 [12]   = MR_AN_NP_ACK2;
   assign reg07 [11]   = MR_AN_NP_LCW_TOGGLE;
   assign reg07 [10:0] = MR_AN_NP_MESSAGE;

   // Form control Register @ address 16
   assign reg16 [15] = 1'b0;                  // Reserved
   assign reg16 [14] = ack_rcvd_intr_enab;
   assign reg16 [13] = page_rx_intr_enab;
   assign reg16 [12] = link_chgd_intr_enab;
   assign reg16 [11] = an_chgd_intr_enab;
   assign reg16 [10] = par_det_fault_intr_enab;
   assign reg16 [9]  = rmt_fault_intr_enab;
   assign reg16 [8]  = jabber_intr_enab;
   assign reg16 [7]  = 1'b0;                 // Reserved
   assign reg16 [6]  = ack_rcvd_intr;
   assign reg16 [5]  = page_rx_intr;
   assign reg16 [4]  = link_chgd_intr;
   assign reg16 [3]  = an_chgd_intr;
   assign reg16 [2]  = par_det_fault_intr;
   assign reg16 [1]  = rmt_fault_intr;
   assign reg16 [0]  = jabber_intr;

   // Form control Register @ address 17
   assign reg17 [15]  = 1'd0;               // Reserved
   assign reg17 [14]  = int_link_down;
   assign reg17 [13]  = MR_FULL_DUPLEX;
   assign reg17 [12]  = MR_100MBS;
   assign reg17 [11]  = 1'd0;               // Reserved
   assign reg17 [10]  = MR_AN_COMPLETE;
   assign reg17 [9]   = int_mr_an_exp[1];
   assign reg17 [8]   = int_no_common_mode;
   assign reg17 [7]   = 1'b0;
   assign reg17 [6]   = MDIX;
   assign reg17 [5]   = MR_POL_REVERSED;
   assign reg17 [4:0] = 5'b00000;           // Reserved

   // Form control Register @ address 18
   assign reg18 [15]  = 1'b0;
   assign reg18 [14]  = MR_FEF_DISB;
   assign reg18 [13]  = MR_MII_LOOP_BACK_DISB;
   assign reg18 [12]  = MR_MDIX_DISB;
   assign reg18 [11]  = MR_MDIX_FORCE;
   assign reg18 [10]  = MR_JABBER_ENAB;
   assign reg18 [9]   = MR_LINK_TEST_DISB;
   assign reg18 [8]   = MR_POL_CORR_DISB;
   assign reg18 [7]   = MR_ALIGN_DISB;
   assign reg18 [6]   = MR_SYMBOL_MODE;
   assign reg18 [5]   = MR_BYPASS_SCRAMBLER;
   assign reg18 [4]   = MR_TP_DISC;
   assign reg18 [3]   = MR_RXTX_TEST;
   assign reg18 [2:0] = 3'b000;

   // Form control Register @ address 19
   assign reg19 [15]    = MR_BYPASS10TX_FILTER;
   assign reg19 [14]    = MR_BYPASS10RX_FILTER;
   assign reg19 [13:12] = MR_SQUELCH_RANGE;
   assign reg19 [11]    = MR_SQUELCH_DISB;
   assign reg19 [10]    = MR_SQE_ENAB;
   assign reg19 [9:7]   = MR_RX10_PLL_MAX_ADJ_SHIFT;
   assign reg19 [6:0]   = 7'b0000000;                // Reserved

   // Form control Register @ address 20
   assign reg20 [15]    = trim_reg_enab;
   assign reg20 [14:12] = MR_PHASE_ADJ;
   assign reg20 [11:10] = TX_AMPTRIM;
   assign reg20 [9:8]   = TX_SLOPETRIM;
   assign reg20 [7:5]   = TEST_MODE;
   assign reg20 [4:0]   = MR_SCRAMBLER_SEED;

   // Form control Register @ address 21
   assign reg21 [15:5] = rsvd_21_15_5;
   assign reg21 [4:0]  = MR_PHY;

   // Form control Register @ address 23
   assign reg23 [15:11] = MR_ERR_THRESH;
   assign reg23 [10:1]  = MR_ERR_TIMER;
   assign reg23 [0]     = MR_MSE_NORESET;

   // Form control Register @ address 30
   assign reg30 [15:1]  = MR_TEST_MODE;
   assign reg30 [0]     = MR_FORCE_TIMER;

   // Form control Register @ address 31
   assign reg31 [15:3]  = 13'd0;
   assign reg31 [2]     = MR_FAST_MSE;
   assign reg31 [1]     = MR_FAST_LINK;
   assign reg31 [0]     = MR_FAST_JABBER;

//------------------------------------------------------------------------------
// This process assigns the selects the appropriate register output 
// and latches the signals. This process should be investigated to
// determine if they can be removed our replaced with a synchronuous
// process.
//------------------------------------------------------------------------------
//
   always @ (REG_ENAB or REG_R_NW or REG_ADDR or SM_DATA_READ or
             reg00 or reg01 or reg04 or reg05 or reg06 or reg07 or
             reg16 or reg17 or reg18 or reg19 or reg20 or reg21 or
             reg23 or MR_100MBS or reg30 or reg31)
             
      begin : p_read_reg
      // A read function
      
      if (REG_ENAB & REG_R_NW)
         begin
         case (REG_ADDR)        //synopsys parallel_case
            5'd0:  REG_DOUT = reg00;
            5'd1:  REG_DOUT = reg01;
            5'd2:  REG_DOUT = par_phy_id1;
            5'd3:  REG_DOUT = par_phy_id2;
            5'd4:  REG_DOUT = reg04;
            5'd5:  REG_DOUT = reg05;
            5'd6:  REG_DOUT = reg06;
            5'd7:  REG_DOUT = reg07;
            5'd16: REG_DOUT = reg16;
            5'd17: REG_DOUT = reg17;
            5'd18: REG_DOUT = reg18;
            5'd19: REG_DOUT = reg19;
            5'd20: REG_DOUT = reg20;
            5'd21: REG_DOUT = reg21;
            5'd23: REG_DOUT = reg23;
            5'd24: REG_DOUT = SM_DATA_READ & {16{MR_100MBS}};
            5'd25: REG_DOUT = SM_DATA_READ & {16{MR_100MBS}};
            5'd26: REG_DOUT = SM_DATA_READ & {16{MR_100MBS}};
            5'd27: REG_DOUT = SM_DATA_READ & {16{MR_100MBS}};
            5'd28: REG_DOUT = SM_DATA_READ & {16{MR_100MBS}};
            5'd29: REG_DOUT = SM_DATA_READ & {16{MR_100MBS}};
            5'd30: REG_DOUT = reg30;
            5'd31: REG_DOUT = reg31;

            default: REG_DOUT = 16'h0000;
         endcase
         end
      end        // p_read_reg

   assign int_link_down = MR_100MBS ? LINK_DOWN_100 : LINK_DOWN_10;

//------------------------------------------------------------------------------
// This process assigns the selects the appropriate register output 
//------------------------------------------------------------------------------
//

   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_link_status
      if (RESETREG)
         begin
         mr_link_status       <= 1'b0;
         link_status_pend_cl  <= 1'b0;
         link_status_pend_set <= 1'b0;
         end
      else
         casex ({prev2_reg_enab, rd1_going, rd1_done,
                prev_int_link_down[1],link_status_pend_cl,link_status_pend_set})
                                               //synopsys parallel_case

// Clearing link

           6'b0001xx,  // clear instantly
           6'b01111x : begin
                       mr_link_status       <= 1'b0;
                       link_status_pend_cl  <= 1'b0;
                       link_status_pend_set <= 1'b0;
                       end

           6'b01x100,  // pending clear
           6'b1x0100 : begin
                       mr_link_status       <= mr_link_status;
                       link_status_pend_cl  <= 1'b1;
                       link_status_pend_set <= 1'b0;
                       end


// Setting Link

           6'b0000xx,  // set instantly
           6'b0110x1 : begin
                       mr_link_status       <= 1'b1;
                       link_status_pend_cl  <= 1'b0;
                       link_status_pend_set <= 1'b0;
                       end

           6'b01x000, // pending set
           6'b1x0000 : begin
                       mr_link_status       <= mr_link_status;
                       link_status_pend_cl  <= 1'b0;
                       link_status_pend_set <= 1'b1;
                       end

             default: begin
                      mr_link_status      <= mr_link_status;
                      link_status_pend_cl <= link_status_pend_cl;
                      end
         endcase
      end // p_link_status



//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_ack_rcvd_intr
      if (RESETREG)
         begin
         ack_rcvd_intr      <= 1'b0;
         ack_rcvd_intr_pend <= 1'b0;
         end
      else
         case ({ack_rcvd_intr_enab, REG_ENAB, rd16_going,
                rd16_done, trigger_ack_intr, ack_rcvd_intr_pend})
                                                //synopsys parallel_case

            6'b100001: begin
                       ack_rcvd_intr      <= 1'b1;
                       ack_rcvd_intr_pend <= 1'b0;
                       end

            6'b100010: begin
                       ack_rcvd_intr      <= ack_rcvd_intr;
                       ack_rcvd_intr_pend <= 1'b1;
                       end

            6'b100011: begin
                       ack_rcvd_intr      <= 1'b1;
                       ack_rcvd_intr_pend <= 1'b0;
                       end
 
            6'b101010: begin
                       ack_rcvd_intr      <= ack_rcvd_intr;
                       ack_rcvd_intr_pend <= 1'b1;
                       end

            6'b101100: begin
                       ack_rcvd_intr      <= 1'b0;
                       ack_rcvd_intr_pend <= 1'b0;
                       end
 
            6'b101101: begin
                       ack_rcvd_intr      <= 1'b1;
                       ack_rcvd_intr_pend <= 1'b0;
                       end

            6'b101110: begin
                       ack_rcvd_intr      <= ack_rcvd_intr;
                       ack_rcvd_intr_pend <= 1'b1;
                       end

            6'b101111: begin
                       ack_rcvd_intr      <= 1'b1;
                       ack_rcvd_intr_pend <= 1'b0;
                       end

            6'b110010: begin
                       ack_rcvd_intr      <= ack_rcvd_intr;
                       ack_rcvd_intr_pend <= 1'b1;
                       end

            6'b111010: begin
                       ack_rcvd_intr      <= ack_rcvd_intr;
                       ack_rcvd_intr_pend <= 1'b1;
                       end
         endcase 
      end //p_ack_rcvd_intr

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_page_rx_intr
      if (RESETREG)
         begin
         page_rx_intr      <= 1'b0;
         page_rx_intr_pend <= 1'b0;
         end
      else
         case ({page_rx_intr_enab, REG_ENAB, rd16_going, rd16_done,
                trigger_prx_intr, page_rx_intr_pend})
                                             //synopsys parallel_case

            6'b100001: begin
                       page_rx_intr      <= 1'b1;
                       page_rx_intr_pend <= 1'b0;
                       end

            6'b100010: begin
                       page_rx_intr      <= page_rx_intr;
                       page_rx_intr_pend <= 1'b1;
                       end

            6'b100011: begin
                       page_rx_intr      <= 1'b1;
                       page_rx_intr_pend <= 1'b0;
                       end

            6'b101010: begin
                       page_rx_intr      <= page_rx_intr;
                       page_rx_intr_pend <= 1'b1;
                       end

            6'b101100:begin
                       page_rx_intr      <= 1'b0;
                       page_rx_intr_pend <= 1'b0;
                       end

            6'b101101:begin
                       page_rx_intr      <= 1'b1;
                       page_rx_intr_pend <= 1'b0;
                       end

            6'b101110: begin
                       page_rx_intr      <= page_rx_intr;
                       page_rx_intr_pend <= 1'b1;
                       end

            6'b101111:begin
                       page_rx_intr      <= 1'b1;
                       page_rx_intr_pend <= 1'b0;
                       end

            6'b110010: begin
                       page_rx_intr      <= page_rx_intr;
                       page_rx_intr_pend <= 1'b1;
                       end

            6'b111010: begin
                       page_rx_intr      <= page_rx_intr;
                       page_rx_intr_pend <= 1'b1;
                       end

         endcase 
      end // p_page_rx_intr

//------------------------------------------------------------------------------
// This process is used to syncronise the link status to the XTAL domain
//------------------------------------------------------------------------------
//
   always @ (posedge CLKXTAL or posedge RESETREG)
      begin : p_prev_int_link_down
      if (RESETREG)
         prev_int_link_down <= 2'b11;
      else
         prev_int_link_down <= {prev_int_link_down[0], int_link_down};
      end //p_prev_int_link_down

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_link_chgd_intr
      if (RESETREG)
         begin
         link_chgd_intr      <= 1'b0 ;
         link_chgd_intr_pend <= 1'b0 ;
         end
      else
         case ({link_chgd_intr_enab, REG_ENAB, rd16_going, rd16_done,
                (^prev_int_link_down), link_chgd_intr_pend})
                                                  //synopsys parallel_case

            6'b100001: begin
                       link_chgd_intr      <= 1'b1;
                       link_chgd_intr_pend <= 1'b0;
                       end

            6'b100010: begin
                       link_chgd_intr      <= link_chgd_intr;
                       link_chgd_intr_pend <= 1'b1;
                       end

            6'b100011: begin
                       link_chgd_intr      <= 1'b1;
                       link_chgd_intr_pend <= 1'b0;
                       end

            6'b101010: begin
                       link_chgd_intr      <= link_chgd_intr;
                       link_chgd_intr_pend <= 1'b1;
                       end

            6'b101100: begin
                       link_chgd_intr      <= 1'b0;
                       link_chgd_intr_pend <= 1'b1;
                       end

            6'b101101: begin
                       link_chgd_intr      <= 1'b1;
                       link_chgd_intr_pend <= 1'b0;
                       end

            6'b101110: begin
                       link_chgd_intr      <= link_chgd_intr;
                       link_chgd_intr_pend <= 1'b1;
                       end

            6'b101111: begin
                       link_chgd_intr      <= 1'b1;
                       link_chgd_intr_pend <= 1'b0;
                       end

            6'b110010: begin
                       link_chgd_intr      <= link_chgd_intr;
                       link_chgd_intr_pend <= 1'b1;
                       end

            6'b111010: begin
                       link_chgd_intr      <= link_chgd_intr;
                       link_chgd_intr_pend <= 1'b1;
                       end
         endcase 
      end // p_link_chgd_intr

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @ (posedge CLKXTAL or posedge RESETREG)
      begin : p_prev_an_active
      if (RESETREG)
         prev_an_active <= 2'b00;
      else
         prev_an_active <= {prev_an_active[0], AN_ACTIVE};
      end // p_prev_an_active

   // Detect pos or neg edge of AN_ACTIVE (i.e. A/N is starting or ending). 
   assign trigger_an_chgd_intr = ^prev_an_active;

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_an_chgd_intr
      if (RESETREG)
         begin
         an_chgd_intr      <= 1'b0;
         an_chgd_intr_pend <= 1'b0;
         end
      else
         case ({an_chgd_intr_enab, REG_ENAB, rd16_going, rd16_done,
                trigger_an_chgd_intr, an_chgd_intr_pend})
                                               //synopsys parallel_case
            6'b100001: begin
                       an_chgd_intr      <= 1'b1;
                       an_chgd_intr_pend <= 1'b0;
                       end

            6'b100010: begin
                       an_chgd_intr      <= an_chgd_intr;
                       an_chgd_intr_pend <= 1'b1;
                       end

            6'b100011: begin
                       an_chgd_intr      <= 1'b1;
                       an_chgd_intr_pend <= 1'b0;
                       end

            6'b101010: begin
                       an_chgd_intr      <= an_chgd_intr;
                       an_chgd_intr_pend <= 1'b1;
                       end

            6'b101100: begin
                       an_chgd_intr      <= 1'b0;
                       an_chgd_intr_pend <= 1'b0;
                       end

            6'b101101: begin
                       an_chgd_intr      <= 1'b1;
                       an_chgd_intr_pend <= 1'b0;
                       end

            6'b101110: begin
                       an_chgd_intr      <= an_chgd_intr;
                       an_chgd_intr_pend <= 1'b1;
                       end

            6'b101111: begin
                       an_chgd_intr      <= 1'b1;
                       an_chgd_intr_pend <= 1'b0;
                       end

            6'b110010: begin
                       an_chgd_intr      <= an_chgd_intr;
                       an_chgd_intr_pend <= 1'b1;
                       end

            6'b111010: begin
                       an_chgd_intr      <= an_chgd_intr;
                       an_chgd_intr_pend <= 1'b1;
                       end

         endcase
      end // p_an_chgd_intr

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin :p_par_det_fault_intr
      if (RESETREG)
         begin
         par_det_fault_intr      <= 1'b0 ;
         par_det_fault_intr_pend <= 1'b0 ;
         end
      else
         case ({par_det_fault_intr_enab, REG_ENAB, rd16_going, rd16_done,
                trigger_pdf_intr, par_det_fault_intr_pend})
                                          //synopsys parallel_case
            6'b100001: begin
                       par_det_fault_intr      <= 1'b1;
                       par_det_fault_intr_pend <= 1'b0;
                       end

            6'b100010: begin
                       par_det_fault_intr      <= par_det_fault_intr;
                       par_det_fault_intr_pend <= 1'b1;
                       end

            6'b100011: begin
                       par_det_fault_intr      <= 1'b1;
                       par_det_fault_intr_pend <= 1'b0;
                       end

            6'b101010: begin
                       par_det_fault_intr      <= par_det_fault_intr;
                       par_det_fault_intr_pend <= 1'b1;
                       end

            6'b101100:begin
                       par_det_fault_intr      <= 1'b0;
                       par_det_fault_intr_pend <= 1'b0;
                       end

            6'b101101: begin
                       par_det_fault_intr      <= 1'b1;
                       par_det_fault_intr_pend <= 1'b0;
                       end

            6'b101110: begin
                       par_det_fault_intr      <= par_det_fault_intr;
                       par_det_fault_intr_pend <= 1'b1;
                       end

            6'b101111: begin
                       par_det_fault_intr <= 1'b1;
                       par_det_fault_intr_pend <= 1'b0;
                       end

            6'b110010: begin
                       par_det_fault_intr      <= par_det_fault_intr;
                       par_det_fault_intr_pend <= 1'b1;
                       end

            6'b111010: begin
                       par_det_fault_intr      <= par_det_fault_intr;
                       par_det_fault_intr_pend <= 1'b1;
                       end
         endcase 
      end // p_par_det_fault_intr

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_rmt_fault_intr
      if (RESETREG)
         begin 
         rmt_fault_intr      <= 1'b0 ;
         rmt_fault_intr_pend <= 1'b0 ;
         end
      else
         case ({rmt_fault_intr_enab, REG_ENAB, rd16_going, rd16_done,
                trigger_rf_intr, rmt_fault_intr_pend})
                                                  //synopsys parallel_case
            6'b100001: begin
                       rmt_fault_intr      <= 1'b1;
                       rmt_fault_intr_pend <= 1'b0;
                       end

            6'b100010: begin
                       rmt_fault_intr      <= rmt_fault_intr;
                       rmt_fault_intr_pend <= 1'b1;
                       end

            6'b100011: begin
                       rmt_fault_intr      <= 1'b1;
                       rmt_fault_intr_pend <= 1'b0;
                       end

            6'b101010: begin
                       rmt_fault_intr      <= rmt_fault_intr;
                       rmt_fault_intr_pend <= 1'b1;
                       end

            6'b101100: begin
                       rmt_fault_intr      <= 1'b0;
                       rmt_fault_intr_pend <= 1'b0;
                       end

            6'b101101: begin
                       rmt_fault_intr      <= 1'b1;
                       rmt_fault_intr_pend <= 1'b0;
                       end

            6'b101110: begin
                       rmt_fault_intr      <= rmt_fault_intr;
                       rmt_fault_intr_pend <= 1'b1;
                       end

            6'b101111: begin
                       rmt_fault_intr      <= 1'b1;
                       rmt_fault_intr_pend <= 1'b0;
                       end

            6'b110010: begin
                       rmt_fault_intr      <= rmt_fault_intr;
                       rmt_fault_intr_pend <= 1'b1;
                       end

            6'b111010: begin
                       rmt_fault_intr      <= rmt_fault_intr;
                       rmt_fault_intr_pend <= 1'b1;
                       end
         endcase
      end // p_rmt_fault_intr

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_jabber_intr
      if (RESETREG)
         begin
         jabber_intr      <= 1'b0 ;
         jabber_intr_pend <= 1'b0 ;
         end
      else 
         case ({jabber_intr_enab, REG_ENAB, rd16_going, rd16_done,
                trigger_jabber_intr, jabber_intr_pend})
                                               //synopsys parallel_case
            6'b100001: begin
                       jabber_intr      <= 1'b1 ;
                       jabber_intr_pend <= 1'b0 ;
                       end

            6'b100010: begin
                       jabber_intr      <= jabber_intr ;
                       jabber_intr_pend <= 1'b1 ;
                       end

            6'b100011: begin
                       jabber_intr      <= 1'b1 ;
                       jabber_intr_pend <= 1'b0 ;
                       end

            6'b101010: begin
                       jabber_intr      <= jabber_intr ;
                       jabber_intr_pend <= 1'b1 ;
                       end

            6'b101100: begin
                       jabber_intr      <= 1'b0 ;
                       jabber_intr_pend <= 1'b0 ;
                       end

            6'b101101: begin
                       jabber_intr      <= 1'b1 ;
                       jabber_intr_pend <= 1'b0 ;
                       end

            6'b101110: begin
                       jabber_intr      <= jabber_intr ;
                       jabber_intr_pend <= 1'b1 ;
                       end

            6'b101111: begin
                       jabber_intr      <= 1'b1 ;
                       jabber_intr_pend <= 1'b0 ;
                       end

            6'b110010: begin
                       jabber_intr      <= jabber_intr ;
                       jabber_intr_pend <= 1'b1 ;
                       end

            6'b111010: begin
                       jabber_intr      <= jabber_intr ;
                       jabber_intr_pend <= 1'b1 ;
                       end
         endcase
      end // p_jabber_intr

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_mr_jabber_status
      if (RESETREG)
         begin
         mr_jabber_status      <= 1'b0;
         mr_jabber_status_pend <= 1'b0;
         end
      else 
         case ({REG_ENAB, rd1_going, rd1_done,
                prev_jabber_detected[1], mr_jabber_status_pend})
                                             //synopsys parallel_case

            5'b00001: begin
                      mr_jabber_status      <= 1'b1;
                      mr_jabber_status_pend <= 1'b0;
                      end

            5'b00010: begin
                      mr_jabber_status      <= mr_jabber_status;
                      mr_jabber_status_pend <= 1'b1;
                      end

            5'b00011: begin
                      mr_jabber_status      <= 1'b1;
                      mr_jabber_status_pend <= 1'b0;
                      end

            5'b01010: begin
                      mr_jabber_status      <= mr_jabber_status;
                      mr_jabber_status_pend <= 1'b1;
                      end

            5'b01100: begin
                      mr_jabber_status      <= 1'b0;
                      mr_jabber_status_pend <= 1'b0;
                      end

            5'b01101: begin
                      mr_jabber_status      <= 1'b1;
                      mr_jabber_status_pend <= 1'b0;
                      end

            5'b01110: begin
                      mr_jabber_status      <= mr_jabber_status;
                      mr_jabber_status_pend <= 1'b1;
                      end

            5'b01111: begin
                      mr_jabber_status      <= 1'b1;
                      mr_jabber_status_pend <= 1'b0;
                      end

            5'b10010: begin
                      mr_jabber_status      <= mr_jabber_status;
                      mr_jabber_status_pend <= 1'b1;
                      end

            5'b11010: begin
                      mr_jabber_status      <= mr_jabber_status;
                      mr_jabber_status_pend <= 1'b1;
                      end
         endcase 
      end // p_mr_jabber_status
 
//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_mr1_remote_fault
      if (RESETREG)
         begin
         mr1_remote_fault      <= 1'b0;
         mr1_remote_fault_pend <= 1'b0;
         end
      else
        case ({REG_ENAB, rd1_going, rd1_done,
               trigger_rf_intr, mr1_remote_fault_pend})
                                          //synopsys parallel_case
            5'b00001: begin
                      mr1_remote_fault      <= 1'b1;
                      mr1_remote_fault_pend <= 1'b0;
                      end

            5'b00010: begin
                      mr1_remote_fault      <= mr1_remote_fault;
                      mr1_remote_fault_pend <= 1'b1;
                      end

            5'b00011: begin
                      mr1_remote_fault      <= 1'b1;
                      mr1_remote_fault_pend <= 1'b0;
                      end

            5'b01010: begin
                      mr1_remote_fault      <= mr1_remote_fault;
                      mr1_remote_fault_pend <= 1'b1;
                      end

            5'b01100:begin
                      mr1_remote_fault      <= 1'b0;
                      mr1_remote_fault_pend <= 1'b0;
                      end

            5'b01101: begin
                      mr1_remote_fault      <= 1'b1;
                      mr1_remote_fault_pend <= 1'b0;
                      end

            5'b01110: begin
                      mr1_remote_fault      <= mr1_remote_fault;
                      mr1_remote_fault_pend <= 1'b1;
                      end

            5'b01111: begin
                      mr1_remote_fault      <= 1'b1;
                      mr1_remote_fault_pend <= 1'b0;
                      end

            5'b10010: begin
                      mr1_remote_fault      <= mr1_remote_fault;
                      mr1_remote_fault_pend <= 1'b1;
                      end

            5'b11010: begin
                      mr1_remote_fault      <= mr1_remote_fault;
                      mr1_remote_fault_pend <= 1'b1;
                      end
        endcase 
      end //p_mr1_remote_fault

//------------------------------------------------------------------------------
// This process sets internal signals for received Link Partner abilities and
//  'no common mode' status.
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_int_mr_an_lp_ability
      if (RESETREG)
         begin
         int_mr_an_lp_ability <= 16'd0;
         int_no_common_mode   <= 1'b1;
         end
      
      else
         if (!prev3_mr_page_rx & prev2_mr_page_rx)
            begin
            // Abilities resolved through FLP exchange.
            int_mr_an_lp_ability <= MR_AN_LP_ABILITY;
            int_no_common_mode <= MR_NO_COMMON_MODE;
            end
            
         else
            if (MR_PAGE_RX == 1'b0)
               begin
               // MR_PAGE_RX is not set through Parallel Detection (only set 
               // in CompleteAcknowledge state).
               //
               // TAF resolved through Parallel Detection
               // Parallel Detection cannot resolve whether there is a common 
               // mode or not, so maintain  int_no_common_mode value.
               int_mr_an_lp_ability <= {7'd0,MR_PAR_DETECT_TAF,5'd0};
               int_no_common_mode <= int_no_common_mode;
               end
               
            else 
               // Maintain existing values.
               begin
               int_mr_an_lp_ability <= int_mr_an_lp_ability;
               int_no_common_mode   <= int_no_common_mode;
               end
               
      end // p_int_mr_an_lp_ability

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @ (posedge CLKXTAL or posedge RESETREG)
      begin : p_int_mr_an_exp_input
      if (RESETREG)
         int_mr_an_exp_input <= 5'b0;
      else if (trigger_prx_intr)
         int_mr_an_exp_input <= {MR_PARALLEL_DETECTION_FAULT,
                                 MR_AN_LP_ABILITY[15],
                                 1'b1,MR_PAGE_RX,MR_LP_AN_ABLE};
      end // p_int_mr_an_exp_input

   assign int_mr_an_exp_hold [4]   = 1'b0;
   assign int_mr_an_exp_hold [3]   = int_mr_an_exp[3];
   assign int_mr_an_exp_hold [2:1] = 2'b10;
   assign int_mr_an_exp_hold [0]   = int_mr_an_exp[0];

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_int_mr_an_exp
      if (RESETREG)
         begin
         int_mr_an_exp      <= 5'b00100;
         int_mr_an_exp_pend <= 1'b0;
         end
      else 
         case ({REG_ENAB, rd6_going, rd6_done,
                trigger_prx_intr, int_mr_an_exp_pend})
                                       //synopsys parallel_case

            5'b00001: begin
                      int_mr_an_exp      <= int_mr_an_exp_input;
                      int_mr_an_exp_pend <= 1'b0;
                      end

            5'b00010: begin
                      int_mr_an_exp      <= int_mr_an_exp;
                      int_mr_an_exp_pend <= 1'b1;
                      end

            5'b00011: begin
                      int_mr_an_exp      <= int_mr_an_exp_input;
                      int_mr_an_exp_pend <= 1'b0;
                      end

            5'b01010: begin
                      int_mr_an_exp      <= int_mr_an_exp;
                      int_mr_an_exp_pend <= 1'b1;
                      end

            5'b01100: begin
                      int_mr_an_exp      <= int_mr_an_exp_hold;
                      int_mr_an_exp_pend <= 1'b0;
                      end

            5'b01101: begin
                      int_mr_an_exp      <= int_mr_an_exp_input;
                      int_mr_an_exp_pend <= 1'b0;
                      end

            5'b01110: begin
                      int_mr_an_exp      <= int_mr_an_exp;
                      int_mr_an_exp_pend <= 1'b1;
                      end

            5'b01111: begin
                      int_mr_an_exp      <= int_mr_an_exp_input;
                      int_mr_an_exp_pend <= 1'b0;
                      end

            5'b10010: begin
                      int_mr_an_exp      <= int_mr_an_exp;
                      int_mr_an_exp_pend <= 1'b1;
                      end

            5'b11010: begin
                      int_mr_an_exp      <= int_mr_an_exp;
                      int_mr_an_exp_pend <= 1'b1;
                      end
         endcase
      end // p_int_mr_an_exp


//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_prev_jabber_detected
      if (RESETREG) 
         begin
         prev_jabber_detected <= 2'b00;
         prev_remote_fault    <= 2'b00;
         end
      else
         begin
         prev_jabber_detected <= {prev_jabber_detected[0], JABBER_DETECTED};
         prev_remote_fault    <= {prev_remote_fault[0], MRAN_REMOTE_FAULT};
         end
     end // p_prev_jabber_detected

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_prev_reg_enab
      if (RESETREG)
         begin
         prev1_reg_enab  <= 1'b0;
         prev2_reg_enab  <= 1'b0;
         prev3_reg_enab  <= 1'b0;
         prev1_reg_r_nw  <= 1'b1;
         int_r_nw        <= 1'b1;
         meta_1_REG_ADDR <= 5'b00000;
         REG_ADDR_synced <= 5'b00000;
         end
      else
         begin
         prev1_reg_enab  <= REG_ENAB;
         prev2_reg_enab  <= prev1_reg_enab;
         prev3_reg_enab  <= prev2_reg_enab;
         prev1_reg_r_nw  <= REG_R_NW;
         int_r_nw        <= prev1_reg_r_nw;
         meta_1_REG_ADDR <= REG_ADDR;
         REG_ADDR_synced <= meta_1_REG_ADDR;
         end
      end // p_prev_reg_enab

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_prev_mr_page_rx
      if (RESETREG)
         begin
         prev1_mr_page_rx      <= 1'b0;
         prev2_mr_page_rx      <= 1'b0;
         prev3_mr_page_rx      <= 1'b0;
         prev_l10_link_control <= 1'b0;
         end
      else 
         begin
         prev1_mr_page_rx      <= MR_PAGE_RX;
         prev2_mr_page_rx      <= prev1_mr_page_rx;
         prev3_mr_page_rx      <= prev2_mr_page_rx;
         prev_l10_link_control <= L10_LINK_CONTROL;
         end
      end // p_prev_mr_page_rx

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_mr_next_page_loaded
      if (RESETREG)
         begin
         MR_NEXT_PAGE_LOADED <= 1'b0 ;
         np_loaded_del       <= 1'b0 ;
         end
      else
         begin
            np_loaded_del <= MR_NEXT_PAGE_LOADED;
         if (int_enab | np_loaded_del)
            MR_NEXT_PAGE_LOADED <= 1'b0;
         else if (wr7_done)
            MR_NEXT_PAGE_LOADED <= 1'b1;
         end
      end // p_mr_next_page_loaded

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESETREG)
      begin : p_mr_scrambler_load
      if (RESETREG)
         MR_SCRAMBLER_LOAD <= 1'b0;
      else
         begin
         if (int_enab)
            MR_SCRAMBLER_LOAD <= 1'b0;
         else if (wr20_done)
            MR_SCRAMBLER_LOAD <= 1'b1;
         end
      end // p_mr_scrambler_load

//------------------------------------------------------------------------------
// This process is for the synchronisation of signals generated within
// the XTAL clock domian to move into the CLKPLL_IN domain
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_domain
      if (RESETPLL)
         begin
         meta_MR_DIG_LOOP_BACK_ENAB <= 2'b00;
         meta_MR_100MBS             <= 2'b11;
         meta_MR_AN_ENAB            <= 2'b00;
         meta_MR_ISOLATE_TX         <= 2'b00;
         meta_MR_FULL_DUPLEX        <= 2'b11;
         meta_MR_COL_TEST           <= 2'b00;
         meta_MR4_REMOTE_FAULT      <= 2'b00;
         meta_MR_FLOW_CTL           <= 2'b00;
         meta_MR_TAF_100FULL        <= 2'b11;
         meta_MR_TAF_100HALF        <= 2'b11;
         meta_MR_TAF_10FULL         <= 2'b11;
         meta_MR_TAF_10HALF         <= 2'b11;
         meta1_MR_SELECTOR_pll      <= 5'b00001;
         MR_SELECTOR_pll            <= 5'b00001;
         meta_MR_NEXT_PAGE_LOADED   <= 2'b00;
         meta_MR_RXTX_TEST          <= 2'b00;
         meta_MR_MII_LOOP_BACK_DISB <= 2'b11;
         meta_MR_MSE_NORESET        <= 2'b00;
         meta_MR_SQE_ENAB           <= 2'b00;
         meta_MR_JABBER_ENAB        <= 2'b11;
         meta_MR_LINK_TEST_DISB     <= 2'b00;
         meta_MR_SYMBOL_MODE        <= 2'b00;
         meta_MR_BYPASS_SCRAMBLER   <= 2'b00;
         meta_MR_BYPASS10TX_FILTER  <= 2'b00;
         meta_MR_POL_CORR_DISB      <= 2'b00;
         meta_MR_RX10_PLL_MAX_ADJ_SHIFT_pll <= 3'd5;
         MR_RX10_PLL_MAX_ADJ_SHIFT_pll      <= 3'd5;
         meta_MR_SCRAMBLER_SEED_pll <=  5'b00000;
         MR_SCRAMBLER_SEED_pll      <=  5'b00000;
         meta_MR_ERR_THRESH_pll     <=  5'b01010;
         MR_ERR_THRESH_pll          <=  5'b01010;
         meta_MR_ERR_TIMER_pll      <= 10'h3E8;
         MR_ERR_TIMER_pll           <= 10'h3E8;
         meta_MR_FEF_DISB           <=  2'b00;
         meta_MR_AN_NP_MORE         <=  2'b00;
         meta_MR_AN_NP_MSG_PAGE     <=  2'b11;
         meta_MR_AN_NP_ACK2         <=  2'b00;
         meta_MR_AN_NP_MESSAGE      <= 11'b00000000001;
         MR_AN_NP_MESSAGE_pll       <= 11'b00000000001;
         end
      else
         begin
         meta_MR_DIG_LOOP_BACK_ENAB <= {meta_MR_DIG_LOOP_BACK_ENAB[0],
                                        MR_DIG_LOOP_BACK_ENAB};
         meta_MR_100MBS             <= {meta_MR_100MBS[0], MR_100MBS};
         meta_MR_AN_ENAB            <= {meta_MR_AN_ENAB[0], MR_AN_ENAB};
         meta_MR_ISOLATE_TX         <= {meta_MR_ISOLATE_TX[0], MR_ISOLATE_TX};
         meta_MR_FULL_DUPLEX        <= {meta_MR_FULL_DUPLEX[0], MR_FULL_DUPLEX};
         meta_MR_COL_TEST           <= {meta_MR_COL_TEST[0], MR_COL_TEST};
         meta_MR4_REMOTE_FAULT      <= {meta_MR4_REMOTE_FAULT[0],
                                        MR4_REMOTE_FAULT};
         meta_MR_FLOW_CTL           <= {meta_MR_FLOW_CTL[0], MR_FLOW_CTL};
         meta_MR_TAF_100FULL        <= {meta_MR_TAF_100FULL[0],
                                        MR_TAF_100FULL};
         meta_MR_TAF_100HALF        <= {meta_MR_TAF_100HALF[0],
                                        MR_TAF_100HALF};
         meta_MR_TAF_10FULL         <= {meta_MR_TAF_10FULL[0],
                                        MR_TAF_10FULL};
         meta_MR_TAF_10HALF         <= {meta_MR_TAF_10HALF[0],
                                        MR_TAF_10HALF};
         meta1_MR_SELECTOR_pll      <= MR_SELECTOR;
         MR_SELECTOR_pll            <= meta1_MR_SELECTOR_pll;
         meta_MR_NEXT_PAGE_LOADED   <= {meta_MR_NEXT_PAGE_LOADED[0],
                                        MR_NEXT_PAGE_LOADED};
         meta_MR_RXTX_TEST          <= {meta_MR_RXTX_TEST[0], MR_RXTX_TEST};
         meta_MR_MII_LOOP_BACK_DISB <= {meta_MR_MII_LOOP_BACK_DISB[0],
                                        MR_MII_LOOP_BACK_DISB};
         meta_MR_MSE_NORESET        <= {meta_MR_MSE_NORESET[0], MR_MSE_NORESET};
         meta_MR_SQE_ENAB           <= {meta_MR_SQE_ENAB[0], MR_SQE_ENAB};
         meta_MR_JABBER_ENAB        <= {meta_MR_JABBER_ENAB[0], MR_JABBER_ENAB};
         meta_MR_LINK_TEST_DISB     <= {meta_MR_LINK_TEST_DISB[0],
                                        MR_LINK_TEST_DISB};
         meta_MR_SYMBOL_MODE        <= {meta_MR_SYMBOL_MODE[0], MR_SYMBOL_MODE};
         meta_MR_BYPASS_SCRAMBLER   <= {meta_MR_BYPASS_SCRAMBLER[0],
                                        MR_BYPASS_SCRAMBLER};
         meta_MR_BYPASS10TX_FILTER  <= {meta_MR_BYPASS10TX_FILTER[0],
                                        MR_BYPASS10TX_FILTER};
         meta_MR_POL_CORR_DISB      <= {meta_MR_POL_CORR_DISB[0],
                                        MR_POL_CORR_DISB};
         meta_MR_RX10_PLL_MAX_ADJ_SHIFT_pll <= MR_RX10_PLL_MAX_ADJ_SHIFT;
         MR_RX10_PLL_MAX_ADJ_SHIFT_pll <= meta_MR_RX10_PLL_MAX_ADJ_SHIFT_pll;
         meta_MR_SCRAMBLER_SEED_pll    <= MR_SCRAMBLER_SEED;
         MR_SCRAMBLER_SEED_pll         <= meta_MR_SCRAMBLER_SEED_pll;
         meta_MR_ERR_THRESH_pll        <= MR_ERR_THRESH;
         MR_ERR_THRESH_pll             <= meta_MR_ERR_THRESH_pll;
         meta_MR_ERR_TIMER_pll         <= MR_ERR_TIMER;
         MR_ERR_TIMER_pll              <= meta_MR_ERR_TIMER_pll;
         meta_MR_FEF_DISB              <= {meta_MR_FEF_DISB[0], MR_FEF_DISB};
         meta_MR_AN_NP_MORE            <= {meta_MR_AN_NP_MORE[0], MR_AN_NP_MORE};
         meta_MR_AN_NP_MSG_PAGE        <= {meta_MR_AN_NP_MSG_PAGE[0],
                                           MR_AN_NP_MSG_PAGE};
         meta_MR_AN_NP_ACK2            <= {meta_MR_AN_NP_ACK2[0],
                                           MR_AN_NP_ACK2};
         meta_MR_AN_NP_MESSAGE         <= MR_AN_NP_MESSAGE;
         MR_AN_NP_MESSAGE_pll          <= meta_MR_AN_NP_MESSAGE;
         end
      end


   assign MR_DIG_LOOP_BACK_ENAB_pll = meta_MR_DIG_LOOP_BACK_ENAB[1];
   assign MR_100MBS_pll             = meta_MR_100MBS[1];
   assign MR_AN_ENAB_pll            = meta_MR_AN_ENAB[1];
   assign MR_ISOLATE_TX_pll         = meta_MR_ISOLATE_TX[1];
   assign MR_FULL_DUPLEX_pll        = meta_MR_FULL_DUPLEX[1];
   assign MR_COL_TEST_pll           = meta_MR_COL_TEST[1];
   assign MR4_REMOTE_FAULT_pll      = meta_MR4_REMOTE_FAULT[1];
   assign MR_FLOW_CTL_pll           = meta_MR_FLOW_CTL[1];
   assign MR_TAF_100FULL_pll        = meta_MR_TAF_100FULL[1];
   assign MR_TAF_100HALF_pll        = meta_MR_TAF_100HALF[1];
   assign MR_TAF_10FULL_pll         = meta_MR_TAF_10FULL[1];
   assign MR_TAF_10HALF_pll         = meta_MR_TAF_10HALF[1];
   assign MR_NEXT_PAGE_LOADED_pll   = meta_MR_NEXT_PAGE_LOADED[1];
   assign MR_RXTX_TEST_pll          = meta_MR_RXTX_TEST[1];
   assign MR_MII_LOOP_BACK_DISB_pll = meta_MR_MII_LOOP_BACK_DISB[1];
   assign MR_MSE_NORESET_pll        = meta_MR_MSE_NORESET[1];
   assign MR_SQE_ENAB_pll           = meta_MR_SQE_ENAB[1];
   assign MR_JABBER_ENAB_pll        = meta_MR_JABBER_ENAB[1];
   assign MR_LINK_TEST_DISB_pll     = meta_MR_LINK_TEST_DISB[1];
   assign MR_SYMBOL_MODE_pll        = meta_MR_SYMBOL_MODE[1];
   assign MR_BYPASS_SCRAMBLER_pll   = meta_MR_BYPASS_SCRAMBLER[1];
   assign MR_BYPASS10TX_FILTER_pll  = meta_MR_BYPASS10TX_FILTER[1];
   assign MR_POL_CORR_DISB_pll      = meta_MR_POL_CORR_DISB[1];
   assign MR_FEF_DISB_pll           = meta_MR_FEF_DISB[1];
   assign MR_AN_NP_MORE_pll         = meta_MR_AN_NP_MORE[1];
   assign MR_AN_NP_MSG_PAGE_pll     = meta_MR_AN_NP_MSG_PAGE[1];
   assign MR_AN_NP_ACK2_pll         = meta_MR_AN_NP_ACK2;
//------------------------------------------------------------------------------
endmodule

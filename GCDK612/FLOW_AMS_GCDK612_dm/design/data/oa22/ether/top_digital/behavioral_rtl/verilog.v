// Created by ihdl
`timescale 1 ns / 1 ps

module top_digital (
                    // Inputs from Analog (Clocks)
                    RCLK125, X_125, X_160, CLKXTAL, CLKPLL_IN,

                    // Inputs from Analog (10BaseT)
                    SLICER_OUT, POS_DETECT, NEG_DETECT,

                    // Inputs from DSP (to test block)
                    ADC_OUT, ADC_FLASH, AEQ_CNT_DSP, WANDER_CNT_DSP, 
                    TIMING_UP_DSP, TIMING_DN_DSP,

                    // Inputs from DSP (100BaseTX)
                    MSE_GOOD, MLT3_DATAIN, SM_DATA_READ,
                    SIGNAL_DETECT,

                    // Inputs from Pads or Std-Alone Reset Block
                    PHY, ANDIS_I, RESETN, MDC_I, TXER_I,
                    TXEN_I, TXD, TX_SLP_TRIM, TX_AMP_TRIM, 
                    //SIDDQ,
                    
                    // Input for management interface
                    MDIO_IN,

                    // Outputs for management interface
                    MDIO_OUT, MDIO_OE,

                    // Outputs - Reset and Enable Signals to Analog and DSP
                    BASEFX_DIS, RESET_DSP, BASE10_DIS, BASE100TX_DIS, 

                    // Outputs to Analog
                    MDIX,

                    // Hard reset used by DSP sm interface registers
                    RESETREG,

                    RESET25,
                    SM_ADDRESS, SM_DATA_WRITE, SM_WRITE, 

                    // Outputs to Analog (100BaseTX, _O is from test block)
                    WANDER_CNT_ANLG, AEQ_BYPASS, AEQ_CNT_ANLG, 
                    TIMING_UP_ANLG, TIMING_DN_ANLG,
                    MLT3_TDATA, TX_AMPTRIM, TX_SLOPETRIM,

                    // Outputs to Analog (10BaseT)
                    RX10_PRESENT, MR_SQUELCH_DISB, MR_SQUELCH_RANGE,
                    MR_BYPASS10RX_FILTER, TENBT_CLK160, TENBT_FILTER, TP_DISC,
                    BASE10_TX_DIS, TEST_MODE,

                    // Outputs to Pads
                    CRS_O, LEDS_OUT, LEDT_VREF_OUT, LEDL_OUT, LEDC_OUT, 
                    LEDR_LEDA_OUT, LEDD_OUT, RXD_O, RXDV_O, RXC_O, RXER_O, TXC_O, COL_O,
                    FULL_DUPLEX, MDINT, TRISTATE, ENC_BYPASS, CLKPLL_SC,
                    ANLG_TST
                    );

//
// I/O Declarations
//
input         RCLK125;              // Rx Synchronised 125MHz clock
input         X_125;                // Clock 125MHz
input         X_160;                // Clock 160MHz
input         CLKXTAL;              // 25MHz crystal clock
input         CLKPLL_IN;            //
input         SLICER_OUT;           //
input         POS_DETECT;           //
input         NEG_DETECT;           //
input [5:0]   ADC_OUT;              // ADC data
input [2:0]   ADC_FLASH ;           //
input [4:0]   AEQ_CNT_DSP;          //
input [6:0]   WANDER_CNT_DSP;       //
input         TIMING_UP_DSP;        //
input         TIMING_DN_DSP;        //
input         MSE_GOOD;             //
input [1:0]   MLT3_DATAIN;          //
input [15:0]  SM_DATA_READ;         //
input         SIGNAL_DETECT;        //
input [4:0]   PHY;                  // PHY address
input [4:0]   TXD;                  // MII Transmit data
input         ANDIS_I;              // Auto-Negotiation disable
input         RESETN;               // Master reset
input         MDC_I;                // Management data clock
input         TXER_I;               // Transmit error
input         TXEN_I;               // Transmit data enable
input [1:0]   TX_SLP_TRIM;          // Transmit amplitude trim
input [1:0]   TX_AMP_TRIM;          // Transmit slope trim
input         MDIO_IN;              // Management data input

output        MDIO_OUT;             // Management data output
output        MDIO_OE;              // Management data output enable
output        BASEFX_DIS;           // Fiber disable
output        RESET_DSP;            // Reset DSP
output        RESETREG;             // DSP hard reset synced to CLKXTAL
output        BASE10_DIS;           // 10BaseT disable
output        BASE100TX_DIS;        // 10BaseT Transmit disable
output        MDIX;                 //
output        RESET25;              //
output [2:0]  SM_ADDRESS;           //
output [15:0] SM_DATA_WRITE;        //
output        SM_WRITE;             //
output [6:0]  WANDER_CNT_ANLG;      // Baseline wander control
output        AEQ_BYPASS;           // Analogue equaliser bypass
output [4:0]  AEQ_CNT_ANLG;         // Analogue equaliser control
output        TIMING_UP_ANLG;       //
output        TIMING_DN_ANLG;       //
output [1:0]  MLT3_TDATA;           //
output [1:0]  TX_AMPTRIM;           // Transmitter amplitude adjustment
output [1:0]  TX_SLOPETRIM;         // Transmitter slope adjustment
output        RX10_PRESENT;         // 10Base-T receiving data
output        MR_SQUELCH_DISB;      // 10Base-T squelch disabled
output [1:0]  MR_SQUELCH_RANGE;     // Squelch
output        MR_BYPASS10RX_FILTER; // 10Base-T RX filter bypass
output        TENBT_CLK160;         //
output [4:0]  TENBT_FILTER;         //
output        TP_DISC;              //
output        BASE10_TX_DIS;        // 10Base-T TX disable
output [2:0]  TEST_MODE ;           // Test mode
output        CRS_O;                // Carrier sense output
output        LEDS_OUT;             // Speed LED active low 100Mbps
output        LEDT_VREF_OUT;        // Full Duplex LED active low
output        LEDL_OUT;             // Link active LED active low
output        LEDC_OUT;             // Collision LED active low
output        LEDR_LEDA_OUT;        // Receive LED active low
output        LEDD_OUT;             // Full Duplex LED active low
output [4:0]  RXD_O;                // MII receive data
output        RXDV_O;               // Recieve data valid
output        RXC_O;                // Receive clock
output        RXER_O;               // Recieve data error
output        TXC_O;                // Transmit data clock
output        COL_O;                // Collision detection
output        FULL_DUPLEX;          // Full duplex mode
output        MDINT;                // Management interface interrupt
output        TRISTATE;             // Isolate from MII
output        ENC_BYPASS;           // Encoder bypassed
output        CLKPLL_SC;            // Output of PLL that is connected to
                                    // CLKPLL_IN at the level above (Done to
                                    // help with ynthesis)
output        ANLG_TST;             //

//
// I/O Type Declarations
//
// Inputs
wire          RCLK125;              
wire          X_125;                
wire          X_160;                
wire          CLKXTAL;              
wire          CLKPLL_IN;            
wire          SLICER_OUT;           
wire          POS_DETECT;           
wire          NEG_DETECT;           
wire  [5:0]   ADC_OUT;              
wire  [2:0]   ADC_FLASH ;           
wire  [4:0]   AEQ_CNT_DSP;          
wire  [6:0]   WANDER_CNT_DSP;       
wire          TIMING_UP_DSP;        
wire          TIMING_DN_DSP;        
wire          MSE_GOOD;             
wire  [1:0]   MLT3_DATAIN;          
wire  [15:0]  SM_DATA_READ;         
wire          SIGNAL_DETECT;        
wire  [4:0]   PHY;                  
wire  [4:0]   TXD;                  
wire          ANDIS_I;              
wire          RESETN;               
wire          MDC_I;                
wire          TXER_I;               
wire          TXEN_I;               
wire  [1:0]   TX_SLP_TRIM;          
wire  [1:0]   TX_AMP_TRIM;          
wire          MDIO_IN;              

// Outputs
wire          MDIO_OUT;             
wire          MDIO_OE;              
wire          BASEFX_DIS;           
wire          RESET_DSP;            
wire          BASE10_DIS;           
wire          BASE100TX_DIS;        
wire          RESET;                
wire          MDIX;                 
wire   [2:0]  SM_ADDRESS;           
wire   [15:0] SM_DATA_WRITE;        
wire          SM_WRITE;             
wire   [6:0]  WANDER_CNT_ANLG;      
wire          AEQ_BYPASS;           
wire   [4:0]  AEQ_CNT_ANLG;         
wire          TIMING_UP_ANLG;       
wire          TIMING_DN_ANLG;       
wire   [1:0]  MLT3_TDATA;           
wire   [1:0]  TX_AMPTRIM;           
wire   [1:0]  TX_SLOPETRIM;         
wire          RX10_PRESENT;         
wire          MR_SQUELCH_DISB;      
wire   [1:0]  MR_SQUELCH_RANGE;     
wire          MR_BYPASS10RX_FILTER; 
wire          TENBT_CLK160;         
wire   [4:0]  TENBT_FILTER;         
wire          TP_DISC;              
wire          BASE10_TX_DIS;        
wire   [2:0]  TEST_MODE ;           
wire          CRS_O;                
wire          LEDS_OUT;               
wire          LEDT_VREF_OUT;          
wire          LEDL_OUT;               
wire          LEDC_OUT;               
wire          LEDR_LEDA_OUT;          
wire          LEDD_OUT;               
wire   [4:0]  RXD_O;                
wire          RXDV_O;               
wire          RXC_O;                
wire          RXER_O;               
wire          TXC_O;                
wire          COL_O;                
wire          FULL_DUPLEX;          
wire          MDINT;                
wire          TRISTATE;             
wire          ENC_BYPASS;           
wire          CLKPLL_SC;            
wire          ANLG_TST;             


//
// Internal Signal Declarations
//
wire [4:0]    DACDATA;
wire          LINE_DRIVER10_ENAB;
wire [1:0]    MLT3ENC_DATA;
wire [1:0]    LPBK_MLT3DATA;
wire          FE_FAULT;
wire          MR_100MBS;
wire          MR_TP_DISC;
wire          RPD_10_DISB;
wire          RPD_100_DISB;
wire          TP_DISC_int;
wire          TXC;
wire          RXC;
wire          RXC25N;
wire          RXER100;
wire          MR_ALIGN_DISB;
wire          MR_BYPASS_SCRAMBLER;
wire          MR_MII100_LOOP_BACK_ENAB;
wire          MR_MII_LOOP_BACK_DISB;
wire          MR_SQE_ENAB;
wire          MR_LINK_TEST_DISB;
wire          MR_BYPASS10TX_FILTER;
wire          RCLK2_5;
wire          REG_ENAB;
wire          REG_R_NW;
wire          RESETREG;
wire          MR_RESET_DONE;
wire          MR_AN_COMPLETE;
wire          MR_AN_DUPLEX_MODE;
wire          MR_PAGE_RX;
wire          MR_BASE_PAGE;
wire          MR_LP_AN_ABLE;
wire          MRAN_REMOTE_FAULT;
wire          MR4_REMOTE_FAULT;
wire          SELECT_160MHZ;
wire          MR_MSE_NORESET;
wire          MR_PLL_LOCKED;
wire          MR_NO_COMMON_MODE;
wire          LINK10_DOWN;
wire          LINK100_DOWN;
wire          LINK_DET;
wire          JABBER_DETECTED;
wire          MR_JABBER_ENAB;
wire          AN_ACTIVE;
wire          AN_ACTIVE_XTND;
wire          MR_POL_CORR_DISB;
wire          T_PULSE;
wire          MR_FEF_DISB;
wire          RX100_ACTIVE;
wire          TX100_ACTIVE;
wire          RX10_ACTIVE;
wire          TX10_ACTIVE;
wire          L10_LINK_CONTROL;
wire [1:0]    L100_LINK_CONTROL;
wire [1:0]    L100_LINK_STATUS;
wire [4:0]    RX100_DATA;
wire          RX100_DV;
wire          RX100_ER;
wire [3:0]    RXD10;
wire [3:0]    RX10_DATA;
wire          RXDV10;
wire          CRS10;
wire          CRS100;
wire          DEC10_DATA_D1;
wire          DEC10_RCLK10;
wire          MR_POL_REVERSED;
wire [4:0]    RXD100;
wire          RXDV100;
wire [4:0]    REG_ADDR;
wire [15:0]   REG_DIN;
wire [15:0]   REG_DOUT;
wire [15:0]   MR_AN_LP_ABILITY;
wire          MR_RESET_TO_RCB;
wire [4:0]    MR_SELECTOR;
wire [2:0]    MR_RX10_PLL_MAX_ADJ_SHIFT;
wire          AN_PULSE;
wire          MR_AN_ENAB;
wire          MR_AN_RESTART;
wire          MR_FULL_DUPLEX;
wire          MR_FLOW_CTL;
wire          MR_TAF_100FULL;
wire          MR_TAF_100HALF;
wire          MR_TAF_10FULL;
wire          MR_TAF_10HALF;
wire          MR_COL_TEST;
wire          MR_DIG_LOOP_BACK_ENAB;
wire          MR_RXTX_TEST;
wire          MR_POWER_DOWN;
wire          MR_MDIX_DISB;
wire          MR_MDIX_FORCE;
wire          MDIX_int;
wire          MR_NP_ENAB;
wire [15:0]   MR_AN_NP;
wire          MR_NEXT_PAGE_LOADED;
wire          MR_AN_NP_LCW_TOGGLE;
wire [4:0]    MR_SCRAMBLER_SEED;
wire          MR_SCRAMBLER_LOAD;
wire [4:0]    MR_PHY;
wire [4:0]    MR_ERR_THRESH;
wire [9:0]    MR_ERR_TIMER;
wire          CFG1_I;
wire          MR_REPEATER;
wire          MR_REPEATER_COL_DISB;
wire          RXDV;
wire [4:0]    RXD;
wire          clk160_enable;
wire          clk160n_enable;
wire          clk125_enable;
wire          clk125_disb;
wire          txc25_enable;
wire          clk12_5_enable;
wire          clk10_enable;
wire          clk10n_enable;
wire          txc2_5_enable;
wire          txc2_5n_enable;
wire          clkfast_enable;
wire          clkfastd8_enable;
wire          clkfastd8_gate;
wire          MR_100MBS_pll;
wire          MR_AN_ENAB_pll;
wire          MR_ISOLATE_TX_pll;
wire          MR_SYMBOL_MODE_pll;
wire          MR_BYPASS_SCRAMBLER_pll;

// internal wires added for Mux/Debug system module (dig_test_mux.v):
wire          MR_FORCE_TIMER;
wire [14:0]   MR_TEST_MODE;
wire [15:0]   an_debug_bus;
wire          MR_PARALLEL_DETECTION_FAULT;
wire          LEDS_OUT_topdig;
wire          LEDT_VREF_OUT_topdig;
wire          LEDR_LEDA_OUT_topdig;
wire          LEDD_OUT_topdig;
wire          LEDL_OUT_topdig;
wire          LEDC_OUT_topdig;

//
// Parameter Declarations
//
// None


//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
// This module contains the PCS submodules


assign RXER_O = MR_100MBS_pll & RXER100;
assign SM_ADDRESS = REG_ADDR[2:0];
assign FULL_DUPLEX = MR_FULL_DUPLEX;
assign ANLG_TST = (|TEST_MODE);
   
// *** FIX THIS ***
// These signals should be pulled out!!!!!
assign CFG1_I               = 1'b0;
assign MR_REPEATER          = 1'b0;
assign MR_REPEATER_COL_DISB = 1'b0;
// *** END FIX ***

// The fibre mode is not used
assign BASEFX_DIS = 1'b1;

dig_test_mux i_dig_test_mux (
                     // Inputs
                     // from dig_n_arbitration.v
                     .arb_intl_bus(an_debug_bus[14:7]),
                     .MR_AN_NP_LCW_TOGGLE(MR_AN_NP_LCW_TOGGLE),
                     .MR_AUTONEG_COMPLETE(MR_AN_COMPLETE),
                     .MR_BASE_PAGE(MR_BASE_PAGE),
                     .MR_PARALLEL_DETECTION_FAULT(MR_PARALLEL_DETECTION_FAULT),
                     .TX_ACK_BIT(an_debug_bus[6]),
 
                     // from dig_an_transmit.v
                     .TD_AUTONEG(an_debug_bus[5]),
                     .ACK_FINISHED(an_debug_bus[4]),
 
                     // from dig_an_receive.v
                     .FLP_RECEIVE_IDLE(an_debug_bus[3]),
                     .RCV_DONE(an_debug_bus[15]),
                     .TIMEOUT(an_debug_bus[2]),
 
                     // from dig_an_linktest.v
                     .LINK_STATUS(an_debug_bus[1]),
 
                     // from dig_an_txrx10.v
                     .LINKPULSE(an_debug_bus[0]),
 
                     //from dig_regs.v
                     .MR_TEST_MODE(MR_TEST_MODE),
                     .MR_NO_COMMON_MODE(MR_NO_COMMON_MODE),
                     .MR_DUPLEX_MODE(MR_AN_DUPLEX_MODE),

                     // for RESET_DSP test mux (from dsp blocks)
                     .RESET_DSP(RESET_DSP),
                     .MSE_GOOD(MSE_GOOD),

                     // squelch outputs
                     .RX10_PRESENT(RX10_PRESENT),
                     .POS_LINK_PULSE(POS_LINK_PULSE),
                     .NEG_LINK_PULSE(NEG_LINK_PULSE),

                     // polarity check output
                     .MR_POL_REVERSED(MR_POL_REVERSED),

                     // Manchester decode signals
                     .DEC10_RCLK_GOOD(DEC10_RCLK_GOOD),
                     .NEW_EDGE(NEW_EDGE),
                     .SLICER_MUX(SLICER_MUX),
                     .DEC10_RCLK10(DEC10_RCLK10),
                     .DEC10_DATA(DEC10_DATA),
 
                     // From fef det
                     .FE_FAULT(FE_FAULT),

                     //from top_digital.v
                     .LINK10_DOWN(LINK10_DOWN),
                     .LINK100_DOWN(LINK100_DOWN),
   
                     // from top_dig_led_out.v
                     .LEDS_OUT_topdig(LEDS_OUT_topdig),
                     .LEDT_VREF_OUT_topdig(LEDT_VREF_OUT_topdig),
                     .LEDR_LEDA_OUT_topdig(LEDR_LEDA_OUT_topdig),
                     .LEDD_OUT_topdig(LEDD_OUT_topdig),
 
                     // from dig_test.v
                     .LEDL_OUT_topdig(LEDL_OUT_topdig),
                     .LEDC_OUT_topdig(LEDC_OUT_topdig),
 
                     // from dig_clk.v
                     .clk12_5_enable(clk12_5_enable),

                     // Outputs 
                     .LEDS_OUT(LEDS_OUT),
                     .LEDT_VREF_OUT(LEDT_VREF_OUT),
                     .LEDR_LEDA_OUT(LEDR_LEDA_OUT),
                     .LEDD_OUT(LEDD_OUT),
                     .LEDL_OUT(LEDL_OUT),
                     .LEDC_OUT(LEDC_OUT)
                     );
                     
                     
top_dig_led_out i_top_dig_led_out (
                     // Inputs
                     .MR_100MBS(MR_100MBS_pll),
                     .TX100_ACTIVE(TX100_ACTIVE),
                     .TX10_ACTIVE(TX10_ACTIVE),
                     .RX100_ACTIVE(RX100_ACTIVE),
                     .RX10_ACTIVE(RX10_ACTIVE),
                     .MR_FULL_DUPLEX(MR_FULL_DUPLEX),

                     // Outputs
                     .LEDS_OUT_topdig(LEDS_OUT_topdig),
                     .LEDT_VREF_OUT_topdig(LEDT_VREF_OUT_topdig),
                     .LEDR_LEDA_OUT_topdig(LEDR_LEDA_OUT_topdig),
                     .LEDD_OUT_topdig(LEDD_OUT_topdig)
                     );


dig_tx10misc i_dig_tx10misc (
                       .CLKPLL_IN(CLKPLL_IN), 
                       .TXD(TXD[3:0]),
                       .TXEN(TXEN_I), 
                       .MR_ISOLATE_TX(TRISTATE),
                       .AN_TXEN(AN_TXEN),
                       .AN_PULSE(AN_PULSE),
                       .RESET(RESETPLL),
                       .clk10_enable(clk10_enable),
                       .clk10n_enable(clk10n_enable),
                       .txc2_5_enable(txc2_5_enable),
                       .txc2_5n_enable(txc2_5n_enable),
                       .CLK2_5_NO_FF(CLK2_5_NO_FF),
                       .clk160_enable(clk160_enable),
                       .clkfast_enable(clkfast_enable),
                       .clkfastd8_enable(clkfastd8_enable),
                       .clkfastd8_gate(clkfastd8_gate),
                       .MR_BYPASS10TX_FILTER(MR_BYPASS10TX_FILTER),
                       .MR_JABBER_ENAB(MR_JABBER_ENAB),
                       .MR_FULL_DUPLEX(MR_FULL_DUPLEX),
                       .MR_REPEATER(MR_REPEATER),
                       .MR_100MBS(MR_100MBS_pll),
                       .MR_LINK_TEST_DISB(MR_LINK_TEST_DISB),
                       .MR_SQE_ENAB(MR_SQE_ENAB),
                       .MR_REPEATER_COL_DISB(MR_REPEATER_COL_DISB),
                       .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB),
                       .MR_COL_TEST(MR_COL_TEST),
                       .MR_FAST_LINK(MR_FAST_LINK),
                       .MR_FAST_JABBER(MR_FAST_JABBER),
                       .MR_POL_REVERSED(MR_POL_REVERSED),
                       .POS_LINK_PULSE(POS_LINK_PULSE),
                       .NEG_LINK_PULSE(NEG_LINK_PULSE),
                       .RX10_ACTIVE(RX10_ACTIVE),
                       .RX100_ACTIVE(RX100_ACTIVE),
                       .TX100_ACTIVE(TX100_ACTIVE),
                       .RX10_PRESENT(RX10_PRESENT),
                       .MR_MII10_LOOP_BACK_DISB(MR_MII_LOOP_BACK_DISB),
                       .RX10_DATA(RX10_DATA),
                       .RX10_DV(RX10_DV),
                       .CFG1_I(CFG1_I),
                       .DACDATA(DACDATA),
                       .LINE_DRIVER10_ENAB(LINE_DRIVER10_ENAB),
                       .CRS_GEN(CRS_GEN),
                       .CRS10(CRS10),
                       .COL(COL_O),
                       .RXD10(RXD10),
                       .RXDV10(RXDV10),
                       .LINK_DOWN(LINK10_DOWN),
                       .JABBER_DETECTED(JABBER_DETECTED),
                       .TX10_ACTIVE(TX10_ACTIVE)
                       );

   
dig_slicer_mux i_dig_slicer_mux (.DACDATA(DACDATA[4:3]),
                                 .SLICER_OUT(SLICER_OUT),
                                 .MR_POL_REVERSED(MR_POL_REVERSED),
                                 .POS_DETECT(POS_DETECT),
                                 .NEG_DETECT(NEG_DETECT),
                                 .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB),
                                 .SLICER_MUX(SLICER_MUX),
                                 .POS_DETECT_MUX(POS_DETECT_MUX),
                                 .NEG_DETECT_MUX(NEG_DETECT_MUX)
                                 );
   
dig_rx10 i_dig_rx10 (
                     .CLKPLL_IN(CLKPLL_IN), 
                     .POS_DETECT(POS_DETECT_MUX),
                     .NEG_DETECT(NEG_DETECT_MUX),
                     .clk160_enable(clk160_enable),
                     .clk160n_enable(clk160n_enable),
                     .txc2_5_enable(txc2_5_enable),
                     .RESET(RESETPLL),
                     .SLICER_MUX(SLICER_MUX),
                     .MR_RX10_PLL_MAX_ADJ_SHIFT(MR_RX10_PLL_MAX_ADJ_SHIFT),
                     .MR_SYMBOL_MODE(ENC_BYPASS),
                     .MR_POL_CORR_DISB(MR_POL_CORR_DISB),
                     .RX10_PRESENT(RX10_PRESENT),
                     .POS_LINK_PULSE(POS_LINK_PULSE),
                     .NEG_LINK_PULSE(NEG_LINK_PULSE),
                     .MR_POL_REVERSED(MR_POL_REVERSED),
                     .DEC10_DATA_D1(DEC10_DATA_D1),
                     .DEC10_RCLK10(DEC10_RCLK10),
                     .RCLK2_5_GOOD(RCLK2_5_GOOD),
                     .RX10_DV(RX10_DV),
                     .RX10_DATA(RX10_DATA),
                     .RX10_ACTIVE(RX10_ACTIVE),
                     .RX10_RCLK2_5(RX10_RCLK2_5),
                     .DEC10_RCLK_GOOD(DEC10_RCLK_GOOD),
                     .NEW_EDGE(NEW_EDGE),
                     .DEC10_DATA(DEC10_DATA)
                     );
   
dig_tx100_path i_dig_tx100_path (
                      .TXD(TXD),
                      .TXEN(TXEN_I),
                      .TXER(TXER_I),
                      .CLKPLL_IN(CLKPLL_IN),
                      .txc25_enable(txc25_enable),
                      .TXC25_ALIGN(TXC25_ALIGN),
                      .clk125_enable(clk125_enable),
                      .RESET(RESETPLL),
                      .MR_100MBS(MR_100MBS_pll),
                      .LINK100_DOWN(LINK100_DOWN),
                      .MR_SYMBOL_MODE(MR_SYMBOL_MODE_pll),
                      .MR_SCRAMBLER_SEED(MR_SCRAMBLER_SEED),
                      .MR_SCRAMBLER_LOAD(MR_SCRAMBLER_LOAD),
                      .MR_BYPASS_SCRAMBLER(MR_BYPASS_SCRAMBLER_pll),
                      .MR_ISOLATE_TX(TRISTATE),
                      .MLT3ENC_DATA(MLT3ENC_DATA),
                      .TX100_ACTIVE(TX100_ACTIVE),
                      .MSE_GOOD(MSE_GOOD),
                      .MR_AN_ENAB(MR_AN_ENAB_pll),
                      .MR_FEF_DISB(MR_FEF_DISB),
                      .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB)
                      );
   
dig_rx100_path i_dig_rx100_path (
                      .LPBK_MLT3DATA(LPBK_MLT3DATA),
                      .RXCLK125(RCLK125),
                      .RXC25N(RXC25N),
                      .MR_SYMBOL_MODE(ENC_BYPASS),
                      .MR_BYPASS_SCRAMBLER(MR_BYPASS_SCRAMBLER),
                      .MR_ALIGN_DISB(MR_ALIGN_DISB),
                      .RESET(RESETRX125),
                      .RX100_DATA(RX100_DATA),
                      .RX100_DV(RX100_DV), 
                      .RX100_ER(RX100_ER),
                      .RX100_ACTIVE(RX100_ACTIVE),
                      .LOCKED2IDLES(LOCKED2IDLES),
                      .RX100_STABLE(RX100_STABLE),
                      .LINK100_DOWN(LINK100_DOWN),
                      .SIGNAL_DETECT(SIGNAL_DETECT),
                      .MR_AN_ENAB(MR_AN_ENAB),
                      .MR_FEF_DISB(MR_FEF_DISB),
                      .FE_FAULT(FE_FAULT),
                      .IDLE_DSP_RESET(IDLE_DSP_RESET)
                      );
   
dig_rx_mux i_dig_rx_mux (.RXDV10(RXDV10),
                         .RXD10(RXD10),
                         .RXDV100(RXDV100),
                         .RXD100(RXD100),
                         .CRS10(CRS10),
                         .CRS100(CRS100),
                         .MR_100MBS(MR_100MBS_pll),
                         .RXDV(RXDV),
                         .RXD(RXD[3:0]),
                         .CFG2_O(RXD[4]),
                         .CRS(CRS_O)
                         );
   
dig_rxtx_tpdisc i_dig_rxtx_tpdisc (
                         .MR_100MBS(MR_100MBS_pll), 
                         .MR_MII100_LOOP_BACK_ENAB(MR_MII100_LOOP_BACK_ENAB),
                         .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB),
                         .MR_TP_DISC(MR_TP_DISC),
                         .TP_DISC(TP_DISC_int)
                         );
   
dig_rxtx100_misc i_dig_rxtx100_misc (
                          .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB), 
                          .MLT3ENC_DATA(MLT3ENC_DATA),
                          .MLT3_DATAIN(MLT3_DATAIN),
                          .MR_MII100_LOOP_BACK_ENAB(MR_MII100_LOOP_BACK_ENAB), 
                          .MR_FULL_DUPLEX(MR_FULL_DUPLEX),
                          .CLKPLL_IN(CLKPLL_IN),
                          .RESETPLL(RESETPLL),
                          .txc25_enable(txc25_enable),
                          .txc25n_enable(txc25n_enable),
                          .TXD(TXD),
                          .TXEN(TXEN_I),
                          .TXER(TXER_I), 
                          .clk125_disb(clk125_disb),
                          .RESET_DSP25(RESET_DSP25),
                          .RXCLK125(RCLK125), 
                          .RESETRX125(RESETRX125),
                          .RX100_DATA(RX100_DATA), 
                          .RX100_DV(RX100_DV),
                          .RX100_ER(RX100_ER),
                          .CRS_GEN(CRS_GEN),
                          .RESETREG(RESET25),
                          .MR_100MBS(MR_100MBS_pll), 
                          .MSE_GOOD(MSE_GOOD),
                          .L100_LINK_CONTROL(L100_LINK_CONTROL),
                          .MR_RXTX_TEST(MR_RXTX_TEST),
                          .LOCKED2IDLES(LOCKED2IDLES),
                          .LPBK_MLT3DATA(LPBK_MLT3DATA), 
                          .RXD100(RXD100),
                          .RXDV100(RXDV100),
                          .RXER100(RXER100), 
                          .CRS100(CRS100), 
                          .L100_LINK_STATUS(L100_LINK_STATUS),
                          .LINK100_DOWN(LINK100_DOWN),
                          .RCLK25_GOOD(RCLK25_GOOD),
                          .RX100_STABLE(RX100_STABLE),
                          .FE_FAULT(FE_FAULT)
                          );
   

dig_mdio i_dig_mdio (.MDIO_I(MDIO_IN),
                     .MDIO_O(MDIO_OUT),
                     .MDC(MDC_I),
                     .REG_DOUT(REG_DOUT),
                     .PHYADDR(MR_PHY),
                     .RESET(RESETREG),
                     .MDIO_OE(MDIO_OE),
                     .REG_ENAB(REG_ENAB),
                     .REG_R_NW(REG_R_NW),
                     .REG_ADDR(REG_ADDR),
                     .REG_DIN(REG_DIN)
                     );

   
dig_regs i_dig_regs (.CLKXTAL(CLKXTAL),
                     .REG_ENAB(REG_ENAB),
                     .REG_R_NW(REG_R_NW),
                     .REG_ADDR(REG_ADDR),
                     .REG_DIN(REG_DIN),
                     .RESETREG(RESETREG),
                     .SM_DATA_READ(SM_DATA_READ),
                     .MR_RESET_DONE(MR_RESET_DONE), 
                     .MR_AN_COMPLETE(MR_AN_COMPLETE),
                     .MR_AN_LP_ABILITY(MR_AN_LP_ABILITY),
                     .MR_AN_DUPLEX_MODE(MR_AN_DUPLEX_MODE),
                     .MR_AN_NP_LCW_TOGGLE(MR_AN_NP_LCW_TOGGLE),
                     .MR_PARALLEL_DETECTION_FAULT(MR_PARALLEL_DETECTION_FAULT),
                     .MR_PAGE_RX(MR_PAGE_RX),
                     .MR_LP_AN_ABLE(MR_LP_AN_ABLE),
                     .MRAN_REMOTE_FAULT(MRAN_REMOTE_FAULT),
                     .SELECT_160MHZ(SELECT_160MHZ),
                     .MR_NO_COMMON_MODE(MR_NO_COMMON_MODE),
                     .MR_POL_REVERSED(MR_POL_REVERSED),
                     .LINK_DOWN_10(LINK10_DOWN),
                     .LINK_DOWN_100(LINK100_DOWN),
                     .JABBER_DETECTED(JABBER_DETECTED),
                     .ANDIS_I(ANDIS_I),
                     .AN_ACTIVE(AN_ACTIVE),
                     .L10_LINK_CONTROL(L10_LINK_CONTROL),
                     .L100_LINK_CONTROL(L100_LINK_CONTROL),
                     .MDIX(MDIX_int),
                     .TX_AMP_TRIM(TX_AMP_TRIM),
                     .TX_SLP_TRIM(TX_SLP_TRIM),
                     .PHY(PHY),
                     .CLKPLL_IN(CLKPLL_IN),
                     .RESETPLL(RESETPLL),
                     .REG_DOUT(REG_DOUT),
                     .SM_DATA_WRITE(SM_DATA_WRITE),
                     .SM_WRITE(SM_WRITE),
                     .MR_RESET_TO_RCB(MR_RESET_TO_RCB), 
                     .MR_DIG_LOOP_BACK_ENAB_pll(MR_DIG_LOOP_BACK_ENAB),
                     .MR_100MBS(MR_100MBS),
                     .MR_100MBS_pll(MR_100MBS_pll),
                     .MR_AN_ENAB(MR_AN_ENAB),
                     .MR_AN_ENAB_pll(MR_AN_ENAB_pll),
                     .MR_POWER_DOWN(MR_POWER_DOWN),
                     .MR_ISOLATE_TX_pll(TRISTATE),
                     .MR_AN_RESTART(MR_AN_RESTART),
                     .MR_FULL_DUPLEX_pll(MR_FULL_DUPLEX),
                     .MR_COL_TEST_pll(MR_COL_TEST),
                     .MR4_REMOTE_FAULT_pll(MR4_REMOTE_FAULT),
                     .MR_FLOW_CTL_pll(MR_FLOW_CTL),
                     .MR_TAF_100FULL_pll(MR_TAF_100FULL),
                     .MR_TAF_100HALF_pll(MR_TAF_100HALF),
                     .MR_TAF_10FULL_pll(MR_TAF_10FULL),
                     .MR_TAF_10HALF_pll(MR_TAF_10HALF),
                     .MR_SELECTOR_pll(MR_SELECTOR),
                     .MR_AN_NP(MR_AN_NP),
                     .MR_NEXT_PAGE_LOADED_pll(MR_NEXT_PAGE_LOADED),
                     .MR_RXTX_TEST_pll(MR_RXTX_TEST), 
                     .MR_MII_LOOP_BACK_DISB_pll(MR_MII_LOOP_BACK_DISB),
                     .MR_SQE_ENAB_pll(MR_SQE_ENAB),
                     .MR_JABBER_ENAB_pll(MR_JABBER_ENAB),
                     .MR_LINK_TEST_DISB_pll(MR_LINK_TEST_DISB),
                     .MR_SYMBOL_MODE(ENC_BYPASS),
                     .MR_SYMBOL_MODE_pll(MR_SYMBOL_MODE_pll),
                     .MR_ALIGN_DISB(MR_ALIGN_DISB),
                     .MR_BYPASS_SCRAMBLER(MR_BYPASS_SCRAMBLER),
                     .MR_BYPASS_SCRAMBLER_pll(MR_BYPASS_SCRAMBLER_pll),
                     .MR_TP_DISC(MR_TP_DISC),
                     .MR_BYPASS10TX_FILTER_pll(MR_BYPASS10TX_FILTER),
                     .MR_BYPASS10RX_FILTER(MR_BYPASS10RX_FILTER),
                     .MR_SQUELCH_RANGE(MR_SQUELCH_RANGE),
                     .MR_SQUELCH_DISB(MR_SQUELCH_DISB),
                     .MR_POL_CORR_DISB_pll(MR_POL_CORR_DISB),
                     .MR_RX10_PLL_MAX_ADJ_SHIFT_pll(MR_RX10_PLL_MAX_ADJ_SHIFT),
                     .MR_MII100_LOOP_BACK_ENAB_pll(MR_MII100_LOOP_BACK_ENAB),
                     .MR_MSE_NORESET_pll(MR_MSE_NORESET),
                     .MR_NP_ENAB(MR_NP_ENAB),
                     .MR_MDIX_DISB(MR_MDIX_DISB),
                     .MR_MDIX_FORCE(MR_MDIX_FORCE),
                     .TX_AMPTRIM(TX_AMPTRIM),
                     .TX_SLOPETRIM(TX_SLOPETRIM),
                     .TEST_MODE(TEST_MODE),
                     .MR_SCRAMBLER_SEED_pll(MR_SCRAMBLER_SEED),
                     .MR_SCRAMBLER_LOAD(MR_SCRAMBLER_LOAD),
                     .MR_PHY(MR_PHY),
                     .MR_ERR_THRESH_pll(MR_ERR_THRESH),
                     .MR_ERR_TIMER_pll(MR_ERR_TIMER),
                     .MDINT(MDINT),
                     .MR_FEF_DISB_pll(MR_FEF_DISB),
                     .MR_TEST_MODE(MR_TEST_MODE),
                     .MR_FORCE_TIMER(MR_FORCE_TIMER),
                     .MR_FAST_LINK(MR_FAST_LINK),
                     .MR_FAST_JABBER(MR_FAST_JABBER),
                     .MR_FAST_MSE(MR_FAST_MSE)
                     );

dig_clk i_dig_clk (
             .RX10_RCLK2_5(RX10_RCLK2_5),
             .MR_100MBS(MR_100MBS_pll),
             .CLKXTAL(CLKXTAL),
             .RCLK2_5_GOOD(RCLK2_5_GOOD),
             .X_125(X_125),
             .X_160(X_160),             
             .RX100_RCLK25(RXC25N),
             .RCLK25_GOOD(RCLK25_GOOD),
             .AN_ACTIVE_XTND(AN_ACTIVE_XTND),
             .RESET(RESET25),
             .RPD_10_DISB(RPD_10_DISB),
             .RPD_100_DISB(RPD_100_DISB),
             .RESETREG(RESETREG),
             .RESETPLL(RESETPLL),
             .CLKPLL_IN(CLKPLL_IN),
             .LINK10_DOWN(LINK10_DOWN),
             .LINK100_DOWN(LINK100_DOWN),
             .MR_AN_ENAB(MR_AN_ENAB_pll),
             .CLKPLL_SC(CLKPLL_SC),
             .clk160_enable(clk160_enable),
             .clk160n_enable(clk160n_enable),
             .clk12_5_enable(clk12_5_enable),
             .clk10_enable(clk10_enable),
             .clk10n_enable(clk10n_enable),
             .RCLK2_5_SC(RCLK2_5),
             .RXC_SC(RXC),
             .clk125_enable(clk125_enable),
             .clk125_disb(clk125_disb),
             .CLKFAST_SC(CLKFAST),
             .clkfast_enable(clkfast_enable),
             .clkfastd8_enable(clkfastd8_enable),
             .clkfastd8_gate(clkfastd8_gate),
             .TXC_O_SC(TXC),
             .TXC25_SC(TXC25),
             .txc25_enable(txc25_enable),
             .txc25n_enable(txc25n_enable),
             .TXC25_ALIGN(TXC25_ALIGN),
             .txc2_5_enable(txc2_5_enable),
             .txc2_5n_enable(txc2_5n_enable),
             .CLK2_5_NO_FF(CLK2_5_NO_FF),
             .MR_PLL_LOCKED(MR_PLL_LOCKED),
             .XOFF_20(XOFF_20),
             .BASE10_DIS(BASE10_DIS),
             .BASE100TX_DIS(BASE100TX_DIS),
             .BASE100TX_DIS_ER(BASE100TX_DIS_ER)
             );


dig_reset i_dig_reset (
               .RESETN(RESETN),
               .MR_RESET_TO_RCB(MR_RESET_TO_RCB),
               .AN_ACTIVE(AN_ACTIVE),
               .MR_POWER_DOWN(MR_POWER_DOWN), 
               .MR_100MBS(MR_100MBS),
               .CLKXTAL(CLKXTAL),
               .BASE100TX_DIS_ER(BASE100TX_DIS_ER),
               .ANLG_TST(ANLG_TST),
               .MR_ERR_THRESH(MR_ERR_THRESH),
               .MR_ERR_TIMER(MR_ERR_TIMER),
               .MR_MSE_NORESET(MR_MSE_NORESET),
               .MR_FAST_MSE(MR_FAST_MSE),
               .CLKPLL_IN(CLKPLL_IN),
               .txc25_enable(txc25_enable),
               .RX100_STABLE(RX100_STABLE),
               .RX100_ER(RX100_ER),
               .TP_DISC(TP_DISC),
               .RXCLK125(RCLK125),
               .XOFF_20(XOFF_20),
               .IDLE_DSP_RESET(IDLE_DSP_RESET),
               .RESET25(RESET25),
               .RESETPLL(RESETPLL),
               .RESET_DSP(RESET_DSP),
               .RESET_DSP25(RESET_DSP25),
               .RESETRX125(RESETRX125),              
               .RESETREG(RESETREG),
               .RPD_10_DISB(RPD_10_DISB),
               .RPD_100_DISB(RPD_100_DISB),
               .MR_RESET_DONE(MR_RESET_DONE)          
               );


dig_an_autonegotiation i_dig_an_autonegotiation (
                .CLKPLL_IN(CLKPLL_IN),
                .clk12_5_enable(clk12_5_enable),
                .clkfast_enable(clkfast_enable),
                .LINK10_DOWN(LINK10_DOWN),
                .L100_LINK_STATUS(L100_LINK_STATUS),
                .MR_ADV_ABILITY({MR4_REMOTE_FAULT,
                                 2'b00,   
                                 MR_FLOW_CTL,
                                 1'b0,  // 100BASE-T4 ability not supported
                                 MR_TAF_100FULL,
                                 MR_TAF_100HALF,
                                 MR_TAF_10FULL,
                                 MR_TAF_10HALF,
                                 MR_SELECTOR}),
                .MR_AUTONEG_ENABLE(MR_AN_ENAB_pll),
                .MR_NEXT_PAGE_LOADED(MR_NEXT_PAGE_LOADED),
                .MR_NP_ABLE(MR_NP_ENAB),
                .MR_RESTART_NEGOTIATION(MR_AN_RESTART),
                .NEG_DETECT(NEG_DETECT),
                .POS_DETECT(POS_DETECT),
                .RESET(RESETPLL),
                .TX_MR_AN_NP(MR_AN_NP),
                .MR_FORCE_TIMER(MR_FORCE_TIMER),
                .L10_LINK_CONTROL(L10_LINK_CONTROL),
                .L100_LINK_CONTROL(L100_LINK_CONTROL),
                .LINK_DET(LINK_DET),
                .MR_AN_NP_LCW_TOGGLE(MR_AN_NP_LCW_TOGGLE),
                .MR_AUTONEG_COMPLETE(MR_AN_COMPLETE),
                .MR_BASE_PAGE(MR_BASE_PAGE),
                .MR_DUPLEX_MODE(MR_AN_DUPLEX_MODE),
                .MR_LP_ADV_ABILITY(MR_AN_LP_ABILITY),
                .MR_LP_AUTONEG_ABLE(MR_LP_AN_ABLE),
                .MR_LP_NP_ABLE(MR_LP_NP_ABLE),
                .MR_NO_COMMON_MODE(MR_NO_COMMON_MODE),
                .MR_PAGE_RX(MR_PAGE_RX),
                .MR_PARALLEL_DETECTION_FAULT(MR_PARALLEL_DETECTION_FAULT),
                .MR_REMOTE_FAULT(MRAN_REMOTE_FAULT),
                .SELECT_160MHZ(SELECT_160MHZ),
                .TXD(AN_PULSE),
                .TXE(AN_TXEN),
                .T_PULSE(T_PULSE),
                .an_debug_bus(an_debug_bus),
                .AN_ACTIVE(AN_ACTIVE),
                .AN_ACTIVE_XTND(AN_ACTIVE_XTND),
                .MR_FAST_LINK(MR_FAST_LINK)
                );
                
   
dig_mdix i_dig_mdix (
               .CLKPLL_IN(CLKPLL_IN),
               .clk12_5_enable(clk12_5_enable),
               .RESET(RESETPLL),
               .MDI_STATUS(MDIX_int),
               .T_PULSE(T_PULSE),
               .LINK_DET(LINK_DET),
               .A_TIMER_DONE(A_TIMER_DONE),
               .PHY_ID(MR_PHY),
               .MR_MDIX_DISB(MR_MDIX_DISB),
               .MR_MDIX_FORCE(MR_MDIX_FORCE)
               );

dig_arbitrary_timer i_dig_arbitrary_timer (
                               .CLKPLL_IN(CLKPLL_IN), 
                               .clk12_5_enable(clk12_5_enable),
                               .RESET(RESETPLL),
                               .A_TIMER_DONE(A_TIMER_DONE)
                               );


dig_test i_dig_test (
               .TEST_MODE(TEST_MODE),
               .ADC_OUT(ADC_OUT),
               .FLASH_OUT(ADC_FLASH),
               .PHY(PHY),
               .DEC10_RCLK10(DEC10_RCLK10),
               .DEC10_DATA_D1(DEC10_DATA_D1),
               .SLICER_OUT(SLICER_OUT),
               .TIMING_UP_DSP(TIMING_UP_DSP), 
               .TIMING_DN_DSP(TIMING_DN_DSP),
               .AEQ_CNT_DSP(AEQ_CNT_DSP),
               .WANDER_CNT_DSP(WANDER_CNT_DSP),
               .TXER_I(TXER_I),
               .TXC(TXC),
               .RXDV(RXDV),
               .RXC(RXC),
               .RXD(RXD),
               .TXEN_I(TXEN_I),
               .CLKFAST(CLKFAST),
               .DACDATA(DACDATA),
               .TXD(TXD),
               .MLT3ENC_DATA(MLT3ENC_DATA),
               .MR_100MBS(MR_100MBS_pll),
               .LINK100_DOWN(LINK100_DOWN),
               .LINK10_DOWN(LINK10_DOWN),
               .COL(COL_O),
               .RESET(RESETRX125),
               .RCLK125(RCLK125),
               .LINE_DRIVER10_ENAB(LINE_DRIVER10_ENAB),
               .X_125(X_125),
               .X_160(X_160),
               .MLT3_DATAIN(MLT3_DATAIN[0]),
               .MDIX(MDIX_int),
               .TP_DISC(TP_DISC_int),
               .AEQ_BYPASS(AEQ_BYPASS),
               .AEQ_CNT_ANLG(AEQ_CNT_ANLG),
               .TIMING_UP_ANLG(TIMING_UP_ANLG),
               .TIMING_DN_ANLG(TIMING_DN_ANLG),
               .WANDER_CNT_ANLG(WANDER_CNT_ANLG),
               .RXDV_O(RXDV_O),
               .RXC_O(RXC_O),
               .TENBT_CLK160(TENBT_CLK160),
               .RXD_O(RXD_O), 
               .TENBT_FILTER(TENBT_FILTER),
               .MLT3_TDATA(MLT3_TDATA),
               .LEDL_OUT_topdig(LEDL_OUT_topdig),
               .LEDC_OUT_topdig(LEDC_OUT_topdig),
               .BASE10_TX_DIS(BASE10_TX_DIS),
               .MDIX_O(MDIX),
               .TP_DISC_O(TP_DISC),
               .TXC_O(TXC_O)
               );




//------------------------------------------------------------------------------
endmodule

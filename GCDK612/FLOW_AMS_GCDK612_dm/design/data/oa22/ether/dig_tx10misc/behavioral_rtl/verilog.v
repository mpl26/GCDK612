// Created by ihdl
module dig_tx10misc (
                     //Inputs
                     CLKPLL_IN,
                     TXD,
                     TXEN,
                     MR_ISOLATE_TX,
                     AN_TXEN,
                     AN_PULSE,
                     RESET,
                     clk10_enable,
                     clk10n_enable,
                     txc2_5_enable,
                     txc2_5n_enable,
                     CLK2_5_NO_FF,
                     clk160_enable,
                     clkfast_enable,
                     clkfastd8_enable,
                     clkfastd8_gate,
                     MR_BYPASS10TX_FILTER,
                     MR_JABBER_ENAB,
                     MR_FULL_DUPLEX,
                     MR_REPEATER,
                     MR_100MBS,
                     MR_LINK_TEST_DISB,
                     MR_SQE_ENAB,
                     MR_REPEATER_COL_DISB,
                     MR_DIG_LOOP_BACK_ENAB,
                     MR_COL_TEST,
                     MR_FAST_LINK,
                     MR_FAST_JABBER,
                     MR_POL_REVERSED,
                     POS_LINK_PULSE,
                     NEG_LINK_PULSE,
                     RX10_ACTIVE,
                     RX100_ACTIVE,
                     TX100_ACTIVE,
                     RX10_PRESENT,
                     MR_MII10_LOOP_BACK_DISB,
                     RX10_DATA,
                     RX10_DV,
                     CFG1_I,

                     //Outputs
                     DACDATA,
                     LINE_DRIVER10_ENAB,
                     CRS_GEN,
                     CRS10,
                     COL,
                     RXD10,
                     RXDV10,
                     LINK_DOWN,
                     JABBER_DETECTED,
                     TX10_ACTIVE
                     );

input        CLKPLL_IN;             // system clock either 125MHz/160MHz
input [3:0]  TXD;                   // Transmit Data
input        TXEN;                  // Transmit Enable
input        MR_ISOLATE_TX;         // Don't respond to TXEN
input        AN_TXEN;               // Autoneg Line Driver Enable
input        AN_PULSE;              // Autoneg Link Pulse
input        RESET;                 // System Reset (postive polarity)
input        clk10_enable;          // 10MHz Clock enable
input        clk10n_enable;         // Inverted 10MHz Clock enable
input        txc2_5_enable;         // 2.5 MHz Clock enable
input        txc2_5n_enable;        // Inverted 2.5 MHz Clock enable
input        CLK2_5_NO_FF;          // 2.5 MHz square wave framing CLK2_5
                                    // Not for use clocking flip-flops!
input        clk160_enable;         // 160MHz clock enable
input        clkfast_enable;        // fast clock enable
input        clkfastd8_enable;      // 20 MHz Clk (or autoneg 15.5 MHz)
input        clkfastd8_gate;        // 20 MHz Clk Gate(or autoneg 15.5 MHz)
input        MR_BYPASS10TX_FILTER;  // Bypass 10Base-T TX Filter
input        MR_JABBER_ENAB;        // Enable the jabber function
input        MR_FULL_DUPLEX;        // Full-Duplex operation
input        MR_REPEATER;           // Repeater mode
input        MR_100MBS;             // 100 Mb/s mode
input        MR_LINK_TEST_DISB;     // Disable Link Integrity Test functn
input        MR_SQE_ENAB;           // Enable the SQE Test function
input        MR_REPEATER_COL_DISB;  // Disable collision generation for
                                    // repeater mode
input        MR_FAST_LINK;          // Reduced time between link pulses 
input        MR_FAST_JABBER;        // Reduced jabber time test mode
input        MR_DIG_LOOP_BACK_ENAB; // Enable loop back near slicer
input        MR_COL_TEST;           // Collision test based on reg 0.7
input        POS_LINK_PULSE;        // Positive Link Pulse is present
input        NEG_LINK_PULSE;        // Negative Link Pulse is present
input        MR_POL_REVERSED;       // Polarity has been detected as reversed
input        RX10_ACTIVE;           // 10 Mb/s receive channel is active
input        RX100_ACTIVE;          // 100 Mb/s receive channel is active
input        TX100_ACTIVE;          // 100 Mb/s transmit channel is active
input        RX10_PRESENT;          // 10 MB/s receive signal is present
input        MR_MII10_LOOP_BACK_DISB; // Disable 10Base-T MII Loop back
input [3:0]  RX10_DATA;             // Receive data
input        RX10_DV;               // Receive data is valid
input        CFG1_I;                // CFG1 from Pad

output [4:0] DACDATA;               // Filter output to DAC
output       LINE_DRIVER10_ENAB;    // Enable line driver in 10 Mb/s mode
output       CRS_GEN;               // Carrier sense to rxtx100
output       CRS10;                 // Carrier sense to MII
output       COL;                   // Collision indication to MII
output [3:0] RXD10;                 // MII 10 Mb/s receive data
output       RXDV10;                // MII 10 Mb/s receive data valid
output       LINK_DOWN;             //
output       JABBER_DETECTED;       //
output       TX10_ACTIVE;           //

//
// I/O Type Declarations
//
wire         CLKPLL_IN;
wire  [3:0]  TXD;                   
wire         TXEN;
wire         MR_ISOLATE_TX;
wire         AN_TXEN;
wire         AN_PULSE;
wire         RESET;
wire         clk10_enable;
wire         clk10n_enable;
wire         txc2_5_enable;
wire         txc2_5n_enable;
wire         CLK2_5_NO_FF;
wire         clk160_enable;
wire         clkfast_enable;
wire         clkfastd8_enable;
wire         clkfastd8_gate;
wire         MR_BYPASS10TX_FILTER;
wire         MR_JABBER_ENAB;
wire         MR_FULL_DUPLEX;
wire         MR_REPEATER;
wire         MR_100MBS;
wire         MR_LINK_TEST_DISB;
wire         MR_SQE_ENAB;
wire         MR_REPEATER_COL_DISB;
wire         MR_DIG_LOOP_BACK_ENAB;
wire         MR_COL_TEST;
wire         POS_LINK_PULSE;
wire         NEG_LINK_PULSE;
wire         MR_POL_REVERSED;
wire         RX10_ACTIVE;
wire         RX100_ACTIVE;
wire         TX100_ACTIVE;
wire         RX10_PRESENT;
wire         MR_MII10_LOOP_BACK_DISB;
wire  [3:0]  RX10_DATA;
wire         RX10_DV;
wire         CFG1_I;

wire [4:0]   DACDATA;               
wire         LINE_DRIVER10_ENAB;    
wire         CRS_GEN;               
wire         CRS10;                 
wire         COL;                   
wire [3:0]   RXD10;                 
wire         RXDV10;                
wire         LINK_DOWN;             
wire         JABBER_DETECTED;       
wire         TX10_ACTIVE;           
//
// Internal Signal Declarations
//
wire         ENC_DATA;
wire         FILT_ENAB;
wire         EOF_HOLD;
wire         LINK_GEN_PULSE;
wire         TX10_PRESENT;

//
// Parameter Declarations
//
// None

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
dig_tx10_manch_enc i_dig_tx10_manch_enc (
                         .CLKPLL_IN(CLKPLL_IN),
                         .TXD(TXD),
                         .TXEN(TXEN),
                         .MR_ISOLATE_TX(MR_ISOLATE_TX),
                         .RESET(RESET),
                         .clk10_enable(clk10_enable),
                         .clk10n_enable(clk10n_enable),
                         .txc2_5_enable(txc2_5_enable),
                         .CLK2_5_NO_FF(CLK2_5_NO_FF),
                         .LINK_DOWN(LINK_DOWN),
                         .JABBER_DETECTED(JABBER_DETECTED),
                         .EOF_HOLD(EOF_HOLD),
                         .ENC_DATA(ENC_DATA),
                         .FILT_ENAB(FILT_ENAB),
                         .TX10_ACTIVE(TX10_ACTIVE),
                         .TX10_PRESENT(TX10_PRESENT)
                         );


dig_tx10_filter i_dig_tx10_filter (
                      .ENC_DATA(ENC_DATA),
                      .EOF_HOLD(EOF_HOLD),
                      .TXD_B1_0(TXD[1:0]),
                      .FILT_ENAB(FILT_ENAB),
                      .LINK_DOWN(LINK_DOWN),
                      .LINK_GEN_PULSE(LINK_GEN_PULSE),
                      .AN_PULSE(AN_PULSE),
                      .MR_BYPASS10TX_FILTER(MR_BYPASS10TX_FILTER),
                      .MR_100MBS(MR_100MBS),
                      .CFG1_I(CFG1_I),
                      .CLKPLL_IN(CLKPLL_IN),
                      .clkfast_enable(clkfast_enable),
                      .clkfastd8_gate(clkfastd8_gate),
                      .RESET(RESET),
                      .DACDATA(DACDATA)
                      );

dig_tx10_jabber i_dig_tx10_jabber (
                     .CLKPLL_IN(CLKPLL_IN),
                     .TXEN(TXEN),
                     .MR_ISOLATE_TX(MR_ISOLATE_TX),
                     .MR_JABBER_ENAB(MR_JABBER_ENAB),
                     .MR_FAST_JABBER(MR_FAST_JABBER),
                     .txc2_5_enable(txc2_5_enable),
                     .txc2_5n_enable(txc2_5n_enable),
                     .RESET(RESET),
                     .JABBER_DETECTED(JABBER_DETECTED)
                     );

dig_rxtx_crs_gen i_dig_rxtx_crs_gen (
                       .MR_FULL_DUPLEX(MR_FULL_DUPLEX),
                       .MR_REPEATER(MR_REPEATER),
                       .MR_100MBS(MR_100MBS),
                       .MR_MII10_LOOP_BACK_DISB(MR_MII10_LOOP_BACK_DISB),
                       .RX10_PRESENT(RX10_PRESENT),
                       .RX100_ACTIVE(RX100_ACTIVE),
                       .TX100_ACTIVE(TX100_ACTIVE),
                       .TX10_PRESENT(TX10_PRESENT),
                       .CRS_GEN(CRS_GEN)
                       );

dig_rxtx10_link i_dig_rxtx10_link (
                      .CLKPLL_IN(CLKPLL_IN),
                      .TXEN(TXEN),
                      .MR_ISOLATE_TX(MR_ISOLATE_TX),
                      .AN_TXEN(AN_TXEN),
                      .txc2_5_enable(txc2_5_enable),
                      .clk10n_enable(clk10n_enable),
                      .clkfastd8_enable(clkfastd8_enable),
                      .MR_LINK_TEST_DISB(MR_LINK_TEST_DISB),
                      .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB),
                      .MR_FAST_LINK(MR_FAST_LINK),
                      .RX10_ACTIVE(RX10_ACTIVE),
                      .POS_LINK_PULSE(POS_LINK_PULSE),
                      .NEG_LINK_PULSE(NEG_LINK_PULSE),
                      .MR_POL_REVERSED(MR_POL_REVERSED),
                      .clk160_enable(clk160_enable),
                      .RESET(RESET),
                      .LINE_DRIVER10_ENAB(LINE_DRIVER10_ENAB),
                      .LINK_GEN_PULSE(LINK_GEN_PULSE),
                      .LINK_DOWN(LINK_DOWN)
                      );

dig_rxtx_col i_dig_rxtx_col (
                  .CLKPLL_IN(CLKPLL_IN),
                  .TXEN(TXEN),
                  .MR_ISOLATE_TX(MR_ISOLATE_TX),
                  .txc2_5_enable(txc2_5_enable),
                  .clk10_enable(clk10_enable),
                  .clk10n_enable(clk10n_enable),
                  .MR_100MBS(MR_100MBS),
                  .MR_FULL_DUPLEX(MR_FULL_DUPLEX),
                  .MR_SQE_ENAB(MR_SQE_ENAB),
                  .MR_REPEATER(MR_REPEATER),
                  .MR_REPEATER_COL_DISB(MR_REPEATER_COL_DISB),
                  .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB),
                  .MR_COL_TEST(MR_COL_TEST),
                  .LINK_DOWN(LINK_DOWN),
                  .RX10_ACTIVE(RX10_ACTIVE),
                  .RX10_PRESENT(RX10_PRESENT),
                  .RX100_ACTIVE(RX100_ACTIVE),
                  .TX10_ACTIVE(TX10_ACTIVE),
                  .TX100_ACTIVE(TX100_ACTIVE),
                  .JABBER_DETECTED(JABBER_DETECTED),
                  .RESET(RESET),
                  .COL(COL)
                  );

dig_rxtx10_loopback i_dig_rxtx10_loopback (
                            .CLKPLL_IN(CLKPLL_IN),
                            .MR_MII10_LOOP_BACK_DISB(MR_MII10_LOOP_BACK_DISB),
                            .LINK_DOWN(LINK_DOWN),
                            .MR_FULL_DUPLEX(MR_FULL_DUPLEX),
                            .MR_REPEATER(MR_REPEATER),
                            .MR_ISOLATE_TX(MR_ISOLATE_TX),
                            .TXEN(TXEN),
                            .TXD(TXD),
                            .RX10_DATA(RX10_DATA),
                            .RX10_ACTIVE(RX10_ACTIVE),
                            .RX10_DV(RX10_DV), 
                            .CRS_GEN(CRS_GEN),
                            .JABBER_DETECTED(JABBER_DETECTED),
                            .txc2_5_enable(txc2_5_enable),
                            .txc2_5n_enable(txc2_5n_enable),
                            .RESET(RESET),
                            .RXD10(RXD10),
                            .RXDV10(RXDV10),
                            .CRS10(CRS10)
                            );

endmodule

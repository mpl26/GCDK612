// Created by ihdl
module dig_rxtx100_misc (
                         //Inputs
                         MR_DIG_LOOP_BACK_ENAB,
                         MLT3ENC_DATA,
                         MLT3_DATAIN,
                         FE_FAULT,
                         MR_MII100_LOOP_BACK_ENAB,
                         MR_FULL_DUPLEX,
                         CLKPLL_IN,
                         RESETPLL,
                         txc25_enable,
                         txc25n_enable,
                         TXD,
                         TXEN,
                         TXER,
                         clk125_disb,
                         RXCLK125,
                         RESET_DSP25,
                         RESETRX125,
                         RX100_DATA,
                         RX100_DV,
                         RX100_ER,
                         CRS_GEN,
                         RESETREG,
                         MR_100MBS,
                         MSE_GOOD,
                         L100_LINK_CONTROL,
                         MR_RXTX_TEST,
                         LOCKED2IDLES,

                         //Outputs
                         LPBK_MLT3DATA,
                         RXD100,
                         RXDV100,
                         RXER100,
                         CRS100,
                         L100_LINK_STATUS,
                         LINK100_DOWN,
                         RCLK25_GOOD,
                         RX100_STABLE
                         );

//
// I/O Declarations
//
input          MR_DIG_LOOP_BACK_ENAB;    // Analog Loop-back Enable
input   [1:0]  MLT3ENC_DATA;             // Transmitted Digital Data
input   [1:0]  MLT3_DATAIN;              // Received (Equalizer) Data
input          FE_FAULT;                 // Far -end fault
input          MR_MII100_LOOP_BACK_ENAB; // Loop-back Enable
input          MR_FULL_DUPLEX;           // Full duplex mode
input          CLKPLL_IN;                // System clock 125MHz or 160MHz
input          RESETPLL;                 // System reset 125MHz or 160MHz
input          txc25_enable;             // 25MHz clock enable
input          txc25n_enable;            // Inverted 25MHz clock enable
input   [4:0]  TXD;                      // Tx data
input          TXEN;                     // Tx enable
input          TXER;                     // Tx error
input          clk125_disb;              // 125MHz clock disable
input          RXCLK125;                 // Reference 125 clock for RX path 
input          RESET_DSP25;              //
input          RESETRX125;              //
input   [4:0]  RX100_DATA;               // 100BaseT data
input          RX100_DV;                 // 100BaseT data valid
input          RX100_ER;                 // 100BaseT data error
input          CRS_GEN;                  // Carrie sense
input          RESETREG;                 // Register reset
input          MR_100MBS;                // 100BaseT mode
input          MSE_GOOD;                 // MSE above threshold - good clock
input   [1:0]  L100_LINK_CONTROL;        // 
input          MR_RXTX_TEST;             //
input          LOCKED2IDLES;             // locked to idle

output  [1:0]  LPBK_MLT3DATA;            // Loopback Mux Output
output  [4:0]  RXD100;                   // 100BaseT data
output         RXDV100;                  // 100BaseT data valid
output         RXER100;                  // 100BaseT data error
output         CRS100;                   // 100BaseT carrier sense
output  [1:0]  L100_LINK_STATUS;         // Link status
output         LINK100_DOWN;             // 100 MB/s link is down
output         RCLK25_GOOD;              // Recover 25MHz clk good
output         RX100_STABLE;             // RX path is stable

//
// I/O Type Declarations
//
wire           MR_DIG_LOOP_BACK_ENAB;   
wire    [1:0]  MLT3ENC_DATA;            
wire    [1:0]  MLT3_DATAIN;             
wire           FE_FAULT;                
wire           MR_MII100_LOOP_BACK_ENAB;
wire           MR_FULL_DUPLEX;          
wire           CLKPLL_IN;
wire           txc25_enable;
wire           txc25n_enable;
wire    [4:0]  TXD;                     
wire           TXEN;                    
wire           TXER;                    
wire           RXCLK125;                 
wire    [4:0]  RX100_DATA;              
wire           RX100_DV;                
wire           RX100_ER;                
wire           CRS_GEN;                 
wire           RESETREG;                
wire           MR_100MBS;               
wire           MSE_GOOD;                
wire    [1:0]  L100_LINK_CONTROL;       
wire           MR_RXTX_TEST;            
wire           LOCKED2IDLES;            

wire    [1:0]  LPBK_MLT3DATA;           
wire    [4:0]  RXD100;                  
wire           RXDV100;                 
wire           RXER100;                 
wire           CRS100;                  
wire    [1:0]  L100_LINK_STATUS;        
wire           LINK100_DOWN;            
wire           RCLK25_GOOD;             
wire           RX100_STABLE;            

//
// Internal Signal Declarations
//
// none

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//


//------------------------------------------------------------------------------
// Module Instatiations.
//------------------------------------------------------------------------------
//


dig_rxtx100_dig_loopback i_dig_rxtx100_dig_loopback (
                                 .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB),
                                 .MLT3ENC_DATA(MLT3ENC_DATA), 
                                 .MLT3_DATAIN(MLT3_DATAIN),
                                 .LPBK_MLT3DATA(LPBK_MLT3DATA),
                                 .RXCLK125(RXCLK125),
                                 .RESET(RESETRX125)
                                 );

dig_rxtx100_mii_loopback i_dig_rxtx100_mii_loopback (
                            .MR_MII100_LOOP_BACK_ENAB(MR_MII100_LOOP_BACK_ENAB),
                            .MR_FULL_DUPLEX(MR_FULL_DUPLEX),
                            .CLKPLL_IN(CLKPLL_IN),
                            .txc25_enable(txc25_enable),
                            .txc25n_enable(txc25n_enable),
                            .TXD(TXD),
                            .TXEN(TXEN), 
                            .TXER(TXER),
                            .RX100_DATA(RX100_DATA),
                            .RX100_DV(RX100_DV),
                            .RX100_ER(RX100_ER),
                            .CRS_GEN(CRS_GEN),
                            .RXD100(RXD100),
                            .RXDV100(RXDV100), 
                            .RXER100(RXER100),
                            .CRS100(CRS100),
                            .RESET(RESETPLL)
                            );

dig_rxtx100_linkmonitor i_dig_rxtx100_linkmonitor ( 
                            .CLKPLL_IN(CLKPLL_IN),
                            .txc25_enable(txc25_enable),
                            .RESET(RESETPLL),
                            .RESET_DSP25(RESET_DSP25),
                            .MR_100MBS(MR_100MBS),
                            .MSE_GOOD(MSE_GOOD), 
                            .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB), 
                            .MR_MII100_LOOP_BACK_ENAB(MR_MII100_LOOP_BACK_ENAB),
                            .MR_RXTX_TEST(MR_RXTX_TEST), 
                            .LOCKED2IDLES(LOCKED2IDLES),
                            .L100_LINK_CONTROL(L100_LINK_CONTROL), 
                            .L100_LINK_STATUS(L100_LINK_STATUS),
                            .LINK100_DOWN(LINK100_DOWN), 
                            .RCLK25_GOOD(RCLK25_GOOD),
                            .RX100_STABLE(RX100_STABLE),
                            .FE_FAULT(FE_FAULT)
                            );


//------------------------------------------------------------------------------
endmodule

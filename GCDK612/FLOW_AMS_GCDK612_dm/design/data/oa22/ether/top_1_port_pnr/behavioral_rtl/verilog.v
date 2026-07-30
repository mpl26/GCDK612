//------------------------------------------------------------------------------
// filename: /projects/Bonphyer/work/jfmellon/asic/modules/
//            top_level/rtl/top_1_port_pnr.v
// $Id: top_1_port_pnr.v,v 1.1.1.1 2003/02/21 11:50:15 jfmellon Exp $
//
//------------------------------------------------------------------------------
//
// +---------------+    Copyright 2001
// | Tality UK     |    Tality UK Ltd.
// +---------------+    All Rights Reserved.
//
// Primary Unit Name   : top_1_port_pnr.v
//
//
// Description         : The file contains the top level of the DSP and the PCS
//                       code hierarchies.
//
// Original Author     : unknown
// Modified            : jfmellon
//
// Date                : Fri Nov  9 15:45:05 GMT 2001
//
//
//------------------------------------------------------------------------------
//
// Revision Control
// 
// $Log: top_1_port_pnr.v,v $
// Revision 1.1.1.1  2003/02/21 11:50:15  jfmellon
// Initial release taken from shawnee rev_5_0
//
// Revision 1.1.1.1  2003/01/07 12:28:12  jfmellon
// Initial release taken from Bonphyer rev_2_13
//
// Revision 1.3  2002/05/14 14:11:40  davlee
// Removed fiber-mode and SM_READ signals
//
// Revision 1.2  2002/05/13 09:21:02  davlee
// Added spare_cells instantiation (gives 40 spare-cell blocks).
//
// Revision 1.1  2002/05/13 08:59:34  plesso
// moved to appropriate location
//
// Revision 1.14  2002/05/10 15:50:04  davlee
// Removed old ATLAS "SCAN_*" signals.
//
// Revision 1.13  2002/05/07 12:36:07  davlee
// Removed SCAN_OUT signals and associated dig_test.v Test Mode (4'b1xxx).
//
// Revision 1.12  2002/04/29 13:38:54  hhendry
// Removed RESETREG_RX125 and added RESETREG into DSP.
//
// Revision 1.11  2002/04/04 16:46:32  hhendry
// Added RESETREG_RXCLK125
//
// Revision 1.10  2002/04/04 09:13:22  plesso
// updates for synthesis
//
// Revision 1.9  2002/03/01 16:20:24  hhendry
// Added new dig_reset.v block with new system resets.
//
// Revision 1.8  2002/02/19 14:15:41  davlee
// Mods for Mux/Debug system (LEDx_O changed to LEDx_OUT).
//
// Revision 1.7  2002/01/15 16:01:25  hhendry
// Removed SIDDQ signals
//
// Revision 1.6  2002/01/14 15:13:08  hhendry
// Removed top_with_io_dig and top_1_port_digital_dig_only from hierarchy
//
// Revision 1.5  2002/01/08 10:51:05  hhendry
// Changed instance names to i_"module_name" for better readability
//
// Revision 1.4  2001/12/12 09:06:52  plesso
// changed DSP scan pins to match module
//
// Revision 1.3  2001/12/11 11:16:03  hhendry
// Commented out SCANIN/OUT signals from dsp instantiation
//
// Revision 1.2  2001/11/21 15:04:23  jfmellon
// Modified design structure to make this readable including ensuring
// modules passed named signals
//
// 2005-10-03: RayV added VDD and VSS port due to AMS parasitic sim requirement.
// 2005-10-05: RayV added "//cadence translated_<off/on>" for avoid warning in synthesis tools.
//------------------------------------------------------------------------------
`timescale 1ns / 1ps 

// top_1_port_pnr
module top_1_port_pnr ( 
                   // Inputs
                   ANDIS, CLKPLL_IN, MDC, MDIO_IN, NEG_DETECT,
                   POS_DETECT, RCLK125, RESETN, 
                   SLICER_OUT, TXEN, TXER, XTAL25, X_125, X_160, TX_SLP_TRIM,
                   TXD, FLASH, ADC, PHY, TX_AMP_TRIM, 
                   SCAN_ENABLE,SCAN_MODE,
                   //cadence translate_off
		   VDD,VSS,
		   //cadence translate_on
		   // 
                   //Outputs
                   AEQ_BYPASS, BASE10_DIS, BASE10_TX_DIS, BASE100TX_DIS,
                   BASEFX_DIS, CLKPLL_SC, COL, CRS, 
                   LEDC, LEDD, LEDL, LEDR, LEDS, LEDT, MDINT, MDIO_OE,
                   MDIO_OUT, MDIX, MR_BYPASS10RX_FILTER, MR_SQUELCH_DISB, 
                   RESET, RESET_DSP, RX10_PRESENT, RXC, RXDV, RXER, SYMBOL_MODE,
                   T2_MODE, TENBT_CLK160, TIMING_DN_ANLG, TIMING_UP_ANLG, 
                   TP_DISC, TRISTATE, TXC, ANLG_TST, TX_AMPTRIM, TX_SLOPETRIM,
                   WANDER_CNT_ANLG, TENBT_FILTER, MR_SQUELCH_RANGE, AEQ_CNT_ANLG,
                   MLT3_TDATA, TEST_MODE, RXD,
                   );
//
// I/O Declarations
//
//cadence translate_off
input         VDD;
input         VSS;
//cadence translate_on
input         ANDIS;                // Auto-Negotiation disable
input         CLKPLL_IN;            // 
input         MDC;                  // Management data clock
input         MDIO_IN;              // Management data input
input         NEG_DETECT;           // 
input         POS_DETECT;           // 
input         RCLK125;              // Rx Synchronised 125MHz clock
input         RESETN;               // Master reset
input         SLICER_OUT;           // 
input         TXEN;                 // Transmit data enable
input         TXER;                 // Transmit error
input         XTAL25;               // 25MHz crystal clock
input         X_125;                // Clock 125MHz
input         X_160;                // Clock 160MHz
input [1:0]   TX_SLP_TRIM;          // Transmit slope trim
input [4:0]   TXD;                  // MII Transmit data
input [2:0]   FLASH;                // 
input [5:0]   ADC;                  // ADC data
input [4:0]   PHY;                  // PHY address
input [1:0]   TX_AMP_TRIM;          // Transmit amplitude trim

input   SCAN_ENABLE;
input   SCAN_MODE;

output        AEQ_BYPASS;           // Analog equaliser bypass
output        BASE10_DIS;           // 10BaseT disable
output        BASE10_TX_DIS;        // 10BaseT Transmit disable
output        BASE100TX_DIS;        // 100BaseT Transmit disable
output        BASEFX_DIS;           // Fiber disable
output        CLKPLL_SC;            // 
output        COL;                  // Collision detection
output        CRS;                  // Carrier sense
output        LEDC;                 // Collision LED active low
output        LEDD;                 // Full Duplex LED active low
output        LEDL;                 // Link active LED active low
output        LEDR;                 // Receive LED active low
output        LEDS;                 // Speed LED active low 100Mbps
output        LEDT;                 // Transmit LED active low
output        MDINT;                // Management interface interrupt 
output        MDIO_OE;              // Management data output enable
output        MDIO_OUT;             // Management data output
output        MDIX;                 // 
output        MR_BYPASS10RX_FILTER; //
output        MR_SQUELCH_DISB;      //  
output        RESET;                // Reset25
output        RESET_DSP;            // Reset DSP
output        RX10_PRESENT;         // 10Base-T receiving data
output        RXC;                  // Receive clock
output        RXDV;                 // Recieve data valid
output        RXER;                 // Recieve data error
output        SYMBOL_MODE;          // Indicates 4B/5B disabled
output        T2_MODE;              // 
output        TENBT_CLK160;         // 
output        TIMING_DN_ANLG;       //  
output        TIMING_UP_ANLG;       //  
output        TP_DISC;              // 
output        TRISTATE;             // Isolate from MII
output        TXC;                  // Transmit data clock
output        ANLG_TST;             // 
output [1:0]  TX_AMPTRIM;           //
output [1:0]  TX_SLOPETRIM;         //
output [6:0]  WANDER_CNT_ANLG;      //
output [4:0]  TENBT_FILTER;         //
output [1:0]  MR_SQUELCH_RANGE;     // 
output [4:0]  AEQ_CNT_ANLG;         //
output [1:0]  MLT3_TDATA;           //
output [2:0]  TEST_MODE;            //
output [4:0]  RXD;                  // MII receive data

//
// I/O Type Declarations
//
wire          ANDIS;                
wire          CLKPLL_IN;            
wire          MDC;                  
wire          MDIO_IN;              
wire          NEG_DETECT;           
wire          POS_DETECT;           
wire          RCLK125;              
wire          RESETN;               
wire          SLICER_OUT;           
wire          TXEN;                 
wire          TXER;                 
wire          XTAL25;               
wire          X_125;                
wire          X_160;                
wire [1:0]    TX_SLP_TRIM;
wire [4:0]    TXD;    
wire [2:0]    FLASH;
wire [5:0]    ADC;
wire [4:0]    PHY;
wire [1:0]    TX_AMP_TRIM;

wire          AEQ_BYPASS;           
wire          BASE10_DIS;           
wire          BASE10_TX_DIS;        
wire          BASE100TX_DIS;        
wire          BASEFX_DIS;           
wire          CLKPLL_SC;            
wire          COL;                  
wire          CRS;                  
wire          LEDC;                 
wire          LEDD;                 
wire          LEDL;                 
wire          LEDR;                 
wire          LEDS;                 
wire          LEDT;                 
wire          MDINT;                
wire          MDIO_OE;              
wire          MDIO_OUT;             
wire          MDIX;                 
wire          MR_BYPASS10RX_FILTER; 
wire          MR_SQUELCH_DISB;      
wire          RESET;                
wire          RESET_DSP;            
wire          RX10_PRESENT;         
wire          RXC;                  
wire          RXDV;                 
wire          RXER;                 
wire          SYMBOL_MODE;          
wire          T2_MODE;              
wire          TENBT_CLK160;         
wire          TIMING_DN_ANLG;       
wire          TIMING_UP_ANLG;       
wire          TP_DISC;              
wire          TRISTATE;             
wire          TXC;                  
wire          ANLG_TST;             
wire [1:0]    TX_AMPTRIM;
wire [1:0]    TX_SLOPETRIM;
wire [6:0]    WANDER_CNT_ANLG;
wire [4:0]    TENBT_FILTER;
wire [1:0]    MR_SQUELCH_RANGE;
wire [4:0]    AEQ_CNT_ANLG;
wire [1:0]    MLT3_TDATA;
wire [2:0]    TEST_MODE;
wire [4:0]    RXD;

wire          MSE_GOOD;

//
// Internal Signal Declarations
//
wire  [4:0]   AEQ_CNT_DSP;
wire  [1:0]   MLT;
wire  [2:0]   SM_ADDRESS;
wire  [15:0]  SM_DATA_WRITE;
wire  [6:0]   WANDER_CNT_DSP;
wire  [15:0]  SM_DATA_READ;
//

wire   SCAN_ENABLE;
wire   SCAN_MODE;
//
// Parameter Declarations
//
// None

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
// This module contains submodules for the PCS and DSP, plus spare-cell blocks 
// (for metal-fix, if required).


top_digital i_top_digital (
                   .RCLK125(RCLK125),
                   .X_125(X_125),
                   .X_160(X_160),
                   .CLKXTAL(XTAL25),
                   .CLKPLL_IN(CLKPLL_IN),
                   
                   .SLICER_OUT(SLICER_OUT),
                   .POS_DETECT(POS_DETECT),
                   .NEG_DETECT(NEG_DETECT),
                   
                   .ADC_OUT(ADC),
                   .ADC_FLASH(FLASH),
                   .AEQ_CNT_DSP(AEQ_CNT_DSP),
                   .WANDER_CNT_DSP(WANDER_CNT_DSP),
                   .TIMING_UP_DSP(TIMING_UP_DSP),
                   .TIMING_DN_DSP(TIMING_DN_DSP),
                   
                   .MSE_GOOD(MSE_GOOD),
                   .MLT3_DATAIN(MLT),
                   .SM_DATA_READ(SM_DATA_READ),
                   .SIGNAL_DETECT(SIGDET),
                   
                   .PHY(PHY),
                   .ANDIS_I(ANDIS),
                   .RESETN(RESETN),
                   .MDC_I(MDC),
                   .TXER_I(TXER),
                   .TXEN_I(TXEN),
                   .TXD(TXD),
                   .TX_SLP_TRIM(TX_SLP_TRIM),
                   .TX_AMP_TRIM(TX_AMP_TRIM),
                   
                   .MDIO_IN(MDIO_IN),
                   
                   .MDIO_OUT(MDIO_OUT),
                   .MDIO_OE(MDIO_OE),
                   
                   .BASEFX_DIS(BASEFX_DIS),
                   .RESET_DSP(RESET_DSP),
                   .BASE10_DIS(BASE10_DIS),
                   .BASE100TX_DIS(BASE100TX_DIS),
                   
                   .RESET25(RESET),
                   
                   .MDIX(MDIX),
                   
                   .RESETREG(RESETREG),
                   .SM_ADDRESS(SM_ADDRESS),
                   .SM_DATA_WRITE(SM_DATA_WRITE),
                   .SM_WRITE(SM_WRITE),
                   .WANDER_CNT_ANLG(WANDER_CNT_ANLG),
                   .AEQ_BYPASS(AEQ_BYPASS),
                   .AEQ_CNT_ANLG(AEQ_CNT_ANLG),
                   .TIMING_UP_ANLG(TIMING_UP_ANLG),
                   .TIMING_DN_ANLG(TIMING_DN_ANLG),
                   .MLT3_TDATA(MLT3_TDATA),
                   .TX_AMPTRIM(TX_AMPTRIM),
                   .TX_SLOPETRIM(TX_SLOPETRIM),
                   .RX10_PRESENT(RX10_PRESENT),
                   .MR_SQUELCH_DISB(MR_SQUELCH_DISB),
                   .MR_SQUELCH_RANGE(MR_SQUELCH_RANGE),
                   .MR_BYPASS10RX_FILTER(MR_BYPASS10RX_FILTER),
                   .TENBT_CLK160(TENBT_CLK160),
                   .TENBT_FILTER(TENBT_FILTER),
                   .TP_DISC(TP_DISC),
                   .BASE10_TX_DIS(BASE10_TX_DIS),
                   .TEST_MODE(TEST_MODE),
                   .CRS_O(CRS),
                   .LEDS_OUT(LEDS),
                   .LEDT_VREF_OUT(LEDT),
                   .LEDL_OUT(LEDL),
                   .LEDC_OUT(LEDC),
                   .LEDR_LEDA_OUT(LEDR),
                   .LEDD_OUT(LEDD),
                   .RXD_O(RXD),
                   .RXDV_O(RXDV),
                   .RXC_O(RXC),
                   .RXER_O(RXER),
                   .TXC_O(TXC),
                   .COL_O(COL),
                   .FULL_DUPLEX(net158),
                   .MDINT(MDINT),
                   .TRISTATE(TRISTATE),
                   .ENC_BYPASS(SYMBOL_MODE),
                   .CLKPLL_SC(CLKPLL_SC),
                   .ANLG_TST(ANLG_TST)
                   );


dsp_top i_dsp_top (
                   .ADC(ADC), 
                   .ADC_TIMING(FLASH),
                   .BASEFX_DIS(BASEFX_DIS),
                   .CLK125(RCLK125),
                   .CLKXTAL(XTAL25),                   
                   .RESET_DSP(RESET_DSP),
                   .RESET_SM(RESETREG),
                   .SM_ADDRESS(SM_ADDRESS),
                   .SM_DATA_WRITE(SM_DATA_WRITE),
                   .SM_WRITE(SM_WRITE), 
                   .AEQ_CNT(AEQ_CNT_DSP), 
                   .MSE_GOOD(MSE_GOOD), 
                   .SIGDET(SIGDET), 
                   .SLICE_OUT(MLT),
                   .SM_DATA_READ(SM_DATA_READ), 
                   .TIMING_DN(TIMING_DN_DSP), 
                   .TIMING_MODE(T2_MODE), 
                   .TIMING_UP(TIMING_UP_DSP), 
                   .WANDER_CNT(WANDER_CNT_DSP)
                   );




endmodule

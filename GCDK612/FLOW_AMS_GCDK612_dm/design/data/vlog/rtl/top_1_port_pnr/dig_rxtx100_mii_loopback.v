// Created by ihdl
module dig_rxtx100_mii_loopback (
                                 //Inputs
                                 MR_MII100_LOOP_BACK_ENAB,
                                 MR_FULL_DUPLEX,
                                 CLKPLL_IN,
                                 txc25_enable,
                                 txc25n_enable,
                                 TXD,
                                 TXEN,
                                 TXER,
                                 RX100_DATA,
                                 RX100_DV,
                                 RX100_ER,
                                 CRS_GEN,
                                 RESET,

                                 //Outputs
                                 RXD100,
                                 RXDV100,
                                 RXER100,
                                 CRS100,
                                 );

//
// I/O Declarations
//
input          MR_MII100_LOOP_BACK_ENAB; // Disable 10BT MII Loop back
input          MR_FULL_DUPLEX;           // Full Duplex mode
input          CLKPLL_IN;                // System clock 125MHz or 160MHz
input          txc25_enable;             // 25MHz clock enable
input          txc25n_enable;            // Inverted 25MHz clock enable
input   [4:0]  TXD;                      // Transmit Data
input          TXEN;                     // Transmit Enable
input          TXER;                     // Transmit Error
input   [4:0]  RX100_DATA;               // Receive data
input          RX100_DV;                 // Receive data valid
input          RX100_ER;                 // Receive Error
input          CRS_GEN;                  // Generated carrier sense
input          RESET;                    // Use synched RESETREG

output  [4:0]  RXD100;                   // MII 100 Mb/s receive data
output         RXDV100;                  // MII 100 Mb/s receive data valid
output         RXER100;                  // MII 100 Mb/s receive error
output         CRS100;                   // MII 100 Mb/s carrier sense

//
// I/O Type Declarations
//
wire           MR_MII100_LOOP_BACK_ENAB;
wire           MR_FULL_DUPLEX;          
wire           CLKPLL_IN;
wire           txc25_enable;
wire           txc25n_enable;
wire    [4:0]  TXD;                     
wire           TXEN;                    
wire           TXER;                    
wire    [4:0]  RX100_DATA;              
wire           RX100_DV;                
wire           RX100_ER;                
wire           CRS_GEN;                 
wire           RESET;                   

reg     [4:0]  RXD100;                  
reg            RXDV100;                 
reg            RXER100;                 
reg            CRS100;                  

//
// Internal Signal Declarations
//
reg     [4:0]  plpbkD;                 // Loop-back Data
reg     [4:0]  lpbkD;                  // Loop-back Data
reg            plpbkDV;                // Loop-back Data Valid
reg            lpbkDV;                 // Loop-back Data Valid
reg            plpbkER;                // Loop-back Error
reg            lpbkER;                 // Loop-back Error

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//


//------------------------------------------------------------------------------
// These processes will register the Loop-Back Data by synchronising the input
// data with the posedge to the TXC25 then aligning this to the negative edge
// before passing the data out of the mux.
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_lpbk
      if (RESET)
         begin
         plpbkD  <= 5'b0;
         plpbkDV <= 1'b0;
         plpbkER <= 1'b0;
         end
      else if (txc25_enable & (!MR_MII100_LOOP_BACK_ENAB))
         begin
         plpbkD  <= 5'b0;
         plpbkDV <= 1'b0;
         plpbkER <= 1'b0;
         end
      else if (txc25_enable)
         begin
         plpbkD  <= TXD;
         plpbkDV <= TXEN;
         plpbkER <= TXER;
         end
      else
         begin
         plpbkD  <= plpbkD;
         plpbkDV <= plpbkDV;
         plpbkER <= plpbkER;
         end
      end // p_lpbk

   always @(negedge CLKPLL_IN or posedge RESET )
      begin : p_lpbk_n
      if (RESET)
         begin
         lpbkD  <= 5'b0;
         lpbkDV <= 1'b0;
         lpbkER <= 1'b0;
         end
       else if (txc25n_enable)
         begin
         lpbkD  <= plpbkD;
         lpbkDV <= plpbkDV;
         lpbkER <= plpbkER;
         end
       else
         begin
         lpbkD  <= lpbkD;
         lpbkDV <= lpbkDV;
         lpbkER <= lpbkER;
         end
      end // p_lpbk_n

//------------------------------------------------------------------------------
// This process is the loop-back output mux.
//------------------------------------------------------------------------------
//
   always @ (MR_MII100_LOOP_BACK_ENAB or MR_FULL_DUPLEX or RX100_DATA or
             RX100_DV or RX100_ER or CRS_GEN or lpbkD or lpbkDV or lpbkER or
             TXEN)
      begin : p_lpbk_mux
      if (!MR_MII100_LOOP_BACK_ENAB)
         begin
         RXD100  = RX100_DATA;
         RXDV100 = RX100_DV;
         RXER100 = RX100_ER;
         CRS100  = CRS_GEN;
         end
      else
         begin
         RXD100  = lpbkD;
         RXDV100 = lpbkDV;
         RXER100 = lpbkER;
         if (!MR_FULL_DUPLEX)
            CRS100  = TXEN;
         else
            CRS100  = lpbkDV;
         end
      end // p_lpbk_mux

endmodule

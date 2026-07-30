// Created by ihdl
module dig_rxtx10_loopback (
                            //Inputs
                            CLKPLL_IN,
                            MR_MII10_LOOP_BACK_DISB,
                            LINK_DOWN,
                            MR_FULL_DUPLEX,
                            MR_REPEATER,
                            MR_ISOLATE_TX,
                            TXEN,
                            TXD,
                            RX10_DATA,
                            RX10_ACTIVE,
                            RX10_DV,
                            CRS_GEN,
                            JABBER_DETECTED,
                            txc2_5_enable,
                            txc2_5n_enable,
                            RESET,

                            //Outputs
                            RXD10,
                            RXDV10,
                            CRS10
                            );

//
// I/O Declarations
//
input          CLKPLL_IN;               // system clock either 125MHz/160MHz
input          MR_MII10_LOOP_BACK_DISB; // Disable 10BT MII Loop back
input          LINK_DOWN;               // 10BT Link is down
input          MR_FULL_DUPLEX;          // Full Duplex mode
input          MR_REPEATER;             // Repeater Mode
input          MR_ISOLATE_TX;           // Don't respond to TXEN
input          TXEN;                    // Transmit Enable
input   [3:0]  TXD;                     // Transmit Data
input   [3:0]  RX10_DATA;               // Receive data
input          RX10_ACTIVE;             // Receive activity is present
input          RX10_DV;                 // Receive data is valid
input          CRS_GEN;                 // Generated carrier sense
input          JABBER_DETECTED;         // Jabber condition detected
input          txc2_5_enable;           // 2.5 MHz Clock enable
input          txc2_5n_enable;          // Inverted 2.5 MHz Clock enable
input          RESET;                   // System Reset

output  [3:0]  RXD10;                   // MII 10 Mb/s receive data
output         RXDV10;                  // MII 10 Mb/s receive data valid
output         CRS10;                   // MII 10 Mb/s carrier sense

//
// I/O Type Declarations
//
wire           CLKPLL_IN;
wire           MR_MII10_LOOP_BACK_DISB;
wire           LINK_DOWN;             
wire           MR_FULL_DUPLEX;        
wire           MR_REPEATER;           
wire           MR_ISOLATE_TX;         
wire           TXEN;                  
wire    [3:0]  TXD;                   
wire    [3:0]  RX10_DATA;             
wire           RX10_ACTIVE;           
wire           RX10_DV;               
wire           CRS_GEN;               
wire           JABBER_DETECTED;       
wire           txc2_5_enable;
wire           txc2_5n_enable;
wire           RESET;                 

reg     [3:0]  RXD10;                 
reg            RXDV10;                
reg            CRS10;                 

//
// Internal Signal Declarations
//
reg     [3:0]  prev_txd;
reg     [3:0]  prev_odd_txd;
reg            prev_txen;
reg            prev_odd_txen;
wire           select_tx;
wire           int_txen;

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign int_txen= TXEN & !MR_ISOLATE_TX;
   assign select_tx = !MR_FULL_DUPLEX & !MR_MII10_LOOP_BACK_DISB &
                      !(RX10_ACTIVE | RX10_DV) & 
                      !LINK_DOWN & !MR_REPEATER & !JABBER_DETECTED;

//------------------------------------------------------------------------------
// These processes register the TXD/TXEN signals using the positive TXC2_5 and
// then register the values using the negative edge to output the data
// appropriately through the mux
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_prev
      if (RESET)
         begin
         prev_txd  <= 4'd0;
         prev_txen <= 1'b0;
         end
      else if (txc2_5_enable)
         begin
         prev_txd  <= TXD;
         prev_txen <= int_txen;
         end
      else
         begin
         prev_txd  <= prev_txd;
         prev_txen <= prev_txen;
         end
      end // p_prev

   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_prev_odd
      if (RESET)
         begin
         prev_odd_txd  <= 4'b0;
         prev_odd_txen <= 1'b0;
         end
      else if (txc2_5n_enable)
         begin
         prev_odd_txd  <= prev_txd;
         prev_odd_txen <= prev_txen;
         end
      else
         begin
         prev_odd_txd  <= prev_odd_txd;
         prev_odd_txen <= prev_odd_txen;
         end
    end // p_prev_odd

//------------------------------------------------------------------------------
// Output Mux to select the loopback data
//------------------------------------------------------------------------------
//
   always @ (select_tx or prev_odd_txd or prev_odd_txen or prev_odd_txen or
             RX10_DATA or RX10_DV or CRS_GEN)
      begin : p_select_tx
      if (select_tx)
         begin
         RXD10  = prev_odd_txd;
         RXDV10 = prev_odd_txen;
         CRS10  = prev_odd_txen;
         end
      else
         begin
         RXD10  = RX10_DATA;
         RXDV10 = RX10_DV;
         CRS10  = CRS_GEN;
         end
      end // p_select_tx

endmodule

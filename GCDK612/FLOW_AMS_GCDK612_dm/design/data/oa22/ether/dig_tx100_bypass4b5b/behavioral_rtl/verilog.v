// Created by ihdl
module dig_tx100_bypass4b5b (
                             //Inputs
                             TXD,
                             TXEN,
                             CLKPLL_IN,
                             txc25_enable,
                             ENC4B5B_DATA, 
                             MR_SYMBOL_MODE,
                             RESET,
                             //Outputs
                             TX100_ACTIVE_SYMBOL, 
                             BYPASS4B5B_DATA
                             );

//
// I/O Declarations
//
input   [4:0]  TXD;                  // 5-bit Parallel Data from MII
input          TXEN;                 // Transmit Enable from MII
input          CLKPLL_IN;            // System clock 125MHz or 160MHz
input          txc25_enable;         // 25MHz clock enable
input   [4:0]  ENC4B5B_DATA;         // 5-bit Parallel Data from encoder
input          MR_SYMBOL_MODE;       // Symbol Mode Indicator
input          RESET;                // System reset

output         TX100_ACTIVE_SYMBOL;  // Transmit Enable for Symbol Mode
output  [4:0]  BYPASS4B5B_DATA;      // Output Data
//
// I/O Type Declarations
//
wire    [4:0]  TXD;           
wire           TXEN;          
wire           CLKPLL_IN;
wire           txc25_enable;
wire    [4:0]  ENC4B5B_DATA;  
wire           MR_SYMBOL_MODE;
wire           RESET;
         
reg            TX100_ACTIVE_SYMBOL;
reg     [4:0]  BYPASS4B5B_DATA;

//
// Internal Signal Declarations
//
reg     [4:0]  TXD_latch;            // Latch Data for Symbol Mode
reg     [4:0]  encoder_latch;        // Encoder latch to meet min latency

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

//------------------------------------------------------------------------------
// This process is used for bypassing the encoded data so that when the symbol
// mode is active then the data passed is straight from the TXD stream
//------------------------------------------------------------------------------
//
   always @ (MR_SYMBOL_MODE or TXD_latch or encoder_latch) 
      begin : p_BYPASS4B5B_DATA
      if (MR_SYMBOL_MODE)
         BYPASS4B5B_DATA = TXD_latch;
      else
         BYPASS4B5B_DATA = encoder_latch;
      end // p_BYPASS4B5B_DATA

//------------------------------------------------------------------------------
// This process is used to synchronise the TXD with the 25MHz data stream. This
// is done by using the system clock then when enabled every 25MHz the encoded
// data is registered. 
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_TX100_ACTIVE_SYMBOL
      if (RESET)
         begin
         encoder_latch       <= 5'b11111;
         TX100_ACTIVE_SYMBOL <= 1'b0;
         TXD_latch           <= 5'b11111;
         end
     else if (txc25_enable)
         begin
         encoder_latch       <= ENC4B5B_DATA;
         TX100_ACTIVE_SYMBOL <= MR_SYMBOL_MODE & TXEN;
         if (TXEN)
            TXD_latch  <= TXD;
         else
            TXD_latch  <= 5'b11111;
         end
      else
         begin
         encoder_latch       <= encoder_latch;
         TX100_ACTIVE_SYMBOL <= TX100_ACTIVE_SYMBOL;
         TXD_latch           <= TXD_latch;
         end
      end // p_TX100_ACTIVE_SYMBOL

endmodule

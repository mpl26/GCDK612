// Created by ihdl
module dig_rx100_bypass_dec4b5b (
                                 //Inputs
                                 DES100_DATA,
                                 DES100_DV,
                                 DES100_ER,
                                 DEC4B5B_DATA,
                                 DEC4B5B_DV,
                                 DEC4B5B_ER,
                                 MR_SYMBOL_MODE,
                                 RESET,
                                 rclk25_pos_neg_en,
                                 RXCLK125,
 
                                 //Outputs
                                 RX100_DATA,
                                 RX100_DV,
                                 RX100_ER
                                 );

//
// I/O Declarations
//
input  [3:0]  DEC4B5B_DATA;      // 4-bit Parallel Data from DEC4b5b
input         DEC4B5B_DV;        // Data Valid Indicator
input         DEC4B5B_ER;        // Error Indicator
input  [4:0]  DES100_DATA;       // 5-bit Parallel Data from deserializer
input         DES100_DV;         // Data Valid Indicator
input         DES100_ER;         // Error Indicator
input         MR_SYMBOL_MODE;    // Symbol Mode Indicator
input         RESET;             // System Reset
input         rclk25_pos_neg_en; // clock enable for RXCLK125 
input         RXCLK125;
 
output [4:0]  RX100_DATA;       // Output Data
output        RX100_DV;         // Data Valid
output        RX100_ER;         // Receive error

//
// I/O Type Declarations
//
wire   [3:0]  DEC4B5B_DATA;  
wire          DEC4B5B_DV;    
wire          DEC4B5B_ER;    
wire   [4:0]  DES100_DATA;   
wire          DES100_DV;     
wire          DES100_ER;     
wire          MR_SYMBOL_MODE;
wire          RESET;
wire          rclk25_pos_neg_en;
wire          RXCLK125;

wire   [4:0]  RX100_DATA;
wire          RX100_DV;
wire          RX100_ER;

//
// Internal Signal Declarations
//
reg    [4:0]  SYMBOL_DATA;    // Delay Added for Repeater mode
reg           SYMBOL_DV;     // Delay Added for Repeater mode
reg           SYMBOL_ER;

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign RX100_DATA  = (!MR_SYMBOL_MODE) ? {1'b0,DEC4B5B_DATA} : SYMBOL_DATA;
   assign RX100_DV    = (!MR_SYMBOL_MODE) ? DEC4B5B_DV : SYMBOL_DV;
   assign RX100_ER    = (!MR_SYMBOL_MODE) ? DEC4B5B_ER : SYMBOL_ER;

//------------------------------------------------------------------------------
// This process registers the data from the deserialiser
//------------------------------------------------------------------------------
//
   always @(negedge RXCLK125 or posedge RESET)
      begin : p_symbol
      if (RESET)
         begin
         SYMBOL_DATA <= 5'b0;
         SYMBOL_DV   <= 1'b0;
         SYMBOL_ER   <= 1'b0;
         end
      else if (~MR_SYMBOL_MODE & rclk25_pos_neg_en)
         begin
         SYMBOL_DATA <= 5'b0;
         SYMBOL_DV   <= 1'b0;
         SYMBOL_ER   <= 1'b0;
         end
      else if (rclk25_pos_neg_en)
         begin
         SYMBOL_DATA <= DES100_DATA;
         SYMBOL_DV   <= DES100_DV;
         SYMBOL_ER   <= DES100_ER;
         end
      else
         begin
         SYMBOL_DATA <= SYMBOL_DATA;
         SYMBOL_DV   <= SYMBOL_DV;
         SYMBOL_ER   <= SYMBOL_ER;
         end
      end // p_symbol

endmodule

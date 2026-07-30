// Created by ihdl
module dig_rx100_dec4b5b (
                          //Inputs
                          DES100_DATA,
                          DES100_DV,
                          DES100_ER,
                          DES100_BADSSD,
                          MR_SYMBOL_MODE,
                          RX100_STABLE,
                          RESET,
                          LINK100_DOWN,
                          DATA_RECEIVE,
                          rclk25_pos_pos_en,
                          RXCLK125,

                          //Outputs
                          DEC4B5B_DATA,
                          DEC4B5B_DV,
                          DEC4B5B_ER
                          );

//
// I/O Declarations
//
input  [4:0]  DES100_DATA;       // Receive Parallel Data
input         DES100_DV;         // Deserializer Enable Signal
input         DES100_ER;         // Deserializer Error Signal
input         DES100_BADSSD;     // Deserializer BadSSD Error Signal
input         MR_SYMBOL_MODE;    // Symbol Mode Indicator
input         RX100_STABLE;      // Receive channel is stable
input         RESET;             // System reset
input         LINK100_DOWN;      // Link 100 status
input         DATA_RECEIVE;      // Indicated data part of frame
input         RXCLK125;          // 125MHz Parallel Data Clock
input         rclk25_pos_pos_en; // Clock enable

output [3:0]  DEC4B5B_DATA;      // Data Values
output        DEC4B5B_DV;        // Data Valid
output        DEC4B5B_ER;        // Error Signal

//
// I/O Type Declarations
//
wire   [4:0]  DES100_DATA;   
wire          DES100_DV;     
wire          DES100_ER;
wire          DES100_BADSSD;
wire          MR_SYMBOL_MODE;
wire          RX100_STABLE;
wire          RESET;
wire          DATA_RECEIVE;
wire          RXCLK125;
wire          rclk25_pos_pos_en;

reg    [3:0]  DEC4B5B_DATA;
reg           DEC4B5B_DV;
reg           DEC4B5B_ER;

//
// Internal Signal Declarations
//
reg           data_error;        // data error flag
reg           prem_end;          // premature end error flag
reg    [1:0]  prev_rx100_stable; // 4B/5B Values for Conversion
                                 // between 4-bit nibbles and 5-bit Symbols
//wire          reset_state;

//
// Parameter Declarations
//
// 4-bit nibble values
`define nibble0 4'b0000    // MII data value = 0
`define nibble1 4'b0001    // MII data value = 1
`define nibble2 4'b0010    // MII data value = 2
`define nibble3 4'b0011    // MII data value = 3
`define nibble4 4'b0100    // MII data value = 4
`define nibble5 4'b0101    // MII data value = 5
`define nibble6 4'b0110    // MII data value = 6
`define nibble7 4'b0111    // MII data value = 7
`define nibble8 4'b1000    // MII data value = 8
`define nibble9 4'b1001    // MII data value = 9
`define nibbleA 4'b1010    // MII data value = 10
`define nibbleB 4'b1011    // MII data value = 11
`define nibbleC 4'b1100    // MII data value = 12
`define nibbleD 4'b1101    // MII data value = 13
`define nibbleE 4'b1110    // MII data value = 14
`define nibbleF 4'b1111    // MII data value = 15

// 5-bit Symbol Values
`define symbol0 5'b11110   // 5-bit symbol value = 0
`define symbol1 5'b01001   // 5-bit symbol value = 1
`define symbol2 5'b10100   // 5-bit symbol value = 2
`define symbol3 5'b10101   // 5-bit symbol value = 3
`define symbol4 5'b01010   // 5-bit symbol value = 4
`define symbol5 5'b01011   // 5-bit symbol value = 5
`define symbol6 5'b01110   // 5-bit symbol value = 6
`define symbol7 5'b01111   // 5-bit symbol value = 7
`define symbol8 5'b10010   // 5-bit symbol value = 8
`define symbol9 5'b10011   // 5-bit symbol value = 9
`define symbolA 5'b10110   // 5-bit symbol value = 10
`define symbolB 5'b10111   // 5-bit symbol value = 11
`define symbolC 5'b11010   // 5-bit symbol value = 12
`define symbolD 5'b11011   // 5-bit symbol value = 13
`define symbolE 5'b11100   // 5-bit symbol value = 14
`define symbolF 5'b11101   // 5-bit symbol value = 15

// Special Control Values
`define symbolH 5'b00100   // Transmit Error Value
`define symbolI 5'b11111   // Idle value
`define symbolJ 5'b11000   // Start-of-Stream delimiter 1 of 2
`define symbolK 5'b10001   // Start-of-Stream delimiter 2 of 2
`define symbolT 5'b01101   // End-of-Stream delimiter 1 of 2
`define symbolR 5'b00111   // End-of-Stream delimiter 2 of 2

// Invalid Symbol Set
`define symbolV0  5'b00000 // Invalid code 0
`define symbolV1  5'b00001 // Invalid code 1
`define symbolV2  5'b00010 // Invalid code 2
`define symbolV3  5'b00011 // Invalid code 3
`define symbolV5  5'b00101 // Invalid code 5
`define symbolV6  5'b00110 // Invalid code 6
`define symbolV8  5'b01000 // Invalid code 8
`define symbolVC  5'b01100 // Invalid code 12
`define symbolV10 5'b10000 // Invalid code 16
`define symbolV19 5'b11001 // Invalid code 25

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

//------------------------------------------------------------------------------
//  This process is used... 
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET)
      begin : p_decoder
      if (RESET)
         begin
         DEC4B5B_DATA <= `nibbleF;      // Initialize Output Data
         DEC4B5B_ER   <= 1'b0;          // No Error
         data_error   <= 1'b0;
         prem_end     <= 1'b0;
         DEC4B5B_DV   <= 1'b0;
         end
      else if ((MR_SYMBOL_MODE | !RX100_STABLE | LINK100_DOWN) &
               (rclk25_pos_pos_en))
         begin
         DEC4B5B_DATA <= `nibbleF;     
         DEC4B5B_ER   <= 1'b0;         
         data_error   <= 1'b0;
         prem_end     <= 1'b0;
         DEC4B5B_DV   <= 1'b0;
         end
      else if (prem_end & rclk25_pos_pos_en)
         begin
         DEC4B5B_DATA <= `nibbleF;     // Initialize Output Data
         DEC4B5B_ER   <= 1'b0;         // No Error
         data_error   <= 1'b0;
         prem_end     <= 1'b0;
         DEC4B5B_DV   <= 1'b0;
         end
      else if (~RX100_STABLE & DES100_DV & rclk25_pos_pos_en)
         DEC4B5B_ER    <= 1'b1;        // Link Failed Error
      else if (!DES100_ER & !data_error & rclk25_pos_pos_en)
         begin
         DEC4B5B_DV <= DES100_DV;
         case({DES100_DATA, DATA_RECEIVE})
            {`symbol0, 1'b1}: DEC4B5B_DATA <= `nibble0;
            {`symbol1, 1'b1}: DEC4B5B_DATA <= `nibble1;
            {`symbol2, 1'b1}: DEC4B5B_DATA <= `nibble2;
            {`symbol3, 1'b1}: DEC4B5B_DATA <= `nibble3;
            {`symbol4, 1'b1}: DEC4B5B_DATA <= `nibble4;
            {`symbol5, 1'b1}: DEC4B5B_DATA <= `nibble5;
            {`symbol6, 1'b1}: DEC4B5B_DATA <= `nibble6;
            {`symbol7, 1'b1}: DEC4B5B_DATA <= `nibble7;
            {`symbol8, 1'b1}: DEC4B5B_DATA <= `nibble8;
            {`symbol9, 1'b1}: DEC4B5B_DATA <= `nibble9;
            {`symbolA, 1'b1}: DEC4B5B_DATA <= `nibbleA;
            {`symbolB, 1'b1}: DEC4B5B_DATA <= `nibbleB;
            {`symbolC, 1'b1}: DEC4B5B_DATA <= `nibbleC;
            {`symbolD, 1'b1}: DEC4B5B_DATA <= `nibbleD;
            {`symbolE, 1'b1}: DEC4B5B_DATA <= `nibbleE;
            {`symbolF, 1'b1}: DEC4B5B_DATA <= `nibbleF;
            {`symbolJ, 1'b0}: DEC4B5B_DATA <= `nibble5;
            {`symbolK, 1'b0}: DEC4B5B_DATA <= `nibble5;
            default: begin              // Error - Asserted for only 1 cycle
                     DEC4B5B_DATA <= `nibbleF; // error id
                     data_error   <= DES100_DV;
                     DEC4B5B_ER   <= DES100_DV & !data_error;
                     end
         endcase
         end
      else if (data_error & rclk25_pos_pos_en) // all errors should last just 1 cycle
         begin
         data_error   <= DES100_DV;  // Watch for False Carrier
         DEC4B5B_ER   <= 1'b0;       // Clear the Error
         DEC4B5B_DATA <= `nibbleB;   // Output does not matter
         DEC4B5B_DV   <= DES100_DV;
         end
      else if (DES100_BADSSD & rclk25_pos_pos_en)
         begin                       // False carrier lasts until BADSSD release
         DEC4B5B_DATA <= `nibbleE;   // false carrier nibble
         DEC4B5B_ER   <= 1'b1;
         DEC4B5B_DV   <= DES100_DV;
         end
      else if (rclk25_pos_pos_en)
         begin                       // Premature End
         prem_end     <= 1'b1;
         DEC4B5B_DATA <= `nibbleF;   // Idle nibble
         DEC4B5B_ER   <= 1'b1;
         DEC4B5B_DV   <= DES100_DV;
         end
      else 
         begin
         prem_end     <= prem_end;
         DEC4B5B_DATA <= DEC4B5B_DATA;
         DEC4B5B_ER   <= DEC4B5B_ER;
         DEC4B5B_DV   <= DEC4B5B_DV;
         end
      end // p_decoder

endmodule

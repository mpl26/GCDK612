// Created by ihdl
module dig_tx100_enc4b5b (
                          //Inputs
                          TXD,
                          TXEN,
                          TXER,
                          CLKPLL_IN,
                          txc25_enable,
                          RESET,
                          MR_100MBS,
                          LINK100_DOWN,
                          MR_SYMBOL_MODE,

                          //Outputs
                          ENC4B5B_DATA,
                          TX100_ACTIVE_NORMAL
                          );

//
// I/O Declarations
//
input   [3:0]  TXD;                  // Transmit Data from MII
input          TXEN;                 // Transmit Enable
input          TXER;                 // Transmit Error
input          CLKPLL_IN;            // System clock 125MHz or 160MHz
input          txc25_enable;         // 25MHz clock enable
input          RESET;                // System Reset
input          MR_100MBS;            // ENABLE 100MHz path
input          LINK100_DOWN;         // Link down
input          MR_SYMBOL_MODE;       // Symbol Mode 

output  [4:0]  ENC4B5B_DATA;         // Output encoded data
output         TX100_ACTIVE_NORMAL;  // Output Data is Active	

//
// I/O Type Declarations
//
wire    [3:0]  TXD;                
wire           TXEN;               
wire           TXER;               
wire           CLKPLL_IN;
wire           txc25_enable;
wire           RESET;              
wire           MR_100MBS;          
wire           LINK100_DOWN;       
wire           MR_SYMBOL_MODE;     

reg     [4:0]  ENC4B5B_DATA;       
reg            TX100_ACTIVE_NORMAL;

//
// Internal Signal Declarations
//
reg           start_of_stream;
reg           end_of_stream;
reg           end_of_stream2;
wire          reset_state;
//
// Parameter Declarations
//
`define symbol0 5'b11110        // 5-bit symbol value = 0
`define symbol1 5'b01001        // 5-bit symbol value = 1
`define symbol2 5'b10100        // 5-bit symbol value = 2
`define symbol3 5'b10101        // 5-bit symbol value = 3
`define symbol4 5'b01010        // 5-bit symbol value = 4
`define symbol5 5'b01011        // 5-bit symbol value = 5
`define symbol6 5'b01110        // 5-bit symbol value = 6
`define symbol7 5'b01111        // 5-bit symbol value = 7
`define symbol8 5'b10010        // 5-bit symbol value = 8
`define symbol9 5'b10011        // 5-bit symbol value = 9
`define symbolA 5'b10110        // 5-bit symbol value = 10
`define symbolB 5'b10111        // 5-bit symbol value = 11
`define symbolC 5'b11010        // 5-bit symbol value = 12
`define symbolD 5'b11011        // 5-bit symbol value = 13
`define symbolE 5'b11100        // 5-bit symbol value = 14
`define symbolF 5'b11101        // 5-bit symbol value = 15
   
`define symbolH 5'b00100        // Transmit Error Value
`define symbolI 5'b11111        // Idle value
`define symbolJ 5'b11000        // Start-of-Stream delimiter 1 of 2
`define symbolK 5'b10001        // Start-of-Stream delimiter 2 of 2
`define symbolT 5'b01101        // End-of-Stream delimiter 1 of 2
`define symbolR 5'b00111        // End-of-Stream delimiter 2 of 2

`define nibble0 4'b0000         // MII data value = 0
`define nibble1 4'b0001         // MII data value = 1
`define nibble2 4'b0010         // MII data value = 2
`define nibble3 4'b0011         // MII data value = 3
`define nibble4 4'b0100         // MII data value = 4
`define nibble5 4'b0101         // MII data value = 5
`define nibble6 4'b0110         // MII data value = 6
`define nibble7 4'b0111         // MII data value = 7
`define nibble8 4'b1000         // MII data value = 8
`define nibble9 4'b1001         // MII data value = 9
`define nibbleA 4'b1010         // MII data value = 10
`define nibbleB 4'b1011         // MII data value = 11
`define nibbleC 4'b1100         // MII data value = 12
`define nibbleD 4'b1101         // MII data value = 13
`define nibbleE 4'b1110         // MII data value = 14
`define nibbleF 4'b1111         // MII data value = 15

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign reset_state = (LINK100_DOWN | !MR_100MBS | MR_SYMBOL_MODE);

   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_ENC4B5B_DATA
      if (RESET)
         begin
         ENC4B5B_DATA        <= `symbolI;  // Output Idles during RESET
         TX100_ACTIVE_NORMAL <= 1'b0;      // Channel is inactive
         start_of_stream     <= 1'b0;
         end_of_stream       <= 1'b0;
         end_of_stream2      <= 1'b0;
         end
      else if (txc25_enable & reset_state)
         begin
         ENC4B5B_DATA        <= `symbolI;  // Output Idles during RESET
         TX100_ACTIVE_NORMAL <= 1'b0;      // Channel is inactive
         start_of_stream     <= 1'b0;
         end_of_stream       <= 1'b0;
         end_of_stream2      <= 1'b0;
         end
      else if (txc25_enable)
         begin
         if (TXEN && !TX100_ACTIVE_NORMAL)
            begin
            TX100_ACTIVE_NORMAL <= 1'b1;
            ENC4B5B_DATA        <= `symbolJ;  // SSD 1 of 2
            start_of_stream     <= 1'b1;
            end
         if (start_of_stream)
            begin
            ENC4B5B_DATA    <= `symbolK;      // SSD 2 of 2
            start_of_stream <= 1'b0;
            end
         if (end_of_stream2)
            begin                             // Extend to end of R
            ENC4B5B_DATA        <= `symbolI;  // ESD 2 of 2
            end_of_stream2      <= 1'b0;
            TX100_ACTIVE_NORMAL <= 1'b0;
            end
         if (end_of_stream)
            begin                             // 
            ENC4B5B_DATA   <= `symbolR;       // ESD 2 of 2
            end_of_stream  <= 1'b0;
            end_of_stream2 <= 1'b1;
            end
         if (!TXEN && TX100_ACTIVE_NORMAL && !end_of_stream && !end_of_stream2)
            begin
            ENC4B5B_DATA  <= `symbolT;       // ESD 1 of 2
            end_of_stream <= 1'b1;
            end
         if (TXEN && TX100_ACTIVE_NORMAL && !start_of_stream )
            begin
            if (!TXER)
               begin
               case( TXD ) // synopsys parallel_case full_case
                  `nibble0: ENC4B5B_DATA <= `symbol0;
                  `nibble1: ENC4B5B_DATA <= `symbol1;
                  `nibble2: ENC4B5B_DATA <= `symbol2;
                  `nibble3: ENC4B5B_DATA <= `symbol3;
                  `nibble4: ENC4B5B_DATA <= `symbol4;
                  `nibble5: ENC4B5B_DATA <= `symbol5;
                  `nibble6: ENC4B5B_DATA <= `symbol6;
                  `nibble7: ENC4B5B_DATA <= `symbol7;
                  `nibble8: ENC4B5B_DATA <= `symbol8;
                  `nibble9: ENC4B5B_DATA <= `symbol9;
                  `nibbleA: ENC4B5B_DATA <= `symbolA;
                  `nibbleB: ENC4B5B_DATA <= `symbolB;
                  `nibbleC: ENC4B5B_DATA <= `symbolC;
                  `nibbleD: ENC4B5B_DATA <= `symbolD;
                  `nibbleE: ENC4B5B_DATA <= `symbolE;
                  `nibbleF: ENC4B5B_DATA <= `symbolF;
               endcase
               end
            else
               ENC4B5B_DATA <= `symbolH;
            end
         if (!TXEN && !TX100_ACTIVE_NORMAL)
            begin
            ENC4B5B_DATA <= `symbolI;
            TX100_ACTIVE_NORMAL <= 1'b0;     // Channel is inactive
            end
         end
      else
         // Remain in the same state
         begin
         ENC4B5B_DATA        <= ENC4B5B_DATA;
         TX100_ACTIVE_NORMAL <= TX100_ACTIVE_NORMAL;
         start_of_stream     <= start_of_stream;
         end_of_stream       <= end_of_stream;
         end_of_stream2      <= end_of_stream2;
         end
      end // p_ENC4B5B_DATA

endmodule

// Created by ihdl
module dig_rx_mux (
                   //Inputs
                   RXDV10,
                   RXD10,
                   RXDV100,
                   RXD100,
                   MR_100MBS,
                   CRS10,
                   CRS100,

                   //Outputs
                   RXDV,
                   RXD,
                   CFG2_O,
                   CRS
                   );

//
// I/O Declarations
//
input         RXDV10;       // 10BaseT rx data valid
input         RXDV100;      // 100BaseT rx data valid
input         CRS10;        // 10BaseT carrier sense
input         CRS100;       // 100BaseT carrier sense
input         MR_100MBS;    // 100BaseT mode
input  [3:0]  RXD10;        // 10BaseT rx data
input  [4:0]  RXD100;       // 100BaseT rx data

output        RXDV;         // Rx data valid
output        CFG2_O;       // Symbol mode bit5
output        CRS;          // Carrier sense
output [3:0]  RXD;          // Rx data

//
// I/O Type Declarations
//
wire          RXDV10;
wire          RXDV100;
wire          CRS10;
wire          CRS100;
wire          MR_100MBS;
wire   [3:0]  RXD10;
wire   [4:0]  RXD100;

reg           RXDV;
reg           CFG2_O;
reg           CRS;
reg    [3:0]  RXD;

//
// Internal Signal Declarations
//
// None

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

//------------------------------------------------------------------------------
// Process to select between 10BaseT or 100BaseT outputs
//------------------------------------------------------------------------------
//
   always @(MR_100MBS or RXDV100 or RXD100 or CRS100 or
                         RXDV10  or RXD10  or CRS10)
      begin : p_op_mux
      if (MR_100MBS)
         begin
         RXDV   = RXDV100;
         RXD    = RXD100[3:0];
         CFG2_O = RXD100[4];
         CRS    = CRS100;
         end
      else
         begin
         RXDV   = RXDV10;
         RXD    = RXD10;
         CFG2_O = 1'b0;
         CRS    = CRS10;
         end
      end

endmodule

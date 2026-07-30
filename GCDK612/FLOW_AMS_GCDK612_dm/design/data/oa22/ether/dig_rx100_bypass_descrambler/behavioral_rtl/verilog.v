// Created by ihdl
module dig_rx100_bypass_descrambler (
                                     //Inputs
                                     DESCRAMBLER_DATA,
                                     MLT3DEC_DATA,
                                     MR_BYPASS_SCRAMBLER,

                                     //Outputs
                                     BYPASS_DESC_DATA
                                     );

//
// I/O Declarations
//
input   DESCRAMBLER_DATA;     // Data from Scrambler
input   MLT3DEC_DATA;         // Data from MLT3 Decoder
input   MR_BYPASS_SCRAMBLER;  // Select Line from MI

output  BYPASS_DESC_DATA;     // Serial Output Data

//
// I/O Type Declarations
//
wire    DESCRAMBLER_DATA;  
wire    MLT3DEC_DATA;      
wire    MR_BYPASS_SCRAMBLER;

reg     BYPASS_DESC_DATA;

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
// Mux for bypassing the descrambler
//------------------------------------------------------------------------------
//
   always @(MR_BYPASS_SCRAMBLER or MLT3DEC_DATA or DESCRAMBLER_DATA)
      begin : p_mux
      if (MR_BYPASS_SCRAMBLER)
         BYPASS_DESC_DATA = MLT3DEC_DATA;
      else
         BYPASS_DESC_DATA = DESCRAMBLER_DATA;
      end // p_mux

endmodule

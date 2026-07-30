// Created by ihdl
module dig_tx100_bypass_scrambler (
                                   //Inputs
                                   SCRAMBLER_DATA,
                                   SERIALIZER_DATA,
                                   MR_BYPASS_SCRAMBLER,

                                   //Outputs
                                   BYPASS_SCRAMBLER_DATA,
                                   );

//
// I/O Declarations
//
input     SCRAMBLER_DATA;         // Data from Scrambler
input     SERIALIZER_DATA;        // Data from Serializer
input     MR_BYPASS_SCRAMBLER;    // Select Line from MI

output    BYPASS_SCRAMBLER_DATA;  // Output Data

//
// I/O Type Declarations
//
wire      SCRAMBLER_DATA;        
wire      SERIALIZER_DATA;       
wire      MR_BYPASS_SCRAMBLER;   

reg       BYPASS_SCRAMBLER_DATA;

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
   always @ (MR_BYPASS_SCRAMBLER or SERIALIZER_DATA or SCRAMBLER_DATA)
      begin : p_BYPASS_SCRAMBLER_DATA
      if (MR_BYPASS_SCRAMBLER)
         BYPASS_SCRAMBLER_DATA = SERIALIZER_DATA;
      else
         BYPASS_SCRAMBLER_DATA = SCRAMBLER_DATA;
      end // p_BYPASS_SCRAMBLER_DATA

endmodule

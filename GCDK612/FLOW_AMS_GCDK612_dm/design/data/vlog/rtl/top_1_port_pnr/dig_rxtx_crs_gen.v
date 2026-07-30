// Created by ihdl
module dig_rxtx_crs_gen(
                        //Inputs
                        MR_FULL_DUPLEX,
                        MR_REPEATER,
                        MR_100MBS,
                        MR_MII10_LOOP_BACK_DISB,
                        RX10_PRESENT,
                        RX100_ACTIVE,
                        TX100_ACTIVE,
                        TX10_PRESENT,

                        //Outputs
                        CRS_GEN
                        );

//
// I/O Declarations
//
input     MR_FULL_DUPLEX;          // Full Duplex operation selected
input     MR_REPEATER;             // Repeater mode selected
input     MR_100MBS;               // 100 Mb/s mode selected
input     MR_MII10_LOOP_BACK_DISB; // Disable MII loopback function
input     RX10_PRESENT;            // 10 Mb/s receive data is present
input     RX100_ACTIVE;            // 100 Mb/s receive data is present
input     TX100_ACTIVE;            // 100 Mb/s transmit data is present
input     TX10_PRESENT;            // Any 10 Mb/s transmit data is present

output    CRS_GEN;                 // CRS generated
//
// I/O Type Declarations
//
wire      MR_FULL_DUPLEX;        
wire      MR_REPEATER;           
wire      MR_100MBS;
wire      MR_MII10_LOOP_BACK_DISB;
wire      RX10_PRESENT;
wire      RX100_ACTIVE;
wire      TX100_ACTIVE;
wire      TX10_PRESENT;

reg       CRS_GEN;
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
   always @(MR_FULL_DUPLEX or MR_REPEATER or MR_100MBS or RX10_PRESENT or
            RX100_ACTIVE or TX100_ACTIVE or TX10_PRESENT or 
            MR_MII10_LOOP_BACK_DISB)
      begin : p_crs_gen
      if (!MR_FULL_DUPLEX && MR_100MBS && !MR_REPEATER) 
         CRS_GEN = RX100_ACTIVE | TX100_ACTIVE;
      else if (MR_100MBS)
         CRS_GEN = RX100_ACTIVE;
      else
         CRS_GEN = RX10_PRESENT | (TX10_PRESENT & (MR_MII10_LOOP_BACK_DISB
                    & !MR_REPEATER & !MR_FULL_DUPLEX));
      end // p_crs_gen

endmodule

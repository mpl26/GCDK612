// Created by ihdl
module dig_rxtx_tpdisc(
                       //Inputs
                       MR_100MBS,
                       MR_MII100_LOOP_BACK_ENAB, 
                       MR_DIG_LOOP_BACK_ENAB,
                       MR_TP_DISC,

                       //Outputs
                       TP_DISC
                       );

//
// I/O Declarations
//
input   MR_100MBS;                 // 100MBS path is enabled
input   MR_MII100_LOOP_BACK_ENAB;  // MII Loopback is disabled
input   MR_DIG_LOOP_BACK_ENAB;     // Digital Loopback is enabled
input   MR_TP_DISC;                // Twisted Pair Disconnect

output  TP_DISC;                   // Twisted Pair disconnect
//
// I/O Type Declarations
//
wire    MR_100MBS;                
wire    MR_MII100_LOOP_BACK_ENAB; 
wire    MR_DIG_LOOP_BACK_ENAB;    
wire    MR_TP_DISC;               

wire    TP_DISC;                  
//
// Internal Signal Declarations
//
wire    tp10_disc;                // 10 MBS disconnect
wire    tp100_disc;               // 100 MBS disconnect

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign tp10_disc  = (!MR_100MBS) & MR_DIG_LOOP_BACK_ENAB;
   assign tp100_disc = MR_100MBS & 
                       (MR_MII100_LOOP_BACK_ENAB | MR_DIG_LOOP_BACK_ENAB);

   assign TP_DISC = tp10_disc | tp100_disc | MR_TP_DISC;

endmodule

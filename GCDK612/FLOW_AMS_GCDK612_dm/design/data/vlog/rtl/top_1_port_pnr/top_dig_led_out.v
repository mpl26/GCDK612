// Created by ihdl
module top_dig_led_out( 

            // Inputs
            MR_100MBS,
            TX100_ACTIVE,
            TX10_ACTIVE,
            RX100_ACTIVE,
            RX10_ACTIVE,
            MR_FULL_DUPLEX,
            
            // Outputs
            LEDS_OUT_topdig,
            LEDT_VREF_OUT_topdig,
            LEDR_LEDA_OUT_topdig,
            LEDD_OUT_topdig,
            );


// I/O Declarations
// Inputs
input       MR_100MBS;                // Indicates 100Mbps operation
input       TX100_ACTIVE;             // 100BASE-TX transmitter active.
input       TX10_ACTIVE;              // 10BASE-T transmitter active.
input       RX100_ACTIVE;             // 100BASE-TX receiver active.
input       RX10_ACTIVE;              // 10BASE-T receiver active.
input       MR_FULL_DUPLEX;           // Indicates full or half duplex mode.

// Outputs
output      LEDS_OUT_topdig;          // Speed LED.
output      LEDT_VREF_OUT_topdig;     // Transmitter LED.
output      LEDR_LEDA_OUT_topdig;     // Receiver LED.
output      LEDD_OUT_topdig;          // Duplex LED.



// I/O Definitions
wire        MR_100MBS;                // Indicates 100Mbps operation
wire        TX100_ACTIVE;             // 100BASE-TX transmitter active.
wire        TX10_ACTIVE;              // 10BASE-T transmitter active.
wire        RX100_ACTIVE;             // 100BASE-TX receiver active.
wire        RX10_ACTIVE;              // 10BASE-T receiver active.
wire        MR_FULL_DUPLEX;           // Indicates full or half duplex mode.

// Outputs
reg         LEDS_OUT_topdig;          // Speed LED.
reg         LEDT_VREF_OUT_topdig;     // Transmitter LED.
reg         LEDR_LEDA_OUT_topdig;     // Receiver LED.
reg         LEDD_OUT_topdig;          // Duplex LED.



//------------------------------------------------------------------------------
// Main Unit Code.
//------------------------------------------------------------------------------
//
// LED signal set low indicates:
// 
// LEDS - 100Mbps operation selected.
// LEDD - Full Duplex mode selected.
// LEDT - Transmitter active.
// LEDR - Receiver active.
//
//
//
// N.B. These two LED signals are not actually assigned in this module, but for
//      completion...
//
// LEDC - Collision has occurred.
// LEDL - during 100Mbps operation; indicates scrambler lock and receipt of
//        valid 'idle' codes.
//      - during 10Mbps operation; indicates Link Valid status.
//
//------------------------------------------------------------------------------

always @( MR_100MBS or TX100_ACTIVE or TX10_ACTIVE or RX100_ACTIVE or 
          RX10_ACTIVE or MR_FULL_DUPLEX )
   
   begin
      LEDS_OUT_topdig = ~MR_100MBS;
      LEDD_OUT_topdig = ~MR_FULL_DUPLEX;
      
      if (MR_100MBS==1'b1)
         begin
            LEDT_VREF_OUT_topdig = ~TX100_ACTIVE;
            LEDR_LEDA_OUT_topdig = ~RX100_ACTIVE;
         end
         
      else
         begin
            LEDT_VREF_OUT_topdig = ~TX10_ACTIVE;
            LEDR_LEDA_OUT_topdig = ~RX10_ACTIVE;
         end
   end
   


//------------------------------------------------------------------------------
endmodule   // top_dig_led_out

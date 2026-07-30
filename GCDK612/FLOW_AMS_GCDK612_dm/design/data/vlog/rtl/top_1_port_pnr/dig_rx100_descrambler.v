// Created by ihdl
module dig_rx100_descrambler (
                              //Inputs
                              RESET,
                              RXCLK125,
                              RX100_STABLE,
                              MLT3DEC_DATA,
                              MR_BYPASS_SCRAMBLER,

                              DESCRAMBLER_DATA,
                              LOCKED2IDLES
                              );

//
// I/O Declarations
//
input           RESET;               // System reset
input           RXCLK125;            // Recovered 125MHz clock
input           RX100_STABLE;        // MSE is stable start descrambling
input           MLT3DEC_DATA;        // Scrambled input NRZ data (ciphertext)
input           MR_BYPASS_SCRAMBLER; // Bypass Scrambler
   
output          DESCRAMBLER_DATA;    // descrambled NRZ data stream (plaintext)
output          LOCKED2IDLES;        // Locked to idles

//
// I/O Type Declarations
//
wire            RESET;
wire            RXCLK125;           
wire            RX100_STABLE;       
wire            MLT3DEC_DATA;       
wire            MR_BYPASS_SCRAMBLER;

reg             DESCRAMBLER_DATA;
wire            LOCKED2IDLES;

//
// Internal Signal Declarations
//
reg     [10:0]  ciphertext;       // dc: cihpertext stream register
reg     [9:0]   hypothesis;       // dh: hypothesis stream register
wire            hypothesis_in;    //  h: descrambled hypothesis stream
wire    [10:0]  plaintext;        // hp: plaintext pattern derived from 
                                  //     hypothesis stream
wire            keystream_in;     //  u: descrambler key stream
reg     [10:0]  keystream;        // du: descrambler key stream reg
reg             idle;             // idle recognized in hypothesis stream
wire            idlestate;        // idle line state - at least 20 idle bits 
reg             start;            // Determine IJK state
wire            dis;
wire            load;             // load descrambler
wire            active;           // active line state - IIIIJK received
reg     [4:0]   idlecount;        // idle bit counter
reg             wasidle;          // idle pattern was recognized
reg             locked;           // synchronized
reg     [16:0]  locktime;         // lock timer
wire            enable;

//
// Parameter Declarations
//
`define MINIDLE (5'd21)
`define MAXLOCK ( 17'h1FFFF )
`define MINTEST ( `MAXLOCK - 17'd260 )


//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   // Inform Link Monitor if we are locked to idles
   assign LOCKED2IDLES = (MR_BYPASS_SCRAMBLER | locked);

   // Enable descrambling if Link is up, Equalizer Locked, and not Reset
   assign dis = (MR_BYPASS_SCRAMBLER | !RX100_STABLE);


//------------------------------------------------------------------------------
// This process performs the shift register for the cipherdata
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET)
      begin : p_ciphertext
      if (RESET)
         ciphertext[10:0] <= 11'b0;
      else
         ciphertext[10:0] <= {ciphertext[9:0], MLT3DEC_DATA};
      end // p_ciphertext

//------------------------------------------------------------------------------
// This process will Descramble the hypothesis stream
//------------------------------------------------------------------------------
//
   assign hypothesis_in = ciphertext[10] ^ ciphertext[8] ^ MLT3DEC_DATA;

   always @(posedge RXCLK125 or posedge RESET)
      begin : p_hypothesis
      if (RESET)
         hypothesis[9:0] <= 10'b0;
      else
         hypothesis[9:0] <= {hypothesis[8:0], hypothesis_in};
      end // p_hypothesis

//------------------------------------------------------------------------------
// This process will define an idle 
//------------------------------------------------------------------------------
//
   always @(hypothesis or hypothesis_in)
      begin : p_idle
      if ((hypothesis == 10'b11111_1111) && hypothesis_in)
         idle = 1'b1;
      else
         idle = 1'b0;
      end // p_idle

//------------------------------------------------------------------------------
// This process will define start = JK found
//------------------------------------------------------------------------------
//
   always @(hypothesis or hypothesis_in)
      begin : p_start
      if ((hypothesis == 10'b1110001000) && hypothesis_in)
         start = 1'b1;
      else
         start = 1'b0;
      end // p_idle

   assign load      = ( ~locked )  & ( idle );
   assign plaintext = {idle,idle,idle,idle,idle,idle,idle,idle,idle,idle,idle};

//------------------------------------------------------------------------------
// This process will Descramble the keystream
//------------------------------------------------------------------------------
//
   assign keystream_in = keystream[10] ^ keystream[8];  // new bit in

   always @(posedge RXCLK125 or posedge RESET or posedge dis)
      begin : p_keystream
      if (RESET) 
         keystream[10:0] <= 11'b0;
      else if (dis) 
         keystream[10:0] <= 11'b0;
      else if (load)
         keystream[10:0] <= {ciphertext[9:0], MLT3DEC_DATA} 
                                ^ plaintext[10:0];
      else 
         keystream[10:0] <= {keystream[9:0],keystream_in};
      end // p_keystream

//------------------------------------------------------------------------------
// This process determines the Descrambler data
//------------------------------------------------------------------------------
//
  always @(posedge RXCLK125 or posedge RESET)
      begin : p_DESCRAMBLER_DATA
      if (RESET) 
         DESCRAMBLER_DATA <= 1'b0;
      else
         DESCRAMBLER_DATA <= keystream_in ^ MLT3DEC_DATA;
      end // p_DESCRAMBLER_DATA

//------------------------------------------------------------------------------
// This process is used to determine if data is just idle (all 1's)
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET or posedge dis)
      begin : p_idlecount
      if (RESET)
         idlecount <= 5'h0;             // reset the idlecount
      else if (dis)
         idlecount <= 5'h0;             // reset the idlecount
      else if (!DESCRAMBLER_DATA)
         idlecount <= 5'h0;             // reset the idlecount
      else if( idlecount < `MINIDLE )   // If # of idle's less than Min
         idlecount <= idlecount + 5'h1; // increment idle count
      else                              // else, idlecount reached max
         idlecount <= `MINIDLE;         // set value for idle state
      end // p_idlecount

   assign enable    = !dis;
   assign idlestate = (enable & DESCRAMBLER_DATA & (idlecount==`MINIDLE));

//------------------------------------------------------------------------------
// This process is used to determine if data was idle (all 1's)
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET  or posedge dis)
      begin : p_wasidle
      if (RESET)
         wasidle <= 1'b0;
      else if (dis)
         wasidle <= 1'b0;
      else if (locked || (!hypothesis[9]))
         wasidle <= 1'b0;
      else if( load )
         wasidle <= idle;
      else
         wasidle <= wasidle;
      end // p_wasidle

   assign active = (enable && wasidle && start);

//------------------------------------------------------------------------------
// This process is lock time counter
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET)
      begin : p_locktime
      if (RESET)
         locktime <= 17'h0;
      else if( idlestate || active )     // if idle's or active line
         locktime <= 17'h0;              // reset locktime - Synchronized
      else if( locktime < `MAXLOCK )     // If lock time not expired
         locktime <= locktime + 17'h1;   // increment the counter
      else                               // lock time expired
         locktime <= `MAXLOCK;           // set to Not-synchronized value
      end // p_locktime

//------------------------------------------------------------------------------
// This process is used to determine if synchronized (locked)
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125  or posedge RESET or posedge dis)
      begin : p_locked
      if (RESET)
         locked <= 1'b0;
      else if (dis)
         locked <= 1'b0;
      else if( idlestate || active )     // If idle state or active line
         locked <= 1'b1;                 // Set to synch line value
      else if( locktime == `MAXLOCK)     // Not synchronized
         locked <= 1'b0;
      else                               // Keep previous state
         locked <= locked;
      end // p_locked

endmodule

// Created by ihdl
module dig_tx100_scrambler (
                            //Inputs
                            SERIALIZER_DATA,
                            CLKPLL_IN,
                            clk125_enable,
                            RESET,
                            MR_SCRAMBLER_SEED,
                            MR_SCRAMBLER_LOAD,
                            MR_BYPASS_SCRAMBLER,
                            MR_100MBS,

                            //Outputs
                            SCRAMBLER_DATA  
                            );

//
// I/O Declarations
//
input          SERIALIZER_DATA;      // Input Serial Data
input          CLKPLL_IN;            // System clock 125MHz or 160MHz
input          clk125_enable;        // 125MHz clock enable
input          RESET;                // RESET
input   [4:0]  MR_SCRAMBLER_SEED;    // Seed value for initializing scrambler
input          MR_SCRAMBLER_LOAD;    // Scrambler seed value changed, reload it
input          MR_BYPASS_SCRAMBLER;  // Bypass Scrambler Indicator
input          MR_100MBS;            // 100TX mode

output         SCRAMBLER_DATA;       // Output Scrambled Data

//
// I/O Type Declarations
//
wire           SERIALIZER_DATA;    
wire           CLKPLL_IN;
wire           clk125_enable;               
wire           RESET;              
wire    [4:0]  MR_SCRAMBLER_SEED;  
wire           MR_SCRAMBLER_LOAD;  
wire           MR_BYPASS_SCRAMBLER;
wire           MR_100MBS;          
           
reg            SCRAMBLER_DATA;

//
// Internal Signal Declarations
//
wire           enable_scrambler;  //
wire   [11:0]  keystream;         // scrambler key stream
reg    [10:0]  keystreamreg;      // key stream register
reg     [2:0]  prev_scr_load;     // Delay line for synch MR_SCRAMBLER_LOAD
reg     [1:0]  sync_reset;        //
wire           load_scr;          //
wire           int_res;           //
//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign load_scr        = prev_scr_load[1] & ~prev_scr_load[2];
   assign enable_scrambler = (MR_100MBS & !MR_BYPASS_SCRAMBLER);
   assign keystream[11:1]  = keystreamreg[10:0];                 // LFSR
   assign keystream[0]     = keystream[11] ^ keystream[9];       // xor

//------------------------------------------------------------------------------
// Process to syncronise the reset
//------------------------------------------------------------------------------
//
   always @ (posedge CLKPLL_IN or posedge RESET)
      begin
      if (RESET)
         sync_reset <= 2'b11 ;
      else if (clk125_enable)
         sync_reset <= {sync_reset[0], 1'b0};
      else
         sync_reset <= sync_reset;
      end

   assign int_res = sync_reset[1];

//------------------------------------------------------------------------------
// Process to that implement LFSR
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge int_res)
      begin : p_keystreamreg
      if (int_res)
         keystreamreg[10:0] <= {6'b111111, MR_SCRAMBLER_SEED}; 
      else if (clk125_enable)
         begin
         if (load_scr || (keystreamreg == 11'b0))
            // If load, or illegal state
            keystreamreg[10:0] <= {6'b111111, MR_SCRAMBLER_SEED} ;
         else if (!enable_scrambler)
            // If not transmitting hold current value
            keystreamreg <= keystreamreg;
         else
            // Otherwise go to next value
            keystreamreg[10:0] <= keystream[10:0];
         end
      else
         keystreamreg <= keystreamreg;
      end // p_keystreamreg

//------------------------------------------------------------------------------
// Shift register holding the scrambler load signal
//------------------------------------------------------------------------------
//
   always @ (posedge CLKPLL_IN or posedge RESET)
      begin : p_prev_scr_load
      if (RESET)
         prev_scr_load <= 3'b000 ;
      else if (clk125_enable)
         prev_scr_load <= {prev_scr_load[1:0], MR_SCRAMBLER_LOAD};
      else
         prev_scr_load <= prev_scr_load;
      end // p_prev_scr_load

//------------------------------------------------------------------------------
// Process to output the scrambler data
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_SCRAMBLER_DATA
      if (RESET)
         SCRAMBLER_DATA <= 1'b1;
      else if (clk125_enable)
         SCRAMBLER_DATA <= keystream[0] ^ SERIALIZER_DATA;
      else
         SCRAMBLER_DATA <= SCRAMBLER_DATA;
      end // p_SCRAMBLER_DATA

endmodule

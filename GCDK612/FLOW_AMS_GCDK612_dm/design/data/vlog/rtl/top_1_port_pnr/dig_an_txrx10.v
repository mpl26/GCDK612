// Created by ihdl
module dig_an_txrx10( 

            // Inputs
            CLKPLL_IN,
            clk12_5_enable,
            clkfast_enable, 
            NEG_DETECT, 
            POS_DETECT, 
            RESET, 
            TD_AUTONEG, 

            // Outputs
            LINKPULSE, 
            TXD, 
            TXE
            );


// I/O Declarations
// Inputs
input       CLKPLL_IN;       // System clock 125MHz/160MHz
input       clk12_5_enable;  // 12.5MHz Clock enable
input       clkfast_enable;  // Fast Clock enable
input       NEG_DETECT; // Negative analog comparator output.
input       POS_DETECT; // Positive analog comparator output.
input       RESET;      // External reset.
input       TD_AUTONEG; // Set when A/N transmits a link pulse (from
                        // dig_an_transmit.v).


// Outputs
output      LINKPULSE;  // Strobe indicating that a valid link pulse 
                        // has been received.
output      TXD;        // Transmit data.
output      TXE;        // Transmit enable.


// I/O Definitions
// Inputs
wire        CLKPLL_IN;       // System clock
wire        clk12_5_enable;  // 12.5MHz clock enable
wire        clkfast_enable;  // Fast Clock enable.
wire        NEG_DETECT; // Negative analog comparator output.
wire        POS_DETECT; // Positive analog comparator output.
wire        RESET;      // External reset.
wire        TD_AUTONEG; // Set when A/N transmits a link pulse (from
                        // dig_an_transmit.v).

// Outputs
wire        LINKPULSE;  // Strobe indicating that a valid link pulse 
                        // has been received.
reg         TXD;        // Transmit data.
reg         TXE;        // Transmit enable.




// Internal declarations
reg [1:0]   lp_sync;    // Synchronizer for LINKPULSE, uses CLK12_5.
reg [1:0]   neg_sync;   // Synchronizer for negative link detection.
reg [1:0]   pos_sync;   // Synchronizer for positive link detection.
reg [4:0]   rx;         // Counter to generate long link detect pulse.
reg [1:0]   td_sync;    // Synchronizer for transmit.
reg [5:0]   txx;        // TXD/TXE state machine...but why 48 states?
                        // sounds like a counter.....

   
//------------------------------------------------------------------------------
// Assign Statements
//------------------------------------------------------------------------------

// Strobe indicating that a valid linkpulse has been received.
assign LINKPULSE = lp_sync[1];   




//------------------------------------------------------------------------------
// Main Unit Code
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge RESET )
   begin : p_rx_sm
   if(RESET == 1'b1)
      begin
         rx <= 5'h00;
         neg_sync <= 2'b00;
         pos_sync <= 2'b00;

         TXD <= 1'b0;
         TXE <= 1'b0;
         txx <= 6'h00;
         td_sync <= 2'b00;
      end


   else if (clkfast_enable)
      begin


//------------------------------------------------------------------------------
// Receive state machine      
//
// On reset, rx is set to zero.
// After receiving a pulse, rx will increment from 16 to 31 before overflowing 
// to zero.  It will then stay at zero until the next pulse is received.
//
// A linkpulse may be received as a positive pulse or a negative pulse,
// depending on the polarity of the physical connection. 
//
// MSB rx[4]=1'b1 when a link pulse is received.  The remaining four
// bits are the sum of the current MSB and rx[3:0] values.
//
//------------------------------------------------------------------------------

         if ( (pos_sync[1]==1'b1) | (neg_sync[1]==1'b1) )
            // Either sync will cause rx[4] to be 1, so hard-code.
            // Remaining 4 bits will be sum of current MSB and rx[3:0] values.
            rx <= (5'b10000 | (rx + {4'd0,rx[4]}) );
            
         else
            // MSB will be added to current value.
            rx <= rx + {4'd0, rx[4]};

         
         // One cycle delay in assigning POS/NEG_DETECT values.
         neg_sync <= {neg_sync[0],NEG_DETECT};
         pos_sync <= {pos_sync[0],POS_DETECT};




//------------------------------------------------------------------------------
// Transmit state machine  
//
// td_sync is used to (re)start the txx counter whenever the TD_AUTONEG
//         signal is set.  Therefore appears to be the first trigger 
//         for starting to enable the physical transmission functions 
//         and transmitting a link pulse.
//
// TXE = Transmit Enable appears to be a control flag to enable 
//       physical transmission function(s).
//
// TXD = Transmit Data appears to be a trigger for physical 
//       transmission function(s) to transmit a data pulse
//
//------------------------------------------------------------------------------

         // If txx count gets between 30 AND 35 inclusive, enable TXD.
         // i.e. TXD is set for 6 cycles per counter loop (0-47).      
         if ( (txx >= 6'h1E) & (txx <= 6'h23) )
            TXD <= 1'b1;
            
         else
            TXD <= 1'b0;



         // If txx is not zero (i.e. counting, therefore a TD_AUTONEG pulse has
         // already been received) or if a new td_sync pulse (caused by
         // TD_AUTONEG) is received, enable TXE.
         // i.e. TXE enabled all the time except between a reset and reception
         // of a td_sync pulse (due to TD_AUTONEG).
         if ( (txx != 6'd0) | (td_sync[1] == 1'b1) )
            TXE <= 1'b1;
         else
            TXE <= 1'b0;

         // synchronize to TD_AUTONEG input
         td_sync <= {td_sync[0],TD_AUTONEG}; // synchronize to TD_AUTONEG input.



         // Upon reception of a td_autoneg strobe, td_sync is strobed
         // (1-cycle delay). This starts txx counting from 0 to 47.
         // If txx counts beyond 47 before another td_sync pulse, it resets to
         // zero.  The process starts again on next td_sync pulse.
 
         // Once started, the counter auto-increments (increment if counter is 
         // between 1 and 47 (incl), or td_sync pulse received when TXE is set).
         if (((txx!=6'h00) & (txx<6'h30)) |
             ((td_sync[1]==1'b1) & (TXE==1'b1)))
            // Increment counter.
            txx <= txx + 6'd1;
         else
         // Reset the counter
            txx <= 6'd0;
 
      end

   else
      // remain in the same state
      begin
         rx       <= rx;
         neg_sync <= neg_sync;
         pos_sync <= pos_sync;
         TXD      <= TXD;
         TXE      <= TXE;
         txx      <= txx;
         td_sync  <= td_sync;
      end

   end

//------------------------------------------------------------------------------
// lp_sync: 
//
// lp_sync provides the trigger for the LINKPULSE output to be set and
// synchronises it to the 12.5 MHz clock (CLK12_5) used by the other A/N 
// modules.
// The LINKPULSE outputs indicates that a link pulse has been received and is
// used by the (FLP) Receiver and (NLP) Linktest A/N functions.
// 
// When data is received (via POS/NEG_DETECT inputs), lp_sync[1] is set high.
// This causes LINKPULSE to be set (simultaneously via 'assign' statement).
// Hence indication that a pulse has been received. 
//
// In-depth:
// 
//   lp_sync[1] will only be a '1' if prev lp_sync value was [01]...
//   ...that will only occur if rx[4] was 1'b1...
//   ...which would come from reception of sync'd data.
//
//   rx[4] remains set for 16 cycles after NEG/POS_DETECT has been set.
//   Remembering that lp_sync runs on a slower clock than rx, the following
//   sequence occurs:
//      00 -> 01 (rx[4] set) -> 11 (rx[4] still set)...
//   at this point LINKPULSE is enabled.
//
//   rx will overflow to zero on CLK125, so on next CLK12_5, LINKPULSE will
//   be disabled.
//
//   Thus LINKPULSE is enabled for one CLK12_5 cycle, matching the timing
//   of the A/N Receiver and Linktest functions that it is output to.
//------------------------------------------------------------------------------

always @( posedge CLKPLL_IN or posedge RESET )
begin
   if( RESET )
      lp_sync <= 2'b00;
    
   else if (clk12_5_enable)
      lp_sync <= { (~lp_sync[1] & lp_sync[0]), rx[4] };

   else
      lp_sync <= lp_sync;

end

  
//------------------------------------------------------------------------------
endmodule   // dig_an_linkpulse

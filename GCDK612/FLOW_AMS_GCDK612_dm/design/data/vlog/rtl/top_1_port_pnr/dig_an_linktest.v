// Created by ihdl
module dig_an_linktest( 

            // Inputs
            CLKPLL_IN,
            clk12_5_enable,
            LINK_CONTROL, 
            LINK_TEST_RCV, 
            RESET, 
            L100_LINK_STATUS, 
            L10_LINK_STATUS,
            MR_FAST_LINK,

            // Outputs
            LINK_STATUS, 
            LINK_DET 
            );
   

// I/O Declarations
// Inputs
input       CLKPLL_IN;                 // System clock 125MHz/160MHz
input       clk12_5_enable;            // 12.5MHz Clock enable
input       LINK_CONTROL;              // NLP_LINK_CONTROL from arbitrator.
                                       // Set when arbitrator is in
                                       // Ability_Detect state (transmits local
                                       // abilities, and listens for response).
input       LINK_TEST_RCV;             // Set if link pulse has been received.
input       RESET;                     // External Reset.
input [1:0] L100_LINK_STATUS;          // Current state of 100Mbps Link Partner.
input       L10_LINK_STATUS;           // Current state of 10Mbps Link Partner.

input       MR_FAST_LINK;       // fast timer for tx10 linkpulses.  


// Outputs
output      LINK_STATUS;               // Set if Link is good.
output      LINK_DET;                  // Set if Link is detected/connected.
 
                                       


// Parameter declarations

// timer defs, per 802.3-1996 Part 3, Table 14.10.4.5.8, based on a CLK period
// of 80 nS.
//
// link_loss_timer:     longest time that input activity can be missing before 
//                      the MAU determines that a link fail condition exists.
// link_test_min_timer: minimum time between valid link_test_pulses.
// link_test_max_timer: maximum time that input activity can be missing before
//                      Link Fail state is exited.
//

parameter par_Linktest_Timer_Size      = 21;          // Timer size.
parameter par_Link_Test_Min_Timer      = 21'h00e000;  //   4.58752ms
parameter par_Link_Test_Max_Timer      = 21'h110000;  //  89.12896ms
parameter par_Link_Loss_Timer          = 21'h140000;  // 104.8576ms

// Modded to interact with 'fast link' test mode (values divided by 100).
parameter par_fLinktest_Timer_Size      = 21;          // Timer size.
parameter par_fLink_Test_Min_Timer      = 21'h00023d;  // 0.0458752ms
parameter par_fLink_Test_Max_Timer      = 21'h002b85;  // 0.8912896ms
parameter par_fLink_Loss_Timer          = 21'h003333;  // 1.048576ms



// N.B.  NLPs are generated from 10BASE-T generation block as
// IDLES... therefore, if the timers are changed (e.g. using runt -qt), the
// NLPs will not match the timers and so test FAILs.
// Unless the timer values for generation of Idles in 10BASE-T block are 
// changed, these values need to be left alone.
// Hence, reduced-length timer parameters to speed up testing are not used here.
// MR_FORCE_TIMER would have been used to select the appropriate parameters.



// counter definition, per 802.3-1996
parameter par_Link_Count_Init          = 3'd0;  // Reset value.
parameter par_Link_Count_Done          = 3'd2;  // No. of consecutive link test
                                                // pulses required before exit 
                                                // from Link Fail state
                                                // (range=2-10 incl, 
                                                //  as per 14.2.3.1).

// state variable values
parameter par_NlpTestFailReset         = 3'b000;   // 0
parameter par_NlpDetectWait            = 3'b001;   // 1
parameter par_NlpTestFail              = 3'b010;   // 2
parameter par_NlpTestFail_t            = 3'b011;   // 3
parameter par_NlpTestFailCount         = 3'b100;   // 4
parameter par_NlpTestPass              = 3'b101;   // 5
parameter par_NlpTestPass_t            = 3'b110;   // 6

// Link Status encodings
parameter par_LS_Fail                  = 2'b00; // Receive channel not intact.
                                                // Not used, included for 
                                                // completeness.
parameter par_LS_Ready                 = 2'b01; // Receive channel intact and
                                                // ready to be enabled.
parameter par_LS_OK                    = 2'b11; // Receive channel intact and
                                                // enabled. 


// I/O Definitions
// Inputs
wire        CLKPLL_IN;                 // System clock
wire        clk12_5_enable;            // 12.5MHz clock enable
wire        LINK_CONTROL;              // NLP_LINK_CONTROL from arbitrator.
                                       // Set when arbitrator is in
                                       // Ability_Detect state (transmits local
                                       // abilities, and listens for response).
wire        LINK_TEST_RCV;             // Set if link pulse has been received.
wire        RESET;                     // External Reset.
wire  [1:0] L100_LINK_STATUS;          // Current state of 100Mbps Link Partner.
wire        L10_LINK_STATUS;           // Current state of 10Mbps Link Partner.


wire        MR_FAST_LINK;       // fast timer for tx10 linkpulses.  

// Outputs
wire        LINK_STATUS;               // Set if Link is good.
wire        LINK_DET;                  // Set if  Link is detected/connected.




// Internal Signals
reg [par_Linktest_Timer_Size-1:0] timer;  // Timer.
reg [2:0]   state;                        // State machine control register.
reg [2:0]   link_count;                   // Counts link test pulses received 
                                          // consecutively whilst in Link Fail
                                          // state.
reg         link_loss_timer_done;         // Flag for link_loss_timer expiry.
reg         link_test_min_timer_done;     // Flag for min timer limit.
reg         link_test_max_timer_done;     // Flag for max timer limit.

wire        internal_reset;               // Internal Reset.



//------------------------------------------------------------------------------
// Assign Statements
//------------------------------------------------------------------------------

// Link Status is set if NLP test is true (state will be maintained until
// Link Partner no longer connected link_loss_timer expires). 
assign LINK_STATUS = ( (state==par_NlpTestPass) | (state==par_NlpTestPass_t) );

// LINK_DET reports any indication that a link is up (established).
// Link Det(ect) flag is set if 100Mbps Link Partner found in READY or OK state,
// or a 10Mbps Link Partner is found READY or whenever a link pulse is received
// (link_test_rcv).
//
// N.B. It is not used by anything in this block...it just reflects the state of
// several inputs.
assign LINK_DET = ( (L100_LINK_STATUS==par_LS_Ready) |
                    (L100_LINK_STATUS==par_LS_OK) |
                    (LINK_TEST_RCV==1'b1) | 
                    (L10_LINK_STATUS==1'b1) );

// Internal Reset
// LINK_CONTROL is only '1' when arbitrator is in Ability_Detect state (or 
// FlpLinkGood(Check) states if 10Mbps link resolved) and will therefore be '0'
// in all other states. 
// This means that ~LINK_CONTROL will mostly be '1' and therefore internal_reset
// will be active, and the module will be continuously reset for most of the time. 
//
assign internal_reset   = (RESET | ~LINK_CONTROL);


//------------------------------------------------------------------------------
// Timer-Done flags:
//
// TIMER VALUES ARE NOT MUXED FOR THIS MODULE (see comment in PARAMETERS
// section, above).
//------------------------------------------------------------------------------
always @(timer or MR_FAST_LINK)
begin: p_timer_done

   if (MR_FAST_LINK == 1'b1)
   begin
      // Use fast tx10 timer values.
      link_test_min_timer_done  = ( timer >= par_fLink_Test_Min_Timer);
      link_test_max_timer_done  = ( timer >= par_fLink_Test_Max_Timer);         
      link_loss_timer_done      = ( timer >= par_fLink_Loss_Timer );
   end
   
   else   
   begin
      // Use full timer values.
      link_test_min_timer_done  = ( timer >= par_Link_Test_Min_Timer);
      link_test_max_timer_done  = ( timer >= par_Link_Test_Max_Timer);         
      link_loss_timer_done      = ( timer >= par_Link_Loss_Timer );
   end
                                                                            
end // p_timer_done

//------------------------------------------------------------------------------
// Main Unit Code
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge internal_reset ) 
begin: p_linktest_fsm


   if (internal_reset == 1'b1)
      begin
         // Next State
         state <= par_NlpTestFailReset;      // Reset/power-up state.
      
         // Outputs 
         link_count <= par_Link_Count_Init;  
      end
      
      
      
   else if (clk12_5_enable)
      begin
         
         case (state)

//------------------------------------------------------------------------------
// NlpTestFailReset (Power-up/reset state):
//------------------------------------------------------------------------------

         par_NlpTestFailReset:
            begin
               // Next State
               state <= par_NlpDetectWait;

               // Outputs
               link_count <= par_Link_Count_Init;
            end


//------------------------------------------------------------------------------
// NlpDetectWait: 
//
// Spacer state - ensure that previous linkpulse has ended before looking for
// next one (i.e. starting timers in NlpTestFail), and to allow management to 
// disable transmit and receive systems (xmit and rcv) in 802.3).
//
// LINK_TEST_RCV = 1'b1 indicates that a linkpulse has been received.  If this
// is not the case, move to NlpTestFail state.  Otherwise, remain in present 
// state.
//------------------------------------------------------------------------------

         par_NlpDetectWait:
            begin
               if (LINK_TEST_RCV==1'b0)
                  // Next State
                  state <= par_NlpTestFail;
            
               else
                  // Next State
                  state <= par_NlpDetectWait;
            end
            

//------------------------------------------------------------------------------
// NlpTestFail: 
//
//------------------------------------------------------------------------------

         par_NlpTestFail:
            begin
               if (link_count == par_Link_Count_Done)
                  //Next State
                  state <= par_NlpTestPass;
                  
               else
                  //Next State
                  state <= par_NlpTestFail_t;  
            end


//------------------------------------------------------------------------------
// timer state:
//------------------------------------------------------------------------------

         par_NlpTestFail_t:   // Timer state - wait for link
            begin
               // If pulse received too early, or no pulse received before
               // max timer expires...
               if ( (link_test_max_timer_done==1'b1) |
                     ( (link_test_min_timer_done==1'b0) & 
                       (LINK_TEST_RCV==1'b1) ) )
                  // Next State
                  state <= par_NlpTestFailReset;
               
               else
                  // If pulse received on-time...
                  if ( (link_test_min_timer_done==1'b1) & 
                       (LINK_TEST_RCV==1'b1) )
                     // Next State
                     state <= par_NlpTestFailCount;
               
                  else
                     // Remain in this state.
                     // Next State
                     state <= par_NlpTestFail_t;
            end
            

//------------------------------------------------------------------------------
// NlpTestFailCount:
//
// Linkpulse has been received, so increment counter.
//------------------------------------------------------------------------------

         par_NlpTestFailCount:
            begin
               // Next State
               state <= par_NlpDetectWait;  


               // Outputs
               link_count <= link_count + 3'd1;
            end


//------------------------------------------------------------------------------
// NlpTestPass:
//
// Remain in this (and associated timer) state until no more NLPs are received
// (i.e. link_loss_timer expires).
//
//------------------------------------------------------------------------------

         par_NlpTestPass:
            // Next State
            state <= par_NlpTestPass_t;


//------------------------------------------------------------------------------
// timer state:
//------------------------------------------------------------------------------

         par_NlpTestPass_t:   // Waiting for timers to expire...
            begin
               if ( (LINK_TEST_RCV==1'b1) & 
                    (link_test_min_timer_done==1'b1) )
                  // Next State
                  state <= par_NlpTestPass;
               
               else
                  if (link_loss_timer_done)
                     // Next State
                     state <= par_NlpTestFailReset;
                  
                  else
                     // Next State
                     state <=  par_NlpTestPass_t;
            end



//------------------------------------------------------------------------------
// default state:
//------------------------------------------------------------------------------

         default:
            // Next State
            state <= par_NlpTestFailReset;

         endcase
         
      end

   else

      begin
      state      <= state;
      link_count <= link_count;  
      end

end   // p_linktest_fsm




//------------------------------------------------------------------------------
// Timer Control
//
// Single timer variable can be used to implement 3 timers.
// Reset timer on pass/fail of NLP Linktest.
// In other states, increment until ALL timers have expired.
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge RESET)
begin: p_timer_control

   if (RESET == 1'b1)
      // Reset timer.
      timer <= 21'd0;
      
   else if (clk12_5_enable)
      begin
         if ( (state==par_NlpTestPass) | 
            (state==par_NlpTestFail) )
            // Reset timer.
            timer <= 21'd0;
   
         else
            // Increment until ALL timers have expired.
            if ( !( (link_loss_timer_done==1'b1) &
                    (link_test_max_timer_done==1'b1) &
                    (link_test_min_timer_done==1'b1) ) )
               timer <= timer + 21'd1;

            else
               // Maintain value.
               timer <= timer;
         
      end

   else
      timer <= timer;
 
end // p_timer_control


   
//------------------------------------------------------------------------------
endmodule   // dig_an_linktest

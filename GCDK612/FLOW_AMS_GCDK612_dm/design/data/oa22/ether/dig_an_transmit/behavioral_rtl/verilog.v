// Created by ihdl
module dig_an_transmit( 

               // Inputs
               CLKPLL_IN,
               clk12_5_enable,
               COMPLETE_ACK,
               RESET,
               TRANSMIT_ENABLE,
               TX_LINK_CODE_WORD,
               MR_FORCE_TIMER,

               // Outputs
               ACK_FINISHED,
               TD_AUTONEG,
               T_PULSE 
               );



// I/O Definitions
// Inputs
input          CLKPLL_IN;           // System clock 125MHz/160MHz
input          clk12_5_enable;      // 12.5MHz Clock enable
input          COMPLETE_ACK;        // Strobe to count/don't count LCWs with 
                                    // ACK bit set.
input          RESET;               // External Reset.
input          TRANSMIT_ENABLE;     // Signal to allow transmission/reset FSM.
input [15:0]   TX_LINK_CODE_WORD;   // LCW to be transmitted.
input          MR_FORCE_TIMER;      // Mux/Debug flag: use short timer values
                                    // to speed up tests.

// Outputs
output         ACK_FINISHED;        // Flag indicating final remaining_ack_cnt
                                    // LCWs with ACK bit set have been
                                    // transmitted (6 transmitted).
output         TD_AUTONEG;          // Signal to MDI to transmit a (Link 
                                    // Integrity Test) pulse.
output         T_PULSE;             // Set when tx_link_code_word is being 
                                    // transmitted (i.e. clk/data LIT pulses).
 


// timers defs, per 802.3u-1995 Table 28-8, based on a CLK period of 80 nS
// 80ns = 12.5MHz clock.
//
parameter   par_Transmit_Timer_Size             = 18;          // Timer size.
parameter   par_Interval_Timer_Max              = 18'h0030D;   // 62.48us
parameter   par_Transmit_Link_Burst_Timer_Max   = 18'h2AC00;   // 14.00832ms

// Reduced-length timer parameters to speed up testing.
// Use MR_FORCE_TIMER signal to control which parameters are used.

// 300us because need to make it larger than max permissible gap between
// linkpulses within an FLP (125+14us), and also flp_test_max_timer (175us).
parameter   par_force_TLB_Timer_Max             = 18'h00ea6;   // 300us



// counter definition, per 802.3u-1995 Paragraph 28.3.3:
// Number of FLP/LCWs to be transmitted with ACK bit set.
parameter   par_Remaining_Ack_Cnt_Init          = 4'd0;     // Reset value.
parameter   par_Remaining_Ack_Cnt_Done          = 4'd6;     // 'Done' value.

// state variable values
parameter   par_Idle                            = 4'b0000;  // 0
parameter   par_Idle_t                          = 4'b1000;  // 8
parameter   par_TransmitRemainingAcknowledge    = 4'b0001;  // 1
parameter   par_TransmitAbility                 = 4'b0011;  // 3
parameter   par_TransmitClockBit                = 4'b0110;  // 6
parameter   par_TransmitClockBit_t              = 4'b1110;  // 14
parameter   par_TransmitDataBit                 = 4'b0111;  // 7
parameter   par_TransmitDataBit_t               = 4'b1111;  // 15
parameter   par_TransmitCountAck                = 4'b0010;  // 2
parameter   par_TransmitCountAck_t              = 4'b1010;  // 10



// I/O Declarations
// Inputs                                    
wire           CLKPLL_IN;                    // System clock
wire           clk12_5_enable;               // 12.5MHz clock enable
wire           COMPLETE_ACK;                 // Strobe to count/don't count LCWs
                                             // with ACK bit set.
wire           RESET;                        // External Reset.
wire           TRANSMIT_ENABLE;              // Signal to allow transmission/
                                             // reset FSM.
wire [15:0]    TX_LINK_CODE_WORD;            // LCW to be transmitted.
wire           MR_FORCE_TIMER;               // Mux/Debug flag: use short timer
                                             // values to speed up tests.
 
// Outputs
reg            ACK_FINISHED;                 // Flag indicating final 
                                             // remaining_ack_cnt LCWs with ACK 
                                             // bit set have been transmitted.
reg            TD_AUTONEG;                   // Signal to MDI to transmit a 
                                             // (Link Integrity Test) pulse.
wire           T_PULSE;                      // Set when tx_link_code_word is 
                                             // being transmitted (i.e. clk/data
                                             // LIT pulses).

// Internal declarations
reg [par_Transmit_Timer_Size-1:0] timer;     // Counter for both timers.
reg [3:0]   state;                           // State machine control word.
reg [3:0]   remaining_ack_cnt;               // Counter for transmitted LCWs 
                                             // with ACK bit set:
                                             // 0 = 'init'.
                                             // 0-5 = 'not_done'
                                             // 6-8 = 'done'
reg [4:0]   tx_bit_cnt;                      // 5-bit counter to track current
                                             // data bit of tx_link_code_word:
                                             // 0 = 'init'.
                                             // 0-15 = 'not done'
                                             // 16 = 'done'
reg         TRANSMIT_ENABLE_DLY;             // 1-cycle-delayed version of
                                             // TRANSMIT_ENABLE.
reg         transmit_link_burst_timer_done;  // Flag timer expired
reg         interval_timer_done;             // Flag timer expired.

wire        internal_reset;                  // Internal reset for FSM.




//------------------------------------------------------------------------------
// Assign Statements
//------------------------------------------------------------------------------
// Internal Reset
assign internal_reset = (RESET | ~TRANSMIT_ENABLE_DLY);

// T_PULSE - set while clock and data pulses (FLP burst) are generated.
assign T_PULSE = ~tx_bit_cnt[4];
   
   
//------------------------------------------------------------------------------
// Mux timer limits according to MR_FORCE_TIMER, to allow tests to be speeded 
// up.
//------------------------------------------------------------------------------
always @(MR_FORCE_TIMER or timer)
begin:   p_force_timer

   // interval_timer limit is not muxed. 
   interval_timer_done = ( timer >= par_Interval_Timer_Max );


   // Mux transmit_link_burst_timer limit.
   if (MR_FORCE_TIMER==1'b1)
      transmit_link_burst_timer_done = (timer >= par_force_TLB_Timer_Max );
      
   else
      transmit_link_burst_timer_done = ( timer >= 
                                            par_Transmit_Link_Burst_Timer_Max );
   
end   // p_force_timer




//------------------------------------------------------------------------------
// Transmitter State Machine:
// 
// Reset by internal_reset (and hence by external RESET).
// ACK_FINISHED initialised to zero - acknowledge bits still to be transmitted.
// remaining_ack_cnt and tx_bit_cnt initialised to 'done' values.
// 
// FSM starts in Idle state and moves to Idle timer state on next clock cycle
// (unconditional transfer).
//
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge internal_reset ) 
begin: p_transmit_fsm

   if(internal_reset == 1'b1) 
      begin
         // Next State
         state             <= par_Idle;
         
         // Outputs
         ACK_FINISHED      <= 1'b0;
         remaining_ack_cnt <= par_Remaining_Ack_Cnt_Done;
         tx_bit_cnt        <= 5'b10000;   // Set to 16, (i.e. "done").
      end
      
   else if (clk12_5_enable)
      begin
      
         case(state)

         par_Idle:   // Idle State
            begin
               // Next State 
               state <= par_Idle_t;
               
               // Outputs
               ACK_FINISHED       <= 1'b0;
               remaining_ack_cnt  <= par_Remaining_Ack_Cnt_Done;
               tx_bit_cnt         <= 5'b10000;   // Set to 16, (i.e. "done").
            end


//------------------------------------------------------------------------------
// Idle State timer - waiting for transmit_link_burst_timer to expire.
// transmit_link_burst_timer provides separation between FLP bursts.
// Next state dependent on whether LCWs with acknowledge bit set are still to be
// transmitted.
//------------------------------------------------------------------------------
         par_Idle_t:         
            begin
               if (transmit_link_burst_timer_done == 1'b0)
                  // Next State
                  state <= par_Idle_t;
               else
                  // Timer is done...
                  //
                  // COMPLETE_ACK = 0: Link Code Words with Acknowledge bit set
                  // are not counted.
                  if (COMPLETE_ACK == 1'b0)
                     // Next State
                     state <= par_TransmitAbility;

                  else
                     // COMPLETE_ACK = 1: Link Code Words with Acknowledge bit 
                     // set are counted.
                     //
                     // Next State    
                     state <= par_TransmitRemainingAcknowledge;

               // Outputs
               ACK_FINISHED       <= ACK_FINISHED;
               remaining_ack_cnt  <= remaining_ack_cnt;
               tx_bit_cnt         <= tx_bit_cnt;

            end



//------------------------------------------------------------------------------
// Initialise remaining_ack_cnt to zero, for counting number of transmitted LCWs
// with Acknowledge bit set.
//------------------------------------------------------------------------------
         par_TransmitRemainingAcknowledge: 
            begin
               // Next State
               state <= par_TransmitAbility;
               
               // Outputs
               ACK_FINISHED       <= ACK_FINISHED;
               remaining_ack_cnt  <= par_Remaining_Ack_Cnt_Init;
               tx_bit_cnt         <= tx_bit_cnt;
            end


//------------------------------------------------------------------------------
// Initialize tx_bit_cnt to zero, for counting through tx_link_code_word bits.
//------------------------------------------------------------------------------
         par_TransmitAbility: 
            begin
               // Next State
               state <= par_TransmitClockBit;

               // Outputs
               ACK_FINISHED       <= ACK_FINISHED;
               remaining_ack_cnt  <= remaining_ack_cnt;
               tx_bit_cnt         <= 5'd0; 
            end



//------------------------------------------------------------------------------
// Generate link pulse representing clock pulse (see TD_AUTONEG process below).
//------------------------------------------------------------------------------
         par_TransmitClockBit:
            begin
               if (tx_bit_cnt[4] == 1'b0)
                  // Next State
                  state <= par_TransmitClockBit_t;      
               else
                  if (remaining_ack_cnt >= par_Remaining_Ack_Cnt_Done)
                     // Next State
                     state <= par_Idle;
                  else
                     // Next State
                     state <= par_TransmitCountAck;

               // Outputs
               ACK_FINISHED       <= ACK_FINISHED;
               remaining_ack_cnt  <= remaining_ack_cnt;
               tx_bit_cnt         <= tx_bit_cnt;
            end



//------------------------------------------------------------------------------
// timer state - wait for clock-data interval timer to expire.
//------------------------------------------------------------------------------
         par_TransmitClockBit_t:                         
            begin
               if (interval_timer_done == 1'b1)
                  // Next State
                  state <= par_TransmitDataBit;
               else
                  // Next State
                  state <= par_TransmitClockBit_t;

               // Outputs
               ACK_FINISHED       <= ACK_FINISHED;
               remaining_ack_cnt  <= remaining_ack_cnt;
               tx_bit_cnt         <= tx_bit_cnt;
            end
            
            

//------------------------------------------------------------------------------
// Generate link pulse representing data pulse if current bit in
// tx_link_code_word is set - i.e. data '1' (see TD_AUTONEG process below).
// 
// Increment tx_bit_cnt.
//------------------------------------------------------------------------------
         par_TransmitDataBit: 
            begin
               // Next State
               state <= par_TransmitDataBit_t;

               // Outputs
               ACK_FINISHED      <= ACK_FINISHED;
               remaining_ack_cnt <= remaining_ack_cnt;
               tx_bit_cnt        <= tx_bit_cnt + 5'd1;
            end


//------------------------------------------------------------------------------
// timer state - wait for data-clock interval timer to expire.
//------------------------------------------------------------------------------
         par_TransmitDataBit_t:
            begin
               if (interval_timer_done == 1'b1)
                  // Next State
                  state <= par_TransmitClockBit;
               else
                  // Next State
                  state <= par_TransmitDataBit_t;

               // Outputs
               ACK_FINISHED      <= ACK_FINISHED;
               remaining_ack_cnt <= remaining_ack_cnt;
               tx_bit_cnt        <= tx_bit_cnt;
            end
            


//------------------------------------------------------------------------------
// Start transmit_link_burst_timer and increment remaining_ack_cnt (since link
// code word has now been transmitted).
//------------------------------------------------------------------------------
         par_TransmitCountAck: 
            begin
               // Next State
               state <= par_TransmitCountAck_t;
               
               // Outputs
               ACK_FINISHED      <= ACK_FINISHED;
               remaining_ack_cnt <= remaining_ack_cnt + 4'd1;
               tx_bit_cnt        <= tx_bit_cnt;
            end
         
         
         
//------------------------------------------------------------------------------
// timer state.
//
// If LCWs with Acknowledge bit set are not counted or enough have been
// transmitted (count is done), set ACK_FINISHED flag and return to Idle state.
// 
// Otherwise, start transmitting the next FLP burst.
//------------------------------------------------------------------------------
         par_TransmitCountAck_t:
            begin
               if ( (COMPLETE_ACK == 1'b0) | 
                    (remaining_ack_cnt >= par_Remaining_Ack_Cnt_Done) )
                  // Next State
                  state <= par_Idle;      
               else
                  // Start transmitting next FLP burst.
                  if (transmit_link_burst_timer_done == 1'b1)
                     // Next State
                     state <= par_TransmitAbility;
                  else
                     // Next State
                     state <= par_TransmitCountAck_t;

               // Outputs
               if (remaining_ack_cnt >= par_Remaining_Ack_Cnt_Done)
                  ACK_FINISHED <= 1'b1;
               else
                  ACK_FINISHED <= 1'b0;

               remaining_ack_cnt  <= remaining_ack_cnt;
               tx_bit_cnt         <= tx_bit_cnt;                  
            end

                

//------------------------------------------------------------------------------
// Default state.
//------------------------------------------------------------------------------
         default:    // Default is Idle State.
            begin
               // Next State
               state <= par_Idle;
            
               // Outputs
               ACK_FINISHED       <= ACK_FINISHED;
               remaining_ack_cnt  <= par_Remaining_Ack_Cnt_Done;
               tx_bit_cnt         <= tx_bit_cnt;
            end

         endcase

      end
   else
      begin
      state             <= state;
      ACK_FINISHED      <= ACK_FINISHED;
      remaining_ack_cnt <= remaining_ack_cnt;
      tx_bit_cnt        <= tx_bit_cnt;
      end
end   // p_transmit_fsm		



//------------------------------------------------------------------------------
// Register Added to de-glitch TRANSMIT_ENABLE (see log notes above).
//------------------------------------------------------------------------------
always @ (posedge CLKPLL_IN or posedge RESET) 
begin: p_transmit_enable_dly

   if(RESET) 
      TRANSMIT_ENABLE_DLY <= 1'b0;
   else if (clk12_5_enable)
      TRANSMIT_ENABLE_DLY <= TRANSMIT_ENABLE;
   else
      TRANSMIT_ENABLE_DLY <= TRANSMIT_ENABLE_DLY;
      
end   // p_transmit_enable_dly

   
   
//------------------------------------------------------------------------------
// TD_AUTONEG controls transmission of link test pulses for data encoding in FLP 
// bursts:
//    TD_AUTONEG = 0 = 'idle' = no link test pulse transmitted = logic 0 
//    TD_AUTONEG = 1 = 'link_test_pulse' = link test pulse transmitted = logic 1 
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge RESET) 
begin: p_td_autoneg

   if(RESET) 
      TD_AUTONEG  <= 1'b0;
      
   else if (clk12_5_enable) 
      // TD_AUTONEG.
      // Link test pulse is transmitted if in TRANSMIT CLOCK BIT state OR
      // in TRANSMIT DATA BIT state and the next bit of the
      // tx_link_code_word to be transmitted is a '1'.
      if ((state == par_TransmitClockBit) | 
          ((state == par_TransmitDataBit) & 
           (TX_LINK_CODE_WORD[tx_bit_cnt])) )
         // Transmit a link test pulse.
         TD_AUTONEG <= 1'b1; 
          
         
      else
         // 'idle': DO NOT transmit a link test pulse.
         TD_AUTONEG <= 1'b0; 
   else
     TD_AUTONEG <= TD_AUTONEG;

end   // p_td_autoneg      



//------------------------------------------------------------------------------
// Timer Control
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge RESET) 
begin: p_timer_control

   if(RESET) 
      // Reset timer.
      timer <= 18'd0;

   else if (clk12_5_enable)
      // These states cause interval_timer or transmit_timer to start, so
      // initialize the timer to zero (ready to start).        
      if (state == par_Idle |                // transmit_link_burst_timer
          state == par_TransmitCountAck |    // transmit_link_burst_timer
          state == par_TransmitClockBit |    // interval_timer
          state == par_TransmitDataBit)      // interval_timer
         // Initialize the timer to zero, ready to start.        
         timer <= 18'd0;

      else 
         // If in any other state (including "_t" timer states) and particular 
         // timer condition has not yet expired, increment timer.
         if ((interval_timer_done & transmit_link_burst_timer_done) == 1'b0)
            timer <= timer + 18'd1;

         else
            // transmit_link_burst_timer_done has been set (since 
            // interval_timer_done has a smaller max-timer value, it will have  
            // been set as timer incremented), so stop timer where it is.
            timer <= timer;  
   else               
      timer <= timer;

end   // p_timer_control


//------------------------------------------------------------------------------
endmodule   // dig_an_transmit

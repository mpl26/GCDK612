// Created by ihdl
module dig_an_receive( 

        // Inputs
        CLKPLL_IN,
        clk12_5_enable,
        LINKPULSE,
        RESET,
        RECEIVE_ENABLE,
        MR_FORCE_TIMER,
        
        // Outputs
        FLP_RECEIVE_IDLE,
        RCV_DONE,
        RX_LINK_CODE_WORD,
        TIMEOUT
        );


// Inputs
input          CLKPLL_IN;           // System clock 125MHz/160MHz
input          clk12_5_enable;      // 12.5MHz Clock enable
input          LINKPULSE;           // Strobe to indicate link pulse has been
                                    // received.
input          RESET;               // External reset.
input          RECEIVE_ENABLE;      // Used to trigger internal reset.
input          MR_FORCE_TIMER;      // Mux/Debug flag: use short timer values
                                    // to speed up tests.

// Outputs
output         FLP_RECEIVE_IDLE;    // Set while system waits for/tries to
                                    // recognise an FLP burst.
output         RCV_DONE;            // Set when link code word has been
                                    // successfully decoded from FLP burst.
output [15:0]  RX_LINK_CODE_WORD;   // Link code word decoded from FLP burst.
output         TIMEOUT;             // Set if FLP burst does not arrive within 
                                    // given time frame.


// Timer defs, per 802.3u-1995 Table 28-8, based on a CLK period of 80 nS
// Data detect and FLP test timers both have a similar range and do not overlap.
// Hence a single timer signal has been used to represent them both.
parameter par_Data_Detect_Flp_Test_Timer_Size   = 12;          // Timer size.
parameter par_Data_Detect_Min_Timer_Max         = 12'h180;     // 30.72us
parameter par_Data_Detect_Max_Timer_Max         = 12'h460;     // 89.60us
parameter par_Flp_Test_Min_Timer_Max            = 12'h0c0;     // 15.36us
parameter par_Flp_Test_Max_Timer_Max            = 12'h880;     // 174.08us

parameter par_Nlp_Test_Min_Timer_Size           = 17;          // Timer size.
parameter par_Nlp_Test_Min_Timer_Max            = 17'h12400;   // 5.98016ms

parameter par_Nlp_Test_Max_Timer_Size           = 21;          // Timer size.
parameter par_Nlp_Test_Max_Timer_Max            = 21'h140000;  // 104.8576ms

// Counter definition, per 802.3u-1995 Paragraph 28.3.3:
parameter par_Flp_Cnt_Init = 5'd0;           // Reset Value.
parameter par_Flp_Cnt_Done = 5'd6;           // 'Done' Value.


// Reduced-length timer parameters to speed up testing.
// Use MR_FORCE_TIMER signal to control which parameters are used.

// Nlp_Test_Min_Timer is minimum time time between two consecutive FLPS,
// referenced from the start of the first FLP.
// Thus. Need to make this FLP length+(~150us) so that is greater than
// clk-clk FLP gap(139us) but less than transmit_link_burst_timer (300us)....
// Length of FLP burst is 2004.560us, so set timer to be 2.2ms.
parameter par_force_NLPTMin_Timer_Max           = 17'h06b6c;   // 2.2ms

// Nlp_Test_Max_Timer is maximum time that no FLP may be seen before Receive
// function times out and returns to the Idle state. It is started when 
// nlp_test_min_timer stops.
parameter par_force_NLPTMax_Timer_Max           = 21'h00927c;  // 3ms


// State variable values
parameter par_Idle               = 4'b0000;  // 0
parameter par_LinkPulseDetect    = 4'b0001;  // 1
parameter par_LinkPulseDetect_t  = 4'b0010;  // 2
parameter par_LinkPulseCount     = 4'b0011;  // 3
parameter par_LinkPulseCount_t   = 4'b0100;  // 4
parameter par_FlpPass            = 4'b0101;  // 5
parameter par_FlpPass_t          = 4'b0110;  // 6
parameter par_FlpCheck           = 4'b0111;  // 7
parameter par_FlpCheck_t         = 4'b1000;  // 8
parameter par_FlpCapture         = 4'b1001;  // 9
parameter par_FlpClock           = 4'b1010;  // 10
parameter par_FlpClock_t         = 4'b1011;  // 11
parameter par_FlpData_0          = 4'b1100;  // 12
parameter par_FlpData_1          = 4'b1101;  // 13
parameter par_FlpData_1_t        = 4'b1110;  // 14


// I/O Declarations
// Inputs
wire           CLKPLL_IN;           // System clock
wire           clk12_5_enable;      // 12.5MHz clock enable
wire           LINKPULSE;           // Strobe to indicate link pulse has been
                                    // received.
wire           RESET;               // External reset.
wire           RECEIVE_ENABLE;      // Used to trigger internal reset.
wire           MR_FORCE_TIMER;      // Mux/Debug flag: use short timer values
                                    // to speed up tests.

// Outputs
reg            FLP_RECEIVE_IDLE;    // Set while system waits for/tries to
                                    // recognise an FLP burst.
wire           RCV_DONE;            // Set when link code word has been
                                    // successfully decoded from FLP burst.
wire [15:0]    RX_LINK_CODE_WORD;   // Link code word decoded from FLP burst.
reg            TIMEOUT;             // Set if FLP burst does not arrive within 
                                    // given time frame.


// Internal declarations
// Data detect and FLP test timers both have a similar range and do not overlap.
// Hence a single timer signal has been used to represent them both.
reg [par_Data_Detect_Flp_Test_Timer_Size-1:0] data_detect_flp_test_timer; 

reg [par_Nlp_Test_Min_Timer_Size-1:0] nlp_test_min_timer;  // NLP test min.
reg [par_Nlp_Test_Max_Timer_Size-1:0] nlp_test_max_timer;  // NLP test max. 

reg [3:0]      state;            // State machine control register.
reg [4:0]      flp_cnt;          // 5-bit reg, values 0-17 inclusive.
reg [16:0]     rx_bit_sr;        // 17-bit shift register.

// Min/Max 'done' signals for timers:
reg  data_detect_min_timer_done; // data_detect_min.
reg  data_detect_max_timer_done; // data_detect_max.
reg  flp_test_min_timer_done;    // flp_test_min.
reg  flp_test_max_timer_done;    // flp_test_max
reg  nlp_test_min_timer_done;    // nlp_test_min.
reg  nlp_test_max_timer_done;    // nlp_test_max

wire internal_reset;             // Internal reset - resets FSM.

reg  RECEIVE_ENABLE_DLY;         // Single-cycle delayed version of
                                 // RECEIVE_ENABLE input.


//------------------------------------------------------------------------------
// Assign Statements
//------------------------------------------------------------------------------

// Internal Reset
assign   internal_reset = (RESET | ~RECEIVE_ENABLE_DLY);


// Assign Outputs

// RCV_DONE should only occur when shift register rx_bit_sr  has filled up 
// completely, which is determined by the LSB becoming data '1'.
// This is always the case if the FLP was decoded correctly, as the 802.3
// 'Selector Field' has value 00001 (the shift register is loaded MSB->LSB
// i.e. 0,0,0,0,1->).
// RCV_DONE is strobed for a single cycle, as state changes to Flp_Check_t
// one cycle after it reaches Flp_Check.
assign RCV_DONE             = ( (state==par_FlpCheck) & rx_bit_sr[0] );

// RX_LINK_CODE_WORD takes value of first 16 received data bits from rx_bit_sr
// shift-register (rx_bit_sr is initialised to 17'h10000 at RESET).
assign RX_LINK_CODE_WORD   = rx_bit_sr[16:1];


//------------------------------------------------------------------------------
// Mux timer limits according to MR_FORCE_TIMER, to allow tests to be speeded 
// up.
//------------------------------------------------------------------------------
always @(MR_FORCE_TIMER or data_detect_flp_test_timer or 
         nlp_test_min_timer or nlp_test_max_timer)
begin:   p_force_timer

   // Data Detect Timers
   data_detect_min_timer_done = 
               (data_detect_flp_test_timer >= par_Data_Detect_Min_Timer_Max);
   data_detect_max_timer_done = 
               (data_detect_flp_test_timer >= par_Data_Detect_Max_Timer_Max);

   // FLP Test Timers
   flp_test_min_timer_done = 
               (data_detect_flp_test_timer >= par_Flp_Test_Min_Timer_Max);
   flp_test_max_timer_done =
               (data_detect_flp_test_timer >= par_Flp_Test_Max_Timer_Max);


   // Mux timers:
   if (MR_FORCE_TIMER==1'b1)
      begin
         // nlp_test_min_timer limit.
         nlp_test_min_timer_done =
                  (nlp_test_min_timer >= par_force_NLPTMin_Timer_Max);

         // nlp_test_max_timer limit.
         nlp_test_max_timer_done =
                  (nlp_test_max_timer >= par_force_NLPTMax_Timer_Max);

      end
         
   else
      begin
         // nlp_test_min_timer limit.
         nlp_test_min_timer_done =
                  (nlp_test_min_timer >= par_Nlp_Test_Min_Timer_Max);

         // nlp_test_max_timer limit.
         nlp_test_max_timer_done =
                  (nlp_test_max_timer >= par_Nlp_Test_Max_Timer_Max);

      end   
 
end   // p_force_timer





//------------------------------------------------------------------------------
// Receiver State Machine:
// 
// Reset by internal_reset (and hence by external RESET).
//
// rx_bit_sr is initialised to 0x10000.  The '1' is used as a marker for
// determining when the shift register is full.
//
// TIMEOUT and RX_LINK_CODE_WORD are not initialised in the Idle state, because
// they are required to hold their values long enough for the arbitration module
// to pick up the value and act upon it.
//
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge internal_reset ) 
begin: p_receive_fsm

   if (internal_reset == 1'b1)
      begin
         state       <= par_Idle;         // Idle state.
      
         flp_cnt     <= par_Flp_Cnt_Init; // Reset FLP linkpulse count to zero.
         rx_bit_sr   <= 17'h10000;        // Initialise shift_register. 
      end
      
      
   else if (clk12_5_enable)
      begin
 
         case (state)

         par_Idle:
            begin
               if (LINKPULSE == 1'b1)
                  // Next State
                  state <= par_LinkPulseDetect; // Detect a link pulse...
               else
                  // Next State
                  state <= par_Idle;            // Idle state.

            // Outputs
            flp_cnt <= par_Flp_Cnt_Init;
            end


         
//------------------------------------------------------------------------------
// Look for pulse that is received within FLP min/max limits
// (i.e. indication that FLP is being received).
//------------------------------------------------------------------------------

            par_LinkPulseDetect:
               // Next State
               state <= par_LinkPulseDetect_t;  // Timer state - wait for a
                                                // link pulse to be received.



            par_LinkPulseDetect_t:
               begin
                  // Move to Count state if pulse arrives on time.
                  if ( (LINKPULSE==1'b1) &
                       (flp_test_min_timer_done==1'b1)  &
                       (flp_test_max_timer_done==1'b0) )
                     // Next State
                     state <= par_LinkPulseCount;  // Update counter if link
                                                   // pulse is received.
 
                  else
                     // Return to Idle state if pulse arrives early or not
                     // at all.
                     if ( (LINKPULSE==1'b1 & flp_test_min_timer_done==1'b0) |
                          (flp_test_max_timer_done==1'b1) )
                        // Next State
                        state <= par_Idle;   // Idle state.
 
                  else
                     // Remain in state, waiting for timers...
                     state <= par_LinkPulseDetect_t;  // Timer state - wait
                                                      // for a link pulse to
                                                      // be received.
               end
 
 
 
//------------------------------------------------------------------------------
// Count the number of consecutively received Link Pulses that are separated
// by FLP min/max timings.
// If 6 to 17 (inclusive) pulses are received, the Link Partner is able to
// perform A/N.
//------------------------------------------------------------------------------

            par_LinkPulseCount: 
               begin
                  // Next State
                  state <= par_LinkPulseCount_t;   // Delay state - so that 
                                                   // last received link pulse
                                                   // may be recognised. 

                  // Outputs
                  flp_cnt <= flp_cnt + 5'd1;       // Increment FLP count.
               end

            par_LinkPulseCount_t: 
               begin
                  if (flp_cnt < par_Flp_Cnt_Done)
                     // Next State
                     state <= par_LinkPulseDetect; // Detect a link pulse...
                  else
                     // Next State
                     state <= par_FlpPass;         // FLP burst has been
                                                   // recognised.
               end



//------------------------------------------------------------------------------
// Enough consecutive pulses received - Link Partner is A/N able.
// 
// Remain in 'pass' states, detecting further pulses until end of current 
// FLP burst.  When no further pulses are detected, the NLP max timer is 
// started and FSM moves to Flp_Check state.
// Full FLP burst should contain 33 link pulses (17 clock, 16 data).
//
// Initial MSB of rx_bit_sr is '1' for use in checking the number of data bits
// that have been received.  When 16 data bits have been received, this bit will
// have become the LSB.  The transition of the LSB from '0' to '1' indicates
// that enough data bits have been received.
//
//------------------------------------------------------------------------------
         
            par_FlpPass:
               begin
                  // Next State
                  state <= par_FlpPass_t; // Timer state - wait for rest of 
                                          // FLP burst to finish.

                  // Outputs
                  // Initialise 'received data bit' shift register.
                  rx_bit_sr <= 17'h10000;
               end
               

            par_FlpPass_t:
               begin
                  if (LINKPULSE == 1'b1)
                     // Next State
                     state <= par_FlpPass;   // FLP burst has been 
                                             // recognised.
                  
                  else
                     if (flp_test_max_timer_done == 1'b1)
                        // Next State
                        state <= par_FlpCheck;  // FLP burst has finished, 
                                                // wait for next one...
                        
                     else
                        // Next State
                        state <= par_FlpPass_t; // Timer state - wait for rest
                                                // of FLP burst to finish.
               end



//------------------------------------------------------------------------------
// Restart the NLP max timer when the next link pulse is received.
// This begins a time frame within which the FLP burst should complete.
// As it is the first link pulse in the FLP burst, it is consdidered to be a
// clock pulse.
//
// (802.3) The number of 'received bits' are checked against a value of 10-17.
// If an equal or greater number of bits have been decoded from the FLP burst
// (see below) then the nlp_test_max timer is restarted (this opens the
// timeframe to include the next (to-be-)received FLP burst).
//
// If the nlp_test_max timer expires, then no further link pulse/FLP burst was
// received, and the FSM returns to Idle state.
//  
//------------------------------------------------------------------------------

            par_FlpCheck:
               // Next State
               state <= par_FlpCheck_t;            // Timer state - wait for  
                                                   // next FLP burst to arrive.


            par_FlpCheck_t:
               begin
                  if (LINKPULSE == 1'b1)
                     // Next State
                     state <= par_FlpCapture;      // FLP burst has arrived, so 
                                                   // decode its link code word.
                  
                  else
                     if (nlp_test_max_timer_done == 1'b1)
                        // Next State
                        state <= par_Idle;         // Idle state.
                        
                     else
                        // Next State
                        state <= par_FlpCheck_t;  // Timer state - wait for next
                                                  // FLP burst to arrive...
               end         
                     
                        
                        
//------------------------------------------------------------------------------
// Start the NLP min timer and zero the 'received data bits' counter.
//------------------------------------------------------------------------------

            par_FlpCapture:
               begin
                  // Next State
                  state <= par_FlpClock;        // First link pulse of FLP burst
                                                // is assumed to be clock pulse.
                 
                  // Outputs
                  rx_bit_sr <= 17'h10000;
               end

         

//------------------------------------------------------------------------------
// The first received link pulse of an FLP burst is considered to be a clock
// pulse.  The Link Code Word data encoded in the FLP burst is decoded as 
// follows:
// - If a link pulse is received after the data_detect_min timer has expired but
// before the data_detect_max timer has expired, then a data '1' has been 
// received.
// - If a link pulse is received after the data_detect_max timer has expired
// then it is considered to be the next clock pulse.  The 'missing' data pulse
// is therefore considered to be a data '0'.
//
// Received data bits are pushed into the rx_bit_sr shift-register at the MSB. 
//
//
// (802.3) After each 'data bit' and clock is detected, the 'received bit 
// counter' is incremented.
//
// Once all the link pulses in the FLP burst have been processed, the RCV_DONE
// flag is enabled and, the FSM waits until the nlp_min timer expires, at which
// point it returns to the Flp_Check state.
//
//------------------------------------------------------------------------------

            par_FlpClock:
               // Next State
               state <= par_FlpClock_t;      // Timer state - wait for data bit.


         
            par_FlpClock_t:
               begin
                  if ((LINKPULSE == 1'b1) & 
                      (data_detect_min_timer_done == 1'b1) &
                      (data_detect_max_timer_done == 1'b0) )
                     // Next State
                     state <= par_FlpData_1;    // Data '1' bit being received.
                     
                  else
                     if ( (LINKPULSE==1'b1) & 
                          (data_detect_max_timer_done==1'b1) )   
                        // Next State
                        state <= par_FlpData_0; // Data '0' bit being received.
                        
                     else
                        if (nlp_test_min_timer_done==1'b1)
                           // Next State
                           state <= par_FlpCheck;  // FLP burst has finished, 
                                                   // wait for next one...
                        
                        else
                           // Next State
                           state <= par_FlpClock_t;   // Timer state - wait for
                                                      // data bit...
               end          
                   
                   
                        
            par_FlpData_0:
               // Data '0' detected.
               begin
                  // Next State
                  state <= par_FlpClock;        // Next link pulse of FLP burst
                                                // should be clock pulse.
                  // Outputs
                  if (rx_bit_sr[0] == 1'b1)
                     // Shift register is full, maintain first 16 bits.
                     rx_bit_sr <= rx_bit_sr;
                 
                  else
                     // Data '0' is shifted into register at MSB.
                     // LSB should be zero until final data pulse is received.
                     rx_bit_sr <= {1'b0,
                                   rx_bit_sr[16:2],
                                   (rx_bit_sr[1] | rx_bit_sr[0]) };
               end
                    

   
            par_FlpData_1:
               // Data '1' detected.
               begin
                  // Next State
                  state <= par_FlpData_1_t;  // Timer state - wait for next link
                                             // pulse (should be clock pulse).
                  
                  // Outputs
       
                  if (rx_bit_sr[0] == 1'b1)
                     // Shift register is full, maintain first 16 bits.
                     rx_bit_sr <= rx_bit_sr;
                  else
                     // Data '1' is shifted into register at MSB.
                     // LSB should be zero until final data pulse is received.
                     rx_bit_sr <= {1'b1,
                                   rx_bit_sr[16:2],
                                   (rx_bit_sr[1] | rx_bit_sr[0]) };
               end
               
               
               
            par_FlpData_1_t:
               begin
                  if ( (LINKPULSE==1'b1) & 
                       (nlp_test_min_timer_done==1'b0) &
                       (data_detect_min_timer_done==1'b1) )
                     // Next State
                     state <= par_FlpClock;      // Next link pulse of FLP burst
                                                 // should be clock pulse.
                  else
                     if (nlp_test_min_timer_done == 1'b1)
                        // Next State
                        state <= par_FlpCheck;   // FLP burst has finished,
                                                 // wait for next one...
                     else
                        // Next State
                        state <= par_FlpData_1_t;  // Timer state - wait for 
                                                   // next link pulse (should be
                                                   // clock pulse).
               end


//------------------------------------------------------------------------------
// Default State - return to Idle state
//------------------------------------------------------------------------------

            default: 
               // Next State
               state <= par_Idle;      // Idle state.

            endcase
         
         end

   else
      begin
      state     <= state;
      flp_cnt   <= flp_cnt;
      rx_bit_sr <= rx_bit_sr;
      end

end   // p_receive_fsm






//------------------------------------------------------------------------------
// Data detect and FLP Timer Control.
// Same signal is used for both timers.
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge RESET)
begin: p_data_flp_timers

   if (RESET == 1'b1)
      // Reset timer.
      data_detect_flp_test_timer <= 12'd0;
      
   else if (clk12_5_enable)
      begin
         // Reset timer
         if ((state==par_Idle) |    
             (state==par_LinkPulseDetect) |     // for flp_test_min/max_timer
             (state==par_FlpPass) |             // for flp_test_max_timer
             (state==par_FlpClock) |            // for data_detect_min/max_timer
             (state==par_FlpData_1) )           // for data_detect_min_timer
            // Initialize timer
            data_detect_flp_test_timer <= 12'd0;
 
         else
            // Increment if FLP and Data Test timers have not yet expired.
            if ( !(((data_detect_min_timer_done==1'b1) &
                    (data_detect_max_timer_done==1'b1) ) &
                  ( (flp_test_min_timer_done==1'b1) &
                    (flp_test_max_timer_done==1'b1) )))
               // Increment timer
               data_detect_flp_test_timer <= data_detect_flp_test_timer + 12'd1;

            else
               // Maintain timer at present value.
               data_detect_flp_test_timer <= data_detect_flp_test_timer;
      
      end

   else
      data_detect_flp_test_timer <= data_detect_flp_test_timer;

end   // p_data_flp_timers

      
      
//------------------------------------------------------------------------------
// NLP Timers are handled separately because of their size difference.
//
//------------------------------------------------------------------------------
// 'NLP Min' Timer Control
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge RESET)
begin: p_nlp_min_timer
   
   if (RESET == 1'b1)
      // Reset timer.
      nlp_test_min_timer <= 17'd0;
      
   else if (clk12_5_enable)
      begin
      
         // Min Time
         if (state == par_FlpCapture)
            // Reset timer.
            nlp_test_min_timer <= 17'd0;
 
         else
            // Increment timer, if not already expired and not in
            // idle, detect or count state.
            if ( (nlp_test_min_timer_done == 1'b0) &
                 (flp_cnt >= par_Flp_Cnt_Done) )    
               // Increment timer.
               nlp_test_min_timer <= nlp_test_min_timer + 17'd1;

            else
               // Maintain timer at present value.
               nlp_test_min_timer <= nlp_test_min_timer;
      
      end

   else
      nlp_test_min_timer <= nlp_test_min_timer;
  
end   //p_nlp_min_timer
   
   
         
//------------------------------------------------------------------------------
// 'NLP Max' Timer Control
//------------------------------------------------------------------------------
always @( posedge CLKPLL_IN or posedge RESET)
begin: p_nlp_max_timer   

   if (RESET == 1'b1)
      // Reset timer.
      nlp_test_max_timer <= 21'd0;
      
   else if (clk12_5_enable)
      begin
      
         // Start/restart timer if in Flp_Pass state, or in Flp_Check state when
         // 10 or more received data bits have been decoded.
         if ( (state==par_FlpPass) |
              ((state==par_FlpCheck) & (rx_bit_sr[6:0] != 7'd0)) )
            // Initialize timer.
            nlp_test_max_timer <= 21'd0;
 
         else

            // Increment timer, if not already expired and not in
            // idle, detect or count state.
            if ( (nlp_test_max_timer_done == 1'b0) &
                 (flp_cnt >= par_Flp_Cnt_Done) )    
               // Increment timer.
               nlp_test_max_timer <= nlp_test_max_timer + 21'd1;

            else
               // Maintain timer at present value.
               nlp_test_max_timer <= nlp_test_max_timer;
      end
   else
      nlp_test_max_timer <= nlp_test_max_timer;
  
end   // p_nlp_max_timer
         


//------------------------------------------------------------------------------
// RECEIVE_ENABLE_DLY: "add a register to mask glitches on RECEIVE_ENABLE" 
// (see log).
// 
// Only used for internal reset (which resets FSM)!
//
//------------------------------------------------------------------------------
always @ (posedge CLKPLL_IN or posedge RESET) 
begin: p_receive_enable_dly

   if(RESET) 
      RECEIVE_ENABLE_DLY <= 1'b0;
      
   else if (clk12_5_enable)
      RECEIVE_ENABLE_DLY <= RECEIVE_ENABLE;

   else
      RECEIVE_ENABLE_DLY <= RECEIVE_ENABLE_DLY;

end   // p_receive_enable_dly


 


//------------------------------------------------------------------------------
// flp_receive_idle:
//
// flp_receive_idle is set if 'dig_an_receive' (Receive FSM) is in either IDLE, 
// LINK PULSE DETECT or LINK PULSE COUNT state; i.e. if the device is waiting to
// identify an FLP burst.
//
//------------------------------------------------------------------------------
always @(state)
begin: p_flp_receive_idle

   if ( (state == par_Idle) | 
        (state == par_LinkPulseDetect) |
        (state == par_LinkPulseDetect_t) |     
        (state == par_LinkPulseCount) |
        (state == par_LinkPulseCount_t) )
      // FLP_RECEIVE IDLE is true.
      FLP_RECEIVE_IDLE = 1'b1;
      
   else
      // FLP_RECEIVE IDLE is false.
      FLP_RECEIVE_IDLE = 1'b0;

end   // p_flp_receive_idle    




//------------------------------------------------------------------------------
// Timeout:
//
// If no link pulses are received after the initial 'advertise' burst and before
// the nlp_max timer expires, TIMEOUT is flagged. 
// It will remain set until another FLP is recognised (Flp_Pass state), causing
// the timer to be reset.  N.B. This means it will often be set during Idle 
// state (should NOT ALWAYS be reset in Idle state).
//
//------------------------------------------------------------------------------
always @(nlp_test_max_timer_done or RESET)
begin: p_timeout

   if (RESET == 1'b1)
      TIMEOUT = 1'b0;
    
   else
      if (nlp_test_max_timer_done == 1'b1)
         TIMEOUT = 1'b1;
         
      else
         TIMEOUT = 1'b0;

end   //p_TIMEOUT



//------------------------------------------------------------------------------
endmodule   // dig_an_receive

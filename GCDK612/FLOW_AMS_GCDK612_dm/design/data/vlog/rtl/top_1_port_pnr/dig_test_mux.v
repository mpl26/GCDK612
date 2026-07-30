// Created by ihdl
module dig_test_mux ( 

            // Inputs
            
            // from dig_an_arbitration.v
            arb_intl_bus,
            MR_AN_NP_LCW_TOGGLE,
            MR_AUTONEG_COMPLETE,
            MR_BASE_PAGE,
            MR_PARALLEL_DETECTION_FAULT,
            TX_ACK_BIT,
             
            
            // from dig_an_transmit.v
            TD_AUTONEG,
            ACK_FINISHED,
            
            // from dig_an_receive.v
            FLP_RECEIVE_IDLE,
            RCV_DONE,
            TIMEOUT,

            // from dig_an_linktest.v
            LINK_STATUS,
            
            // from dig_an_txrx10.v
            LINKPULSE,
            
            //from dig_regs.v
            MR_TEST_MODE,
            MR_NO_COMMON_MODE,
            MR_DUPLEX_MODE,
            
            // from top_digital.v
            LINK10_DOWN,
            LINK100_DOWN,
            
            // from top_dig_led_out.v
            LEDS_OUT_topdig,
            LEDT_VREF_OUT_topdig,
            LEDR_LEDA_OUT_topdig,
            LEDD_OUT_topdig,
            
            // from dig_test.v
            LEDL_OUT_topdig,
            LEDC_OUT_topdig,

            // for RESET_DSP test mux (from dsp blocks)
            MSE_GOOD,
            RESET_DSP,

            // squelch outputs
            RX10_PRESENT,
            POS_LINK_PULSE,
            NEG_LINK_PULSE,

            // polarity check output
            MR_POL_REVERSED,

            // Manchester decode signals
            DEC10_RCLK_GOOD,
            NEW_EDGE,
            SLICER_MUX,
            DEC10_RCLK10,
            DEC10_DATA,
 
            FE_FAULT,
            
            // from dig_clk.v
            clk12_5_enable,


            // Outputs (to top_digital.v)
            LEDS_OUT,
            LEDT_VREF_OUT,
            LEDR_LEDA_OUT,
            LEDD_OUT,
            LEDL_OUT,
            LEDC_OUT
            );


// I/O Declarations
// Inputs
input [7:0]    arb_intl_bus;                 // Mux/Debug bus of internal
                                             // dig_an_arbitration signals.
input          MR_AN_NP_LCW_TOGGLE;          // NEXT PAGE link code word toggle 
                                             // bit value.
input          MR_AUTONEG_COMPLETE;          // Flag set to indicate that A/N is
                                             // complete.
input          MR_BASE_PAGE;                 // Flag set if the LCW currently
                                             // being transmitted by Local
                                             // Device is a Base Page LCW.
input          MR_PARALLEL_DETECTION_FAULT;  // Flag set if none or more than 1
                                             // potential Link Partner reported
                                             // READY when 'autoneg_wait_timer'
                                             // expires.
input          RCV_DONE;                     // Flag indicating that an FLP has
                                             // been successfully received.
input          TX_ACK_BIT;                   // ACK bit of next LCW to be 
                                             // transmitted. 
input          FLP_RECEIVE_IDLE;             // Set while system waits for/tries
                                             // to recognise an FLP burst.
input          TIMEOUT;                      // Set if FLP burst does not arrive
                                             // within given time frame.
input          ACK_FINISHED;                 // Flag indicating final 
                                             // remaining_ack_cnt LCWs with ACK
                                             // bit set have been transmitted
                                             // (6 transmitted).
input          TD_AUTONEG;                   // Signal to MDI to transmit a 
                                             // (Link Integrity Test) pulse.
input          LINK_STATUS;                  // Set if Link is good.
input          LINKPULSE;                    // Strobe indicating that a valid
                                             // link pulse has been received.
input [14:0]   MR_TEST_MODE;                 // Test mode selector.
input          clk12_5_enable;               // 12.5MHz clock for A/N.

input          MR_NO_COMMON_MODE;            // Devices advertise no common
                                             // abilities.
input          MR_DUPLEX_MODE;               // Duplex mode (full=1, half=0).
                                             
// Link Status inputs from top_digital.v:
input          LINK10_DOWN;                  // 10Mbps Link status (down/up).
input          LINK100_DOWN;                 // 100Mbps Link status (down/up).

// LED Inputs from top_dig_led_OUT.v:
input          LEDS_OUT_topdig;              // Speed LED signal.
input          LEDT_VREF_OUT_topdig;         // Transmitter LED signal. 
input          LEDR_LEDA_OUT_topdig;         // Receiver LED signal. 
input          LEDD_OUT_topdig;              // Duplex LED signal. 

// LED Inputs from dig_test.v:
input          LEDL_OUT_topdig;              // Link LED signal.
input          LEDC_OUT_topdig;              // Collision LED signal. 

// LED inputs for RESET_DSP mux out   
input          RESET_DSP;                    // DSP reset
input          MSE_GOOD;                     // mean square error acceptable

// LED inputs for squelch and polarity
input          RX10_PRESENT;                 // A data signal is being received
input          POS_LINK_PULSE;               // At least one positive pulse received
input          NEG_LINK_PULSE;               // At least one negative pulse received
input          MR_POL_REVERSED;              // Reverse incoming polarity from RX channel

// LED input for Manchester decoder
input          DEC10_RCLK_GOOD;            // A vaild 10MHz Clock
input          NEW_EDGE;                     // Output from dig_rx10_manch_dec_edge module
input          SLICER_MUX;                   // Output from dig_slicer_mux module
input          DEC10_RCLK10;                 // Recovered clock
input          DEC10_DATA;                   // Recovered data

// LED input for fef detection
input          FE_FAULT;                     // far end fault detected
 
// Outputs (LED signals to top_digital.v):
output         LEDS_OUT;                     // Speed LED signal.
output         LEDT_VREF_OUT;                // Transmitter LED signal.
output         LEDR_LEDA_OUT;                // Receiver LED signal.
output         LEDD_OUT;                     // Duplex LED signal.
output         LEDL_OUT;                     // Link LED signal.
output         LEDC_OUT;                     // Collision LED signal.





// I/O Definitions
// Inputs
wire  [7:0]    arb_intl_bus;                 // Mux/Debug bus of internal
                                             // dig_an_arbitration signals.
wire           MR_AN_NP_LCW_TOGGLE;          // NEXT PAGE link code word toggle 
                                             // bit value.
wire           MR_AUTONEG_COMPLETE;          // Flag set to indicate that A/N is
                                             // complete.
wire           MR_BASE_PAGE;                 // Flag set if the LCW currently
                                             // being transmitted by Local
                                             // Device is a Base Page LCW.
wire           MR_PARALLEL_DETECTION_FAULT;  // Flag set if none or more than 1
                                             // potential Link Partner reported
                                             // READY when 'autoneg_wait_timer'
                                             // expires.
wire           RCV_DONE;                     // Flag indicating that an FLP has
                                             // been successfully received.
wire           TX_ACK_BIT;                   // ACK bit of next LCW to be
                                             // transmitted.
wire           FLP_RECEIVE_IDLE;             // Set while system waits for/tries
                                             // to recognise an FLP burst.
wire           TIMEOUT;                      // Set if FLP burst does not arrive
                                             // within given time frame.
wire           ACK_FINISHED;                 // Flag indicating final 
                                             // remaining_ack_cnt LCWs with ACK
                                             // bit set have been transmitted
                                             // (6 transmitted).
wire           TD_AUTONEG;                   // Signal to MDI to transmit a 
                                             // (Link Integrity Test) pulse.
wire           LINK_STATUS;                  // Set if Link is good.
wire           LINKPULSE;                    // Strobe indicating that a valid
                                             // link pulse has been received.

wire  [14:0]   MR_TEST_MODE;                 // Test mode selector.
wire           clk12_5_enable;               // 12.5MHz clock for A/N.

wire           MR_NO_COMMON_MODE;            // Devices advertise no common
                                             // abilities.
wire           MR_DUPLEX_MODE;               // Duplex mode (full=1, half=0).

wire           LINK10_DOWN;                  // 10Mbps Link status (down/up).
wire           LINK100_DOWN;                 // 100Mbps Link status (down/up).

wire           LEDS_OUT_topdig;              // Speed LED signal.
wire           LEDT_VREF_OUT_topdig;         // Transmitter LED signal. 
wire           LEDR_LEDA_OUT_topdig;         // Receiver LED signal. 
wire           LEDD_OUT_topdig;              // Duplex LED signal. 
wire           LEDL_OUT_topdig;              // Link LED signal.
wire           LEDC_OUT_topdig;              // Collision LED signal. 

// Outputs
reg            LEDS_OUT;                     // Speed LED signal.
reg            LEDT_VREF_OUT;                // Transmitter LED signal.
reg            LEDR_LEDA_OUT;                // Receiver LED signal.
reg            LEDD_OUT;                     // Duplex LED signal.
reg            LEDL_OUT;                     // Link LED signal.
reg            LEDC_OUT;                     // Collision LED signal.

//------------------------------------------------------------------------------
// Main Unit Code
// Mux to route signals, controlled by MR_TEST_MUX.
//------------------------------------------------------------------------------
always @( MR_TEST_MODE or arb_intl_bus or MR_AN_NP_LCW_TOGGLE or 
          MR_AUTONEG_COMPLETE or MR_BASE_PAGE or MR_PARALLEL_DETECTION_FAULT or
          TX_ACK_BIT or LINK_STATUS or ACK_FINISHED or TD_AUTONEG or 
          FLP_RECEIVE_IDLE or TIMEOUT or LINKPULSE or clk12_5_enable or
          MR_NO_COMMON_MODE or MR_DUPLEX_MODE or LINK10_DOWN or LINK100_DOWN or 
          LEDS_OUT_topdig or LEDT_VREF_OUT_topdig or LEDR_LEDA_OUT_topdig or 
          LEDD_OUT_topdig or LEDL_OUT_topdig or LEDC_OUT_topdig or MSE_GOOD 
          or RESET_DSP or RCV_DONE or RX10_PRESENT or POS_LINK_PULSE or 
          NEG_LINK_PULSE or MR_POL_REVERSED or DEC10_RCLK_GOOD or NEW_EDGE or
          SLICER_MUX or DEC10_RCLK10 or DEC10_DATA or FE_FAULT)
         

   begin: p_mux_debug
   
      case (MR_TEST_MODE)
         
      15'd1: begin
               // Test Mode 1: Arbitration state signal.
               LEDS_OUT      = clk12_5_enable;  // 12.5MHz clock from dig_clk.v
               LEDT_VREF_OUT = arb_intl_bus[4]; // state[4].
               LEDR_LEDA_OUT = arb_intl_bus[3]; // state[3].
               LEDD_OUT      = arb_intl_bus[2]; // state[2].
               LEDL_OUT      = arb_intl_bus[1]; // state[1].
               LEDC_OUT      = arb_intl_bus[0]; // state[0].
            end
               
      15'd2: begin
               // Test Mode 2
               LEDS_OUT      =  clk12_5_enable;
               LEDT_VREF_OUT =  TD_AUTONEG;
               LEDR_LEDA_OUT =  LINKPULSE;
               LEDD_OUT      =  RCV_DONE; 
               LEDL_OUT      =  arb_intl_bus[7]; // mr_np_loaded
               LEDC_OUT      =  TX_ACK_BIT;
            end
               
      15'd3: begin
               // Test Mode 3
               LEDS_OUT      =  clk12_5_enable;
               LEDT_VREF_OUT =  TD_AUTONEG;
               LEDR_LEDA_OUT =  LINKPULSE;
               LEDD_OUT      =  MR_BASE_PAGE;
               LEDL_OUT      =  TIMEOUT;
               LEDC_OUT      =  MR_PARALLEL_DETECTION_FAULT; 
             end
               
      15'd4: begin
               // Test Mode 4
               LEDS_OUT      =  clk12_5_enable;
               LEDT_VREF_OUT =  TD_AUTONEG;
               LEDR_LEDA_OUT =  LINKPULSE;
               LEDD_OUT      =  arb_intl_bus[5]; // single_link_ready
               LEDL_OUT      =  LINK_STATUS;
               LEDC_OUT      =  LEDC_OUT_topdig;
            end
               
      15'd5: begin
               // Test Mode 5
               LEDS_OUT      =  clk12_5_enable;
               LEDT_VREF_OUT =  TD_AUTONEG;
               LEDR_LEDA_OUT =  LINKPULSE;
               LEDD_OUT      =  RCV_DONE; 
               LEDL_OUT      =  arb_intl_bus[6]; // rx_toggle;
               LEDC_OUT      =  MR_AN_NP_LCW_TOGGLE;
            end
               
      15'd6: begin
               // Test Mode 6
               LEDS_OUT      =  clk12_5_enable;
               LEDT_VREF_OUT =  TD_AUTONEG;
               LEDR_LEDA_OUT =  LINKPULSE;
               LEDD_OUT      =  MR_BASE_PAGE;
               LEDL_OUT      =  ACK_FINISHED;
               LEDC_OUT      =  FLP_RECEIVE_IDLE;
            end
               
      15'd7: begin
               // Test Mode 7
               LEDS_OUT      =  clk12_5_enable;
               LEDT_VREF_OUT =  MR_DUPLEX_MODE; 
               LEDR_LEDA_OUT =  MR_NO_COMMON_MODE; 
               LEDD_OUT      =  MR_AUTONEG_COMPLETE;
               LEDL_OUT      =  LINK100_DOWN;   
               LEDC_OUT      =  LINK10_DOWN;
            end

      15'd8: begin
               // Test Mode bit 15 set
               LEDS_OUT      =  MSE_GOOD;
               LEDT_VREF_OUT =  LEDT_VREF_OUT_topdig;
               LEDR_LEDA_OUT =  LEDR_LEDA_OUT_topdig;
               LEDD_OUT      =  RESET_DSP;
               LEDL_OUT      =  LEDL_OUT_topdig;
               LEDC_OUT      =  LEDC_OUT_topdig;
            end

      15'd9: begin
               // Test Mode bit 15 set
               LEDS_OUT      =  RX10_PRESENT;
               LEDT_VREF_OUT =  POS_LINK_PULSE;
               LEDR_LEDA_OUT =  NEG_LINK_PULSE;
               LEDD_OUT      =  MR_POL_REVERSED;
               LEDL_OUT      =  LEDL_OUT_topdig;
               LEDC_OUT      =  LEDC_OUT_topdig;
            end
      15'd10: begin
               // Test Mode bit 15 set
               LEDS_OUT      =  DEC10_RCLK_GOOD;
               LEDT_VREF_OUT =  NEW_EDGE;
               LEDR_LEDA_OUT =  SLICER_MUX;
               LEDD_OUT      =  DEC10_RCLK10;
               LEDL_OUT      =  DEC10_DATA;
               LEDC_OUT      =  FE_FAULT;
            end


 
      default: 
            begin
               // Default Test Mode (0) - Test mux disabled.
               // Original LED signals are routed to chip_level.
               LEDS_OUT      =  LEDS_OUT_topdig;    
               LEDT_VREF_OUT =  LEDT_VREF_OUT_topdig;
               LEDR_LEDA_OUT =  LEDR_LEDA_OUT_topdig;
               LEDD_OUT      =  LEDD_OUT_topdig;    
               LEDL_OUT      =  LEDL_OUT_topdig;
               LEDC_OUT      =  LEDC_OUT_topdig;
            end
               
      
      endcase  // MR_TEST_MODE

   
   end   // p_mux_debug
          


//------------------------------------------------------------------------------
endmodule   // dig_test_mux

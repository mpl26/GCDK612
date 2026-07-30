// Created by ihdl
module dig_rxtx100_linkmonitor(
                               //Inputs
                               CLKPLL_IN,
                               txc25_enable,
                               RESET,
                               RESET_DSP25,
                               MR_100MBS,
                               MSE_GOOD,
                               MR_DIG_LOOP_BACK_ENAB,
                               MR_MII100_LOOP_BACK_ENAB,
                               MR_RXTX_TEST,
                               LOCKED2IDLES,
                               L100_LINK_CONTROL,
                               FE_FAULT,

                               //Outputs
                               L100_LINK_STATUS,
                               LINK100_DOWN,
                               RCLK25_GOOD,
                               RX100_STABLE
                               );

//
// I/O Declarations
//
input          CLKPLL_IN;                // System clock 125MHz or 160MHz
input          txc25_enable;             // 25MHz clock enable
input          RESET;                    // System reset
input          RESET_DSP25;              //
input          MR_100MBS;                // 100 MB/s mode
input          MSE_GOOD;                 // MSE above threshold - good clock
input          MR_DIG_LOOP_BACK_ENAB;    // Digital Loopback
input          MR_MII100_LOOP_BACK_ENAB; // MII Loopback
input          MR_RXTX_TEST;             // Set LINK100_DOWN to 0
input          LOCKED2IDLES;             // Descrambler Locked to idles
input          FE_FAULT;                 // FEF detector input from fef_det
input   [1:0]  L100_LINK_CONTROL;        // From A/N

output  [1:0]  L100_LINK_STATUS;         // To A/N
output         LINK100_DOWN;             // 100 MB/s link is down
output         RCLK25_GOOD;              // 100 MB/s link is up
output         RX100_STABLE;             // RX channel is stable 

//
// I/O Type Declarations
//
wire           CLKPLL_IN;
wire           txc25_enable;
wire           RESET;                   
wire           MR_100MBS;               
wire           MSE_GOOD;                
wire           MR_DIG_LOOP_BACK_ENAB;   
wire           MR_MII100_LOOP_BACK_ENAB;
wire           MR_RXTX_TEST;            
wire           LOCKED2IDLES;            
wire           FE_FAULT;                
wire    [1:0]  L100_LINK_CONTROL;       

reg     [1:0]  L100_LINK_STATUS;
reg            LINK100_DOWN;
reg            RCLK25_GOOD;
reg            RX100_STABLE;

//
// Internal Signal Declarations
//
wire           stabilize_timer_done;
wire           linkfail;
wire           signal_status;
reg            mse_is_stable;
reg     [1:0]  mse_is_good;
reg     [15:0] stabilize_timer;
reg     [2:0]  state;
reg     [1:0]  sync_LOCKED2IDLES;
reg     [2:0]  dig_loopback;       // 2 -> turn off LINK100_DOWN
                                   // 1 -> set RX100_STABLE
                                   // 0 -> asynchronous interface
reg            sync1_RESET_DSP25;  // meta stables for RESET_DSP25
reg            sync2_RESET_DSP25;  // meta stables for RESET_DSP25

//
// Parameter Declarations
//
// timer defs
`define Stabilize_Timer_Min  16'h203A		// 330us = 8250 * 40ns
`define Stabilize_Timer_Max  16'h61A8		// 1ms = 25000 * 40ns

`ifdef SPEEDUP
  `define Stabilize_Timer_Use  16'd12		// 480ns for fast test
`else 
  `define Stabilize_Timer_Use  16'h203A		// 330us
`endif

initial #115 $display("Stabilize Timer in Use = ",`Stabilize_Timer_Use);

// Link Control encodings
`define LC_Disable            2'b00	
`define LC_Scan_For_Carrier   2'b01
`define LC_Enable             2'b11

// Link Status encodings
`define LS_Fail               2'b00
`define LS_Ready              2'b01
`define LS_OK                 2'b11

// define link monitor states
`define	linkdown   3'b000  // LINK DOWN State
`define	hysteresis 3'b010  // Hysteresis State
`define	linkcheck  3'b110  // Added for A/N
`define	linkready  3'b011  // LINK READY State
`define	linkup     3'b001  // LINK UP State

// Signal Status Values
`define	OFF  1'b0   // Off = low signal 
`define	ON   1'b1   // On  = high signal

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   // linkfail causes the link_status signal to be DISABLEd when set high.
   // This occurs when:
   //    signal_status == 'OFF (MSE_GOOD=0, channel is bad).
   //    L100_LINK_CONTROL == `LC_DISABLE (device disables link itself)
   //    FE_FAULT == 1 (Far End Fault occurred...'0' if Auto-Neg enabled)
   //
   assign linkfail = (signal_status == `OFF) | 
                     (L100_LINK_CONTROL == `LC_Disable) | 
                     FE_FAULT;
                                          
   assign stabilize_timer_done = (stabilize_timer >= `Stabilize_Timer_Use);

//------------------------------------------------------------------------------
// This process syncronises the LOCKED2IDLES with the TXC2
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_sync_LOCKED2IDLES
      if (RESET)
         sync_LOCKED2IDLES <= 2'b00;
      else if (txc25_enable)
         sync_LOCKED2IDLES <= {sync_LOCKED2IDLES[0],LOCKED2IDLES};
      else
         sync_LOCKED2IDLES <= sync_LOCKED2IDLES;
      end // p_sync_LOCKED2IDLES

//------------------------------------------------------------------------------
// This process syncronises the MSE_GOOD with the TXC25
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_mse_is_good
      if (RESET) 
         mse_is_good <= 2'b00;
      else if (txc25_enable & !MR_100MBS) 
         mse_is_good <= 2'b00;
      else if (txc25_enable)
         mse_is_good <= {mse_is_good[0], MSE_GOOD};
      else
         mse_is_good <= mse_is_good;
      end // p_mse_is_good

   assign signal_status = mse_is_good[1];

//------------------------------------------------------------------------------
// This process syncronises the MR_DIG_LOOP_BACK_ENAB with the TXC25
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_dig_loopback
      if (RESET)
         dig_loopback <= 3'b0;
      else if (txc25_enable & !MR_100MBS)
         dig_loopback <= 3'b0;
      else if (txc25_enable)
         dig_loopback <= {dig_loopback[1:0],MR_DIG_LOOP_BACK_ENAB};
      else
         dig_loopback <= dig_loopback;
      end // p_dig_loopback

//------------------------------------------------------------------------------
// If MR_RXTX_TEST is set to 1 then bring the link up independent of its actual
// status else if MR_MII_LOOP_BACK_ENAB then we are disconnected from the link
// and the transmitted data is looped back directly to the MII RX lines
// therefore, set LINK_DOWN to 1 to shut down unneccessary receive channel
// operation else If MR_DIG_LOOP_BACK_ENAB then set the LINK_DOWN variable to 0
// to activate the receive channel else	temporarily bring link100_down if 
// changing to loopback mode check L100_LINK_STATUS
//
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_LINK100_DOWN
      if (RESET)
         LINK100_DOWN <= 1'b1;
      else if (txc25_enable & (!MR_100MBS || MR_MII100_LOOP_BACK_ENAB))
         LINK100_DOWN <= 1'b1;
      else if (txc25_enable & (MR_RXTX_TEST || dig_loopback[1]))
         LINK100_DOWN <= 1'b0;
      else if (txc25_enable)
         LINK100_DOWN <= !(L100_LINK_STATUS == `LS_OK);
      else
         LINK100_DOWN <= LINK100_DOWN;
      end // p_LINK100_DOWN

//------------------------------------------------------------------------------
// This process is similar to link100_down except that it is stable when
// mse_good has been up for 330us  
//------------------------------------------------------------------------------
//

   // Syncronise the DSP reset to the CLKPLL_IN domain before using
   // in the logic
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_sync_reset_dsp
      if (RESET)
         begin
         sync1_RESET_DSP25 <= 2'b1;
         sync2_RESET_DSP25 <= 2'b1;
         end
      else
         begin
         sync1_RESET_DSP25 <= RESET_DSP25;
         sync2_RESET_DSP25 <= sync1_RESET_DSP25;
         end
      end // p_sync_reset_dsp

   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_RX100_STABLE
      if (RESET)
         RX100_STABLE <= 1'b0;
      else if (txc25_enable & (!MR_100MBS || MR_MII100_LOOP_BACK_ENAB))
         RX100_STABLE <= 1'b0;
      else if (txc25_enable & ((MR_RXTX_TEST & !sync2_RESET_DSP25) ||
               dig_loopback[1]))
         RX100_STABLE <= 1'b1;
      else if (txc25_enable)
         RX100_STABLE <= mse_is_stable;
      else
         RX100_STABLE <= RX100_STABLE;
      end // p_RX100_STABLE

//------------------------------------------------------------------------------
// If MR_MII_LOOP_BACK_ENAB then the TXC25 clock needs to be used in the 
// RXC25 line, therefore, set RCLK25_GOOD to not good.                   
// else									 
// If MR_DIG_LOOP_BACK_ENAB then the transmission 125clk is used as the  
// receive path clock, therefore, set RCLK25_GOOD to good.               
// else									 
// allow the DSP to set the Link up before setting RCLK25_GOOD           
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_RCLK25_GOOD
      if (RESET)
         RCLK25_GOOD <= 1'b0;
      else if (txc25_enable & (!MR_100MBS || MR_MII100_LOOP_BACK_ENAB))
         RCLK25_GOOD <= 1'b0;
      else if (txc25_enable & dig_loopback[2])
         RCLK25_GOOD <= 1'b1;
      else if (txc25_enable)
         RCLK25_GOOD <= !LINK100_DOWN;
      else
         RCLK25_GOOD <= RCLK25_GOOD;
      end // p_RCLK25_GOOD

//------------------------------------------------------------------------------
// This process is the stabilizer timer
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_stabilize_timer
      if (RESET)
         stabilize_timer <= 16'b0;
      else if (txc25_enable & (state == `hysteresis))
         stabilize_timer <= stabilize_timer + 16'b1;
      else if (txc25_enable)
         stabilize_timer <= 16'b0;
      else
         stabilize_timer <= stabilize_timer;
      end // p_stabilize_timer

//------------------------------------------------------------------------------
// This process forms the Link Monitor State machine
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_link_sm
      if (RESET)
         begin
         state            <= `linkdown;
         L100_LINK_STATUS <= `LS_Fail; 
         mse_is_stable    <= 1'b0;
         end
      else if (txc25_enable)
         case (state)
            `linkdown: begin
                       if (signal_status==`ON)
                          state <= `hysteresis;
                       else
                          state <= `linkdown;
                       L100_LINK_STATUS <= `LS_Fail;
                       mse_is_stable    <= 1'b0;
                       end

            `hysteresis: begin
                         if (linkfail)
                            state <= `linkdown;
                         else if (stabilize_timer_done)
                            state <= `linkcheck;
                         else
                            state <= `hysteresis;
                         end

            // linkcheck is not part of the IEEE state diagram      
            // however, it is added to allow the rx path to analyze 
            // the receive data to check for idle's.                
            // If idle's are found then the link is set to ready    
            // for A/N to complete with parallel detection of 100TX 
            `linkcheck: begin
                        if (linkfail)
                           state <= `linkdown;
                        else if (sync_LOCKED2IDLES[1])
                           state <= `linkready;
                        else
                           state <= `linkcheck;
                        mse_is_stable <= 1'b1;
                        end

            `linkready: begin
                        if (linkfail)
                           state <= `linkdown;
                        else if (L100_LINK_CONTROL==`LC_Enable)
                           state <= `linkup;
                        else
                           state <= `linkready;
                        L100_LINK_STATUS <= `LS_Ready;
                        end

            `linkup: begin
                     if (linkfail)
                        state <= `linkdown;
                     else if (L100_LINK_CONTROL==`LC_Scan_For_Carrier)
                        state <= `linkdown;
                     else
                        state <= `linkup;
                     L100_LINK_STATUS <= `LS_OK;
                     end

            default: begin
                     state            <= `linkdown;
                     L100_LINK_STATUS <= `LS_Fail; 
                     mse_is_stable    <= 1'b0;
                     end
         endcase
      else
         begin
         state            <= state;
         L100_LINK_STATUS <= L100_LINK_STATUS; 
         mse_is_stable    <= mse_is_stable;
         end
      end // p_link_sm


//------------------------------------------------------------------------------
endmodule

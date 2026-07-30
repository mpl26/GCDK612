// Created by ihdl
`timescale 1 ns / 1 ps

module dig_clk (
                //Inputs
                RX10_RCLK2_5,
                MR_100MBS,
                CLKXTAL,
                RCLK2_5_GOOD,
                X_125,
                X_160,
                RX100_RCLK25,
                RCLK25_GOOD,
                AN_ACTIVE_XTND,
                RESET,
                RPD_10_DISB,
                RPD_100_DISB,
                RESETREG,
                RESETPLL,
                CLKPLL_IN,
                LINK10_DOWN,
                LINK100_DOWN,
                MR_AN_ENAB,

                //Outputs
                CLKPLL_SC,
                clk160_enable,
                clk160n_enable,
                clk12_5_enable,
                clk10_enable,
                clk10n_enable,
                RCLK2_5_SC,
                RXC_SC,
                clk125_enable,
                clk125_disb,
                CLKFAST_SC,
                clkfast_enable,
                clkfastd8_enable,
                clkfastd8_gate,
                TXC_O_SC,
                TXC25_SC,
                txc25_enable,
                txc25n_enable,
                TXC25_ALIGN,
                txc2_5_enable,
                txc2_5n_enable,
                CLK2_5_NO_FF,
                MR_PLL_LOCKED,
                XOFF_20, 
                BASE10_DIS,
                BASE100TX_DIS,
                BASE100TX_DIS_ER
                );

input       RX10_RCLK2_5;          // Recovered 2.5 MHz nibble clk from 10Base-T
input       MR_100MBS;             // Indicates 100 Mb/s operation
input       CLKXTAL;               // On-board crystal output (25 MHz)
input       RCLK2_5_GOOD;          // indicates 2.5 MHz recovered clock is locked
input       X_125;                 // 125 MHz PLL output
input       X_160;                 // 160 MHz PLL output
input       RX100_RCLK25;          // Recovered 25MHz clk from 100Base-X rx
input       RCLK25_GOOD;           // Indicates RX100_RCLK25 is locked
input       AN_ACTIVE_XTND;        // A/N process runs until MR_AN_COMPLETE set
input       RESET;                 // RESET input from dig_reset block
input       RPD_10_DISB;           // Operational mode signal from dig_reset
input       RPD_100_DISB;          // Operational mode signal from dig_reset
input       RESETREG;              // RESETREG signal from dig_reset block
input       RESETPLL;              // RESETPLL signal from dig_reset block
input       CLKPLL_IN;             // Combined PLL input (separated for 
                                   // synthesis) Driven from the CLKPLL_SC 
                                   // output in the block
input       LINK10_DOWN;           // 10 Mb link is down
input       LINK100_DOWN;          // 100 Mb link is down
input       MR_AN_ENAB;            // AN is enabled

output      CLKPLL_SC;             // Combined PLL output (125 MHz or 160 MHz)
output      clk160_enable;         // 160MHz clock enable
output      clk160n_enable;        // Negedge 160MHz clock enable
output      clk12_5_enable;        // 12.5MHz clock enable
output      clk10_enable;          // 10MHz clock enable
output      clk10n_enable;         // Inverted 10MHz clock enable
output      RCLK2_5_SC;            // Continuous 2.5MHz recovered clk for 10B-T
output      RXC_SC;                // Continuous recovered clock
output      clk125_enable;         // 125MHz clock enable
output      clk125_disb;           // 125MHz clock disable
output      CLKFAST_SC;            // 125 or 160MHz clk for analog TX filter
output      clkfast_enable;        // 125MHz or 160MHz clock enable
output      clkfastd8_enable;      // 125MHz or 160MHz div 8 clock enable
output      clkfastd8_gate;        // Gating signal for CLKFAST_SC div 8
output      TXC_O_SC;              // 25 or 2.5MHz Tx clock
output      TXC25_SC;              // 25MHz tx clock (125 MHz div 5)
output      txc25_enable;          // 25MHz clock enable
output      txc25n_enable;         // Inverted 25MHz clock enable
output      TXC25_ALIGN;           // Alignment signal for tx100_serializer
output      txc2_5_enable;         // 2.5MHz clock enable
output      txc2_5n_enable;        // Inverted 2.5MHz clock enable
output      CLK2_5_NO_FF;          // Square wave framing TXC2_5
output      MR_PLL_LOCKED;         // Status bit to register block
output      XOFF_20;               // 20 usec mode change pulse to dig_ecb blk
output      BASE10_DIS;            // Indication OK to disable 160 MHz PLL
output      BASE100TX_DIS;         // Indication OK to disable 125 MHz PLL
output      BASE100TX_DIS_ER;      // Early version of BASE100TX_DIS required
                                   // for sampling by RCLK125 before PLL
                                   // disabled.

//
// I/O Type Declarations
//
wire        RX10_RCLK2_5;      
wire        MR_100MBS;         
wire        CLKXTAL;           
wire        RCLK2_5_GOOD;      
wire        X_125;             
wire        X_160;             
wire        RX100_RCLK25;      
wire        RCLK25_GOOD;       
wire        AN_ACTIVE_XTND;
wire        RESET;             
wire        RPD_10_DISB;       
wire        RPD_100_DISB;      
wire        RESETREG;
wire        RESETPLL;
wire        CLKPLL_IN;         
wire        LINK10_DOWN;       
wire        LINK100_DOWN;      
wire        MR_AN_ENAB;        

wire        CLKPLL_SC;       
reg         clk160_enable;
reg         clk160n_enable;
wire        clk12_5_enable;
reg         clk10_enable;
reg         clk10n_enable;    
reg         RCLK2_5_SC;      
reg         RXC_SC;          
reg         clk125_enable;
reg         clk125_disb;          // Disable 125 MHz clock 
wire        CLKFAST_SC;
reg         clkfast_enable;
wire        clkfastd8_enable;
wire        clkfastd8_gate;  
reg         TXC_O_SC;        
reg         TXC25_SC;
wire        txc25_enable;
wire        txc25n_enable;
wire        TXC25_ALIGN;     
reg         txc2_5_enable;
reg         txc2_5n_enable;
reg         CLK2_5_NO_FF;    
wire        MR_PLL_LOCKED;   
wire        XOFF_20;         
wire        BASE10_DIS;      
wire        BASE100TX_DIS;
wire        BASE100TX_DIS_ER;   

//
// Internal Signal Declarations
//
wire       cont2_5;              // 2.5MHzclk to use if 10Base-T recov. clk bad
wire       x125_sel;             // Indicates the 125MHz PLL is selected
wire       x160_sel;             // Indicates the 160MHz PLL is selected
wire [7:0] prev_x125_sel;        // Serial chain of clock selection
wire [7:0] prev_x160_sel;        // Serial chain of clock selection
wire       pll125_locked;        // Indicates the 125MHz PLL is locked
wire       pll160_locked;        // Indicates the 160MHz PLL is locked
wire       b10dis;               // Indicates 10BaseT disable
wire       b100txdis;            // Indicates 100BaseT copper disable
wire       all_disb;             // Indicates all modes disabled
wire       genplld5_gate;        // Indicated strobes for TXC25_SC
wire       txc25ena;             // Enable for TXC25_SC
wire       txc2_5ena;            // Enable for txc2_5_enable
wire       txc2_5ena_pll;        // Enable for txc2_5_enable
wire       next_clk2_5_gate;     // Enable for txc2_5_enable
wire       next_gent2_5_gate;    // Enable for txc2_5_enable
wire       cnt125_at_1or6;       // indicate conter value

reg        rclk25;               // 25MHz recovered clk for 100Base-X rx
reg        icont2_5;             // Continuous internally generated 2.5MHz clock
reg        sqw25_125;            // Continuous internally generated 25MHz clock
reg        clk160_disb;          // Disable 160 MHz clock 
reg        clk160_disb_pll;      // Disable 160 MHz clock (sync'd to CLKPLL)
reg        xoff_20;              // 20us counter
reg [1:0]  xoff_20_pc;           // synchronizers for XOFF to CLKPLL
reg        prev1_cont2_5;        // 2.5MHz clock syncroniser
reg        prev2_cont2_5;        // 2.5MHz clock syncroniser
reg        prev3_cont2_5;        // 2.5MHz clock syncroniser
reg        prev1_rx10_rclk2_5;   // Recovered 2.5MHz clock syncroniser
reg        prev2_rx10_rclk2_5;   // Recovered 2.5MHz clock syncroniser
reg        prev3_rx10_rclk2_5;   // Recovered 2.5MHz clock syncroniser
reg        prev1pll_10disb;      // 10BaseT disable syncroniser
reg        prev2pll_10disb;      // 10BaseT disable syncroniser
reg        prev1pll_100disb;     // 100BaseT disable syncroniser
reg        prev2pll_100disb;     // 100BaseT disable syncroniser
reg        prev1xtal_10disb;     // 10BaseT disable syncroniser
reg        prev2xtal_10disb;     // 10BaseT disable syncroniser
reg        prev3xtal_10disb;     // 10BaseT disable syncroniser
reg        prev1xtal_100disb;    // 100BaseT disable syncroniser
reg        prev2xtal_100disb;    // 100BaseT disable syncroniser
reg        prev3xtal_100disb;    // 100BaseT disable syncroniser
reg        prev1_clk25;          // 25MHz clock syncroniser
reg        prev2_clk25;          // 25MHz clock syncroniser
reg        prev3_clk25;          // 25MHz clock syncroniser
reg        rclk2_5_disb;         // Recovered 2.5MHz enable syncroniser
reg        txc25_disb;           // Disables 25MHz clock
reg        txc2_5_disb;          // Disables 2.5MHz clock
reg        cont2_5_disb;         // Disables continuous 2.5MHz clock
reg        cont2_5_sel;          // Selects 2.5MHz clock clock source
reg        txc_disb;             // Disables TXC clock
reg        txc_sel;              // Selects TXC clock source
reg        prev1_mr100;          // 100BaseT mode syncroniser
reg        prev2_mr100;          // 100BaseT mode syncroniser
reg        prev2_5_mr100;        // 100BaseT mode syncroniser
reg        slvtxc25_pd;          // Selects 25MHz TX clock power down
reg        slvtxc2_5_pd;         // Selects 2.5MHz TX clock power down
reg [5:0]  count160;             // 160MHz clock counter
reg [2:0]  count_fast;           // Counter
reg        time_reset;           // Timer reset
reg        twenty_us_expired;    // Indicates 20us counter expired
reg [1:0]  twenty_us_exp_xtal;   // Indicates 20us counter expired
reg [1:0]  time_reset_xc;        // 20us counter reset
reg [6:0]  time_reset_pc;        // 20us counter reset
reg [9:0]  time_count;           // Counter used for 20uS timer
reg        rclk2_5_good;         // Indicates recovered 2.5MHz clock
reg        rclk2_5_good_pll;     // Indicates recovered 2.5MHz clock
reg        prev_x160_sel_7_pll;  // Indicates x160 is selected
reg        prev1_rpd10_disb;     // RPD_10_DISB syncroniser
reg        prev2_rpd10_disb;     // RPD_10_DISB syncroniser
reg        prev3_rpd10_disb;     // RPD_10_DISB syncroniser
reg        prev1_rpd100tx_disb;  // RPD_100_DISB syncroniser
reg        prev2_rpd100tx_disb;  // RPD_100_DISB syncroniser
reg        prev3_rpd100tx_disb;  // RPD_100_DISB syncroniser
reg [1:0]  pll125_status;        // Indicates 125MHz PLL status
reg [1:0]  pll160_status;        // Indicates 160MHz PLL status
reg [2:0]  prev_b10dis_xtal;     // b10dis syncroniser
reg [2:0]  prev_b100txdis_xtal;  // b100dis syncroniser
reg [1:0]  pll125_locked_plln;   // pll125_locked syncroniser
reg [1:0]  pll160_locked_plln;   // pll160_locked syncroniser
reg [1:0]  pll125_locked_pll;    // pll125_locked syncroniser
reg [1:0]  pll160_locked_pll;    // pll160_locked syncroniser
reg        an_link_down;         // Autonegotiation link status
reg [1:0]  an_link_down_plln;    // Autonegotiation link status synchronised
reg        genfast_disb;         // Control signal for CLKFAST_SC
reg [6:0]  count125;             // 125MHz counter
reg        cnt125_at_1;          // 125MHz counter value
reg        cnt125_at_3;          // 125MHz counter value
reg        cnt125_at_4;          // 125MHz counter value
reg        cnt125_at_6;          // 125MHz counter value
reg        cnt125_at_8;          // 125MHz counter value
reg        cnt125_at_9;          // 125MHz counter value
reg        cnt125_at_24;         // 125MHz counter value
reg        cnt125_at_49;         // 125MHz counter value
reg        sqw2_5_125;           // 2.5MHz generated clock
reg        sqw25p;               // 25MHz generated clock positive edge
reg        sqw25n;               // 25MHz generated clock negative edge
reg        cnt160_at_f;          // 160MHz counter value
reg        cnt160_at_7;          // 160MHz counter value
reg        cnt160_at_3e;         // 160MHz counter value
reg        cnt160_next_3f;       // 160MHz counter value
reg        cnt160_at_3f;         // 160MHz counter value
reg        cnt160_at_1f;         // 160MHz counter value
reg        mr_txc2_5_pd_pll;     // 2.5MHz clock disable
reg        cnt125_at_9_pos;      // Indicates every 10th clock pulse
reg        clk12_5_ctrl;         // 12.5MHz clock enable control
reg        genplld5_enable;      // 125MHz clock state at 4 or 9
reg        txc25ena_pos;         // Sync of txc25ena to CLKPLL_IN
reg        cnt_1or6_enable;      // 125Mhz clock state at 1 or 6
reg        pll160_locked_pos;    // 160MHz clock lock sync'd to ^CLKPLL_IN
reg        prev_x160_sel_pos;    // 160MHz clock selected sync'd to ^CLKPLL_IN
reg        cnt160_at_0_pos;      // 160MHz counter @ 0 sync'd to ^CLKPLL_IN
reg        cnt160_at_8_pos;      // 160MHz counter @ 8 sync'd to ^CLKPLL_IN
reg[2:0]   fastcount;            // counts to 8
reg        fastcount_7;          // Indicates counter = 7
reg        fastcount_5;          // Indicates counter = 5
reg        selorlocked125;       // The 125MHz PLL is selected & locked
reg        selorlocked160;       // The 160MHz PLL is selected & locked
reg        clk125_enable_int;    // clk125_disb inverted and sync'ed
reg        clk160_enable_int;    // clk160_disb inverted and sync'ed
reg        clk160n_enable_int;   // clk160_disb inverted and sync'ed
reg        x125_sel_sync1;       // Synch x125_sel to rclk25
reg        x125_sel_sync2;       // Synch x125_sel to rclk25
reg        x125_sel_sync3;       // Synch x125_sel to rclk25
reg        x125_edge;            // Indicated a x125_sel edge change
reg        rxc_disb;             // Disables output clock rxc_sc
reg        rxc_sel;              // Modifies output clock rxc_sc source
reg        Flag100_to_10;        // Indicates change from 100BaseT to 10BaseT
reg        Flag10_to_100;        // Indicates change from 10BaseT to 100BaseT
reg        res_x125_edge;        // Resets x125_sel edge change indicator
reg [1:0]  meta_rclk2_5;         // Synch rclk2_5 to rclk25
reg        cnt160_at_3f_pos;     // 160MHz counter value
reg        cnt160_at_1f_pos;     // 160MHz counter value
reg        prev_rclk25_good;     // register previous RCLK25_GOOD value
reg        rclk25_good_edge;     // Indicates a RCLK25_GOOD edge
reg        rclk25_disb;          // disables the rclk25
reg        rclk25_sel;           // Selects the rclk25_sel source
reg        Flag_rec_to_in;       // Indicates change from recovered to
                                 // internal clock
reg        Flag_in_to_rec;       // Indicates change from internal to
                                 // recovered clock
reg        res_rclk25_edge;      // Resets the rclk25_good_edge value
reg        rclk25_sync1;         // Synchronises rclk25 to the CLKPLL_IN
reg        sqw25_sync1;          // Synchronises sqw25_125 to the CLKPLL_IN
reg        sync1_rclk2_5_good_pll;  // synchronisation for rclk2_5_good
reg        sync2_rclk2_5_good_pll;  // synchronisation for rclk2_5_good
reg        rclk2_5_good_edge;       // Indicates a rclk2_5_good edge
reg        Flag_rclk2_5_int_to_ext; // Indicates changing from internal clock
                                    // to recovered clock
reg        Flag_rclk2_5_ext_to_int; // Indicates changing from recovered 
                                    // clock to internal clock
reg        res_rclk2_5_good_edge;   // Reset for rclk2_5_good edge
reg        cont2_5_edge;            // Counts cont2_5_edges when the recovered 
                                    // clock stopped
reg [1:0]  sync_all_disb_pll;
reg [1:0]  sync_all_disb_plln;
reg [1:0]  meta_rpd_10_disb;        // Sync register

//
// Parameter Declarations
//
parameter par_pll_locked  = 2'd3;
parameter par_pll_down    = 2'd0;
parameter par_pll_startup = 2'd1;

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
// Both these signals are sources from the XTAL clock domain therefore 
// all_disb is also reference to this clock.
//
   assign all_disb  = RPD_10_DISB & RPD_100_DISB;

//------------------------------------------------------------------------------
// Control signals are passed to the crystal clock domain environment to 
// indicate the speed of operation.
//------------------------------------------------------------------------------
//
   assign b10dis    = all_disb | ~(|prev_x160_sel) & prev3_rpd10_disb;

   assign b100txdis = all_disb | ~(|prev_x125_sel) & prev3_rpd100tx_disb &
                      ~AN_ACTIVE_XTND & ~an_link_down;

//------------------------------------------------------------------------------
// These are mode control bits that are synchronised with the crystal clock.
//------------------------------------------------------------------------------
//
   assign BASE10_DIS       = prev_b10dis_xtal[2];
   assign BASE100TX_DIS    = prev_b100txdis_xtal[2];
   assign BASE100TX_DIS_ER = prev_b100txdis_xtal[1]; 

//------------------------------------------------------------------------------
// If either 160 or 125 MHz clock is selected set register bit indicating PLL 
// is locked. I am not sure why the pll125_locked or pll160_locked were not used
// as at least one of these signals will will be active at startup dispite the
// PLL not being locked.
//------------------------------------------------------------------------------
//
   assign MR_PLL_LOCKED = x160_sel | x125_sel;

//------------------------------------------------------------------------------
// Instantiated Module of dig_clk_pll_sel this module is used to selected 
// between the two plls without the generation of any glitches
//------------------------------------------------------------------------------
// 
   dig_clk_pll_sel i_dig_clk_pll_sel (
                                      .X_125(X_125),
                                      .X_160(X_160),
                                      .RPD_10_DISB(RPD_10_DISB), 
                                      .RPD_100_DISB(RPD_100_DISB),
                                      .pll125_locked(pll125_locked),
                                      .pll160_locked(pll160_locked),
                                      .all_disb(all_disb),
                                      .RESETREG(RESETREG),
                                      .RESETPLL(RESETPLL),
                                      .x125_sel(x125_sel),
                                      .x160_sel(x160_sel),
                                      .prev_x125_sel(prev_x125_sel),
                                      .prev_x160_sel(prev_x160_sel),
                                      .CLKPLL_SC(CLKPLL_SC)
                                     );

//------------------------------------------------------------------------------
// This process is used to determine the status of the PLL and also contains
// register chains for synchronising disable control signals for the speed of
// operation.
// The synchronised signals are :RPD_10_DISB
//                               RPD_100_DISB
// 
// The pll<speed>status signals can be: pll125_status = 2'b00  Down
//                                      pll125_status = 2'b01  startup
//                                      pll125_status = 2'b11  locked
//
// The control sequence for the locking of the PLL is such that it will
// require the 20uS timing signal xoff_20 to be active before the status can
// enter the startup sequence. This mode cannot move into the locked mode
// until the 20uS signal goes inactive.
//
//------------------------------------------------------------------------------
//
   always @(negedge CLKXTAL or posedge RESET)   // check if this needs to be
      begin : p_pll_status                      // reset by a powerdown
      if (RESET)
         begin
         prev3_rpd10_disb     <= 1'b1 ;
         prev2_rpd10_disb     <= 1'b1 ;
         prev1_rpd10_disb     <= 1'b1 ;
         prev3_rpd100tx_disb  <= 1'b0 ;
         prev2_rpd100tx_disb  <= 1'b0 ;
         prev1_rpd100tx_disb  <= 1'b0 ;
         pll125_status        <= par_pll_down ;
         pll160_status        <= par_pll_down ;
         end
      else
         begin
         prev3_rpd10_disb     <= prev2_rpd10_disb ;
         prev2_rpd10_disb     <= prev1_rpd10_disb ;
         prev1_rpd10_disb     <= RPD_10_DISB ;
         prev3_rpd100tx_disb  <= prev2_rpd100tx_disb ;
         prev2_rpd100tx_disb  <= prev1_rpd100tx_disb ;
         prev1_rpd100tx_disb  <= RPD_100_DISB ;

         case (pll125_status)   //synopsys parallel_case

            par_pll_down : begin
                           if (xoff_20 & ~prev3xtal_100disb)
                              pll125_status <= par_pll_startup;
                           else
                              pll125_status <= par_pll_down;
                           end

            par_pll_startup : begin
                              if (prev3xtal_100disb)
                                 pll125_status <= par_pll_down;
                              else if (xoff_20)
                                 pll125_status <= par_pll_startup;
                              else
                                 pll125_status <= par_pll_locked;
                              end

            par_pll_locked : begin
                             if (prev_b100txdis_xtal[2])
                                pll125_status <= par_pll_down;
                             else
                                pll125_status <= par_pll_locked;
                             end

            default : pll125_status <= par_pll_down;

         endcase

         case (pll160_status)   //synopsys parallel_case
            par_pll_down : begin
                           if (xoff_20 & ~prev3xtal_10disb & prev3xtal_100disb)
                              pll160_status <= par_pll_startup;
                           else
                              pll160_status <= par_pll_down;
                           end

            par_pll_startup : begin
                              if (prev3xtal_10disb)
                                 pll160_status <= par_pll_down;
                              else if (xoff_20)
                                 pll160_status <= par_pll_startup;
                              else
                                 pll160_status <= par_pll_locked;
                              end

            par_pll_locked : begin
                             if (prev_b10dis_xtal[2])
                                pll160_status <= par_pll_down;
                             else
                                pll160_status <= par_pll_locked;
                             end

            default : pll160_status <= par_pll_down;

         endcase
      end
   end // p_pll_status

   // The msb of the pllx_locked signal is used to indicate lock
   assign pll125_locked = pll125_status[1];
   assign pll160_locked = pll160_status[1];

//------------------------------------------------------------------------------
// This process is used to determine the status of the Auto-negotiation
// link.
//------------------------------------------------------------------------------
//
   always @(prev2_mr100 or MR_AN_ENAB or LINK100_DOWN or LINK10_DOWN)

      begin : p_an_link_down
      if (prev2_mr100)
         an_link_down = MR_AN_ENAB & LINK100_DOWN;
      else
         an_link_down = MR_AN_ENAB & LINK10_DOWN;
      end // p_an_link_down

//------------------------------------------------------------------------------
// This process is used to synchronise the mode control signals to the PLL and
// genrate the appropriate clock disable signal
//------------------------------------------------------------------------------
//
   always @(negedge CLKPLL_IN or posedge RESETPLL)
      begin : p_pll_disb
      if (RESETPLL)
         begin
         prev1pll_10disb  <= 1'b1;
         prev1pll_100disb <= 1'b1;
         prev2pll_10disb  <= 1'b1;
         prev2pll_100disb <= 1'b1;
         clk160_disb <= 1'b1;
         clk125_disb <= 1'b1;
         end
      else
         begin
         prev1pll_10disb  <= RPD_10_DISB;
         prev2pll_10disb  <= prev1pll_10disb;
         prev1pll_100disb <= RPD_100_DISB;
         prev2pll_100disb <= prev1pll_100disb;
         clk160_disb <= prev2pll_10disb  | ~prev_x160_sel[7] | 
                        ~pll160_locked_plln[1];
         clk125_disb <= prev2pll_100disb | ~prev_x125_sel[7] |
                        ~pll125_locked_plln[1];
         end
      end // p_pll_disb

//------------------------------------------------------------------------------
// The following process is to generate a 125MHz clock enable using the control
// previously defined. 
//------------------------------------------------------------------------------
//
   always@(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_clk125_enable
      if (RESETPLL)
         begin
         clk125_enable     <= 1'b0;
         clk125_enable_int <= 1'b0;
         end
      else
         begin
         clk125_enable     <= clk125_enable_int;
         clk125_enable_int <= ~clk125_disb;
         end
      end // p_clk125_enable

//------------------------------------------------------------------------------
// The following process is to generate a 160MHz clock enable using the control
// previously defined. 
//------------------------------------------------------------------------------
//
   always@(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_clk160_enable
      if (RESETPLL)
         begin
         clk160_enable     <= 1'b0;
         clk160_enable_int <= 1'b0;
         end
      else
         begin
         clk160_enable     <= clk160_enable_int;
         clk160_enable_int <= ~clk160_disb;
         end
      end // p_clk160_enable

  always@(negedge CLKPLL_IN or posedge RESETPLL)
      begin : p_clk160n_enable
      if (RESETPLL)
         begin
         clk160n_enable     <= 1'b0;
         clk160n_enable_int <= 1'b0;
         end
      else
         begin
         clk160n_enable     <= clk160_enable_int;
         clk160n_enable_int <= ~clk160_disb;
         end
      end // p_clk160_enable

//------------------------------------------------------------------------------
// This process is used to generate a control signals that are syncronised to
// CLKPLL_IN clock.
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_clk160_disb_pll
      if (RESETPLL)
         begin
         clk160_disb_pll     <= 1'b1;
         prev_x160_sel_7_pll <= 1'b0;
         end
      else 
         begin
         clk160_disb_pll     <= clk160_disb;
         prev_x160_sel_7_pll <= prev_x160_sel[7];
         end
      end // p_clk160_disb_pll
   
//------------------------------------------------------------------------------
// This process is used to generate a 20uS high pulse. The pulse is only
// generated when all_disb and time_reset are inactive. The control signals
// are passed through synchronisation registers
// Issue in that the counter wraps round therefore producing a 20uS high pulse
// followed by a 20.96uS low.
// 
// The process also synchronises the b10dis, b100txdis, and bfxdis from their
// appropriate clock domain to that of the CLKXTAL
//
//------------------------------------------------------------------------------
//  
   always @(posedge CLKXTAL or posedge RESET)
      begin : p_xoff_20
      if (RESET)
         begin
         time_reset_xc       <= 2'b00;
         prev_b10dis_xtal    <= 3'b111;
         prev_b100txdis_xtal <= 3'b000;
         xoff_20             <= 1'b1;
         time_count          <= 10'd0;
         end
      else
         begin
         // Synchronize time_reset
         time_reset_xc       <= {time_reset_xc[0], time_reset | all_disb};
         prev_b10dis_xtal    <= {prev_b10dis_xtal[1:0], b10dis};
         prev_b100txdis_xtal <= {prev_b100txdis_xtal[1:0], b100txdis};

         if (time_reset_xc[1])
            begin
            xoff_20 <= 1'b0;
            time_count <= 10'd0;
            end
         else 
            begin
            if (time_count >= 10'd500)
               xoff_20 <= 1'b0;
            else
               xoff_20 <= 1'b1;
            time_count <= time_count + 10'd1;
            end
         end
      end // p_xoff_20

//------------------------------------------------------------------------------
// This process uses a clock that is a 25MHz pulse that is generated from a
// CLKPLL_IN pulse divided by 5. The signals below are then synchronised to
// the source clock.
//------------------------------------------------------------------------------
//  
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_twenty_us_expired
      if (RESETPLL)
         begin
         xoff_20_pc        <= 2'b11;
         twenty_us_expired <= 1'b0;
         time_reset_pc     <= 7'h7f;
         end
      else if (genplld5_enable)
         begin
         xoff_20_pc    <= {xoff_20_pc[0], xoff_20};
         time_reset_pc <= {time_reset_pc[5:0], time_reset_xc[1]};

         // If not reset and at TC...
         if (~time_reset_pc[1] & ~time_reset_pc[6] & ~xoff_20_pc[1])
            twenty_us_expired <= 1'b1;
         else
            twenty_us_expired <= 1'b0;
         end
      else
         begin
         xoff_20_pc        <= xoff_20_pc;
         twenty_us_expired <= twenty_us_expired;
         time_reset_pc     <= time_reset_pc;
         end
      end // p_twenty_us_expired

   assign XOFF_20 = xoff_20_pc[1];

//------------------------------------------------------------------------------
// This process sets the output of genfast_disb to the appropriate status only
// allowing the CLKPLL_IN clock to pass if the appropriate pll is selected and
// locked.
//------------------------------------------------------------------------------
//  
   always @(prev2_5_mr100 or prev_x125_sel or pll125_locked_plln or 
                              prev_x160_sel or pll160_locked_plln)
      begin : p_genfast_disb
      if (prev2_5_mr100)
         genfast_disb = (~prev_x125_sel[7] | ~pll125_locked_plln[1]);
      else
         genfast_disb = (~prev_x160_sel[7] | ~pll160_locked_plln[1]);
      end // p_genfast_disb

//------------------------------------------------------------------------------
// This controls the generation of the CLKFAST_SC. This is not used within the
// digital design, but feeds in to an analogue filter.
//------------------------------------------------------------------------------
//
   assign CLKFAST_SC   = ~genfast_disb & CLKPLL_IN;

//------------------------------------------------------------------------------
// This section divides the clock by 8 to generate a clkfast8_enable
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_fastcount
      if (RESETPLL)
         begin
         fastcount   <= 3'd0;
         fastcount_7 <= 1'b0;
         fastcount_5 <= 1'b0;
        end
      else 
         begin
         fastcount   <= fastcount -  3'd1;
         fastcount_7 <= fastcount == 3'b111;
         fastcount_5 <= fastcount == 3'b101;
         end
      end // p_fastcount

   assign clkfastd8_enable = clkfast_enable & fastcount_7;
   assign clkfastd8_gate   = clkfast_enable & fastcount_5;


//------------------------------------------------------------------------------
// This process is a 7bit counter used to generate subsequent clocks from the
// CLKPLL_IN. The counter counts in Decimal, therefore always skips the 
// A,B,C,D,E,F states.
//
//------------------------------------------------------------------------------
//
   always @(negedge CLKPLL_IN or posedge RESETPLL)
      begin : p_cnt125
      if (RESETPLL)
         begin
         count125     <= 7'd0;
         sqw2_5_125   <= 1'b0;
         sqw25p       <= 1'b0;
         cnt125_at_1  <= 1'b0;
         cnt125_at_3  <= 1'b0;
         cnt125_at_4  <= 1'b0;
         cnt125_at_6  <= 1'b0;
         cnt125_at_8  <= 1'b0;
         cnt125_at_9  <= 1'b0;
         cnt125_at_24 <= 1'b0;
         cnt125_at_49 <= 1'b0;
         end
      else
         begin
         cnt125_at_1  <= (count125[3:0] == 4'h1);
         cnt125_at_3  <= (count125[3:0] == 4'h3);
         cnt125_at_4  <= (count125[3:0] == 4'h4);
         cnt125_at_6  <= (count125[3:0] == 4'h6);
         cnt125_at_8  <= (count125[3:0] == 4'h8);
         cnt125_at_9  <= (count125[3:0] == 4'h9);
         cnt125_at_24 <= (count125      == 7'h24);
         cnt125_at_49 <= (count125      == 7'h49);

         if (cnt125_at_8)
            begin
            count125[3:0] <= 4'd0;
            if (count125[6])
               count125[6:4] <= 3'b0;
            else
               count125[6:4] <= count125[6:4] + 3'd1;
            end
         else
            count125[3:0] <= count125[3:0] + 4'd1;

         // Generates a 2.5MHz clock
         // ie the 125MHz clock is divided by 50
         if (cnt125_at_24)
            sqw2_5_125 <= 1'b0;
         if (cnt125_at_49)
            sqw2_5_125 <= 1'b1;

         // Generate a 25MHz clock positive pulse
         // ie divide the 125MHz clock by 5
         if (cnt125_at_3 | cnt125_at_8)
            sqw25p <= 1'b1;
         else
            sqw25p <= 1'b0;

         end
      end // p_cnt125

   assign cnt125_at_1or6 = cnt125_at_1 | cnt125_at_6;
   assign TXC25_ALIGN    = cnt125_at_3 | cnt125_at_8;

//------------------------------------------------------------------------------
// This process is generates a 25MHz pulse clocked from the positive CLKPLL_IN
//
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin
      if (RESETPLL)
         sqw25n <= 1'b1;
      else if (cnt125_at_1 | cnt125_at_6)
         sqw25n <= 1'b1;
      else
         sqw25n <= 1'b0;
      end

//------------------------------------------------------------------------------
// This process uses both the sqw25p and sqw25n to generate a 25MHz clock
// with an even mark to space ratio.
//------------------------------------------------------------------------------
//
   always @(posedge sqw25n or posedge sqw25p)
      begin
      if (sqw25p)
         sqw25_125 <= 1'b1;
      else
         sqw25_125 <= 1'b0;
      end

//------------------------------------------------------------------------------
// This process generates 25MHz clock for 100Base-X tx. This will be in the form
// of a CLKPLL pulse controlled by genplld5_gate which uses the cnt125 outputs 
// to divide the 125MHz clock by 5
//------------------------------------------------------------------------------
// This process has been left since the clock is fed out the top level driving
// the analogue logic. This logic could be replaced with CLKPLL_IN and 
// txc25_enable allowing for better synthesisable code.
//
   assign genplld5_gate  = cnt125_at_4 | cnt125_at_9;
   assign txc25ena       = ~(txc25_disb | slvtxc25_pd | clk125_disb);

   always @(genplld5_gate or txc25ena or CLKPLL_IN)
      begin : p_TXC25_SC
      if (genplld5_gate & txc25ena)
         TXC25_SC = CLKPLL_IN;
      else
         TXC25_SC = 1'b0;
      end // p_TXC25_SC

//------------------------------------------------------------------------------
// This process generates the posavite and negative 25MHz clock enable for 
// 100Base-X tx. This will be controlled by the Count125 in either 
// state 4 or 9 and then a validation of the pll being select and locked
// for the positive pulse and state 1 or 6 for the negaive enable.
//------------------------------------------------------------------------------
//
   assign txc25_enable  = (genplld5_enable & txc25ena_pos);
   assign txc25n_enable = (cnt125_at_1or6 & txc25ena);

   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_txc25ena_pos
      if (RESETPLL)
         begin
         genplld5_enable <= 1'b0;
         cnt_1or6_enable <= 1'b0;
         txc25ena_pos    <= 1'b0;
         end
      else
         begin
         genplld5_enable <= ((count125[3:0] == 4'h4)| (count125[3:0] == 4'h9));
         cnt_1or6_enable <= ((count125[3:0] == 4'h1)| (count125[3:0] == 4'h6));
         txc25ena_pos    <= txc25ena;
         end
      end // p_txc25ena_pos


//------------------------------------------------------------------------------
// This process is for the switching control of the 125MHz clock to ensure
// that the 25MHz generated clock is glitch free
//------------------------------------------------------------------------------
//
   always @(negedge CLKPLL_IN or posedge RESETPLL)
      begin : p_txc25_disb
      if (RESETPLL)
         begin
         txc25_disb  <= 1'b0;    // In 125 MHz mode
         slvtxc25_pd <= 1'b0;
         end
      else
         begin
         if (slvtxc25_pd & ~prev2pll_100disb & ~genplld5_gate)
            // If entering 125 MHz mode
            begin                                 // When new clock is low
            txc25_disb <= 1'b0;                   // Release hold
            slvtxc25_pd <= prev2pll_100disb;      // Update int. power down sel.
            end
         else if (~slvtxc25_pd & prev2pll_100disb & ~genplld5_gate)
            // If exiting 125 MHz mode
            begin                                 // When new clock is low
            txc25_disb <= 1'b1;                   // Hold clock low
            slvtxc25_pd <= prev2pll_100disb;      // Update int. power down sel.
            end
         else
            // Default
            begin 
            txc25_disb <= txc25_disb;
            slvtxc25_pd <= slvtxc25_pd;
            end
         end
      end // p_txc25_disb

//------------------------------------------------------------------------------
// This process generates the an enable for the 12.5MHz clock. It is formed when
// in 100BaseT mode and is enabled every 10th clock assuming that the pll is
// locked and we are not autonegotiating.
//------------------------------------------------------------------------------
//

   assign clk12_5_enable = cnt125_at_9_pos & clk12_5_ctrl;
   // This process synch's the control signals to the positive edge of 
   // CLKPLL_IN.
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_clk12_5_ctrl
      if (RESETPLL)
         begin
         sync_all_disb_pll <= 2'h3;
         cnt125_at_9_pos   <= 1'b0;
         clk12_5_ctrl      <= 1'b0;
         end
      else
         begin
         sync_all_disb_pll <= {sync_all_disb_pll[0], all_disb};
         cnt125_at_9_pos   <= (count125[3:0] == 4'h9);
         
         // Enable clock when AN is enabled (though not necessarily 'active') on
         // either 125MHz or 160MHz PLL.
          
         clk12_5_ctrl  <= ( ((prev_x125_sel[7] |
                              prev_x160_sel[7] |
                              (AN_ACTIVE_XTND & ~sync_all_disb_pll[1])) & 
                             (pll125_locked_plln[1] | 
                              pll160_locked_plln[1])) |
                             an_link_down_plln[1]);
         end
      end // p_clk12_5_ctrl

//------------------------------------------------------------------------------
// This process divides down the 160MHz Clock. Like the 125MHz counter it counts
// in decimal. 
//------------------------------------------------------------------------------
//
   always @(negedge CLKPLL_IN or posedge RESETPLL)
      begin : p_count160
      if (RESETPLL)
         begin
         count160     <= 6'd63;
         cnt160_at_f  <= 1'b0;
         cnt160_at_7  <= 1'b0;
         cnt160_at_3e <= 1'b0;
         cnt160_at_3f <= 1'b0;
         cnt160_at_1f <= 1'b0;
         CLK2_5_NO_FF <= 1'b1;
         end
      else
         begin
         count160     <= count160 - 6'd1;
         cnt160_at_f  <= (count160[3:0] == 4'hf);
         cnt160_at_7  <= (count160[3:0] == 4'h7);
         cnt160_at_3e <= (count160 == 6'h3e);
         cnt160_at_3f <= (count160 == 6'h3f);
         cnt160_at_1f <= (count160 == 6'h1f);
         CLK2_5_NO_FF <= count160[5];
         end
      end // p_count160

//------------------------------------------------------------------------------
// This process generates the clkfast_enable. The enable is used to indicate to
// the submodules when the CLKPLL_IN should be used. The prev2_mr100 is used to
// select either the 125MHz clock control logic or the 160MHz control logic. The
// actual control logic generates an enable when both the pll is selected and 
// locked.
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_selorlocked
      if (RESETPLL)
         begin
         selorlocked125 <= 1'b0;
         selorlocked160 <= 1'b0;
         end
      else
         begin
         selorlocked125 <= prev_x125_sel[7] & pll125_locked_plln[1];
         selorlocked160 <= prev_x160_sel[7] & pll160_locked_plln[1];
         end
      end // p_selorlocked

   // Mux to select between 125 or 160MHz control
   always @(prev2_mr100 or selorlocked125 or selorlocked160)
      begin : p_clkfast_enable
      if (prev2_mr100)
         clkfast_enable = selorlocked125;
      else
         clkfast_enable = selorlocked160;
      end // p_clkfast_enable

//------------------------------------------------------------------------------
// This process is used for synchronising signals into the CLKPLL clock domain. 
//------------------------------------------------------------------------------
//  
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_locked_pll
      if (RESETPLL)
         begin
         pll125_locked_pll <= 1'b0;
         pll160_locked_pll <= 1'b0;
         cnt160_next_3f    <= 1'b0;
         end
      else
         begin
         pll125_locked_pll <= {pll125_locked_pll[0], pll125_locked};
         pll160_locked_pll <= {pll160_locked_pll[0], pll160_locked};
         cnt160_next_3f    <= cnt160_at_3e ;
         end
      end // p_locked_pll

//------------------------------------------------------------------------------
// This process is for controlling the source of the CLKREG clock. This can be 
// either from a free running source or from the PLLs. Its sequence of events
// ensure that during switch over the generated clocks will be glitch free.
//------------------------------------------------------------------------------
// 

   always @(negedge CLKPLL_IN or posedge RESETPLL) 
      begin : p_pll_sync
      if (RESETPLL)
         begin
         pll125_locked_plln <= 2'b00;
         pll160_locked_plln <= 2'b00;
         sync_all_disb_plln <= 2'b11;
         end
      else if (~sync_all_disb_plln[1])
         // In normal operation ...
         begin
         pll125_locked_plln  <= {pll125_locked_plln[0], pll125_locked};
         pll160_locked_plln  <= {pll160_locked_plln[0], pll160_locked};
         sync_all_disb_plln  <= {sync_all_disb_plln[0], all_disb};
         end
      else
         // In power down ...
         begin
         pll125_locked_plln <= 2'b00; // Mark PLLs as down
         pll160_locked_plln <= 2'b00; // Mark PLLs as down
         sync_all_disb_plln <= {sync_all_disb_plln[0], all_disb};
         end
      end // p_pll_sync

//------------------------------------------------------------------------------
// This processes is used to generate enables which define 10MHz clocks
// from the 160MHz output on CLKPLL_IN. The enable will only be active if 
// the 160MHz PLL is locked, you are in 10BaseT mode, the 160MHz clock has
// been selected, then using 160MHz counter is at activate the clk10 when the
// counter is at 0 and the clk10n when the counter is at 8.
//------------------------------------------------------------------------------
//

   // This process has been added to synchronise the control signals
   // to that of the rising edge of CLKPLL_IN before moving to the actual
   // enable control
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_clk_pos
      if (RESETPLL)
         begin
         pll160_locked_pos <= 1'b0;
         prev_x160_sel_pos <= 1'b0;
         cnt160_at_0_pos   <= 1'b0;
         cnt160_at_8_pos   <= 1'b0;
         end
      else
         begin
         pll160_locked_pos <= pll160_locked_pll[1];
         prev_x160_sel_pos <= prev_x160_sel[7];
         cnt160_at_0_pos   <= (count160[3:0] == 4'h0);
         cnt160_at_8_pos   <= (count160[3:0] == 4'h8);
         end
      end // p_clk_pos

   // This is the enable control process
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_clk10_enable
      if (RESETPLL)
         begin
         meta_rpd_10_disb <= 2'b00;
         clk10_enable     <= 1'b0;
         clk10n_enable    <= 1'b0;
         end
      else
         begin
         meta_rpd_10_disb <= {meta_rpd_10_disb[0], RPD_10_DISB};
         clk10_enable     <= (~meta_rpd_10_disb[1] & pll160_locked_pos & 
                            prev_x160_sel_pos & cnt160_at_0_pos);
         clk10n_enable <= (~meta_rpd_10_disb[1] & pll160_locked_pos & 
                            prev_x160_sel_pos & cnt160_at_8_pos);
         end
      end // p_clk10_enable

//------------------------------------------------------------------------------
// These processes generate a 2.5MHz clock enable and negative version of the 
// clock enable from the 160MHz clock from CLKPLL. The enable not only uses the
// counter but additional control logic with the process p_txc2_5_disb to ensure 
// that we anable and disable the control dependant on the mode of the device 
// and the status of the pll.
//------------------------------------------------------------------------------
//
   assign txc2_5ena         = ~(txc2_5_disb | slvtxc2_5_pd | clk160_disb);

   // The txc2_5 clock enable control
   always @(cnt160_at_3f_pos or txc2_5ena)
      begin : p_txc2_5_enable
      if (cnt160_at_3f_pos & txc2_5ena)
         txc2_5_enable = 1'b1;
      else
         txc2_5_enable = 1'b0;
      end // p_txc2_5_enable

   // synch counter to the rising edge of the clkpll_in
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_cnt160_at_3f_pos
      if (RESETPLL)
         cnt160_at_3f_pos <= 1'b0;
      else
         cnt160_at_3f_pos <= (count160 == 6'h3f);
      end // p_cnt160_at_3f_pos

   // The txc2_5n clock enable control
   always @(cnt160_at_1f_pos or txc2_5ena)
      begin : p_txc2_5n_enable
      if (cnt160_at_1f_pos & txc2_5ena)
         txc2_5n_enable = 1'b1;
      else
         txc2_5n_enable = 1'b0;
      end // p_txc2_5_enable

   // synch counter to the rising edge of the clkpll_in
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_cnt160_at_1f_pos
      if (RESETPLL)
         cnt160_at_1f_pos <= 1'b0;
      else
         cnt160_at_1f_pos <= (count160 == 6'h1f);
      end // p_cnt160_at_1f_pos

//------------------------------------------------------------------------------
// This process generates a continuous 2.5MHz square wave from either the 160MHz
// clock counter or the 125MHz clock counter.
//------------------------------------------------------------------------------
// 
   always @(cont2_5_sel or sqw2_5_125 or CLK2_5_NO_FF)
      begin : p_icont2_5
      if (cont2_5_sel)
         icont2_5 = sqw2_5_125;
      else
         icont2_5 = CLK2_5_NO_FF;
      end // p_icont2_5

   assign cont2_5 = ~cont2_5_disb & icont2_5;

//------------------------------------------------------------------------------
// This process passes either a continuous 2.5MHz square wave or 25MHz clock
// dependant on whether in 10 or 100 BaseT mode
//------------------------------------------------------------------------------
// 
   always @(txc_disb or txc_sel or sqw25_125 or cont2_5)
      begin : p_TXC_O_SC
      if (txc_disb)
         TXC_O_SC = 1'b1;
      else if (txc_sel)
         TXC_O_SC = sqw25_125;
      else
         TXC_O_SC = cont2_5;
      end // p_TXC_O_SC


//------------------------------------------------------------------------------
// The output rclk25 can be selected from 2 sources; 
// 1) sqw25_125 a 25MHz clock internally generated, 
// 2) RX100_RCLK25 a 25MHz recovered clock. 
//
// These clocks can be considered as free running clocks dependent on the
// status of the PLL's. This logic ensures that the correct clock source
// is selected and that it is free from glitches. This is done by ensuring that
// a disable signal is active during the handover ensuring that the clock
// output remains in a High condition until new clock is sourced.
//
// There are a number of processes to perform the task
//------------------------------------------------------------------------------
//
   // RCLK25_GOOD is a control signal that is used to indicate if
   // the design has a good recovered clock this signal is sourced
   // from a CLKPLL_IN environment and the following process is
   // used to determine an edge

   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_rclk25_good_edge
      if (RESETPLL)
         begin             // Default is generated clock
         prev_rclk25_good <= 1'b0;
         rclk25_good_edge  <= 1'b0;
         end
      else
         begin
         prev_rclk25_good <= RCLK25_GOOD;

         // This logic detects an edge. 
         // When the edge is detected its kept set until forced clear
         if (~rclk25_good_edge)
            rclk25_good_edge <= prev_rclk25_good ^ RCLK25_GOOD;

         // reset edge detection
         else if (res_rclk25_edge)
            rclk25_good_edge <= 1'b0;

         // Keep the existing state
         else
            rclk25_good_edge <= rclk25_good_edge;
         end
      end // p_rclk25_good_edge

   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_rclk25_disb
      if (RESETPLL)
         begin
         rclk25_disb     <= 1'b0;
         rclk25_sel      <= 1'b0;
         Flag_rec_to_in  <= 1'b0;
         Flag_in_to_rec  <= 1'b0;
         res_rclk25_edge <= 1'b0;
         rclk25_sync1    <= 1'b0;
         sqw25_sync1     <= 1'b0;
         end

      else
         begin
         // Sync register to ensure high phase of clock
         // aligns with that of the CLKPLL_IN
         rclk25_sync1 <= RX100_RCLK25;
         sqw25_sync1  <= sqw25_125;

         // Changing from Internal clock to Recovered clock
         // setting disable
         if (rclk25_good_edge & RCLK25_GOOD)
            begin
            // to ensure a clean hand over the internal clock must be high
            // This clock is async to the clock used in this process
            // therefore will test a combined previous state with the
            // the existing state
            if (sqw25_sync1 & sqw25_125)         
               begin
               rclk25_disb     <= 1'b1;
               rclk25_sel      <= 1'b0;
               Flag_in_to_rec  <= 1'b1;
               res_rclk25_edge <= 1'b1;
               end
             end

         // Changing from Internal clock to Recovered clock
         // setting mux
         else if (Flag_in_to_rec & ~rclk25_sel)
            begin
            rclk25_disb     <= 1'b1;
            rclk25_sel      <= 1'b1;
            Flag_in_to_rec  <= 1'b1;
            res_rclk25_edge <= 1'b0;
            end

         // Changing from Internal clock to Recovered clock
         // turn of disable.
         else if (Flag_in_to_rec)
            begin
            // to ensure a clean hand over the RX100_RCLK25 must be high
            // This clock is async to the clock used in this process
            // therefore will test a combined previous state with the
            // the existing state
            if (rclk25_sync1 & RX100_RCLK25)
               begin
               rclk25_disb     <= 1'b0;
               rclk25_sel      <= 1'b1;
               Flag_in_to_rec  <= 1'b0;
               res_rclk25_edge <= 1'b0;
               end
            end

         // Changing from Recovered clock to Internal clock
         // setting disable
         else if (rclk25_good_edge & ~RCLK25_GOOD)
            begin
            // to ensure a clean hand over the RX100_RCLK25 must be high
            // This clock is async to the clock used in this process
            // therefore will test a combined previous state with the
            // the existing state
            if (rclk25_sync1 & RX100_RCLK25)
               begin
               rclk25_disb     <= 1'b1;
               rclk25_sel      <= 1'b1;
               Flag_rec_to_in  <= 1'b1;
               res_rclk25_edge <= 1'b1;
               end
            end

         // Changing from Recovered clock to Internal clock
         // setting mux
         else if (Flag_rec_to_in & rclk25_sel)
            begin
            rclk25_disb     <= 1'b1;
            rclk25_sel      <= 1'b0;
            Flag_rec_to_in  <= 1'b1;
            res_rclk25_edge <= 1'b0;
            end

         // Changing from Recovered clock to Internal clock
         // turn of disable 
         else if (Flag_rec_to_in)
            begin
            // to ensure a clean hand over the internal clock must be high
            // This clock is async to the clock used in this process
            // therefore will test a combined previous state with the
            // the existing state
            if (sqw25_sync1 & sqw25_125)         
               begin
               rclk25_disb     <= 1'b0;
               rclk25_sel      <= 1'b0;
               Flag_rec_to_in  <= 1'b0;
               res_rclk25_edge <= 1'b0;
               end
            end

         // Default condition
         else
            begin
            rclk25_disb     <= rclk25_disb;
            rclk25_sel      <= rclk25_sel;
            Flag_in_to_rec  <= Flag_in_to_rec;
            Flag_rec_to_in  <= Flag_rec_to_in;
            res_rclk25_edge <= res_rclk25_edge;
            end
         end
      end // p_rclk25_disb

   // This is a mux to select between the two clocks. In order to change
   // clock sources the rclk25_disb must be active before changing. This can
   // only be activate when the currently selected clock is high and then
   // changing the mux source. When activating the clock following the source
   // change to rclk25_disb should be performed during the high phase of the
   // clock.
   always @(rclk25_sel or rclk25_disb or RX100_RCLK25 or sqw25_125)
      begin : p_rclk25
      if (rclk25_sel)
         rclk25 = RX100_RCLK25 | rclk25_disb;
      else
         rclk25 = sqw25_125 | rclk25_disb;
      end // p_rclk25

//------------------------------------------------------------------------------
// Continuous 2.5 MHz clock de-glitching
// Source can be either XTAL div 10 or clk160 div 64
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_cont2_5_disb
      if (RESETPLL)
         begin
         cont2_5_disb <= 1'b0;
         cont2_5_sel  <= 1'b1;        // 0=160/64, 1=sqw2_5_125
         end
      else
         begin
         if (prev2_mr100 & pll125_locked_pll[1] & ~cont2_5_sel &
             prev3_cont2_5 & ~prev2_cont2_5)
            // If switching from 160 to 125 look for falling edge of old clock
            begin
            cont2_5_disb <= 1'b1;
            cont2_5_sel  <= 1'b1;
            end

         else if (~prev2_mr100 & pll160_locked_pll[1] & cont2_5_sel &
              prev3_cont2_5 & ~prev2_cont2_5)
            // If switching from 125 to 160 look for falling edge of old clock
            begin
            cont2_5_disb <= 1'b1; 
            cont2_5_sel  <= 1'b0;
            end

         else if (cont2_5_disb & prev_x125_sel[7] & cnt125_at_49)
            begin
            cont2_5_disb <= 1'b0;
            cont2_5_sel  <= cont2_5_sel;
            end

         else if (cont2_5_disb & prev_x160_sel_7_pll & cnt160_next_3f)
            begin
            cont2_5_disb <= 1'b0;
            cont2_5_sel  <= cont2_5_sel;
            end

         else
            begin
            cont2_5_disb <= cont2_5_disb;
            cont2_5_sel  <= cont2_5_sel;
            end

         end

      end // p_cont2_5_disb

//------------------------------------------------------------------------------
// TXC de-glitching
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_txc_disb
      if (RESETPLL)
         begin
         txc_disb <= 1'b1;
         txc_sel  <= 1'b1;      // 0=10BT(cont2_5), 1=100BX(clk25)
         end
      else
         begin
         if (~sync_all_disb_pll[1])
            begin
            if (prev2_mr100 & pll125_locked_pll[1] & ~txc_sel &
                    ~prev3_cont2_5 & prev2_cont2_5)
               begin
               txc_disb <= 1'b1;
               txc_sel  <= 1'b1;
               end

            else if (~prev2_mr100 & pll160_locked_pll[1] & txc_sel &
                     ~prev2_clk25 & prev1_clk25)
               begin
               txc_disb <= 1'b1;
               txc_sel  <= 1'b0;
               end

           else if (txc_disb & prev_x125_sel[7] & pll125_locked_pll[1] & 
                     txc_sel & prev2_mr100 & ~prev2_clk25 & prev1_clk25)
                 begin
                 txc_disb <= 1'b0;
                 txc_sel  <= txc_sel;
                 end

           else if (txc_disb & prev_x160_sel_7_pll & pll160_locked_pll[1] &
                     ~txc_sel & ~prev2_mr100 & ~prev3_cont2_5 & prev2_cont2_5)
                 begin
                 txc_disb <= 1'b0;
                 txc_sel  <= txc_sel;
                 end

           else
               begin
               txc_disb <= txc_disb;
               txc_sel  <= txc_sel;
               end

           end

         else if (prev2_mr100 & ~prev2_clk25 & prev1_clk25)
            begin
            txc_disb    <= 1'b1;
            txc_sel     <= txc_sel;
            end

        else if (~prev2_mr100 & ~prev3_cont2_5 & prev2_cont2_5)
            begin
            txc_disb    <= 1'b1;
            txc_sel     <= txc_sel;
            end

         else
            begin
            txc_disb    <= txc_disb;
            txc_sel     <= txc_sel;
            end

         end

      end // p_txc_disb

//------------------------------------------------------------------------------
// This process is for the de-glitching RCLK2_5_SC. When the mode is changed
// it is detected and the output clock is held in a high state while the logic
// determines the appropriate output for the next clock source
//------------------------------------------------------------------------------
//

   // Sync rclk2_5_good (synced to neg CLKPLL) to CLKPLL
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_sync1_rclk2_5_good_pll
      if (RESETPLL)
         begin
         sync1_rclk2_5_good_pll <= 1'b0;
         sync2_rclk2_5_good_pll <= 1'b0;
         rclk2_5_good_edge      <= 1'b0;
         end
      else
         begin
         sync1_rclk2_5_good_pll <= rclk2_5_good;
         sync2_rclk2_5_good_pll <= sync1_rclk2_5_good_pll;

         // This logic detects an edge change on the rclk2_5_good_edge input
         // which can be either a change to the recovered clock 0>1 or 
         // the self generated clock 1>0. 
         // When the edge is detected its kept set until forced clear
         if (~rclk2_5_good_edge)
           rclk2_5_good_edge <= sync1_rclk2_5_good_pll ^ sync2_rclk2_5_good_pll;

         // reset edge detection
         else if (res_rclk2_5_good_edge)
            rclk2_5_good_edge <= 1'b0;

         // Keep the existing state
         else
            rclk2_5_good_edge <= rclk2_5_good_edge;

         end
      end // p_sync1_rclk2_5_good_pll



   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_rclk2_5_disb
      if (RESETPLL)
         begin
         rclk2_5_disb            <= 1'b0;
         rclk2_5_good_pll        <= 1'b0;
         Flag_rclk2_5_int_to_ext <= 1'b0;
         Flag_rclk2_5_ext_to_int <= 1'b0;
         res_rclk2_5_good_edge   <= 1'b0;
         cont2_5_edge            <= 1'b0;
         end
      else
         begin
         
         // Change from Internally generated clock to
         // the recovered clock.
         // Setting disable
         if (rclk2_5_good_edge & sync2_rclk2_5_good_pll )
            begin
            // When clock is high 
            if (prev2_cont2_5 & ~prev3_cont2_5)
               begin
               rclk2_5_disb            <= 1'b1;
               rclk2_5_good_pll        <= 1'b0;
               Flag_rclk2_5_int_to_ext <= 1'b1;
               res_rclk2_5_good_edge   <= 1'b1;
               end
            end

         // Change from Internally generated clock to
         // the recovered clock.
         // setting mux
         else if (Flag_rclk2_5_int_to_ext & ~rclk2_5_good_pll)
            begin
            rclk2_5_disb            <= 1'b1;
            rclk2_5_good_pll        <= 1'b1;
            Flag_rclk2_5_int_to_ext <= 1'b1;
            res_rclk2_5_good_edge   <= 1'b0;
            end

         // Change from Internally generated clock to
         // the recovered clock.
         // turn of disable.
         else if (Flag_rclk2_5_int_to_ext)
            begin
            // to ensure a clean hand over the rx10_rclk2_5 must be high
            if (prev2_rx10_rclk2_5 & ~prev3_rx10_rclk2_5)
               begin
               rclk2_5_disb            <= 1'b0;
               rclk2_5_good_pll        <= 1'b1;
               Flag_rclk2_5_int_to_ext <= 1'b0;
               res_rclk2_5_good_edge   <= 1'b0;
               end
            end

         // Change from recovered clock to
         // the Internally generated clock.
         // Setting disable
         else if (rclk2_5_good_edge & ~sync2_rclk2_5_good_pll )
            begin
            // to ensure a clean hand over the rx10_rclk2_5 must be high
            // look for either a rx10_rclk2_5 rising edge or if it is a
            // constant high (Clock stopped)
            if ((prev2_rx10_rclk2_5 & ~prev3_rx10_rclk2_5) |
                (prev2_rx10_rclk2_5 & prev3_rx10_rclk2_5))
               begin
               rclk2_5_disb            <= 1'b1;
               rclk2_5_good_pll        <= 1'b1;
               Flag_rclk2_5_ext_to_int <= 1'b1;
               res_rclk2_5_good_edge   <= 1'b1;
               end

            // It is possible to have detected the edge and the rx10_rclk2_5
            // to be constant low (Clock stopped). To switch over wait for 
            // the second cont2_5 clock edge by setting a flag
            else if ((~prev2_rx10_rclk2_5 & ~prev3_rx10_rclk2_5) & 
                     (prev2_cont2_5 & ~prev3_cont2_5) & ~cont2_5_edge)
               cont2_5_edge <= 1'b1;

            // The second cont2_5 clock detected therefore push a clock
            // through the logic since the rx10_rclk2_5 has stopped
            else if ((~prev2_rx10_rclk2_5 & ~prev3_rx10_rclk2_5) & 
                     (prev2_cont2_5 & ~prev3_cont2_5) & cont2_5_edge)
               begin
               rclk2_5_disb            <= 1'b1;
               rclk2_5_good_pll        <= 1'b1;
               Flag_rclk2_5_ext_to_int <= 1'b1;
               res_rclk2_5_good_edge   <= 1'b1;
               cont2_5_edge            <= 1'b0;
               end
            end

         // Change from recovered clock to
         // the Internally generated clock.
         // setting mux
         else if (Flag_rclk2_5_ext_to_int & rclk2_5_good_pll)
            begin
            rclk2_5_disb            <= 1'b1;
            rclk2_5_good_pll        <= 1'b0;
            Flag_rclk2_5_ext_to_int <= 1'b1;
            res_rclk2_5_good_edge   <= 1'b0;
            end

         // Change from recovered clock to
         // the Internally generated clock.
         // turn of disable 
         else if (Flag_rclk2_5_ext_to_int)
            begin
            // When cont2_5 clock is high 
            if (prev2_cont2_5 & ~prev3_cont2_5)
               begin
               rclk2_5_disb            <= 1'b0;
               rclk2_5_good_pll        <= 1'b0;
               Flag_rclk2_5_ext_to_int <= 1'b0;
               res_rclk2_5_good_edge   <= 1'b0;
               end
            end

         // Default condition
         else
            begin
            rclk2_5_disb            <= rclk2_5_disb;
            rclk2_5_good_pll        <= rclk2_5_good_pll;
            Flag_rclk2_5_ext_to_int <= Flag_rclk2_5_ext_to_int;
            res_rclk2_5_good_edge   <= res_rclk2_5_good_edge;
            end
         end
      end // p_rclk2_5_disb

//------------------------------------------------------------------------------
// The RXC output will be a 2.5MHz clock selected from either a recovered clock
// or driven from a continious source.
//------------------------------------------------------------------------------
// 
   always @(rclk2_5_disb or rclk2_5_good_pll or RX10_RCLK2_5 or cont2_5)
      begin : p_RCLK2_5_SC
      // recovered clock  
      if (rclk2_5_good_pll)
         RCLK2_5_SC = RX10_RCLK2_5 | rclk2_5_disb;
      // Internally generated clock
      else
         RCLK2_5_SC = cont2_5 | rclk2_5_disb;
      end // p_RCLK2_5_SC
//------------------------------------------------------------------------------
// Logic for de-glitching rclk25 (source for RXC_SC output)
//------------------------------------------------------------------------------
   always @(negedge CLKPLL_IN or posedge RESETPLL)
      begin :p_rclk2_5_good
      if (RESETPLL)
         begin
         rclk2_5_good       <= 1'b0;
         end
      else
         begin
         rclk2_5_good       <= RCLK2_5_GOOD;
         end
      end // p_rclk2_5_good

//------------------------------------------------------------------------------
// A process used for the synchronisation of clocks to the CLKPLL_IN clock
// domain
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin
      if (RESETPLL)
         begin
         prev1_clk25        <= 1'b0;
         prev2_clk25        <= 1'b0;
         prev3_clk25        <= 1'b0;
         end
      else
         begin
         prev1_clk25        <= sqw25_125;
         prev2_clk25        <= prev1_clk25;
         prev3_clk25        <= prev2_clk25;
         end
      end

//------------------------------------------------------------------------------
// The output RXC_SC can be selected from 2 sources; 
// 1) RCLK2_5_SC the 2.5MHz clock for 10BaseT mode, 
// 2) rclk25 a 25MHz clock from 100BaseT. 
//
// These clocks can be considered as free running clocks dependent on the
// status of the PLL's. This logic ensures that the correct clock source
// is selected and that it is free from glitches. This is done by ensuring that
// the rxc_disb signal is active during the handover ensuring that the clock
// output remains in a High condition until new clock is sourced.
//
// There are a number of processes to perform the task
//------------------------------------------------------------------------------
//

   // x125_sel is a control signal that is used to indicate if
   // the design has a stable 125MHz clock (100BaseT mode) this
   // signal requires to be synched into the rclk25 environment
   // before being used.
   always @(posedge rclk25 or posedge RESET)
      begin : p_x125_sel_sync
      if (RESET)
         begin             // Default is 100BaseT mode
         x125_sel_sync1 <= 1'b1;
         x125_sel_sync2 <= 1'b1;
         x125_sel_sync3 <= 1'b1;
         x125_edge      <= 1'b0;
         end
      else
         begin
         x125_sel_sync1 <= x125_sel;
         x125_sel_sync2 <= x125_sel_sync1;
         x125_sel_sync3 <= x125_sel_sync2;

         // This logic detects an edge change on the x125_sel input which 
         // can be either a change to 100BaseT 0>1 or 10BaseT 1>0
         // When the edge is detected its kept set until forced clear
         if (~x125_edge)
            x125_edge <= x125_sel_sync2 ^ x125_sel_sync3;

         // reset edge detection
         else if (res_x125_edge)
            x125_edge <= 1'b0;

         // Keep the existing state
         else
            x125_edge <= x125_edge;
         end
      end // p_x125_sel_sync


   // Set the disable control signal. This should only be disabled if the
   // selected clock is in a high condition.
   always @(posedge rclk25 or posedge RESET)
      begin : p_rxc_disb
      if (RESET)
         begin
         meta_rclk2_5 <= 2'b00;
         rxc_disb      <= 1'b0;
         rxc_sel       <= 1'b1;
         Flag100_to_10 <= 1'b0;
         Flag10_to_100 <= 1'b0;
         res_x125_edge <= 1'b0;
         end

      else
         begin
         // Metastability registers to align the RCLK2_5_SC
         // with that of the rclk25
         meta_rclk2_5 <= { meta_rclk2_5[0],RCLK2_5_SC};

         // Changing from 100BaseT to 10BaseT mode
         // setting disable
         if (x125_edge & ~x125_sel_sync2)
            begin
            rxc_disb      <= 1'b1;
            rxc_sel       <= 1'b1;
            Flag100_to_10 <= 1'b1;
            res_x125_edge <= 1'b1;
            end

         // Changing from 100BaseT to 10BaseT mode
         // setting mux
         else if (Flag100_to_10 & rxc_sel)
            begin
            rxc_disb      <= 1'b1;
            rxc_sel       <= 1'b0;
            Flag100_to_10 <= 1'b1;
            res_x125_edge <= 1'b0;
            end

         // Changing from 100BaseT to 10BaseT mode
         // turn of disable.
         else if (Flag100_to_10)
            begin
            // to ensure a clean hand over the RCLK2_5_SC must be high
            // This clock is async to the clock used in this process
            // therefore will test a combined previous state with the
            // the existing state
            if (meta_rclk2_5[1] & RCLK2_5_SC)
               begin
               rxc_disb      <= 1'b0;
               rxc_sel       <= 1'b0;
               Flag100_to_10 <= 1'b0;
               res_x125_edge <= 1'b0;
               end
            end

         // Changing from 10BaseT to 100BaseT mode
         // setting disable
         else if (x125_edge & x125_sel_sync2)
            begin
            // to ensure a clean hand over the RCLK2_5_SC must be high
            // This clock is async to the clock used in this process
            // therefore will test a combined previous state with the
            // the existing state
            if (meta_rclk2_5[1] & RCLK2_5_SC)
               begin
               rxc_disb      <= 1'b1;
               rxc_sel       <= 1'b0;
               Flag10_to_100 <= 1'b1;
               res_x125_edge <= 1'b1;
               end
            end

         // Changing from 10BaseT to 100BaseT mode
         // setting mux
         else if (Flag10_to_100 & ~rxc_sel)
            begin
            rxc_disb      <= 1'b1;
            rxc_sel       <= 1'b1;
            Flag10_to_100 <= 1'b1;
            res_x125_edge <= 1'b0;
            end

         // Changing from 10BaseT to 100BaseT mode
         // turn of disable 
         else if (Flag10_to_100)
            begin
            rxc_disb      <= 1'b0;
            rxc_sel       <= 1'b1;
            Flag10_to_100 <= 1'b0;
            res_x125_edge <= 1'b0;
            end

         // Default condition
         else
            begin
            rxc_disb      <= rxc_disb;
            rxc_sel       <= rxc_sel;
            Flag100_to_10 <= Flag100_to_10;
            Flag10_to_100 <= Flag10_to_100;
            res_x125_edge <= res_x125_edge;
            end
         end
      end // p_rxc_disb

   // This is a mux to select between the two clocks. In order to change
   // clock sources the rxc_disb must be active before changing. This can
   // only be activate when the currently selected clock is high and then
   // changing the mux source. When activating the clock following the source
   // change to rxc_disb should be performed during the high phase of the clock.
   always @(rxc_sel or rclk25 or RCLK2_5_SC or rxc_disb)
      begin : p_RXC_SC
      if (rxc_sel)
         RXC_SC = rclk25 | rxc_disb;
      else
         RXC_SC = RCLK2_5_SC | rxc_disb;
      end //p_RXC_SC


//------------------------------------------------------------------------------
// Synchronise clocks for RXC_SC to PLL clock domain
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_prev1_rxc2_5
      if (RESETPLL)
         begin
         prev1_rx10_rclk2_5 <= 1'b0;
         prev3_rx10_rclk2_5 <= 1'b0;
         prev1_cont2_5      <= 1'b0;
         prev2_cont2_5      <= 1'b0;
         prev3_cont2_5      <= 1'b0;
         prev1_mr100        <= 1'b1;
         prev2_mr100        <= 1'b1;
         end
      else
         begin
         prev1_rx10_rclk2_5 <= RX10_RCLK2_5;
         prev3_rx10_rclk2_5 <= prev2_rx10_rclk2_5;
         prev1_cont2_5      <= cont2_5;
         prev2_cont2_5      <= prev1_cont2_5;
         prev3_cont2_5      <= prev2_cont2_5;
         prev1_mr100        <= MR_100MBS | ~RPD_100_DISB;
         prev2_mr100        <= prev1_mr100;
         end
      end // p_prev1_rxc2_5


//------------------------------------------------------------------------------
// A-N link status control signals
//------------------------------------------------------------------------------
//
   always @(negedge CLKPLL_IN or posedge RESETPLL)
      begin : p_prev2_rx10_rclk2_5
      if (RESETPLL)
         begin
         prev2_rx10_rclk2_5 <= 1'b0;
         an_link_down_plln  <= 2'b00;
         prev2_5_mr100      <= 1'b1;
         end
      else 
         begin
         prev2_rx10_rclk2_5 <= prev1_rx10_rclk2_5;
         an_link_down_plln  <= {an_link_down_plln[0], an_link_down};
         prev2_5_mr100      <= prev2_mr100;
         end
      end // p_prev2_rx10_rclk2_5

//------------------------------------------------------------------------------
// Synchronise disable signals to XTAL clock domain and use for
// edge detection
//------------------------------------------------------------------------------
//
   always @(posedge CLKXTAL or posedge RESET)
      begin : p_prev1xtal_10disb
      if (RESET)
         begin
         prev1xtal_10disb       <= 1'b1;
         prev2xtal_10disb       <= 1'b1;
         prev3xtal_10disb       <= 1'b1;
         prev1xtal_100disb      <= 1'b0;
         prev2xtal_100disb      <= 1'b0;
         prev3xtal_100disb      <= 1'b0;
         time_reset             <= 1'b0;
         twenty_us_exp_xtal     <= 2'b00;
         end
      else
         begin
         prev1xtal_10disb       <= RPD_10_DISB;
         prev2xtal_10disb       <= prev1xtal_10disb;
         prev3xtal_10disb       <= prev2xtal_10disb;
         prev1xtal_100disb      <= RPD_100_DISB;
         prev2xtal_100disb      <= prev1xtal_100disb;
         prev3xtal_100disb      <= prev2xtal_100disb;
         twenty_us_exp_xtal     <= {twenty_us_exp_xtal[0],
                                    twenty_us_expired};

         casex ({prev3xtal_10disb,prev3xtal_100disb,
                 prev2xtal_10disb,prev2xtal_100disb})

            // Start 20 usec timer for switching PLL speeds
            4'bx0x1 : begin      // 125 MHz going off
                      time_reset <= 1'b0; 
                      end

            4'b011x : begin      // 160 MHz going off
                      time_reset <= 1'b0; 
                      end

            4'b01x0 : begin      // 160 MHz going off entering autoneg mode
                      time_reset <= 1'b0; 
                      end

            4'b11x0 : begin      // 125 MHz coming on
                      time_reset <= 1'b0; 
                      end

            4'b110x : begin      // 125/160 MHz coming on
                      time_reset <= 1'b0; 
                      end

            default: if (twenty_us_exp_xtal)
                        // At end of 20 usec for PLL to re-lock
                        time_reset <= 1'b1;
                      else
                         time_reset <= time_reset; 

         endcase
         end
      end // p_prev1xtal_10disb

//------------------------------------------------------------------------------
// This process ensures that the control signals do not allow any glitches to
// occur on the txc2_5_sc clock
//------------------------------------------------------------------------------
//
   assign txc2_5ena_pll     = ~(txc2_5_disb | slvtxc2_5_pd | clk160_disb_pll);
   assign next_clk2_5_gate  = cnt160_next_3f & ~clk160_disb_pll; 
   assign next_gent2_5_gate = cnt160_next_3f & txc2_5ena_pll;

   always @(posedge CLKPLL_IN or posedge RESETPLL)
      begin : p_txc2_5_disb
      if (RESETPLL)
         begin
         txc2_5_disb      <= 1'b0;      // Initial not de-glitching
         slvtxc2_5_pd     <= 1'b1;      // Initial clock disabled
         mr_txc2_5_pd_pll <= 1'b0;
         end
      else
         begin
         mr_txc2_5_pd_pll <= prev2pll_10disb | ~prev2pll_100disb;

         if (({slvtxc2_5_pd,mr_txc2_5_pd_pll} == 2'b01) & next_gent2_5_gate)
            // If going from ON to OFF on rising edge of old clk
            begin
            txc2_5_disb  <= 1'b1;               // Hold clock high
            slvtxc2_5_pd <= mr_txc2_5_pd_pll;   // Update internal power-down
            end
         else if (({slvtxc2_5_pd,mr_txc2_5_pd_pll} == 2'b10) & next_clk2_5_gate)
            // If going from OFF to ON on rising edge of new clock
            begin
            txc2_5_disb  <= 1'b0;               // Release hold
            slvtxc2_5_pd <= mr_txc2_5_pd_pll;   // Update internal power-down
            end
         else
            begin
            txc2_5_disb  <= txc2_5_disb;
            slvtxc2_5_pd <= slvtxc2_5_pd;
            end
         end
      end // p_txc2_5_disb

//------------------------------------------------------------------------------
endmodule

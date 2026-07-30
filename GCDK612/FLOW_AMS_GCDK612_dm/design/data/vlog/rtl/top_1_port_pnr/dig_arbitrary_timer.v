// Created by ihdl
module dig_arbitrary_timer( 
                           //Inputs
                           CLKPLL_IN,
                           clk12_5_enable,
                           RESET, 

                           //Outputs
                           A_TIMER_DONE
                          );

//
// I/O Declarations
//
input      CLKPLL_IN;      // System clock 125MHz/160MHz
input      clk12_5_enable; // 12.5MHz Clock enable
input      RESET;          // reset signal

output     A_TIMER_DONE;   // Indicates maximum timer value

//
// I/O Type Declarations
//
wire      CLKPLL_IN;       // System clock
wire      clk12_5_enable;  // 12.5MHz clock enable
wire      RESET;

wire      A_TIMER_DONE;


//
// Parameter Declarations
//
// use +define+Tick_Step="<value>" on command line for faster simulation
`define Tick_Step 1
`define Arb_Timer_Max 24'hF80000 // 1.3s +/- 25% as per 40.4.5.2 of 802.3-2000
`define A_Timer_Size  24         // F7F490 @ 80ns -- 1EFE920 => 1.3s @ 40ns

//
// Internal Signal Declarations
//
reg [`A_Timer_Size-1:0] timer;

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
assign A_TIMER_DONE = (timer >= `Arb_Timer_Max);

//------------------------------------------------------------------------------
// A Counter that increments until reaching its maximum value. 
//------------------------------------------------------------------------------
//
   always @ (posedge CLKPLL_IN or posedge RESET)
      begin : p_a_timer
      if(RESET)
         timer <= 0;
      else if (clk12_5_enable)
         begin
         if(~A_TIMER_DONE)
            timer <= timer + `Tick_Step;
         else
            timer <= 0;
         end
      else
         timer <= timer;
      end // p_a_timer

endmodule

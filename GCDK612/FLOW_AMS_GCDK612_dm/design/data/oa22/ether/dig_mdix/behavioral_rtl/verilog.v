// Created by ihdl
module dig_mdix(
                //Inputs
                CLKPLL_IN,
                clk12_5_enable,
                RESET,
                T_PULSE,
                LINK_DET,
                A_TIMER_DONE,
                PHY_ID,
                MR_MDIX_DISB,
                MR_MDIX_FORCE,

                //Outputs
                MDI_STATUS
                );

//
// I/O Declarations
//
input        CLKPLL_IN;       // System clock 125MHz/160MHz
input        clk12_5_enable;  // 12.5MHz Clock enable
input        RESET;           // System reset
input        T_PULSE;         // Linkpulse reaching MDI
input        LINK_DET;        // Linkpulse = True or Link_Status = True
input        A_TIMER_DONE;    // Arbitrary timer Complete
input  [4:0] PHY_ID;          // PHY ID
input        MR_MDIX_DISB;    // Disable MDI/MDIX
input        MR_MDIX_FORCE;   // Only used when MDI/MDIX is disabled

output       MDI_STATUS;

//
// I/O Type Declarations
//
wire         CLKPLL_IN;       // System clock
wire         clk12_5_enable;  // 12.5MHz clock enable
wire         RESET;    
wire         T_PULSE;      
wire         LINK_DET;     
wire         A_TIMER_DONE; 
wire   [4:0] PHY_ID;       
wire         MR_MDIX_DISB; 
wire         MR_MDIX_FORCE;
reg          MDI_STATUS;

//
// Parameter Declarations
//
// use +define+Tick_Step="<value>" on command line for faster simulation
`define Tick_Step 1
`define Sample_Timer_Max  20'hBD000     // 62ms +/- 2ms as
                                        // per 40.4.5.2 of 802.3-2000
`define Timer_Size        20            // BD358 => 62ms @ 80ns clock period

// state variables
`define MDI_MODE          2'b00         // Original Configuration Mode
`define MDIX_MODE         2'b11         // Crossover Configuration Mode
`define RESET_TO_MDIX     2'b01         // intermediate state to reset timer
`define RESET_TO_MDI      2'b10         // intermediate state to reset timer


//
// Internal Signal Declarations
//
reg [`Timer_Size-1:0] timer;            // Timer used for sample time
reg [10:0]            rnd_seed;         // LSFR init seed
reg [1:0]             next_state;    
reg                   link_det;
reg [1:0]             prev_LINK_DET;
reg                   load;
wire                  sample_timer_done;
wire                  rnd;
wire                  init;

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign sample_timer_done = (timer >= `Sample_Timer_Max);
   assign rnd               = rnd_seed[10];
   assign init              = (RESET | (A_TIMER_DONE & ~T_PULSE & ~link_det));

//------------------------------------------------------------------------------
// This process sets the MDI_STATUS
//------------------------------------------------------------------------------
//
   always @(MR_MDIX_DISB or MR_MDIX_FORCE or next_state)
      begin : p_MDI_STATUS
      if (MR_MDIX_DISB)
         MDI_STATUS = MR_MDIX_FORCE;
      else 
         MDI_STATUS = (next_state == `MDIX_MODE || 
                       next_state == `RESET_TO_MDIX);
      end // p_MDI_STATUS

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @ (posedge CLKPLL_IN or posedge RESET)
      begin : p_load
      if (RESET)
         load <= 1'b1;
      else if (clk12_5_enable)
         load <= 1'b0;
      else
         load <= load;
      end // p_load

//------------------------------------------------------------------------------
// This process is a state machine
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge init)
      begin : p_next_state
      if(init)
         begin
         timer          <= 'b0;
         next_state     <= `MDI_MODE;
         link_det       <= 1'b0 ;
         prev_LINK_DET  <= 2'b0 ;
         end
      else if (clk12_5_enable)
         begin
         prev_LINK_DET <= {prev_LINK_DET[0], LINK_DET};
         case( next_state )
            `MDI_MODE: begin
                       if (init)
                          next_state <= `MDI_MODE;
                       else if (sample_timer_done & rnd & ~link_det & ~T_PULSE)
                          next_state <= `RESET_TO_MDIX;
                       else if (sample_timer_done & (~rnd | link_det))
                          next_state <= `RESET_TO_MDI;
                       else
                          next_state <= `MDI_MODE;
                       timer     <= timer + 1;
                       link_det  <= link_det | prev_LINK_DET[1] |
                                    prev_LINK_DET[0] | LINK_DET;
                       end

            `RESET_TO_MDIX: begin
                            if (init)
                               next_state <= `MDI_MODE;
                            else
                               next_state <= `MDIX_MODE;
                            timer      <= 'b0;
                            link_det   <= LINK_DET;
                            end

            `MDIX_MODE: begin
                        if (init)
                           next_state <= `MDI_MODE;
                        else if (sample_timer_done & ~rnd & ~link_det & ~T_PULSE)
                           next_state <= `RESET_TO_MDI;
                        else if (sample_timer_done & (rnd | link_det))
                           next_state <= `RESET_TO_MDIX;
                        else
                           next_state <= `MDIX_MODE;
                        timer    <= timer + 1;
                        link_det <= link_det | prev_LINK_DET[1] |
                                    prev_LINK_DET[0] | LINK_DET ;
                        end

            `RESET_TO_MDI: begin
                           next_state <= `MDI_MODE;
                           timer      <= 'b0;
                           link_det   <= LINK_DET;
                           end

             endcase
         end
      else
         begin
         timer          <= timer;
         next_state     <= next_state;
         link_det       <= link_det;
         prev_LINK_DET  <= prev_LINK_DET;
         end

      end // p_next_state

//------------------------------------------------------------------------------
// This process is a LFSR as defined by Figure 40-14 802.3-2000
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_lfsr
      if (RESET)
         rnd_seed <= 11'b0;
      else if (clk12_5_enable & load)
         rnd_seed <= {PHY_ID[4:0], PHY_ID[0], PHY_ID[3],
                      PHY_ID[1],~PHY_ID[2], ~PHY_ID[1], ~PHY_ID[4]};
      else if (clk12_5_enable)
         rnd_seed <= {rnd_seed[9:0], rnd_seed[8] + rnd_seed[10]};
      else
         rnd_seed <= rnd_seed;
      end // p_lfsr

endmodule // dig_mdix

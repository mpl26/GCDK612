// Created by ihdl
module dig_fef_gen(
                   //Inputs
                   CLKPLL_IN,
                   clk125_enable,
                   SIGNAL_STATUS,
                   RESET,
                   MR_AN_ENAB,
                   MR_FEF_DISB,
                   SERIALIZER_DATA,
                   MR_DIG_LOOP_BACK_ENAB,

                   //Outputs
                   FE_DATA
                   );

//
// I/O Declarations
//
input  CLKPLL_IN;             // System clock 125MHz or 160MHz
input  clk125_enable;         // 125MHz clock enable
input  SIGNAL_STATUS;         // Turns on Generate 
input  RESET;                 // System reset
input  SERIALIZER_DATA;       // Incoming Data Stream
input  MR_AN_ENAB;            // Autonegotiate enable
input  MR_FEF_DISB;           //
input  MR_DIG_LOOP_BACK_ENAB; // Disable FEF while in Dig Loopback

output FE_DATA;               // Outgoing Data Stream

//
// I/O Type Declarations
//
wire   CLKPLL_IN;
wire   clk125_enable;               
wire   SIGNAL_STATUS;        
wire   RESET;                
wire   SERIALIZER_DATA;      
wire   MR_AN_ENAB;           
wire   MR_FEF_DISB;          
wire   MR_DIG_LOOP_BACK_ENAB;

wire   FE_DATA;

//
// Parameter Declarations
//
//Constants set by 24.3.3.1 802.3u-1995
`define FEF_CYCLES       2'b11
`define FEF_ONES         7'b1010100
`define COUNTER84_SIZE   7

//
// Internal Signal Declarations
//
reg [`COUNTER84_SIZE-1:0] counter84;
reg [1:0]                 cycle_count;   
reg                       iTX;
wire                      counter84_done;
wire                      FE_EN;
reg [1:0]                 meta_signal_status;
   
//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign  counter84_done = (counter84 >= `FEF_ONES);
   assign  FE_EN          = (~MR_FEF_DISB & ~MR_DIG_LOOP_BACK_ENAB) & 
                            (~MR_AN_ENAB);
   assign  FE_DATA        = FE_EN & ~meta_signal_status[1] ? iTX : SERIALIZER_DATA;

//------------------------------------------------------------------------------
// SIGNAL_STATUS comes from the DSP logic and is synchronous to RXCLK125. The 
// signal requires to be converted into the CLKPLL clock domain before being
// used as a control signal
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_signal_status_sync
      if (RESET)
         meta_signal_status <= 2'b0;
      else
         meta_signal_status <= {meta_signal_status[0], SIGNAL_STATUS};
      end

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_counter84
      if (RESET)
         begin
         counter84   <=  'b0;
         cycle_count <= 2'b0;
         iTX         <= 1'b0;
         end
      else if (clk125_enable)
         begin      
         if (FE_EN & ~meta_signal_status[1])
            begin
            if (~counter84_done)
               begin   
               counter84 <= counter84 + 1;       
               iTX       <= 1'b1;         
               end
            else if (counter84_done)
               begin
               counter84 <=  'b0;            
               iTX       <= 1'b0;           
               end
            end
         else
            begin
            counter84   <=  'b0;    
            cycle_count <= 2'b0;     
            end       
         end
      else
         begin
         counter84   <= counter84;
         cycle_count <= cycle_count;
         iTX         <= iTX;
         end
      end // p_counter84

endmodule

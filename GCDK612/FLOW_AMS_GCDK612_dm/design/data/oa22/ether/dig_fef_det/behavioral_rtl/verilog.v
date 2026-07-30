// Created by ihdl
module dig_fef_det(
                   //Inputs
                   CLK125,
                   MR_AN_ENAB,
                   MR_FEF_DISB,
                   BYPASS_DESC_DATA,
                   RESET,

                   //Outputs
                   FE_FAULT
                   );

//
// I/O Declarations
//
input  CLK125;           // 125MHz Clock
input  MR_AN_ENAB;       // Autonegotiate enabled
input  MR_FEF_DISB;      //
input  BYPASS_DESC_DATA; //
input  RESET;            // System reset

output FE_FAULT;         //

//
// I/O Type Declarations
//
wire   CLK125;     
wire   MR_AN_ENAB; 
wire   MR_FEF_DISB;
wire   BYPASS_DESC_DATA; 
wire   RESET;      
wire   FE_FAULT;

//
// Parameter Declarations
//
//Constants set by 24.3.3.1 802.3u-1995
`define FEF_CYCLES       2'b11
`define FEF_ONES         7'b1010100
`define STRETCH          3'b110
`define COUNTER84_SIZE   7
`define STRETCHER_SIZE   3 

//
// Internal Signal Declarations
//
reg [`COUNTER84_SIZE-1:0] counter84;
reg [`STRETCHER_SIZE-1:0] stretch_count;
reg [1:0]                 cycle_count;   
reg [1:0]                 rx_sync;
reg                       start_stretch;
wire                      stretch_done;
wire                      counter84_done;
wire                      FE_EN;
reg [1:0]                 meta_fe_en;
wire                      sync_fe_en;

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

assign stretch_done   = (stretch_count == `STRETCH);
assign counter84_done = (counter84 >= `FEF_ONES);
assign FE_FAULT       = (cycle_count == `FEF_CYCLES);
assign FE_EN          = ~MR_FEF_DISB & ~MR_AN_ENAB;
   
//------------------------------------------------------------------------------
// Resync FE_EN
//------------------------------------------------------------------------------
   always @(posedge CLK125 or posedge RESET)
      begin :p_meta_fe_en
      if (RESET)
         meta_fe_en <= 2'b00;
      else
         meta_fe_en <= {meta_fe_en[0], FE_EN};
      end

   assign sync_fe_en = meta_fe_en[1];
//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLK125 or posedge RESET)
      begin :p_cycle_count
      if (RESET)
         begin
         counter84     <= 7'b0;
         cycle_count   <= 2'b0;
         stretch_count <= 3'b0;
         rx_sync       <= 2'b0;
         end      
      else
         begin
         if (sync_fe_en)
            begin
            rx_sync <= {rx_sync[0], BYPASS_DESC_DATA};
            if (rx_sync[1] == 1'b1)
               begin        
               if(cycle_count != 0 | !counter84_done)
                  counter84 <= counter84 + 1;
               end
            else
               begin
               counter84 <= 'b0;                       
               if (counter84_done)
                  cycle_count <= cycle_count + 1;
               else
                  cycle_count <= 2'b0;
               end

            if (start_stretch)
               stretch_count <= stretch_count + 1;
            else
               stretch_count <= 'b0;

            if (FE_FAULT & stretch_done)
               cycle_count <= 2'b0;
            end
         else
            begin
            cycle_count <= 2'b0;
            counter84   <=  'b0;       
            end
         end 
      end // p_cycle_count

//------------------------------------------------------------------------------
// This process needs attention as it is not reset and uses a self generated
// clock
//------------------------------------------------------------------------------
//
   always @(posedge CLK125 or posedge RESET)
      begin : p_start_stretch
      
      if (RESET)
         start_stretch <= 1'b0;
      else if (stretch_done)
         start_stretch <= 1'b0;
      else if (FE_FAULT)
         start_stretch <= 1'b1;
      else
         start_stretch <= start_stretch;
      end // p_start_stretch

endmodule

// Created by ihdl
module dig_gen_rclk25(
                      //Inputs
                      RXCLK125,
                      aligned,
                      clk_aligned,
                      RESET_SC,

                      //Outputs
                      RXC25N,
                      rclk25_pos_pos_en,
                      rclk25_pos_neg_en 
                      );
//
// I/O Declarations
//
input        RXCLK125;           // 125MHz clock
input        aligned;            // 
input        clk_aligned;        // 
input        RESET_SC;           // System reset

output       RXC25N;             // Inverted 25MHz clock
output       rclk25_pos_pos_en;  // Positive 25Mhz edge aligned to pos125
output       rclk25_pos_neg_en;  // Positive 25Mhz edge aligned to neg125

//
// I/O Type Declarations
//
wire         RXCLK125;   
wire         aligned;    
wire         clk_aligned;
wire         RESET_SC;   

wire         RXC25N;
reg          rclk25_pos_pos_en;  // Positive 25Mhz edge aligned to pos125
reg          rclk25_pos_neg_en;  // Positive 25Mhz edge aligned to neg125

//
// Internal Signal Declarations
//
reg   [1:0]  count_posedge;     // Count RXCLK125 posedges
reg   [1:0]  count_negedge;     // Count RXCLK125 negedges
reg          phase_1;           //
reg          phase_2;           //
reg          phase_1_b;         //
reg          phase_2_b;         //
wire         RXC25;             //
wire         RXC25b;            //

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
// Create RXC25 clock
   assign RXC25b = (phase_1 ^ phase_2);
   assign RXC25  = (phase_1_b ^ phase_2_b);
   assign RXC25N = !RXC25;

//------------------------------------------------------------------------------
// This process....
//------------------------------------------------------------------------------
//
   always @(negedge RXCLK125 or posedge RESET_SC)
      begin : p_phase_1_b
      if (RESET_SC)
         phase_1_b <= 1'b0;
      else
         phase_1_b <= phase_1;
      end // p_phase_1_b

//------------------------------------------------------------------------------
// This process....
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET_SC)
      begin : p_phase_2_b
      if (RESET_SC)
         phase_2_b <= 1'b0;
      else
         phase_2_b <= phase_2;
      end // p_phase_2_b


//------------------------------------------------------------------------------
// This process....
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET_SC)
      begin : p_count_posedge
      if (RESET_SC)
         begin
         phase_1       <= 1'b0;
         count_posedge <= 2'b00;
         end
      else
         begin
         if (clk_aligned && !aligned )
            count_posedge <= 2'b11;
         else
            begin
            if (count_posedge == 2'b10)
               phase_1 <= !phase_2;
            if (!RXC25b) 
               count_posedge <= count_posedge + 2'b01;
            else
               count_posedge <= 2'b00;
            end
         end
      end // p_count_posedge

//------------------------------------------------------------------------------
// This process....
//------------------------------------------------------------------------------
//
   always @(negedge RXCLK125 or posedge RESET_SC)
      begin : p_count_negedge
      if (RESET_SC)
         begin
         phase_2       <= 1'b0;
         count_negedge <= 2'b00;
         end
      else
         begin
         if (clk_aligned && !aligned )
            count_negedge <= 2'b01;
         else
            begin
            if (count_negedge == 2'b10)
               phase_2 <= phase_1;
            if (RXC25b) 
               count_negedge <= count_negedge + 2'b01;
            else
               count_negedge <= 2'b00;
            end
         end
      end // p_count_negedge

//------------------------------------------------------------------------------
// These processes are used to generate clock enables for the 25Mhz clock.
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET_SC)
      begin : p_rclk25_pos_pos_en
      if (RESET_SC)
         rclk25_pos_pos_en <= 1'b0;
      else if (count_posedge == 2'b10)
         rclk25_pos_pos_en <= 1'b1;
      else
         rclk25_pos_pos_en <= 1'b0;
      end // p_rclk25_pos_pos_en

   always @(negedge RXCLK125 or posedge RESET_SC)
      begin : p_rclk25_pos_neg_en
      if (RESET_SC)
         rclk25_pos_neg_en <= 1'b0;
      else if (count_posedge == 2'b10)
         rclk25_pos_neg_en <= 1'b1;
      else
         rclk25_pos_neg_en <= 1'b0;
      end // p_rclk25_pos_pos_en


endmodule

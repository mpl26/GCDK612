// Created by ihdl
module dig_rx10_ser2par (
                         //Inputs
                         DEC10_DATA,
                         DEC10_RCLK_GOOD,
                         DEC10_RCLK10,
                         MR_SYMBOL_MODE,
                         RESET,

                         //Outputs
                         RX10_DV,
                         RX10_DATA,
                         RX10_ACTIVE,
                         RX10_RCLK2_5,
                         DEC10_DATA_D1,
                         RCLK2_5_GOOD
                         );

//
// I/O Declarations
//
input        DEC10_DATA;       // Serial data from manchester decoder
input        DEC10_RCLK_GOOD;  // Recovered clock is locked
input        DEC10_RCLK10;     // Recovered 10 MHz clock from manch dec
input        MR_SYMBOL_MODE;   // 1= Symbol receive mode (i.e. disable)
input        RESET;            // System Reset

output       RX10_DV;          // MII Data Valid
output [3:0] RX10_DATA;        // MII Data
output       RX10_ACTIVE;      // SFD sets & reset when DEC10_RCLK_GOOD removed
output       RX10_RCLK2_5;     // Generated 2.5 MHz clock from recovered clock
output       DEC10_DATA_D1;    // Stable Recovered Data
output       RCLK2_5_GOOD;     // Recovered 2.5 MHz clock is good

//
// I/O Type Declarations
//
wire         DEC10_DATA;     
wire         DEC10_RCLK_GOOD;
wire         DEC10_RCLK10;   
wire         MR_SYMBOL_MODE; 
wire         RESET;          

reg          RX10_DV;
wire [3:0]   RX10_DATA;
reg          RX10_ACTIVE;
reg          RX10_RCLK2_5;
reg          DEC10_DATA_D1;
reg          RCLK2_5_GOOD;

//
// Internal Signal Declarations
//
reg          data_d2;
reg          data_d3;
reg          data_d4;
reg          data_d5;
reg          data_d6;
reg          early_dv;
reg          prev_actv;
reg          aligned;
reg          clk_count;   // 1-bit clock counter
reg          sfd_found;   // SFD found in data stream

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//

//------------------------------------------------------------------------------
// This process is used to shift data in aligned to the positive edge of the
// DEC10_RCLK10 clock. This is a six bit register in which the alignment
// effects the bit selection
//------------------------------------------------------------------------------
//
   always @(negedge DEC10_RCLK10 or posedge RESET)
      begin : p_shift_reg
      if (RESET)
         begin
         DEC10_DATA_D1 <= 1'b1;
         data_d2 <= 1'b1;
         data_d3 <= 1'b1;
         data_d4 <= 1'b1;
         data_d5 <= 1'b1;
         data_d6 <= 1'b1;
         end
      else
         begin
         DEC10_DATA_D1 <= DEC10_DATA;
         data_d2 <= DEC10_DATA_D1;
         data_d3 <= data_d2;
         data_d4 <= data_d3;
         data_d5 <= data_d4;
         data_d6 <= data_d5;
         end
      end // p_shift_reg

   assign RX10_DATA = aligned ? {DEC10_DATA_D1,data_d2,data_d3,data_d4} :
                                {data_d3,data_d4,data_d5,data_d6};

//------------------------------------------------------------------------------
// This process 
//------------------------------------------------------------------------------
//
   always @(posedge DEC10_RCLK10 or posedge RESET)
      begin : p_clk_count
      if (RESET)
         begin
         RX10_RCLK2_5 <= 1'b1;
         clk_count <= 1'b0;
         prev_actv <= 1'b0;
         RCLK2_5_GOOD <= 1'b0;
         end
      else
         begin
         prev_actv <= RX10_ACTIVE;
         if ((DEC10_RCLK_GOOD | RCLK2_5_GOOD) & !MR_SYMBOL_MODE)
            begin
            if (DEC10_RCLK_GOOD)
               RCLK2_5_GOOD <= 1'b1;
            if (RX10_ACTIVE & !prev_actv)
               begin
               if (DEC10_DATA_D1 == 1'b0)
                  begin
                  RX10_RCLK2_5 <= ~RX10_RCLK2_5;
                  clk_count <= 1'b0;
                  end
               else
                  clk_count <= 1'd1;
               end
            else
               begin
               if (clk_count)
                  RX10_RCLK2_5 <= ~RX10_RCLK2_5;
               if (RX10_RCLK2_5 & !DEC10_RCLK_GOOD)
                  RCLK2_5_GOOD <= 1'b0;
               clk_count <= ~clk_count;
               end
            end
         end
      end // p_clk_count

//------------------------------------------------------------------------------
// This process is used to indicate that the receive path is active. This is
// accomplished by looking for preamble data.
//------------------------------------------------------------------------------
//
   always @(negedge DEC10_RCLK10 or posedge RESET)
      begin : p_RX10_ACTIVE
      if (RESET)
         RX10_ACTIVE <= 1'b0;
      else
         begin

         // Receiving data, but not in sysmbol mode
         if (DEC10_RCLK_GOOD & !MR_SYMBOL_MODE)

            // Check if we are receiving preamble data setting
            // RX10_ACTIVE appropriately
            if ({DEC10_DATA_D1,data_d2,data_d3,data_d4} == 4'b0101)
               RX10_ACTIVE <= 1'b1;
            else
               RX10_ACTIVE <= RX10_ACTIVE;

         // Nolonger in an active state
         else
            RX10_ACTIVE <= 1'b0;
         end
      end // p_RX10_ACTIVE

//------------------------------------------------------------------------------
// This process is used to indicate that a start of frame delimiter has been
// found and aligns the data with the 
//------------------------------------------------------------------------------
//
   always @(negedge DEC10_RCLK10 or posedge RESET)
      begin : p_sfd_found
      if (RESET)
         begin
         early_dv <= 1'b0;
         RX10_DV <= 1'b0;
         aligned <= 1'b1;
         sfd_found <= 1'b0;
         end
      else
         begin
         if (!sfd_found)
            if (!RX10_RCLK2_5 & clk_count)
               begin
               if ({DEC10_DATA,DEC10_DATA_D1,data_d2,data_d3} ==4'b0101)
                  begin
                  early_dv <= 1'b1;     // Allow time for clock de-glitching
                  RX10_DV <= early_dv;
                  end
               if ({DEC10_DATA,DEC10_DATA_D1,data_d2,data_d3} == 4'b1101)
                  sfd_found <= 1'b1;
               else if ({data_d2,data_d3,data_d4,data_d5} == 4'b1101)
                  begin
                  aligned <= 1'b0;
                  sfd_found <= 1'b1;
                  end
               else;
               end
            else;
         else
            if (!RCLK2_5_GOOD)
               begin
               RX10_DV <= 1'b0;
               early_dv <= 1'b0;
               aligned <= 1'b1;
               sfd_found <= 1'b0;
               end
         end
      end // p_sfd_found


endmodule

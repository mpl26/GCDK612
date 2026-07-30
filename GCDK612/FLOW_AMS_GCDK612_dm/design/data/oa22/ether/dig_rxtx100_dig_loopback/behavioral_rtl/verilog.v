// Created by ihdl
module dig_rxtx100_dig_loopback (
                                 //Inputs
                                 MR_DIG_LOOP_BACK_ENAB,
                                 MLT3ENC_DATA,
                                 MLT3_DATAIN,
                                 RXCLK125,
                                 RESET,

                                 //Outputs
                                 LPBK_MLT3DATA
                                 );

//
// I/O Declarations
//
input         MR_DIG_LOOP_BACK_ENAB;  // Digital Loopback
input  [1:0]  MLT3ENC_DATA;           // Output from Transmitter
input  [1:0]  MLT3_DATAIN;            // Input from Equalizer
input         RXCLK125;               // Receive path clock
input         RESET;                  // System reset

output [1:0]  LPBK_MLT3DATA;          // Output Data

//
// I/O Type Declarations
//
wire          MR_DIG_LOOP_BACK_ENAB;
wire   [1:0]  MLT3ENC_DATA;         
wire   [1:0]  MLT3_DATAIN;          
wire          RXCLK125;             
wire          RESET;

reg    [1:0]  LPBK_MLT3DATA;        

//
// Internal Signal Declarations
//
reg    [1:0]  loopback_data_clkn;     // sample at negedge of the clock
reg    [1:0]  loopback_data;          // Output Data
reg    [1:0]  equalizer_data_clkn;    // sample at negedge of the clock
reg    [1:0]  equalizer_data;         // Equalizer input data

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//


//------------------------------------------------------------------------------
// This process capture the MLT3 data on the negative edge of the RXCLK125 then 
// retimes the data to align with the positive edge before passing the data
// through the mux.
//------------------------------------------------------------------------------
//
   always @(negedge RXCLK125 or posedge RESET)
      begin : p_mlt3data_clkn
      if (RESET)
         begin
         loopback_data_clkn  <= 2'b0;
         equalizer_data_clkn <= 2'b0;
         end
      else
         begin
         loopback_data_clkn  <= MLT3ENC_DATA;
         equalizer_data_clkn <= MLT3_DATAIN;
         end
      end // p_mlt3data_clkn

   always @(posedge RXCLK125 or posedge RESET)
      begin : p_mlt3data_clk
      if (RESET)
         begin
         loopback_data  <= 2'b0;
         equalizer_data <= 2'b0;
         end
      else
         begin
         loopback_data  <= loopback_data_clkn;
         equalizer_data <= equalizer_data_clkn;
         end
      end // p_mlt3data_clk

   always @ (MR_DIG_LOOP_BACK_ENAB or loopback_data or equalizer_data)
      begin : p_mlt3data_mux
      if (MR_DIG_LOOP_BACK_ENAB)
         LPBK_MLT3DATA = loopback_data;
      else
         LPBK_MLT3DATA = equalizer_data;
      end // p_mlt3data_mux




endmodule

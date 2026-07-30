// Created by ihdl
module dig_rx100_mlt3_dec(
                          //Inputs
                          LPBK_MLT3DATA,
                          RXCLK125,
                          RX100_STABLE,

                          //Outputs
                          MLT3DEC_DATA
                          );
//
// I/O Declarations
//
input  [1:0]  LPBK_MLT3DATA;   // From loopback mux
input         RXCLK125;        // 125 MHz clock
input         RX100_STABLE;    //
   
output        MLT3DEC_DATA;    // MLT3 Decoded Data

//
// I/O Type Declarations
//
wire   [1:0]  LPBK_MLT3DATA;
wire          RXCLK125;    
wire          RX100_STABLE;

reg           MLT3DEC_DATA;

//
// Internal Signal Declarations
//
wire   [1:0]  decoder_input;
reg    [1:0]  prev_data;
wire          datachange;
wire          reset_state;

//
// Parameter Declarations
//
// none
//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign decoder_input = LPBK_MLT3DATA;
   assign datachange    = (decoder_input[1] ^ prev_data[1]) | 
                          (decoder_input[0] ^ prev_data[0]);
   assign reset_state   = !RX100_STABLE;

//------------------------------------------------------------------------------
// This process is used to provide the MLT3 decoded data
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge reset_state)
      begin : p_MLT3DEC_DATA
      if (reset_state)
         begin
         prev_data    <= 2'b00; // previous data initializer
         MLT3DEC_DATA <= 1'b0;
         end
      else
         begin
         prev_data <= decoder_input;
         if (datachange)
            MLT3DEC_DATA <= 1'b1;
         else 
            MLT3DEC_DATA <=1'b0;
         end
      end // p_MLT3DEC_DATA

endmodule

// Created by ihdl
module dig_tx100_mlt3_enc(
                          //Inputs
                          BYPASS_SCRAMBLER_DATA,
                          CLKPLL_IN,
                          clk125_enable,
                          RESET,
                          MR_100MBS,

                          //Outputs
                          MLT3ENC_DATA
                          );

//
// I/O Declarations
//
input          BYPASS_SCRAMBLER_DATA;  // From Bypass Scrambler Mux
input          CLKPLL_IN;              // System clock 125MHz or 160MHz
input          clk125_enable;          // 125MHz clock enable
input          RESET;                  // System reset
input          MR_100MBS;              // 100BaseT mode

output  [1:0]  MLT3ENC_DATA;           // MLT3 Data

//
// I/O Type Declarations
//
wire           BYPASS_SCRAMBLER_DATA;
wire           CLKPLL_IN;
wire           clk125_enable;               
wire           RESET;                
wire           MR_100MBS;            

reg     [1:0]  MLT3ENC_DATA;         
//
// Internal Signal Declarations
//
reg     [1:0]  Next_state;            // New State Identifier
reg            datareg;               // data register
wire           reset_state;

//
// Parameter Declarations
//
`define	zeroup   2'b00               // Set values for slope control
`define	posone   2'b01
`define	negone   2'b10
`define	zerodown 2'b11

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign reset_state = !MR_100MBS;

//------------------------------------------------------------------------------
// This process selects the MLT3ENC_DATA
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_MLT3ENC_DATA
      if (RESET)
         begin
         datareg      <= 1'b0;
         MLT3ENC_DATA <= `zeroup;
         end
      else if (reset_state)
         begin
         datareg      <= 1'b0;
         MLT3ENC_DATA <= `zeroup;
         end
      else if (clk125_enable)
         begin
         datareg      <= BYPASS_SCRAMBLER_DATA;
         MLT3ENC_DATA <= Next_state;
         end
      else
         begin
         datareg      <= datareg;
         MLT3ENC_DATA <= MLT3ENC_DATA;
         end
      end // p_MLT3ENC_DATA
  
//------------------------------------------------------------------------------
// This process selects the Next_state 
//------------------------------------------------------------------------------
//
   always @(MLT3ENC_DATA or datareg)
      begin : p_Next_state
      case (MLT3ENC_DATA)
         `zeroup:   Next_state = (datareg) ? `posone   : `zeroup;
         `posone:   Next_state = (datareg) ? `zerodown : `posone;
         `negone:   Next_state = (datareg) ? `zeroup   : `negone;
         `zerodown: Next_state = (datareg) ? `negone   : `zerodown;
         default:   Next_state = `zeroup;
      endcase 
      end // p_Next_state

endmodule

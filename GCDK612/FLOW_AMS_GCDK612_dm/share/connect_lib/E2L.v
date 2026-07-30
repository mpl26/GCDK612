// 'E2L.vams' - Verilog-AMS connection rules file.
// last revised:  2/06/03 (ronv)
//
// REVISION HISTORY:
// Created:  3/13/02 ronv
// Updated:  4/17/02 ronv - allow initial X state.
// Updated:  6/20/02 ronv - matched up with L2E writeback logic.
// Updated:  8/30/02 ronv - removed optional input cap
// Updated:  9/14/02 ronv - added tr for ttol reference, loosened default ttol
// Updated: 10/22/02 ronv - updated from @cross to @above format, limit vtol
// Updated: 10/30/02 ronv - improved initialization
// Updated:  2/06/03 ronv - added hysteresis to A2D conversion
//
//============================================================================
// E2L (Ain, Dout)
// - Electrical-to-Logic connect module.
//
// DESCRIPTION:
//  Reasonably comprehensive electrical-to-logic conversion routine.
//  Logic output will change to X if input stays between thresholds too long.
//
//  If the supply voltage parameter, vsup, is set, the threshold voltages
//  will default to 1/3 and 2/3 of that value, or they may be defined 
//  explicitely.
//
// INCLUDE FILES:
`include "disciplines.vams"
`timescale 1ns / 100ps

//============================================================================
connectmodule E2L (Ain, Dout);
  input Ain; electrical Ain;                     // electrical input
  output Dout; logic Dout;                       // logic output

// INSTANCE PARAMETERS:
  parameter real vsup=1.8 from (0:inf);          // nominal supply voltage
  parameter real vthi=vsup/1.5 from (-inf:vsup); // upper input threshold
  parameter real vtlo=vthi/2 from (-inf:vthi);   // lower threshold
  parameter real vtol=vsup/100 from (0:(vthi-vtlo)/4]; // voltage tolerance
  parameter real tr=0.2n from (0:1m);            // risetime (for defaults)
  parameter real txdel=4*tr;                     // time midrange til output X
  parameter real ttol=tr/4;                      // time tolerance of crossing

// LOCAL VARIABLES:
  reg Dreg;                // output register
  reg Xin;                 // Tx control registers
  real txdig;              // tx in timescale units
  real vtlox,vthix;        // thresholds for transition to X state
  
//============================================================================
  initial begin
    txdig=txdel/1n;        // digital delay midlevel to X  (ASSUMES TIMESCALE)
    Dreg=(V(Ain)>vthi)? 1'b1 : (V(Ain)<vtlo)? 1'b0 : 1'bx;  // initial level
    Xin=0;                 // initially not in X delay region.
    vtlox=vtlo+2*vtol;     // lo-to-x threshold point
    vthix=vthi-2*vtol;     // hi-to-x threshold point
  end
// Convert analog signal to high/low and X/notX:
  always @(above(V(Ain)-vthi,ttol,vtol))
      begin Dreg=1; Xin=0; end                   // analog XtoH
  always @(above(vtlo-V(Ain),ttol,vtol))
      begin Dreg=0; Xin=0; end                   // analog XtoL
  always @(above(vthix-V(Ain),ttol,vtol))
      if (V(Ain)<vthi && Dreg!==1'bx) Xin=1;     // analog HtoX
  always @(above(V(Ain)-vtlox,ttol,vtol))
      if (V(Ain)>vtlo && Dreg!==1'bx) Xin=1;     // analog LtoX
// Wait for txdel before driving output to X:
  always @(posedge(Xin)) begin :GoToX            // input changed to X
    #(txdig)                                     // wait for X time delay
    if (V(Ain)>vtlo && V(Ain)<vthi) Dreg=1'bx;   // goto X if still between
    else Xin=0;                                  // else clear the X flag
  end
  always @(negedge(Xin)) disable GoToX;          // cancel out-to-X on Xin=0
  assign  Dout=Dreg;                             // assign register to output
endmodule

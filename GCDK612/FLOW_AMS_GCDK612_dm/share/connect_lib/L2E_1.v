// 'L2E_1.vams' - Verilog-AMS connection rules file.
// last revised: 10/22/02 (ronv)
//
// REVISION HISTORY:
// Created:  6/21/02 ronv - updated from L2E_0 with full 4 state operation 
// Updated:  6/26/02 ronv - updated comments
// Updated:  8/30/02 ronv - removed optional output cap
// Updated: 10/22/02 ronv - loosened unused params
//
//============================================================================
// L2E_1 (Din,Aout) 
// - Simple four-level logic to electrical conversion.
//
// Unidirectional logic to electrical conversion.  All four logic levels
// are included (01xz), but no analog loading effects are fed back.  
//
// Output voltages will choose vhi, vlo, or vxz, based on the digital input,
// with all transitions taking a risetime of tr.
//
// Output resistance is defined as:   R = rout*(1+80K*pow(Kres,5))
// So Kres=0 results in rout (for high or low), Kres=1 results in 80K*rout
// (for high impedance case), and Kres=-0.1 results in rout/5 (to model 
// the X case). Actual output resistance calculation will use a transition
// statement to shift the Kres value using the same risetime of tr.
//
// For rout=200 ohms, the variation of R with Kres is:
//   Kres:  -0.1   0    0.2   0.4    0.6   0.8   1.0
//   Rout:   40   200   5K    160K   1.2M   5M   16M
//
// LIMITATIONS:
//  Loading effects on the analog side are not fed back to the digital 
//  side in this model.  If there are significant delays (due to capacitive
//  loading) or logical errors (due to drive conflicts) on the analog side,
//  and the digital side is also driving other digital gates, a more complete
//  connect module module that includes digital feedback (L2E) should be used.

// INCLUDE FILES:
`include "disciplines.vams"
`timescale 1ns / 100ps

//============================================================================
connectmodule L2E_1(Din,Aout);
 input Din; logic Din;          // digital input signal
 output Aout; electrical Aout;  // analog output signal
 
 parameter real vsup=1.8 from (0:inf);       // nominal supply voltage
 parameter real vlo=0;                       // output voltage levels
 parameter real vhi=vsup from (vlo:vsup];    //
 parameter real vxz=(vhi+vlo)/2; // X or Z output voltage
 parameter real tr=0.2n;        // risetime of analog output
 parameter real rout=200;       // output resistance

 reg Dreg;                      // output is a register
 real Vstate,Kres;              // output voltage & resistance states
 real Vout,Rval;                // output V & R with transitions
 
 assign Din = Dreg;             // assign digital value to input pin. 
 initial begin
   Dreg = Din;                  // initial logic writeback
   Vstate = (Din===1'b0)? vlo : (Din===1'b1)? vhi : vxz;  // initial V
   Kres = (Din===1'bz)? 1 : 0;                            // initial R
 end
 always @Din begin
   Dreg = Din;                  // logic writeback follows level.
   case(Din)
     1'b0:  begin  Vstate=vlo; Kres=0;    end  // low state
     1'b1:  begin  Vstate=vhi; Kres=0;    end  // high state
     1'bx:  begin  Vstate=vxz; Kres=-0.1; end  // X (impedance is 0.2*rout)
     1'bz:  begin  Vstate=vxz; Kres=1;    end  // Z (impedance is 80K*rout)
   endcase
 end
 analog begin
   Vout = transition(Vstate,0,tr,tr);             // add risetimes to Vstate
   Rval = rout*(1+80K*pow(transition(Kres,0,tr,tr),5)); // resistor with rise
   I(Aout) <+ (V(Aout)-Vout)/Rval;                // drive output 
 end
endmodule

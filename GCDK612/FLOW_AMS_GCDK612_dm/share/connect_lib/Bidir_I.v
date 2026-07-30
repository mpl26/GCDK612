// 'Bidir_0.vams' - Verilog-AMS connection rules file.
// last revised: 11/11/02 (ronv)
//
// REVISION HISTORY:
// Created:  4/19/02 ronv
// Updated:  6/26/02 ronv - updated with resistance model from L2E_1
// Updated:  9/03/02 ronv - removed optional output cap
// Updated:  9/10/02 ronv - removed analog X crossthru, loosened ttol
// Updated: 10/22/02 ronv - use @above format with analog disable, limit vtol
// Updated: 11/11/02 ronv - allow analog level to supercede digital X input
//
//============================================================================
// Bidir_0 (Din, Aout)
// - Simple Bidirectional connect module (3 state switchable direction)
//
// Analog output follows two-state digital input (1,0). When the digital
// input goes to Z or X, analog drive impedance will go to Roff=80K*rout or
// 7*rout, respectively, and actual measured voltage on analog side will be
// used to drive digital side.  If analog is between thresholds, logic level
// will initially be X, but will switch to two-level high/low form once it
// reaches a threshold.
//
// Analog output voltages will choose vhi, vlo, or vxz, based on the
// digital input, with all transitions taking a risetime of tr.
//
// Output resistance is defined as:   R = rout*(1+80K*pow(Kres,5))
// So Kres=0 results in rout (for high or low), Kres=1 results in 80K*rout
// (for high impedance case), and Kres=0.15 results in rout*7 (to model 
// the X case, such that analog can supercede logic X level). Actual
// output resistance calculation will use a transition statement to shift
// the Kres value using the same risetime of tr.
//
// LIMITATIONS:
// Loading effects are not considered in this model, so analog float-to-X
// will not always be fed back to digital side.  Drive is either just
// digital-to-analog or analog-to-digital.  See the "Bidir" model for a
// full digital-to-analog-to-digital comprehensive model.

// INCLUDE FILES:
`include "disciplines.vams"
`timescale 1ns / 100ps

//============================================================================
connectmodule Bidir_0(Din,Aout);
 inout Din; logic Din;          // digital signal
 inout Aout; electrical Aout;   // analog signal
 
 parameter real vsup=1.8 from (0:inf);       // nominal supply voltage
 parameter real vlo=0;                       // output voltage levels
 parameter real vhi=vsup from (vlo:vsup];    //
 parameter real vthi=vhi/1.5 from (vlo:vhi); // upper threshold (def Vhi*2/3)
 parameter real vtlo=vthi/2 from (vlo:vthi); // lower threshold (def Vhi*1/3)
 parameter real vxz=(vthi+vtlo)/2 from (vtlo:vthi);  // X or Z output voltage
 parameter real vdis=vhi-vlo+1; // threshold offset to disable @above
 parameter real tr=0.2n;        // risetime of analog output
 parameter real rout=200;       // output resistance
 parameter real vtol=vsup/100;  // threshold detect voltage tolerance
 parameter real ttol=tr/3;      // time tol of crossing

 reg Dreg;                      // register to hold output
 reg Kz;                        // high-impedance flag
 real Vstate,Kres;              // output voltage & resistance states
 real Vout,Rval;                // output V & R with transitions
 real Vos;                      // offset variable for @above disable
 
//============================================================================
 assign Din = Dreg;                      // assign digital value to digital pin 
 initial begin
   Dreg = Din;                           // logic feedback of logic value
   if (Din===1'b0 || Din===1'b1) begin   // logic start is hi or lo
     Vstate = Din? vhi:vlo;              // so get normal levels
     Kres = 0;                           // normal resistance
     Kz=1'b0;                            // digital drives analog
   end
   else begin                            // logic starts X or Z
     Vstate = vxz;                       // so set to middle voltage level
     Kres = 1;                           //  and high impedance
     Kz = 1'b1;                          // enable voltage checking
   end
 end  
 always @Din case(Din)                   // On digital input change:
   1'b0:  begin                                  // low state
            Vstate=vlo; Kres=0;
            Kz=1'b0; Dreg=1'b0;                  // drive analog & digital
          end
   1'b1:  begin                                  // high state
            Vstate=vhi; Kres=0;
            Kz=1'b0; Dreg=1'b1;                  // drive analog & digital
          end 
   1'bx:  begin                                  // unknown state
            Vstate=vxz; Kres=0.15;               // XZ voltage @ weak resistance
            Kz=1'b1;                             // allow analog control
            Dreg=(V(Aout)>vthi)? 1'd1 :
                 (V(Aout)<vtlo)? 1'd0 : 1'dx;    // get level from analog
          end
   1'bz:  begin                                  // high impedance state
            Vstate=vxz; Kres=1;                  // XZ voltage @ high resistance
            Kz=1'b1;                             // allow analog control
            Dreg=(V(Aout)>vthi)? 1'd1 :
                 (V(Aout)<vtlo)? 1'd0 : 1'dx;    // get level from analog
          end
 endcase
 analog begin
   Vout = transition(Vstate,0,tr,tr);             // add risetimes to Vstate
   Rval = rout*(1+80K*pow(transition(Kres,0,tr,tr),5)); // resistor with rise
   I(Aout) <+ (V(Aout)-Vout)/Rval;                // drive output
// To disable @above, parameter Vos is used to shift the argument far negative:
   Vos = transition(vdis*Kz,0,tr,ttol);
 end
// Reflect actual levels on analog side back to digital side when enabled:
 always @(above(V(Aout)-vthi-Vos,ttol,vtol)) Dreg=1'b1;
 always @(above(vtlo-V(Aout)-Vos,ttol,vtol)) Dreg=1'b0;
endmodule

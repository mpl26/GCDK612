
// INCLUDE FILES:
`include "disciplines.vams"
`timescale 1ns / 100ps

//============================================================================
connectmodule E2L_MultiTech (Ain, Dout);
  input Ain; electrical Ain;                     // electrical input
  output Dout; logic Dout;                       // logic output

// Inherited VDD! and VSS!
//   VSS! IS NOT USED IN THIS MODEL
electrical  
   (* integer inh_conn_prop_name="DVDD";
      integer inh_conn_def_value="cds_globals.\\VDD! "; *)
  \VDD! ;
electrical  
   (* integer inh_conn_prop_name="DVSS";
      integer inh_conn_def_value="cds_globals.\\VSS! "; *)
  \VSS! ;
 


// INSTANCE PARAMETERS:
  parameter real vsup=2.0 from (0:inf);          // nominal supply voltage
  parameter real vthi=vsup/1.5 from (-inf:vsup); // upper input threshold
  parameter real vtlo=vthi/2 from (-inf:vthi);   // lower threshold
  parameter real txdel=2n;                       // time midrange til output X
  parameter real cin=0;                          // opt. input capacitance
  parameter real vtol=vsup/10;                   // voltage tolerance
  parameter real ttol=50p;                       // time tolerance

// LOCAL VARIABLES:
  reg Dreg;                      // output register
  reg Xin,Xreg;                  // Tx control registers
  real txdig;                    // tx in timescale units

//============================================================================
  initial begin          // interface nodes always start either HI or LO:
    txdig=txdel/1n;                              // digital delay midlevel to X
    Xin=0;                                       // start with tx inactive
    #0.1 Dreg = (V(Ain)>(V(\VDD! )/1.5))? 1'b1 :            // wait till analog start 
                 (V(Ain)<(V(\VDD! )/3.0))? 1'b0 : 1'bx;     //  and compute actual level.
  end
  always @(cross(V(Ain)-(V(\VDD! )/1.5),0,ttol,(V(\VDD! )/10.0))) begin // upper threshold crossing
    if (V(Ain)>(V(\VDD! )/1.5)) begin
      Dreg=1; Xin=0;                             // output goes high
    end
    else Xin=1;                                  // output in between
  end
  always @(cross(V(Ain)-(V(\VDD! )/3.0),0,ttol,(V(\VDD! )/10.0))) begin // lower threshold crossing
    if (V(Ain)<(V(\VDD! )/3.0)) begin
      Dreg=0; Xin=0;                             // output goes low
    end
    else Xin=1;                                  // output in between
  end
  always @(posedge(Xin)) begin :GoToX            // input changed to X
    #(txdig) Dreg=1'bx;                          // after wait, change to X
  end
  always @(negedge(Xin)) disable GoToX;          // cancel out-to-X @ Xin=0
  assign  Dout=Dreg;                             // assign register to output
  analog if (cin>0) I(Ain) <+ cin*ddt(V(Ain));   // optional input cap
endmodule

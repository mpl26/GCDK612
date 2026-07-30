
// INCLUDE FILES:
`include "disciplines.vams"
`timescale 1ns / 100ps

//============================================================================
connectmodule Bidir_MultiTech (Din, Aout);
  inout Din; logic Din;                       // logic signal
  inout Aout; electrical Aout;                // electrical signal

// Inherited VDD! and VSS!
//   VSS! IS NOT USED IN THIS MODEL
electrical 
   (* integer inh_conn_prop_name="DVDD";
      integer inh_conn_def_value="cds_globals.\\VDDA! "; *)
  \VDDA! ;
electrical 
   (* integer inh_conn_prop_name="DVSS";
      integer inh_conn_def_value="cds_globals.\\VSS! "; *)
  \VSS! ; 

// INSTANCE PARAMETERS:
  parameter real vsup=2.0 from (0:inf);       // nominal supply voltage
  parameter real vlo=0;                       // output voltage levels
  parameter real vhi=vsup from (vlo:vsup];    //
  parameter real vthi=vhi/1.5 from (vlo:vhi); // upper threshold (def Vhi*2/3)
  parameter real vtlo=vthi/2 from (vlo:vthi); // lower threshold (def Vhi*1/3)
  parameter real vx=(vthi+vtlo)/2 from (vtlo:vthi); // X output voltage
  parameter real vz=(vthi+vtlo)/2 from (vlo:vhi);   // Z output voltage
  parameter real tr=0.2n from (0:1m);         // risetime (L/X to Hi)
  parameter real tf=tr from (0:1m);           // falltime (H/X to Lo)
  parameter real tx=tr from (0:1m);           // time to unknown (L/H/Z to X)
  parameter real tz=tr from (0:1m);           // impedance risetime to/from Z
  parameter real txdel=2n;                    // analog-midrange to output X
  parameter real rlo=200 from (0:1M);         // low state output resistance
  parameter real rhi=rlo from (0:1M);         // high state output resistance
  parameter real rx=(rlo+rhi)/10 from (0:1M); // X state output resistance
  parameter real rz=10M from (rhi:1T];        // Z state output resistance 
  parameter real cout=0;                      // opt. output capacitance
  parameter real vtol=vsup/10;                // voltage tolerance of crossing
  parameter real ttol=tr/5;                   // time tolerance of crossing

// LOCAL VARIABLES:
  reg Dreg;                // register to writeback logic
  reg Dold;                // register for keeping previous state of Din
  real Vout,Rout;          // output voltage & resistance
  reg Xin;                 // flag if analog is midrange
  real Rlog;               // natural log of output resistance value
  real txdig;              // delay midlevel to X in timescale units
  real TdV,TrV,TrR;        // delays & risetime for voltage & resistance

//============================================================================
  initial begin
    txdig=txdel/1n;                   // digital delay midlevel to X
    Dreg=Din;                         // Digital initially passes thru
    case (Din)     // Convert initial Din to equivalent voltage & log of Rout:
      1'b1:    begin  Vout=V(\VDDA! ); Rlog=ln(rhi);  end     // init Hi
      1'b0:    begin  Vout=vlo; Rlog=ln(rlo);  end     // init Lo
      1'bz:    begin  Vout=(V(\VDDA! )/0.58333);  Rlog=ln(rz);   end     // init Z
      default: begin  Vout=(V(\VDDA! )/0.58333);  Rlog=ln(rx);   end     // init X
    endcase
    TdV=0; TrV=tr; TrR=tr;            // initially default delay&rise terms
    Dold=Din;                         // keep old value of Din
    #0.1 Dreg=(V(Aout)>(V(\VDDA! )/1.5))? 1'b1 :  // Drive digital from analog DC level
               (V(Aout)<(V(\VDDA! )/2.0))? 1'b0 : 1'bx;
  end

  always  @Din begin  
    case (Din)                        // Lookup of V,R,T values for new state
      1'b1:  begin                    // to HIGH
         Vout=V(\VDDA! );  Rlog=ln(rhi);  TdV=0;
         if (Dold!==1'bz)  begin TrV=tr;   TrR=tr; end   // Lo/X to Hi
         else              begin TrV=tz/2; TrR=tz; end   // Z to high
      end
      1'b0: begin                     // to LOW
         Vout=vlo;  Rlog=ln(rlo);  TdV=0;
         if (Dold!==1'bz)  begin TrV=tf;   TrR=tf; end   // Hi/X to Lo
         else              begin TrV=tz/2; TrR=tz; end   // Z to low
      end
      1'bz:  begin                    // to HIGH IMPEDANCE
         Vout=(V(\VDDA! )/0.58333);  Rlog=ln(rz);  TdV=tz/2;
         TrV=tz/2; TrR=tz;                               // Hi/Lo/X to Z
      end
      default:  begin                 // to UNKNOWN
         Vout=(V(\VDDA! )/0.58333);  Rlog=ln(rx);  TdV=0;
         TrV=tx;  TrR=tx;                                // Hi/Lo/Z to X
         Dreg=1'bx;                   // logic X occurs immediately
      end
    endcase
    Dold=Din;                         // keep old value of Din
  end

  analog begin                 // Apply Vout,Rout to output with transitions:
     Rout = exp(transition(Rlog,0,TrR,TrR));       // Rout shifts on log scale
     I(Aout) <+ (V(Aout)-transition(Vout,TdV,TrV,TrV))/Rout; // linear Vout chg
     if (cout>0) I(Aout) <+ cout*ddt(V(Aout));      // Cout if specified
  end
  
  // Reflect actual levels on analog side back to digital side:
  always  @(cross(V(Aout)-(V(\VDDA! )/1.5),0,ttol,(V(\VDDA! )/10.0))) begin  // upper threshold crossed
    if (V(Aout)>(V(\VDDA! )/1.5))  begin
      Dreg=1; Xin=0;                      // go up to high level
    end 
    else if (Din===1'bx)  Dreg=Din;       // logic X drives analog to X
    else                   Xin=1;         // analog passing thru midrange   
  end
  always  @(cross(V(Aout)-(V(\VDDA! )/2.0),0,ttol,(V(\VDDA! )/10.0))) begin  // lower threshold crossed
    if (V(Aout)<(V(\VDDA! )/2.0))  begin
      Dreg=0; Xin=0;                      // go down to low level
    end
    else if (Din===1'bx)  Dreg=Din;       // logic X drives analog to X
    else                   Xin=1;         // analog passing thru midrange
  end
  
  always @(posedge(Xin)) begin :GoToX     // analog is midrange
    #(txdig) Dreg = 1'bx;                 // after wait, change output to X
  end
  always @(negedge(Xin)) disable GoToX;   // cancel out-to-X if leaves midrange
  
  assign  Din=Dreg;                       // assign level back to logic pin.
endmodule

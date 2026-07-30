`include "disciplines.vams"
`timescale 1ns / 1ns

//============================================
connectmodule oz_bidir(aVal, dVal);
inout aVal;
inout dVal;
electrical aVal;
logic dVal;

electrical x;
reg dValout;
logic dValout;

assign dVal = dValout;

parameter real vzdrive=2.5;
parameter real vhdrive=5.0;
parameter real vxdrive=2.5;
parameter real vldrive=0.0;
parameter real rzdrive=1000k;
parameter real rhdrive=1k;
parameter real rldrive=1k;
parameter real rxdrive=1.0;
parameter real vrise=5n;
parameter real vfall=5n;
parameter real rrise=5n;
parameter real rfall=5n;
parameter real internalDigitalDelay=vrise/1n; //dependent on timescale !!

  parameter real thresholdLo = 1.5;  // value below which digital is 0
  parameter real thresholdHi = 3.5;  // value above which digital is 1
  parameter real maxHiZcurrent = 0.1u; // absolut max current allowed in HiZ state

real v2set, r2set;
integer vstate;
reg istate;
reg dValDelayed;

   initial begin
    dValout=1'bz;  //set the dig output to Z until analog voltage is there
    vstate=2;
    istate=0;
    dValDelayed=dVal;
    case(dVal)
    1'b0: begin v2set=vldrive;r2set=rldrive; end
    1'b1: begin v2set=vhdrive;r2set=rhdrive; end
    1'bx: begin v2set=vxdrive;r2set=rxdrive;dValout=1'bx; end
    1'bz: begin v2set=vzdrive;r2set=rzdrive; end
    endcase
    #1
    if (V(aVal)>thresholdHi) vstate=1;
    else
     if (V(aVal)>thresholdLo) vstate=2;
     else vstate=3;
    if (I(x,aVal)>maxHiZcurrent) istate=1;
    else
     if (I(x,aVal)<-maxHiZcurrent) istate=1;
     else istate=0;
   end

   always @dVal begin
    case(dVal)
    1'b0: begin v2set=vldrive;r2set=rldrive; end
    1'b1: begin v2set=vhdrive;r2set=rhdrive; end
    1'bx: begin v2set=vxdrive;r2set=rxdrive;dValout=1'bx; end
    1'bz: begin v2set=vzdrive;r2set=rzdrive; end
    endcase
    dValDelayed = #internalDigitalDelay dVal;
   end

   always @(cross(V(aVal)-thresholdHi,1)) vstate=1;
   always @(cross(V(aVal)-thresholdHi,-1)) vstate=2;
   always @(cross(V(aVal)-thresholdLo,1)) vstate=2;
   always @(cross(V(aVal)-thresholdLo,-1)) vstate=3;

   always @(cross(abs(I(x,aVal))-maxHiZcurrent,1)) istate=1;
   always @(cross(abs(I(x,aVal))-maxHiZcurrent,-1)) istate=0;

   always @(vstate or istate or dValDelayed) begin
    if (dValDelayed===1'bx) dValout=1'bx;
    else
     case(vstate)
     1: dValout=1'b1;
     2: dValout= (istate===1'b0) ? 1'bz : 1'bx;
     3: dValout=1'b0;
     endcase
   end

analog begin
 V(x) <+ transition(v2set,0,vrise,vfall);
 I(x,aVal) <+ V(x,aVal) / transition(r2set,0,rrise,rfall);
end


endmodule


//============================================


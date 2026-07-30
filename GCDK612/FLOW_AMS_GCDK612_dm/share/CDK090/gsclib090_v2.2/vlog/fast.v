`timescale 1ns/10ps
`celldefine
module ACHCONX2 (A, B, CI, CON);
input  A ;
input  B ;
input  CI ;
output CON ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (CON, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A$CON = 0.047:0.048:0.048,
       tphlh$A$CON = 0.047:0.047:0.047,
       tplhl$B$CON = 0.023:0.025:0.027,
       tphlh$B$CON = 0.024:0.028:0.031,
       tplhl$CI$CON = 0.014:0.014:0.014,
       tphlh$CI$CON = 0.016:0.016:0.016;

     // path delays
     (A *> CON) = (tphlh$A$CON, tplhl$A$CON);
     (B *> CON) = (tphlh$B$CON, tplhl$B$CON);
     (CI *> CON) = (tphlh$CI$CON, tplhl$CI$CON);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDFHX1 (A, B, CI, CO, S);
input  A ;
input  B ;
input  CI ;
output CO ;
output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.029:0.049:0.068,
       tplhl$A$S = 0.038:0.047:0.056,
       tpllh$A$CO = 0.032:0.032:0.033,
       tphhl$A$CO = 0.04:0.041:0.041,
       tpllh$B$S = 0.028:0.049:0.07,
       tplhl$B$S = 0.036:0.046:0.057,
       tpllh$B$CO = 0.031:0.033:0.035,
       tphhl$B$CO = 0.04:0.04:0.041,
       tpllh$CI$S = 0.027:0.046:0.065,
       tplhl$CI$S = 0.035:0.045:0.055,
       tpllh$CI$CO = 0.029:0.03:0.031,
       tphhl$CI$CO = 0.035:0.036:0.037;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);
     (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
     (CI *> S) = (tpllh$CI$S, tplhl$CI$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDFHX2 (A, B, CI, CO, S);
input  A ;
input  B ;
input  CI ;
output CO ;
output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.036:0.063:0.09,
       tplhl$A$S = 0.047:0.061:0.074,
       tpllh$A$CO = 0.039:0.039:0.039,
       tphhl$A$CO = 0.049:0.049:0.05,
       tpllh$B$S = 0.035:0.063:0.092,
       tplhl$B$S = 0.045:0.06:0.075,
       tpllh$B$CO = 0.038:0.04:0.042,
       tphhl$B$CO = 0.049:0.049:0.05,
       tpllh$CI$S = 0.034:0.06:0.087,
       tplhl$CI$S = 0.045:0.059:0.074,
       tpllh$CI$CO = 0.036:0.037:0.038,
       tphhl$CI$CO = 0.044:0.045:0.046;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);
     (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
     (CI *> S) = (tpllh$CI$S, tplhl$CI$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDFHX4 (A, B, CI, CO, S);
input  A ;
input  B ;
input  CI ;
output CO ;
output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.045:0.081:0.12,
       tplhl$A$S = 0.059:0.078:0.097,
       tpllh$A$CO = 0.047:0.048:0.048,
       tphhl$A$CO = 0.06:0.061:0.061,
       tpllh$B$S = 0.043:0.081:0.12,
       tplhl$B$S = 0.056:0.077:0.098,
       tpllh$B$CO = 0.046:0.048:0.05,
       tphhl$B$CO = 0.06:0.061:0.061,
       tpllh$CI$S = 0.043:0.078:0.11,
       tplhl$CI$S = 0.056:0.076:0.097,
       tpllh$CI$CO = 0.044:0.046:0.047,
       tphhl$CI$CO = 0.056:0.057:0.058;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);
     (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
     (CI *> S) = (tpllh$CI$S, tplhl$CI$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDFHXL (A, B, CI, CO, S);
input  A ;
input  B ;
input  CI ;
output CO ;
output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.027:0.045:0.063,
       tplhl$A$S = 0.036:0.043:0.051,
       tpllh$A$CO = 0.03:0.03:0.03,
       tphhl$A$CO = 0.038:0.038:0.038,
       tpllh$B$S = 0.025:0.045:0.064,
       tplhl$B$S = 0.033:0.043:0.052,
       tpllh$B$CO = 0.028:0.03:0.032,
       tphhl$B$CO = 0.037:0.037:0.038,
       tpllh$CI$S = 0.024:0.042:0.06,
       tplhl$CI$S = 0.033:0.042:0.051,
       tpllh$CI$CO = 0.027:0.028:0.029,
       tphhl$CI$CO = 0.033:0.033:0.034;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);
     (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
     (CI *> S) = (tpllh$CI$S, tplhl$CI$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDFX1 (A, B, CI, CO, S);
input  A ;
input  B ;
input  CI ;
output CO ;
output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.032:0.055:0.078,
       tplhl$A$S = 0.043:0.054:0.064,
       tpllh$A$CO = 0.035:0.035:0.035,
       tphhl$A$CO = 0.045:0.045:0.045,
       tpllh$B$S = 0.03:0.055:0.079,
       tplhl$B$S = 0.041:0.053:0.065,
       tpllh$B$CO = 0.034:0.035:0.037,
       tphhl$B$CO = 0.044:0.045:0.045,
       tpllh$CI$S = 0.03:0.052:0.075,
       tplhl$CI$S = 0.04:0.052:0.064,
       tpllh$CI$CO = 0.032:0.033:0.034,
       tphhl$CI$CO = 0.04:0.041:0.041;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);
     (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
     (CI *> S) = (tpllh$CI$S, tplhl$CI$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDFX2 (A, B, CI, CO, S);
input  A ;
input  B ;
input  CI ;
output CO ;
output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.042:0.075:0.11,
       tplhl$A$S = 0.056:0.073:0.091,
       tpllh$A$CO = 0.044:0.045:0.045,
       tphhl$A$CO = 0.058:0.058:0.058,
       tpllh$B$S = 0.04:0.075:0.11,
       tplhl$B$S = 0.054:0.073:0.092,
       tpllh$B$CO = 0.043:0.045:0.047,
       tphhl$B$CO = 0.058:0.058:0.058,
       tpllh$CI$S = 0.04:0.073:0.11,
       tplhl$CI$S = 0.054:0.072:0.09,
       tpllh$CI$CO = 0.042:0.043:0.044,
       tphhl$CI$CO = 0.053:0.054:0.055;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);
     (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
     (CI *> S) = (tpllh$CI$S, tplhl$CI$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDFX4 (A, B, CI, CO, S);
input  A ;
input  B ;
input  CI ;
output CO ;
output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.045:0.081:0.12,
       tplhl$A$S = 0.059:0.078:0.097,
       tpllh$A$CO = 0.047:0.048:0.048,
       tphhl$A$CO = 0.06:0.061:0.061,
       tpllh$B$S = 0.043:0.081:0.12,
       tplhl$B$S = 0.056:0.077:0.098,
       tpllh$B$CO = 0.046:0.048:0.05,
       tphhl$B$CO = 0.06:0.061:0.061,
       tpllh$CI$S = 0.043:0.078:0.11,
       tplhl$CI$S = 0.056:0.076:0.097,
       tpllh$CI$CO = 0.044:0.046:0.047,
       tphhl$CI$CO = 0.056:0.057:0.058;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);
     (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
     (CI *> S) = (tpllh$CI$S, tplhl$CI$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDFXL (A, B, CI, CO, S);
input  A ;
input  B ;
input  CI ;
output CO ;
output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.027:0.045:0.063,
       tplhl$A$S = 0.036:0.044:0.051,
       tpllh$A$CO = 0.03:0.03:0.03,
       tphhl$A$CO = 0.038:0.039:0.039,
       tpllh$B$S = 0.025:0.045:0.064,
       tplhl$B$S = 0.034:0.043:0.052,
       tpllh$B$CO = 0.029:0.031:0.032,
       tphhl$B$CO = 0.038:0.038:0.038,
       tpllh$CI$S = 0.025:0.042:0.06,
       tplhl$CI$S = 0.033:0.042:0.051,
       tpllh$CI$CO = 0.028:0.028:0.029,
       tphhl$CI$CO = 0.033:0.034:0.035;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);
     (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
     (CI *> S) = (tpllh$CI$S, tplhl$CI$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDHX1 (A, B, CO, S);
input  A ;
input  B ;
output CO ;
output S ;

   and (CO, A, B);
   xor (S, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.031:0.036:0.042,
       tplhl$A$S = 0.034:0.039:0.043,
       tpllh$A$CO = 0.025:0.025:0.025,
       tphhl$A$CO = 0.024:0.024:0.024,
       tpllh$B$S = 0.024:0.027:0.031,
       tplhl$B$S = 0.024:0.03:0.036,
       tpllh$B$CO = 0.024:0.024:0.024,
       tphhl$B$CO = 0.022:0.022:0.022;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDHX2 (A, B, CO, S);
input  A ;
input  B ;
output CO ;
output S ;

   and (CO, A, B);
   xor (S, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.039:0.045:0.051,
       tplhl$A$S = 0.043:0.05:0.057,
       tpllh$A$CO = 0.034:0.034:0.034,
       tphhl$A$CO = 0.031:0.031:0.031,
       tpllh$B$S = 0.033:0.036:0.039,
       tplhl$B$S = 0.031:0.04:0.048,
       tpllh$B$CO = 0.034:0.034:0.034,
       tphhl$B$CO = 0.03:0.03:0.03;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDHX4 (A, B, CO, S);
input  A ;
input  B ;
output CO ;
output S ;

   and (CO, A, B);
   xor (S, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.059:0.06:0.06,
       tplhl$A$S = 0.064:0.065:0.066,
       tpllh$A$CO = 0.037:0.037:0.037,
       tphhl$A$CO = 0.033:0.033:0.033,
       tpllh$B$S = 0.036:0.045:0.053,
       tplhl$B$S = 0.042:0.048:0.055,
       tpllh$B$CO = 0.037:0.037:0.037,
       tphhl$B$CO = 0.032:0.032:0.032;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module ADDHXL (A, B, CO, S);
input  A ;
input  B ;
output CO ;
output S ;

   and (CO, A, B);
   xor (S, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$S = 0.027:0.032:0.037,
       tplhl$A$S = 0.029:0.033:0.037,
       tpllh$A$CO = 0.02:0.02:0.02,
       tphhl$A$CO = 0.02:0.02:0.02,
       tpllh$B$S = 0.019:0.023:0.027,
       tplhl$B$S = 0.02:0.025:0.03,
       tpllh$B$CO = 0.019:0.019:0.019,
       tphhl$B$CO = 0.018:0.018:0.018;

     // path delays
     (A *> CO) = (tpllh$A$CO, tphhl$A$CO);
     (A *> S) = (tpllh$A$S, tplhl$A$S);
     (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
     (B *> S) = (tpllh$B$S, tplhl$B$S);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND2X1 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.025:0.025:0.025,
       tphhl$A$Y = 0.024:0.024:0.024,
       tpllh$B$Y = 0.024:0.024:0.024,
       tphhl$B$Y = 0.022:0.022:0.022;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND2X2 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.034:0.034:0.034,
       tphhl$A$Y = 0.031:0.031:0.031,
       tpllh$B$Y = 0.034:0.034:0.034,
       tphhl$B$Y = 0.03:0.03:0.03;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND2X4 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.037:0.037:0.037,
       tphhl$A$Y = 0.033:0.033:0.033,
       tpllh$B$Y = 0.036:0.036:0.036,
       tphhl$B$Y = 0.032:0.032:0.032;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND2X6 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.031:0.031:0.031,
       tphhl$A$Y = 0.029:0.029:0.029,
       tpllh$B$Y = 0.031:0.031:0.031,
       tphhl$B$Y = 0.028:0.028:0.028;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND2X8 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.037:0.037:0.037,
       tphhl$A$Y = 0.033:0.033:0.033,
       tpllh$B$Y = 0.037:0.037:0.037,
       tphhl$B$Y = 0.032:0.032:0.032;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND2XL (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.02:0.02:0.02,
       tphhl$A$Y = 0.02:0.02:0.02,
       tpllh$B$Y = 0.019:0.019:0.019,
       tphhl$B$Y = 0.018:0.018:0.018;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND3X1 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.033:0.033:0.033,
       tphhl$A$Y = 0.026:0.026:0.026,
       tpllh$B$Y = 0.033:0.033:0.033,
       tphhl$B$Y = 0.025:0.025:0.025,
       tpllh$C$Y = 0.031:0.031:0.031,
       tphhl$C$Y = 0.023:0.023:0.023;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND3X2 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.047:0.047:0.047,
       tphhl$A$Y = 0.034:0.034:0.034,
       tpllh$B$Y = 0.046:0.046:0.046,
       tphhl$B$Y = 0.033:0.033:0.033,
       tpllh$C$Y = 0.044:0.044:0.044,
       tphhl$C$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND3X4 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.05:0.05:0.05,
       tphhl$A$Y = 0.036:0.036:0.036,
       tpllh$B$Y = 0.05:0.05:0.05,
       tphhl$B$Y = 0.034:0.034:0.034,
       tpllh$C$Y = 0.048:0.048:0.048,
       tphhl$C$Y = 0.033:0.033:0.033;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND3X6 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.042:0.042:0.042,
       tphhl$A$Y = 0.031:0.031:0.031,
       tpllh$B$Y = 0.042:0.042:0.042,
       tphhl$B$Y = 0.03:0.03:0.03,
       tpllh$C$Y = 0.04:0.04:0.04,
       tphhl$C$Y = 0.028:0.028:0.028;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND3X8 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.05:0.05:0.05,
       tphhl$A$Y = 0.036:0.036:0.036,
       tpllh$B$Y = 0.05:0.05:0.05,
       tphhl$B$Y = 0.034:0.034:0.034,
       tpllh$C$Y = 0.048:0.048:0.048,
       tphhl$C$Y = 0.033:0.033:0.033;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND3XL (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.027:0.027:0.027,
       tphhl$A$Y = 0.022:0.022:0.022,
       tpllh$B$Y = 0.026:0.026:0.026,
       tphhl$B$Y = 0.021:0.021:0.021,
       tpllh$C$Y = 0.025:0.025:0.025,
       tphhl$C$Y = 0.019:0.019:0.019;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND4X1 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.043:0.043:0.043,
       tphhl$A$Y = 0.028:0.028:0.028,
       tpllh$B$Y = 0.043:0.043:0.043,
       tphhl$B$Y = 0.027:0.027:0.027,
       tpllh$C$Y = 0.041:0.041:0.041,
       tphhl$C$Y = 0.026:0.026:0.026,
       tpllh$D$Y = 0.038:0.038:0.038,
       tphhl$D$Y = 0.024:0.024:0.024;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND4X2 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.06:0.06:0.06,
       tphhl$A$Y = 0.036:0.036:0.036,
       tpllh$B$Y = 0.059:0.059:0.059,
       tphhl$B$Y = 0.035:0.035:0.035,
       tpllh$C$Y = 0.058:0.058:0.058,
       tphhl$C$Y = 0.033:0.033:0.033,
       tpllh$D$Y = 0.055:0.055:0.055,
       tphhl$D$Y = 0.032:0.032:0.032;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND4X4 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.065:0.065:0.065,
       tphhl$A$Y = 0.038:0.038:0.038,
       tpllh$B$Y = 0.064:0.064:0.064,
       tphhl$B$Y = 0.037:0.037:0.037,
       tpllh$C$Y = 0.062:0.062:0.062,
       tphhl$C$Y = 0.035:0.035:0.035,
       tpllh$D$Y = 0.059:0.059:0.059,
       tphhl$D$Y = 0.034:0.034:0.034;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND4X6 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.055:0.055:0.055,
       tphhl$A$Y = 0.034:0.034:0.034,
       tpllh$B$Y = 0.055:0.055:0.055,
       tphhl$B$Y = 0.033:0.033:0.033,
       tpllh$C$Y = 0.053:0.053:0.053,
       tphhl$C$Y = 0.031:0.031:0.031,
       tpllh$D$Y = 0.05:0.05:0.05,
       tphhl$D$Y = 0.029:0.029:0.029;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND4X8 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.065:0.065:0.065,
       tphhl$A$Y = 0.038:0.038:0.038,
       tpllh$B$Y = 0.064:0.064:0.064,
       tphhl$B$Y = 0.037:0.037:0.037,
       tpllh$C$Y = 0.062:0.062:0.062,
       tphhl$C$Y = 0.035:0.035:0.035,
       tpllh$D$Y = 0.059:0.059:0.059,
       tphhl$D$Y = 0.034:0.034:0.034;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AND4XL (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.035:0.035:0.035,
       tphhl$A$Y = 0.024:0.024:0.024,
       tpllh$B$Y = 0.034:0.034:0.034,
       tphhl$B$Y = 0.023:0.023:0.023,
       tpllh$C$Y = 0.033:0.033:0.033,
       tphhl$C$Y = 0.022:0.022:0.022,
       tpllh$D$Y = 0.03:0.03:0.03,
       tphhl$D$Y = 0.02:0.02:0.02;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AO21X1 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (Y, I0_out, B0);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.028:0.028:0.028,
       tphhl$A0$Y = 0.037:0.037:0.037,
       tpllh$A1$Y = 0.028:0.028:0.028,
       tphhl$A1$Y = 0.034:0.034:0.034,
       tpllh$B0$Y = 0.019:0.019:0.02,
       tphhl$B0$Y = 0.025:0.029:0.033;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AO21X2 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (Y, I0_out, B0);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.038:0.038:0.038,
       tphhl$A0$Y = 0.05:0.05:0.05,
       tpllh$A1$Y = 0.038:0.038:0.038,
       tphhl$A1$Y = 0.047:0.047:0.047,
       tpllh$B0$Y = 0.025:0.025:0.026,
       tphhl$B0$Y = 0.035:0.04:0.046;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AO21X4 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (Y, I0_out, B0);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.041:0.041:0.041,
       tphhl$A0$Y = 0.053:0.053:0.053,
       tpllh$A1$Y = 0.04:0.04:0.04,
       tphhl$A1$Y = 0.05:0.05:0.05,
       tpllh$B0$Y = 0.026:0.027:0.027,
       tphhl$B0$Y = 0.038:0.043:0.048;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AO21XL (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (Y, I0_out, B0);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.024:0.024:0.024,
       tphhl$A0$Y = 0.03:0.03:0.03,
       tpllh$A1$Y = 0.023:0.023:0.023,
       tphhl$A1$Y = 0.027:0.027:0.027,
       tpllh$B0$Y = 0.015:0.016:0.016,
       tphhl$B0$Y = 0.02:0.023:0.026;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AO22X1 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (Y, I0_out, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.03:0.031:0.032,
       tphhl$A0$Y = 0.034:0.038:0.042,
       tpllh$A1$Y = 0.029:0.031:0.032,
       tphhl$A1$Y = 0.032:0.036:0.04,
       tpllh$B0$Y = 0.025:0.026:0.027,
       tphhl$B0$Y = 0.028:0.032:0.036,
       tpllh$B1$Y = 0.025:0.026:0.026,
       tphhl$B1$Y = 0.026:0.03:0.034;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
     (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AO22X2 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (Y, I0_out, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.04:0.041:0.042,
       tphhl$A0$Y = 0.044:0.05:0.055,
       tpllh$A1$Y = 0.039:0.041:0.042,
       tphhl$A1$Y = 0.042:0.048:0.053,
       tpllh$B0$Y = 0.035:0.036:0.037,
       tphhl$B0$Y = 0.038:0.044:0.049,
       tpllh$B1$Y = 0.035:0.035:0.036,
       tphhl$B1$Y = 0.036:0.042:0.047;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
     (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AO22X4 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (Y, I0_out, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.043:0.044:0.045,
       tphhl$A0$Y = 0.047:0.053:0.058,
       tpllh$A1$Y = 0.042:0.043:0.044,
       tphhl$A1$Y = 0.045:0.05:0.056,
       tpllh$B0$Y = 0.038:0.039:0.04,
       tphhl$B0$Y = 0.041:0.047:0.052,
       tpllh$B1$Y = 0.037:0.038:0.039,
       tphhl$B1$Y = 0.039:0.044:0.05;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
     (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AO22XL (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (Y, I0_out, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.025:0.026:0.027,
       tphhl$A0$Y = 0.029:0.033:0.036,
       tpllh$A1$Y = 0.024:0.026:0.027,
       tphhl$A1$Y = 0.027:0.03:0.033,
       tpllh$B0$Y = 0.021:0.021:0.022,
       tphhl$B0$Y = 0.023:0.027:0.03,
       tpllh$B1$Y = 0.02:0.021:0.022,
       tphhl$B1$Y = 0.021:0.024:0.027;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
     (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI211X1 (A0, A1, B0, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  C0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.014:0.014,
       tphlh$A0$Y = 0.031:0.031:0.031,
       tplhl$A1$Y = 0.013:0.013:0.013,
       tphlh$A1$Y = 0.027:0.027:0.027,
       tplhl$B0$Y = 0.0082:0.0086:0.009,
       tphlh$B0$Y = 0.019:0.023:0.027,
       tplhl$C0$Y = 0.0064:0.0068:0.0072,
       tphlh$C0$Y = 0.016:0.019:0.022;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI211X2 (A0, A1, B0, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  C0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.013:0.013:0.013,
       tphlh$A0$Y = 0.031:0.031:0.031,
       tplhl$A1$Y = 0.013:0.013:0.013,
       tphlh$A1$Y = 0.027:0.027:0.027,
       tplhl$B0$Y = 0.0081:0.0086:0.009,
       tphlh$B0$Y = 0.02:0.023:0.027,
       tplhl$C0$Y = 0.0061:0.0065:0.0069,
       tphlh$C0$Y = 0.015:0.018:0.021;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI211X4 (A0, A1, B0, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  C0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.013:0.013:0.013,
       tphlh$A0$Y = 0.031:0.031:0.031,
       tplhl$A1$Y = 0.013:0.013:0.013,
       tphlh$A1$Y = 0.026:0.026:0.026,
       tplhl$B0$Y = 0.0081:0.0085:0.009,
       tphlh$B0$Y = 0.019:0.023:0.027,
       tplhl$C0$Y = 0.0061:0.0065:0.0069,
       tphlh$C0$Y = 0.015:0.018:0.021;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI211XL (A0, A1, B0, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  C0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.013:0.013:0.013,
       tphlh$A0$Y = 0.031:0.031:0.031,
       tplhl$A1$Y = 0.013:0.013:0.013,
       tphlh$A1$Y = 0.026:0.026:0.026,
       tplhl$B0$Y = 0.0078:0.0083:0.0087,
       tphlh$B0$Y = 0.019:0.023:0.027,
       tplhl$C0$Y = 0.006:0.0065:0.0069,
       tphlh$C0$Y = 0.016:0.019:0.022;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI21X1 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (I1_out, I0_out, B0);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.012:0.012,
       tphlh$A0$Y = 0.02:0.02:0.02,
       tplhl$A1$Y = 0.012:0.012:0.012,
       tphlh$A1$Y = 0.017:0.017:0.017,
       tplhl$B0$Y = 0.0055:0.0059:0.0064,
       tphlh$B0$Y = 0.011:0.014:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI21X2 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (I1_out, I0_out, B0);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.012:0.012,
       tphlh$A0$Y = 0.02:0.02:0.02,
       tplhl$A1$Y = 0.011:0.011:0.011,
       tphlh$A1$Y = 0.017:0.017:0.017,
       tplhl$B0$Y = 0.0053:0.0058:0.0062,
       tphlh$B0$Y = 0.011:0.014:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI21X4 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (I1_out, I0_out, B0);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.012:0.012,
       tphlh$A0$Y = 0.02:0.02:0.02,
       tplhl$A1$Y = 0.011:0.011:0.011,
       tphlh$A1$Y = 0.017:0.017:0.017,
       tplhl$B0$Y = 0.0054:0.0058:0.0062,
       tphlh$B0$Y = 0.011:0.014:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI21XL (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   and (I0_out, A0, A1);
   or  (I1_out, I0_out, B0);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.012:0.012,
       tphlh$A0$Y = 0.02:0.02:0.02,
       tplhl$A1$Y = 0.011:0.011:0.011,
       tphlh$A1$Y = 0.017:0.017:0.017,
       tplhl$B0$Y = 0.0051:0.0056:0.0061,
       tphlh$B0$Y = 0.011:0.014:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI221X1 (A0, A1, B0, B1, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.015:0.015:0.016,
       tphlh$A0$Y = 0.032:0.036:0.04,
       tplhl$A1$Y = 0.014:0.015:0.015,
       tphlh$A1$Y = 0.029:0.032:0.035,
       tplhl$B0$Y = 0.013:0.014:0.015,
       tphlh$B0$Y = 0.026:0.03:0.035,
       tplhl$B1$Y = 0.013:0.014:0.014,
       tphlh$B1$Y = 0.022:0.026:0.03,
       tplhl$C0$Y = 0.0066:0.0074:0.0083,
       tphlh$C0$Y = 0.014:0.02:0.026;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI221X2 (A0, A1, B0, B1, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.014:0.015,
       tphlh$A0$Y = 0.031:0.035:0.038,
       tplhl$A1$Y = 0.013:0.014:0.015,
       tphlh$A1$Y = 0.028:0.031:0.034,
       tplhl$B0$Y = 0.013:0.013:0.014,
       tphlh$B0$Y = 0.025:0.029:0.033,
       tplhl$B1$Y = 0.012:0.013:0.013,
       tphlh$B1$Y = 0.021:0.025:0.029,
       tplhl$C0$Y = 0.006:0.0068:0.0077,
       tphlh$C0$Y = 0.013:0.019:0.025;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI221X4 (A0, A1, B0, B1, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.015:0.015,
       tphlh$A0$Y = 0.031:0.035:0.039,
       tplhl$A1$Y = 0.013:0.014:0.015,
       tphlh$A1$Y = 0.027:0.031:0.034,
       tplhl$B0$Y = 0.013:0.013:0.014,
       tphlh$B0$Y = 0.025:0.029:0.033,
       tplhl$B1$Y = 0.012:0.013:0.013,
       tphlh$B1$Y = 0.021:0.025:0.029,
       tplhl$C0$Y = 0.0061:0.0069:0.0078,
       tphlh$C0$Y = 0.014:0.019:0.025;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI221XL (A0, A1, B0, B1, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.015:0.016,
       tphlh$A0$Y = 0.032:0.036:0.04,
       tplhl$A1$Y = 0.014:0.014:0.015,
       tphlh$A1$Y = 0.029:0.032:0.035,
       tplhl$B0$Y = 0.013:0.014:0.014,
       tphlh$B0$Y = 0.026:0.03:0.034,
       tplhl$B1$Y = 0.013:0.013:0.014,
       tphlh$B1$Y = 0.022:0.026:0.03,
       tplhl$C0$Y = 0.0063:0.0072:0.008,
       tphlh$C0$Y = 0.014:0.02:0.026;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI222X1 (A0, A1, B0, B1, C0, C1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
input  C1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, C0, C1);
   and (I3_out, B0, B1);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.016:0.018:0.02,
       tphlh$A0$Y = 0.032:0.04:0.048,
       tplhl$A1$Y = 0.015:0.017:0.019,
       tphlh$A1$Y = 0.029:0.036:0.044,
       tplhl$B0$Y = 0.015:0.016:0.017,
       tphlh$B0$Y = 0.026:0.034:0.043,
       tplhl$B1$Y = 0.014:0.015:0.016,
       tphlh$B1$Y = 0.023:0.031:0.039,
       tplhl$C0$Y = 0.011:0.012:0.013,
       tphlh$C0$Y = 0.018:0.025:0.032,
       tplhl$C1$Y = 0.01:0.011:0.013,
       tphlh$C1$Y = 0.015:0.022:0.028;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
     (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI222X2 (A0, A1, B0, B1, C0, C1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
input  C1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, C0, C1);
   and (I3_out, B0, B1);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.015:0.017:0.02,
       tphlh$A0$Y = 0.031:0.039:0.047,
       tplhl$A1$Y = 0.015:0.017:0.019,
       tphlh$A1$Y = 0.028:0.035:0.043,
       tplhl$B0$Y = 0.014:0.015:0.017,
       tphlh$B0$Y = 0.025:0.033:0.042,
       tplhl$B1$Y = 0.014:0.015:0.016,
       tphlh$B1$Y = 0.022:0.03:0.037,
       tplhl$C0$Y = 0.01:0.011:0.012,
       tphlh$C0$Y = 0.017:0.024:0.031,
       tplhl$C1$Y = 0.0099:0.011:0.012,
       tphlh$C1$Y = 0.015:0.021:0.027;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
     (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI222X4 (A0, A1, B0, B1, C0, C1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
input  C1 ;
output Y ;

   and (I0_out, C0, C1);
   and (I1_out, A0, A1);
   and (I3_out, B0, B1);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.015:0.017:0.02,
       tphlh$A0$Y = 0.031:0.039:0.047,
       tplhl$A1$Y = 0.015:0.017:0.019,
       tphlh$A1$Y = 0.028:0.035:0.043,
       tplhl$B0$Y = 0.015:0.016:0.017,
       tphlh$B0$Y = 0.025:0.034:0.042,
       tplhl$B1$Y = 0.014:0.015:0.016,
       tphlh$B1$Y = 0.022:0.03:0.037,
       tplhl$C0$Y = 0.011:0.012:0.013,
       tphlh$C0$Y = 0.017:0.024:0.031,
       tplhl$C1$Y = 0.0099:0.011:0.012,
       tphlh$C1$Y = 0.015:0.021:0.027;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
     (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI222XL (A0, A1, B0, B1, C0, C1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
input  C1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, C0, C1);
   and (I3_out, B0, B1);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.015:0.018:0.02,
       tphlh$A0$Y = 0.032:0.04:0.048,
       tplhl$A1$Y = 0.015:0.017:0.019,
       tphlh$A1$Y = 0.029:0.036:0.044,
       tplhl$B0$Y = 0.015:0.016:0.017,
       tphlh$B0$Y = 0.026:0.034:0.043,
       tplhl$B1$Y = 0.014:0.015:0.016,
       tphlh$B1$Y = 0.023:0.031:0.039,
       tplhl$C0$Y = 0.011:0.012:0.013,
       tphlh$C0$Y = 0.018:0.025:0.032,
       tplhl$C1$Y = 0.0099:0.011:0.012,
       tphlh$C1$Y = 0.015:0.021:0.027;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
     (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI22X1 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I2_out, I0_out, I1_out);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.013:0.015:0.016,
       tphlh$A0$Y = 0.021:0.023:0.026,
       tplhl$A1$Y = 0.013:0.014:0.015,
       tphlh$A1$Y = 0.018:0.021:0.023,
       tplhl$B0$Y = 0.0096:0.01:0.011,
       tphlh$B0$Y = 0.015:0.018:0.02,
       tplhl$B1$Y = 0.0089:0.0095:0.01,
       tphlh$B1$Y = 0.013:0.015:0.018;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI22X2 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I2_out, I0_out, I1_out);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.013:0.014:0.016,
       tphlh$A0$Y = 0.02:0.023:0.026,
       tplhl$A1$Y = 0.013:0.014:0.015,
       tphlh$A1$Y = 0.018:0.02:0.023,
       tplhl$B0$Y = 0.0096:0.01:0.011,
       tphlh$B0$Y = 0.015:0.018:0.02,
       tplhl$B1$Y = 0.009:0.0096:0.01,
       tphlh$B1$Y = 0.013:0.015:0.018;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI22X4 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I2_out, I0_out, I1_out);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.013:0.014:0.016,
       tphlh$A0$Y = 0.02:0.023:0.026,
       tplhl$A1$Y = 0.013:0.014:0.015,
       tphlh$A1$Y = 0.018:0.02:0.023,
       tplhl$B0$Y = 0.0097:0.01:0.011,
       tphlh$B0$Y = 0.015:0.018:0.02,
       tplhl$B1$Y = 0.0091:0.0096:0.01,
       tphlh$B1$Y = 0.013:0.015:0.018;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI22XL (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I2_out, I0_out, I1_out);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.013:0.014:0.015,
       tphlh$A0$Y = 0.021:0.023:0.026,
       tplhl$A1$Y = 0.012:0.014:0.015,
       tphlh$A1$Y = 0.018:0.02:0.023,
       tplhl$B0$Y = 0.0092:0.0097:0.01,
       tphlh$B0$Y = 0.015:0.018:0.02,
       tplhl$B1$Y = 0.0085:0.0091:0.0097,
       tphlh$B1$Y = 0.012:0.015:0.017;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI2BB1X1 (A0N, A1N, B0, Y);
input  A0N ;
input  A1N ;
input  B0 ;
output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.024:0.024:0.024,
       tphhl$A0N$Y = 0.032:0.032:0.032,
       tpllh$A1N$Y = 0.022:0.022:0.022,
       tphhl$A1N$Y = 0.03:0.03:0.03,
       tplhl$B0$Y = 0.0073:0.0073:0.0073,
       tphlh$B0$Y = 0.016:0.016:0.016;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI2BB1X2 (A0N, A1N, B0, Y);
input  A0N ;
input  A1N ;
input  B0 ;
output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.029:0.029:0.029,
       tphhl$A0N$Y = 0.046:0.046:0.046,
       tpllh$A1N$Y = 0.028:0.028:0.028,
       tphhl$A1N$Y = 0.043:0.043:0.043,
       tplhl$B0$Y = 0.0069:0.0069:0.0069,
       tphlh$B0$Y = 0.016:0.016:0.016;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI2BB1X4 (A0N, A1N, B0, Y);
input  A0N ;
input  A1N ;
input  B0 ;
output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.031:0.031:0.031,
       tphhl$A0N$Y = 0.048:0.048:0.048,
       tpllh$A1N$Y = 0.03:0.03:0.03,
       tphhl$A1N$Y = 0.046:0.046:0.046,
       tplhl$B0$Y = 0.007:0.007:0.007,
       tphlh$B0$Y = 0.016:0.016:0.016;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI2BB1XL (A0N, A1N, B0, Y);
input  A0N ;
input  A1N ;
input  B0 ;
output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.02:0.02:0.02,
       tphhl$A0N$Y = 0.026:0.026:0.026,
       tpllh$A1N$Y = 0.019:0.019:0.019,
       tphhl$A1N$Y = 0.023:0.023:0.023,
       tplhl$B0$Y = 0.007:0.007:0.007,
       tphlh$B0$Y = 0.015:0.015:0.015;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI2BB2X1 (A0N, A1N, B0, B1, Y);
input  A0N ;
input  A1N ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, B0, B1);
   or  (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.029:0.032:0.035,
       tphhl$A0N$Y = 0.03:0.031:0.032,
       tpllh$A1N$Y = 0.027:0.03:0.032,
       tphhl$A1N$Y = 0.028:0.029:0.031,
       tplhl$B0$Y = 0.0096:0.01:0.01,
       tphlh$B0$Y = 0.015:0.017:0.02,
       tplhl$B1$Y = 0.0089:0.0094:0.0098,
       tphlh$B1$Y = 0.013:0.015:0.017;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI2BB2X2 (A0N, A1N, B0, B1, Y);
input  A0N ;
input  A1N ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, B0, B1);
   or  (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.035:0.038:0.041,
       tphhl$A0N$Y = 0.039:0.04:0.041,
       tpllh$A1N$Y = 0.033:0.036:0.039,
       tphhl$A1N$Y = 0.037:0.038:0.039,
       tplhl$B0$Y = 0.0096:0.0099:0.01,
       tphlh$B0$Y = 0.015:0.017:0.02,
       tplhl$B1$Y = 0.009:0.0093:0.0097,
       tphlh$B1$Y = 0.013:0.015:0.017;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI2BB2X4 (A0N, A1N, B0, B1, Y);
input  A0N ;
input  A1N ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, B0, B1);
   or  (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.037:0.04:0.043,
       tphhl$A0N$Y = 0.04:0.042:0.043,
       tpllh$A1N$Y = 0.035:0.038:0.04,
       tphhl$A1N$Y = 0.039:0.04:0.041,
       tplhl$B0$Y = 0.0097:0.01:0.01,
       tphlh$B0$Y = 0.015:0.018:0.02,
       tplhl$B1$Y = 0.009:0.0094:0.0097,
       tphlh$B1$Y = 0.013:0.015:0.017;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI2BB2XL (A0N, A1N, B0, B1, Y);
input  A0N ;
input  A1N ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, B0, B1);
   or  (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.026:0.028:0.031,
       tphhl$A0N$Y = 0.025:0.026:0.027,
       tpllh$A1N$Y = 0.023:0.026:0.029,
       tphhl$A1N$Y = 0.024:0.025:0.026,
       tplhl$B0$Y = 0.0091:0.0095:0.01,
       tphlh$B0$Y = 0.015:0.017:0.02,
       tplhl$B1$Y = 0.0085:0.009:0.0095,
       tphlh$B1$Y = 0.012:0.015:0.017;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI31X1 (A0, A1, A2, B0, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
output Y ;

   and (I1_out, A0, A1, A2);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.017:0.017:0.017,
       tphlh$A0$Y = 0.024:0.024:0.024,
       tplhl$A1$Y = 0.017:0.017:0.017,
       tphlh$A1$Y = 0.022:0.022:0.022,
       tplhl$A2$Y = 0.015:0.015:0.015,
       tphlh$A2$Y = 0.018:0.018:0.018,
       tplhl$B0$Y = 0.0055:0.0059:0.0064,
       tphlh$B0$Y = 0.011:0.015:0.019;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI31X2 (A0, A1, A2, B0, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
output Y ;

   and (I1_out, A0, A1, A2);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.017:0.017:0.017,
       tphlh$A0$Y = 0.024:0.024:0.024,
       tplhl$A1$Y = 0.017:0.017:0.017,
       tphlh$A1$Y = 0.022:0.022:0.022,
       tplhl$A2$Y = 0.015:0.015:0.015,
       tphlh$A2$Y = 0.018:0.018:0.018,
       tplhl$B0$Y = 0.0053:0.0057:0.0062,
       tphlh$B0$Y = 0.011:0.015:0.019;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI31X4 (A0, A1, A2, B0, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
output Y ;

   and (I1_out, A0, A1, A2);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.018:0.018:0.018,
       tphlh$A0$Y = 0.024:0.024:0.024,
       tplhl$A1$Y = 0.017:0.017:0.017,
       tphlh$A1$Y = 0.022:0.022:0.022,
       tplhl$A2$Y = 0.015:0.015:0.015,
       tphlh$A2$Y = 0.018:0.018:0.018,
       tplhl$B0$Y = 0.0055:0.0059:0.0064,
       tphlh$B0$Y = 0.011:0.015:0.019;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI31XL (A0, A1, A2, B0, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
output Y ;

   and (I1_out, A0, A1, A2);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.017:0.017:0.017,
       tphlh$A0$Y = 0.024:0.024:0.024,
       tplhl$A1$Y = 0.016:0.016:0.016,
       tphlh$A1$Y = 0.021:0.021:0.021,
       tplhl$A2$Y = 0.015:0.015:0.015,
       tphlh$A2$Y = 0.018:0.018:0.018,
       tplhl$B0$Y = 0.0052:0.0057:0.0062,
       tphlh$B0$Y = 0.011:0.015:0.019;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI32X1 (A0, A1, A2, B0, B1, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I1_out, A0, A1, A2);
   and (I2_out, B0, B1);
   or  (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.019:0.021:0.022,
       tphlh$A0$Y = 0.023:0.027:0.03,
       tplhl$A1$Y = 0.019:0.02:0.022,
       tphlh$A1$Y = 0.022:0.025:0.028,
       tplhl$A2$Y = 0.017:0.018:0.02,
       tphlh$A2$Y = 0.019:0.022:0.024,
       tplhl$B0$Y = 0.0096:0.01:0.011,
       tphlh$B0$Y = 0.014:0.019:0.023,
       tplhl$B1$Y = 0.009:0.0096:0.01,
       tphlh$B1$Y = 0.012:0.016:0.02;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI32X2 (A0, A1, A2, B0, B1, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I1_out, A0, A1, A2);
   and (I2_out, B0, B1);
   or  (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.019:0.021:0.022,
       tphlh$A0$Y = 0.023:0.027:0.03,
       tplhl$A1$Y = 0.019:0.02:0.022,
       tphlh$A1$Y = 0.022:0.025:0.028,
       tplhl$A2$Y = 0.017:0.018:0.02,
       tphlh$A2$Y = 0.019:0.022:0.024,
       tplhl$B0$Y = 0.0095:0.01:0.011,
       tphlh$B0$Y = 0.014:0.019:0.023,
       tplhl$B1$Y = 0.0089:0.0096:0.01,
       tphlh$B1$Y = 0.012:0.016:0.02;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI32X4 (A0, A1, A2, B0, B1, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I1_out, A0, A1, A2);
   and (I2_out, B0, B1);
   or  (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.019:0.021:0.022,
       tphlh$A0$Y = 0.023:0.027:0.03,
       tplhl$A1$Y = 0.019:0.02:0.022,
       tphlh$A1$Y = 0.021:0.024:0.027,
       tplhl$A2$Y = 0.017:0.018:0.02,
       tphlh$A2$Y = 0.019:0.022:0.024,
       tplhl$B0$Y = 0.0095:0.01:0.011,
       tphlh$B0$Y = 0.014:0.019:0.023,
       tplhl$B1$Y = 0.0089:0.0096:0.01,
       tphlh$B1$Y = 0.012:0.016:0.02;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI32XL (A0, A1, A2, B0, B1, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
output Y ;

   and (I1_out, A0, A1, A2);
   and (I2_out, B0, B1);
   or  (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.019:0.02:0.022,
       tphlh$A0$Y = 0.023:0.027:0.03,
       tplhl$A1$Y = 0.018:0.02:0.021,
       tphlh$A1$Y = 0.022:0.024:0.027,
       tplhl$A2$Y = 0.017:0.018:0.019,
       tphlh$A2$Y = 0.019:0.021:0.024,
       tplhl$B0$Y = 0.0093:0.0099:0.011,
       tphlh$B0$Y = 0.014:0.019:0.023,
       tplhl$B1$Y = 0.0087:0.0094:0.01,
       tphlh$B1$Y = 0.012:0.016:0.02;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI33X1 (A0, A1, A2, B0, B1, B2, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
input  B2 ;
output Y ;

   and (I1_out, A0, A1, A2);
   and (I3_out, B0, B1, B2);
   or  (I4_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.021:0.024:0.027,
       tphlh$A0$Y = 0.025:0.03:0.036,
       tplhl$A1$Y = 0.021:0.024:0.026,
       tphlh$A1$Y = 0.023:0.028:0.033,
       tplhl$A2$Y = 0.019:0.022:0.024,
       tphlh$A2$Y = 0.021:0.025:0.03,
       tplhl$B0$Y = 0.015:0.016:0.016,
       tphlh$B0$Y = 0.017:0.022:0.028,
       tplhl$B1$Y = 0.015:0.015:0.016,
       tphlh$B1$Y = 0.016:0.02:0.025,
       tplhl$B2$Y = 0.013:0.014:0.014,
       tphlh$B2$Y = 0.013:0.018:0.022;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI33X2 (A0, A1, A2, B0, B1, B2, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
input  B2 ;
output Y ;

   and (I1_out, A0, A1, A2);
   and (I3_out, B0, B1, B2);
   or  (I4_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.021:0.024:0.027,
       tphlh$A0$Y = 0.025:0.03:0.036,
       tplhl$A1$Y = 0.021:0.023:0.026,
       tphlh$A1$Y = 0.023:0.028:0.033,
       tplhl$A2$Y = 0.019:0.021:0.024,
       tphlh$A2$Y = 0.021:0.025:0.03,
       tplhl$B0$Y = 0.015:0.015:0.016,
       tphlh$B0$Y = 0.017:0.022:0.027,
       tplhl$B1$Y = 0.014:0.015:0.016,
       tphlh$B1$Y = 0.015:0.02:0.025,
       tplhl$B2$Y = 0.012:0.013:0.014,
       tphlh$B2$Y = 0.013:0.018:0.022;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI33X4 (A0, A1, A2, B0, B1, B2, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
input  B2 ;
output Y ;

   and (I1_out, A0, A1, A2);
   and (I3_out, B0, B1, B2);
   or  (I4_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.021:0.024:0.027,
       tphlh$A0$Y = 0.025:0.03:0.036,
       tplhl$A1$Y = 0.021:0.023:0.026,
       tphlh$A1$Y = 0.023:0.028:0.033,
       tplhl$A2$Y = 0.019:0.021:0.024,
       tphlh$A2$Y = 0.021:0.025:0.03,
       tplhl$B0$Y = 0.015:0.015:0.016,
       tphlh$B0$Y = 0.017:0.022:0.028,
       tplhl$B1$Y = 0.014:0.015:0.016,
       tphlh$B1$Y = 0.015:0.02:0.025,
       tplhl$B2$Y = 0.012:0.013:0.014,
       tphlh$B2$Y = 0.013:0.018:0.022;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module AOI33XL (A0, A1, A2, B0, B1, B2, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
input  B2 ;
output Y ;

   and (I1_out, A0, A1, A2);
   and (I3_out, B0, B1, B2);
   or  (I4_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.021:0.023:0.026,
       tphlh$A0$Y = 0.025:0.03:0.035,
       tplhl$A1$Y = 0.02:0.023:0.026,
       tphlh$A1$Y = 0.023:0.028:0.033,
       tplhl$A2$Y = 0.018:0.021:0.024,
       tphlh$A2$Y = 0.02:0.025:0.03,
       tplhl$B0$Y = 0.014:0.015:0.016,
       tphlh$B0$Y = 0.017:0.022:0.028,
       tplhl$B1$Y = 0.014:0.015:0.016,
       tphlh$B1$Y = 0.015:0.02:0.025,
       tplhl$B2$Y = 0.012:0.013:0.014,
       tphlh$B2$Y = 0.013:0.018:0.022;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BMXIX2 (A, M0, M1, PPN, S, X2);
input  A ;
input  M0 ;
input  M1 ;
input  S ;
input  X2 ;
output PPN ;

   udp_mux2 (I0_out, S, A, M0);
   udp_mux2 (I1_out, S, A, M1);
   udp_mux2 (PPN, I1_out, I0_out, X2);

   specify
     // delay parameters
     specparam
       tpllh$A$PPN = 0.053:0.053:0.053,
       tphhl$A$PPN = 0.063:0.063:0.064,
       tpllh$M0$PPN = 0.048:0.055:0.061,
       tplhl$M0$PPN = 0.055:0.059:0.063,
       tpllh$M1$PPN = 0.048:0.055:0.061,
       tplhl$M1$PPN = 0.055:0.059:0.063,
       tpllh$S$PPN = 0.053:0.053:0.054,
       tphhl$S$PPN = 0.063:0.063:0.063,
       tpllh$X2$PPN = 0.037:0.042:0.046,
       tplhl$X2$PPN = 0.038:0.039:0.039;

     // path delays
     (A *> PPN) = (tpllh$A$PPN, tphhl$A$PPN);
     (M0 *> PPN) = (tpllh$M0$PPN, tplhl$M0$PPN);
     (M1 *> PPN) = (tpllh$M1$PPN, tplhl$M1$PPN);
     (S *> PPN) = (tpllh$S$PPN, tphhl$S$PPN);
     (X2 *> PPN) = (tpllh$X2$PPN, tplhl$X2$PPN);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BMXIX4 (A, M0, M1, PPN, S, X2);
input  A ;
input  M0 ;
input  M1 ;
input  S ;
input  X2 ;
output PPN ;

   udp_mux2 (I0_out, S, A, M0);
   udp_mux2 (I1_out, S, A, M1);
   udp_mux2 (PPN, I1_out, I0_out, X2);

   specify
     // delay parameters
     specparam
       tpllh$A$PPN = 0.079:0.079:0.079,
       tphhl$A$PPN = 0.097:0.097:0.097,
       tpllh$M0$PPN = 0.074:0.08:0.087,
       tplhl$M0$PPN = 0.088:0.092:0.096,
       tpllh$M1$PPN = 0.075:0.081:0.087,
       tplhl$M1$PPN = 0.089:0.092:0.096,
       tpllh$S$PPN = 0.079:0.08:0.08,
       tphhl$S$PPN = 0.096:0.097:0.097,
       tpllh$X2$PPN = 0.058:0.063:0.068,
       tplhl$X2$PPN = 0.065:0.067:0.069;

     // path delays
     (A *> PPN) = (tpllh$A$PPN, tphhl$A$PPN);
     (M0 *> PPN) = (tpllh$M0$PPN, tplhl$M0$PPN);
     (M1 *> PPN) = (tpllh$M1$PPN, tplhl$M1$PPN);
     (S *> PPN) = (tpllh$S$PPN, tphhl$S$PPN);
     (X2 *> PPN) = (tpllh$X2$PPN, tplhl$X2$PPN);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BUFX12 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BUFX16 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.046:0.046:0.046,
       tphhl$A$Y = 0.055:0.055:0.055;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BUFX2 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.024:0.024:0.024,
       tphhl$A$Y = 0.029:0.029:0.029;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BUFX20 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BUFX3 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.022:0.022:0.022,
       tphhl$A$Y = 0.026:0.026:0.026;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BUFX4 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BUFX6 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.022:0.022:0.022,
       tphhl$A$Y = 0.026:0.026:0.026;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module BUFX8 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKAND2X12 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.024:0.024:0.024,
       tphhl$A$Y = 0.037:0.037:0.037,
       tpllh$B$Y = 0.023:0.023:0.023,
       tphhl$B$Y = 0.033:0.033:0.033;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKAND2X2 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.023:0.023:0.023,
       tphhl$A$Y = 0.035:0.035:0.035,
       tpllh$B$Y = 0.022:0.022:0.022,
       tphhl$B$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKAND2X3 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.021:0.021:0.021,
       tphhl$A$Y = 0.032:0.032:0.032,
       tpllh$B$Y = 0.02:0.02:0.02,
       tphhl$B$Y = 0.029:0.029:0.029;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKAND2X4 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.024:0.024:0.024,
       tphhl$A$Y = 0.036:0.036:0.036,
       tpllh$B$Y = 0.023:0.023:0.023,
       tphhl$B$Y = 0.033:0.033:0.033;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKAND2X6 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.021:0.021:0.021,
       tphhl$A$Y = 0.032:0.032:0.032,
       tpllh$B$Y = 0.02:0.02:0.02,
       tphhl$B$Y = 0.029:0.029:0.029;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKAND2X8 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.024:0.024:0.024,
       tphhl$A$Y = 0.037:0.037:0.037,
       tpllh$B$Y = 0.023:0.023:0.023,
       tphhl$B$Y = 0.033:0.033:0.033;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKBUFX12 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKBUFX16 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.046:0.046:0.046,
       tphhl$A$Y = 0.055:0.055:0.055;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKBUFX2 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.024:0.024:0.024,
       tphhl$A$Y = 0.029:0.029:0.029;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKBUFX20 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKBUFX3 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.022:0.022:0.022,
       tphhl$A$Y = 0.026:0.026:0.026;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKBUFX4 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKBUFX6 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.022:0.022:0.022,
       tphhl$A$Y = 0.026:0.026:0.026;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKBUFX8 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKINVX1 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.005:0.005:0.005,
       tphlh$A$Y = 0.0092:0.0092:0.0092;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKINVX12 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0048:0.0048:0.0048,
       tphlh$A$Y = 0.0089:0.0089:0.0089;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKINVX16 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.017:0.017:0.017,
       tphlh$A$Y = 0.032:0.032:0.032;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKINVX2 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0047:0.0047:0.0047,
       tphlh$A$Y = 0.0088:0.0088:0.0088;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKINVX20 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0049:0.0049:0.0049,
       tphlh$A$Y = 0.009:0.009:0.009;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKINVX3 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0049:0.0049:0.0049,
       tphlh$A$Y = 0.009:0.009:0.009;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKINVX4 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0047:0.0047:0.0047,
       tphlh$A$Y = 0.0088:0.0088:0.0088;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKINVX6 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.005:0.005:0.005,
       tphlh$A$Y = 0.0091:0.0091:0.0091;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKINVX8 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0049:0.0049:0.0049,
       tphlh$A$Y = 0.009:0.009:0.009;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKMX2X12 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.11:0.11:0.11,
       tphhl$A$Y = 0.13:0.13:0.13,
       tpllh$B$Y = 0.11:0.11:0.11,
       tphhl$B$Y = 0.13:0.13:0.13,
       tpllh$S0$Y = 0.1:0.11:0.11,
       tplhl$S0$Y = 0.13:0.13:0.13;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKMX2X2 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.038:0.038:0.038,
       tphhl$A$Y = 0.049:0.049:0.049,
       tpllh$B$Y = 0.038:0.038:0.038,
       tphhl$B$Y = 0.049:0.049:0.049,
       tpllh$S0$Y = 0.033:0.04:0.046,
       tplhl$S0$Y = 0.04:0.045:0.049;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKMX2X3 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.036:0.036:0.036,
       tphhl$A$Y = 0.044:0.044:0.044,
       tpllh$B$Y = 0.035:0.035:0.035,
       tphhl$B$Y = 0.046:0.046:0.046,
       tpllh$S0$Y = 0.03:0.039:0.049,
       tplhl$S0$Y = 0.036:0.042:0.048;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKMX2X4 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.048:0.048:0.048,
       tphhl$A$Y = 0.059:0.059:0.059,
       tpllh$B$Y = 0.047:0.047:0.047,
       tphhl$B$Y = 0.06:0.06:0.06,
       tpllh$S0$Y = 0.042:0.05:0.058,
       tplhl$S0$Y = 0.051:0.056:0.061;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKMX2X6 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.062:0.062:0.062,
       tphhl$A$Y = 0.079:0.079:0.079,
       tpllh$B$Y = 0.062:0.062:0.062,
       tphhl$B$Y = 0.079:0.079:0.079,
       tpllh$S0$Y = 0.057:0.064:0.072,
       tplhl$S0$Y = 0.07:0.075:0.079;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKMX2X8 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.077:0.077:0.077,
       tphhl$A$Y = 0.097:0.097:0.097,
       tpllh$B$Y = 0.076:0.076:0.076,
       tphhl$B$Y = 0.098:0.098:0.098,
       tpllh$S0$Y = 0.071:0.079:0.086,
       tplhl$S0$Y = 0.089:0.094:0.098;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKXOR2X1 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.031:0.036:0.041,
       tplhl$A$Y = 0.034:0.039:0.043,
       tpllh$B$Y = 0.023:0.027:0.031,
       tplhl$B$Y = 0.023:0.03:0.036;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKXOR2X2 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.039:0.045:0.051,
       tplhl$A$Y = 0.043:0.05:0.056,
       tpllh$B$Y = 0.033:0.036:0.039,
       tplhl$B$Y = 0.031:0.04:0.048;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKXOR2X4 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.057:0.06:0.064,
       tplhl$A$Y = 0.064:0.067:0.07,
       tpllh$B$Y = 0.042:0.047:0.053,
       tplhl$B$Y = 0.044:0.052:0.06;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module CLKXOR2X8 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.089:0.091:0.093,
       tplhl$A$Y = 0.1:0.1:0.11,
       tpllh$B$Y = 0.071:0.077:0.084,
       tplhl$B$Y = 0.08:0.089:0.098;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFHQX1 (CK, D, Q);
input  CK ;
input  D ;
output Q ;
reg NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, N30);
   not (Q, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.058:0.058:0.058,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tminpwh$CK = 0.037:0.052:0.068,
       tminpwl$CK = 0.047:0.062:0.076,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFHQX2 (CK, D, Q);
input  CK ;
input  D ;
output Q ;
reg NOTIFIER ;

   udp_dff (P0002, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0002);
   not (Q, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.063:0.063:0.063,
       tplhl$CK$Q = 0.074:0.074:0.074,
       tminpwh$CK = 0.037:0.055:0.074,
       tminpwl$CK = 0.047:0.061:0.075,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFHQX4 (CK, D, Q);
input  CK ;
input  D ;
output Q ;
reg NOTIFIER ;

   udp_dff (P0000, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.069:0.069:0.069,
       tplhl$CK$Q = 0.077:0.077:0.077,
       tminpwh$CK = 0.043:0.06:0.077,
       tminpwl$CK = 0.047:0.062:0.076,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFHQX8 (CK, D, Q);
input  CK ;
input  D ;
output Q ;
reg NOTIFIER ;

   udp_dff (P0001, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.082:0.082:0.082,
       tplhl$CK$Q = 0.087:0.087:0.087,
       tminpwh$CK = 0.051:0.069:0.087,
       tminpwl$CK = 0.047:0.062:0.076,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFNSRX1 (CKN, D, Q, QN, RN, SN);
input  CKN ;
input  D ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0001, D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0001);
   not (Q, P0002);
   buf (QN, P0002);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tphlh$CKN$Q = 0.069:0.069:0.069,
       tphhl$CKN$Q = 0.064:0.064:0.064,
       tphlh$CKN$QN = 0.08:0.08:0.08,
       tphhl$CKN$QN = 0.083:0.083:0.083,
       tphhl$RN$Q = 0.076:0.079:0.081,
       tphlh$RN$QN = 0.093:0.095:0.097,
       tplhl$SN$Q = 0.063:0.064:0.066,
       tphlh$SN$Q = 0.062:0.063:0.064,
       tpllh$SN$QN = 0.079:0.081:0.083,
       tphhl$SN$QN = 0.075:0.077:0.078,
       tminpwh$CKN = 0.028:0.044:0.06,
       tminpwl$CKN = 0.031:0.057:0.083,
       tminpwl$RN = 0.032:0.065:0.097,
       tminpwl$SN = 0.018:0.048:0.078,
       tsetup_negedge$D$CKN = 0.094:0.094:0.094,
       thold_negedge$D$CKN = 0:0:0,
       tsetup_posedge$D$CKN = 0.094:0.094:0.094,
       thold_posedge$D$CKN = 0.094:0.094:0.094,
       trec$RN$CKN = 0.094:0.094:0.094,
       trem$RN$CKN = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CKN = 0.094:0.094:0.094,
       trem$SN$CKN = 0.094:0.094:0.094;

     // path delays
     if (CKN == 1'b0)
       (CKN *> Q) = (tphlh$CKN$Q, tphhl$CKN$Q);
     if (CKN == 1'b0)
       (CKN *> QN) = (tphlh$CKN$QN, tphhl$CKN$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
     $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
     $recovery(posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CKN, NOTIFIER);
     $removal (posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CKN, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CKN, NOTIFIER);
     $removal (posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CKN, NOTIFIER);
     $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
     $width(negedge CKN, tminpwl$CKN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFNSRX2 (CKN, D, Q, QN, RN, SN);
input  CKN ;
input  D ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0001, D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0001);
   not (Q, P0002);
   buf (QN, P0002);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tphlh$CKN$Q = 0.073:0.073:0.073,
       tphhl$CKN$Q = 0.067:0.067:0.067,
       tphlh$CKN$QN = 0.093:0.093:0.093,
       tphhl$CKN$QN = 0.097:0.097:0.097,
       tphhl$RN$Q = 0.08:0.083:0.086,
       tphlh$RN$QN = 0.11:0.11:0.11,
       tplhl$SN$Q = 0.067:0.069:0.071,
       tphlh$SN$Q = 0.066:0.068:0.069,
       tpllh$SN$QN = 0.092:0.094:0.097,
       tphhl$SN$QN = 0.09:0.091:0.093,
       tminpwh$CKN = 0.028:0.045:0.061,
       tminpwl$CKN = 0.033:0.065:0.097,
       tminpwl$RN = 0.033:0.072:0.11,
       tminpwl$SN = 0.019:0.056:0.093,
       tsetup_negedge$D$CKN = 0.094:0.094:0.094,
       thold_negedge$D$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$CKN = 0.094:0.094:0.094,
       thold_posedge$D$CKN = 0.094:0.094:0.094,
       trec$RN$CKN = 0.094:0.094:0.094,
       trem$RN$CKN = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CKN = 0.094:0.094:0.094,
       trem$SN$CKN = 0.094:0.094:0.094;

     // path delays
     if (CKN == 1'b0)
       (CKN *> Q) = (tphlh$CKN$Q, tphhl$CKN$Q);
     if (CKN == 1'b0)
       (CKN *> QN) = (tphlh$CKN$QN, tphhl$CKN$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
     $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
     $recovery(posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CKN, NOTIFIER);
     $removal (posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CKN, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CKN, NOTIFIER);
     $removal (posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CKN, NOTIFIER);
     $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
     $width(negedge CKN, tminpwl$CKN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFNSRX4 (CKN, D, Q, QN, RN, SN);
input  CKN ;
input  D ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0001, D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tphlh$CKN$Q = 0.083:0.083:0.083,
       tphhl$CKN$Q = 0.077:0.077:0.077,
       tphlh$CKN$QN = 0.1:0.1:0.1,
       tphhl$CKN$QN = 0.11:0.11:0.11,
       tphhl$RN$Q = 0.091:0.093:0.095,
       tphlh$RN$QN = 0.12:0.12:0.12,
       tplhl$SN$Q = 0.077:0.079:0.08,
       tphlh$SN$Q = 0.075:0.078:0.081,
       tpllh$SN$QN = 0.1:0.11:0.11,
       tphhl$SN$QN = 0.1:0.1:0.11,
       tminpwh$CKN = 0.028:0.044:0.06,
       tminpwl$CKN = 0.04:0.074:0.11,
       tminpwl$RN = 0.032:0.077:0.12,
       tminpwl$SN = 0.019:0.063:0.11,
       tsetup_negedge$D$CKN = 0.094:0.094:0.094,
       thold_negedge$D$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$CKN = 0.094:0.094:0.094,
       thold_posedge$D$CKN = 0.094:0.094:0.094,
       trec$RN$CKN = 0.094:0.094:0.094,
       trem$RN$CKN = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CKN = 0.094:0.094:0.094,
       trem$SN$CKN = 0.094:0.094:0.094;

     // path delays
     if (CKN == 1'b0)
       (CKN *> Q) = (tphlh$CKN$Q, tphhl$CKN$Q);
     if (CKN == 1'b0)
       (CKN *> QN) = (tphlh$CKN$QN, tphhl$CKN$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
     $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
     $recovery(posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CKN, NOTIFIER);
     $removal (posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CKN, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CKN, NOTIFIER);
     $removal (posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CKN, NOTIFIER);
     $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
     $width(negedge CKN, tminpwl$CKN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFNSRXL (CKN, D, Q, QN, RN, SN);
input  CKN ;
input  D ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0001, D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0001);
   not (Q, P0002);
   buf (QN, P0002);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tphlh$CKN$Q = 0.064:0.064:0.064,
       tphhl$CKN$Q = 0.059:0.059:0.059,
       tphlh$CKN$QN = 0.07:0.07:0.07,
       tphhl$CKN$QN = 0.073:0.073:0.073,
       tphhl$RN$Q = 0.071:0.074:0.076,
       tphlh$RN$QN = 0.083:0.085:0.088,
       tplhl$SN$Q = 0.057:0.06:0.062,
       tphlh$SN$Q = 0.057:0.059:0.06,
       tpllh$SN$QN = 0.069:0.071:0.073,
       tphhl$SN$QN = 0.066:0.067:0.069,
       tminpwh$CKN = 0.028:0.044:0.06,
       tminpwl$CKN = 0.031:0.052:0.073,
       tminpwl$RN = 0.032:0.06:0.088,
       tminpwl$SN = 0.018:0.043:0.069,
       tsetup_negedge$D$CKN = 0.094:0.094:0.094,
       thold_negedge$D$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$CKN = 0.094:0.094:0.094,
       thold_posedge$D$CKN = 0.094:0.094:0.094,
       trec$RN$CKN = 0.094:0.094:0.094,
       trem$RN$CKN = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CKN = 0.094:0.094:0.094,
       trem$SN$CKN = 0.094:0.094:0.094;

     // path delays
     if (CKN == 1'b0)
       (CKN *> Q) = (tphlh$CKN$Q, tphhl$CKN$Q);
     if (CKN == 1'b0)
       (CKN *> QN) = (tphlh$CKN$QN, tphhl$CKN$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
     $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
     $recovery(posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CKN, NOTIFIER);
     $removal (posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CKN, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CKN, NOTIFIER);
     $removal (posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CKN, NOTIFIER);
     $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
     $width(negedge CKN, tminpwl$CKN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFQX1 (CK, D, Q);
input  CK ;
input  D ;
output Q ;
reg NOTIFIER ;

   udp_dff (P0001, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.056:0.056:0.056,
       tplhl$CK$Q = 0.064:0.064:0.064,
       tminpwh$CK = 0.033:0.048:0.064,
       tminpwl$CK = 0.043:0.055:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFQX2 (CK, D, Q);
input  CK ;
input  D ;
output Q ;
reg NOTIFIER ;

   udp_dff (P0002, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0002);
   not (Q, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.061:0.061:0.061,
       tplhl$CK$Q = 0.067:0.067:0.067,
       tminpwh$CK = 0.035:0.051:0.067,
       tminpwl$CK = 0.043:0.055:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFQX4 (CK, D, Q);
input  CK ;
input  D ;
output Q ;
reg NOTIFIER ;

   udp_dff (P0001, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.069:0.069:0.069,
       tplhl$CK$Q = 0.073:0.073:0.073,
       tminpwh$CK = 0.042:0.057:0.073,
       tminpwl$CK = 0.043:0.056:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFQXL (CK, D, Q);
input  CK ;
input  D ;
output Q ;
reg NOTIFIER ;

   udp_dff (P0001, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0001);
   not (Q, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.053:0.053:0.053,
       tplhl$CK$Q = 0.059:0.059:0.059,
       tminpwh$CK = 0.033:0.046:0.059,
       tminpwl$CK = 0.043:0.056:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFRHQX1 (CK, D, Q, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (P0002, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.066:0.066:0.066,
       tplhl$CK$Q = 0.069:0.069:0.069,
       tphhl$RN$Q = 0.025:0.025:0.025,
       tminpwh$CK = 0.037:0.053:0.069,
       tminpwl$CK = 0.047:0.061:0.076,
       tminpwl$RN = 0.019:0.035:0.051,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFRHQX2 (CK, D, Q, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (P0001, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0002, P0001);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.074:0.074:0.074,
       tplhl$CK$Q = 0.075:0.075:0.075,
       tphhl$RN$Q = 0.03:0.03:0.031,
       tminpwh$CK = 0.037:0.056:0.075,
       tminpwl$CK = 0.047:0.062:0.076,
       tminpwl$RN = 0.025:0.038:0.052,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFRHQX4 (CK, D, Q, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (P0001, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0003, P0001);
   not (Q, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.078:0.078:0.078,
       tplhl$CK$Q = 0.078:0.078:0.078,
       tphhl$RN$Q = 0.028:0.028:0.028,
       tminpwh$CK = 0.043:0.06:0.078,
       tminpwl$CK = 0.047:0.062:0.076,
       tminpwl$RN = 0.023:0.039:0.056,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFRHQX8 (CK, D, Q, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (P0001, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.091:0.091:0.091,
       tplhl$CK$Q = 0.088:0.088:0.088,
       tphhl$RN$Q = 0.029:0.029:0.029,
       tminpwh$CK = 0.051:0.071:0.091,
       tminpwl$CK = 0.047:0.062:0.077,
       tminpwl$RN = 0.021:0.043:0.065,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFRX1 (CK, D, Q, QN, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (P0000, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);
   buf (QN, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.07:0.07:0.07,
       tplhl$CK$Q = 0.069:0.069:0.069,
       tpllh$CK$QN = 0.085:0.085:0.085,
       tplhl$CK$QN = 0.085:0.085:0.085,
       tphhl$RN$Q = 0.032:0.032:0.032,
       tphlh$RN$QN = 0.048:0.048:0.049,
       tminpwh$CK = 0.032:0.059:0.085,
       tminpwl$CK = 0.043:0.056:0.069,
       tminpwl$RN = 0.026:0.038:0.051,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFRX2 (CK, D, Q, QN, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (P0000, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0001, P0000);
   not (Q, P0001);
   buf (QN, P0001);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.075:0.075:0.075,
       tplhl$CK$Q = 0.071:0.071:0.071,
       tpllh$CK$QN = 0.096:0.096:0.096,
       tplhl$CK$QN = 0.1:0.1:0.1,
       tphhl$RN$Q = 0.032:0.033:0.033,
       tphlh$RN$QN = 0.058:0.058:0.058,
       tminpwh$CK = 0.035:0.068:0.1,
       tminpwl$CK = 0.043:0.055:0.068,
       tminpwl$RN = 0.027:0.043:0.058,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFRX4 (CK, D, Q, QN, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (P0000, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0001, P0000);
   not (Q, P0001);
   buf (QN, P0001);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.082:0.082:0.082,
       tplhl$CK$Q = 0.077:0.077:0.077,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.11:0.11:0.11,
       tphhl$RN$Q = 0.03:0.03:0.03,
       tphlh$RN$QN = 0.058:0.058:0.058,
       tminpwh$CK = 0.041:0.075:0.11,
       tminpwl$CK = 0.043:0.055:0.068,
       tminpwl$RN = 0.025:0.042:0.059,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFRXL (CK, D, Q, QN, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (P0001, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0003, P0001);
   not (Q, P0003);
   buf (QN, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.065:0.065:0.065,
       tplhl$CK$Q = 0.065:0.065:0.065,
       tpllh$CK$QN = 0.076:0.076:0.076,
       tplhl$CK$QN = 0.075:0.075:0.075,
       tphhl$RN$Q = 0.028:0.028:0.028,
       tphlh$RN$QN = 0.039:0.039:0.04,
       tminpwh$CK = 0.032:0.054:0.076,
       tminpwl$CK = 0.043:0.056:0.069,
       tminpwl$RN = 0.023:0.037:0.051,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSHQX1 (CK, D, Q, SN);
input  CK ;
input  D ;
input  SN ;
output Q ;
reg NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (P0003, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.058:0.058:0.058,
       tplhl$CK$Q = 0.072:0.072:0.072,
       tphlh$SN$Q = 0.051:0.052:0.052,
       tminpwh$CK = 0.037:0.054:0.072,
       tminpwl$CK = 0.047:0.064:0.081,
       tminpwl$SN = 0.016:0.034:0.052,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (SN *> Q) = (tphlh$SN$Q, 0);
     $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSHQX2 (CK, D, Q, SN);
input  CK ;
input  D ;
input  SN ;
output Q ;
reg NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (P0003, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.063:0.063:0.063,
       tplhl$CK$Q = 0.078:0.078:0.078,
       tphlh$SN$Q = 0.057:0.057:0.058,
       tminpwh$CK = 0.037:0.057:0.078,
       tminpwl$CK = 0.047:0.064:0.081,
       tminpwl$SN = 0.016:0.037:0.058,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (SN *> Q) = (tphlh$SN$Q, 0);
     $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSHQX4 (CK, D, Q, SN);
input  CK ;
input  D ;
input  SN ;
output Q ;
reg NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (P0001, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.069:0.069:0.069,
       tplhl$CK$Q = 0.083:0.083:0.083,
       tphlh$SN$Q = 0.062:0.064:0.065,
       tminpwh$CK = 0.043:0.063:0.083,
       tminpwl$CK = 0.048:0.064:0.081,
       tminpwl$SN = 0.016:0.041:0.065,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (SN *> Q) = (tphlh$SN$Q, 0);
     $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSHQX8 (CK, D, Q, SN);
input  CK ;
input  D ;
input  SN ;
output Q ;
reg NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (P0000, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.082:0.082:0.082,
       tplhl$CK$Q = 0.095:0.095:0.095,
       tphlh$SN$Q = 0.074:0.078:0.082,
       tminpwh$CK = 0.052:0.073:0.095,
       tminpwl$CK = 0.047:0.064:0.081,
       tminpwl$SN = 0.016:0.049:0.082,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (SN *> Q) = (tphlh$SN$Q, 0);
     $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSRHQX1 (CK, D, Q, RN, SN);
input  CK ;
input  D ;
input  RN ;
input  SN ;
output Q ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, N35);
   not (Q, P0002);
   not (I6_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I6_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.061:0.061:0.061,
       tplhl$CK$Q = 0.071:0.071:0.071,
       tphhl$RN$Q = 0.073:0.076:0.079,
       tplhl$SN$Q = 0.055:0.058:0.06,
       tphlh$SN$Q = 0.055:0.056:0.057,
       tminpwh$CK = 0.039:0.055:0.071,
       tminpwl$CK = 0.047:0.064:0.082,
       tminpwl$RN = 0.037:0.058:0.079,
       tminpwl$SN = 0.019:0.038:0.057,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSRHQX2 (CK, D, Q, RN, SN);
input  CK ;
input  D ;
input  RN ;
input  SN ;
output Q ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0003, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   not (I6_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I6_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.067:0.067:0.067,
       tplhl$CK$Q = 0.078:0.078:0.078,
       tphhl$RN$Q = 0.08:0.083:0.086,
       tplhl$SN$Q = 0.062:0.065:0.067,
       tphlh$SN$Q = 0.06:0.061:0.063,
       tminpwh$CK = 0.039:0.058:0.078,
       tminpwl$CK = 0.047:0.064:0.081,
       tminpwl$RN = 0.037:0.062:0.086,
       tminpwl$SN = 0.019:0.041:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSRHQX4 (CK, D, Q, RN, SN);
input  CK ;
input  D ;
input  RN ;
input  SN ;
output Q ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0001, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0003, P0001);
   not (Q, P0003);
   not (I6_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I6_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.075:0.075:0.075,
       tplhl$CK$Q = 0.082:0.082:0.082,
       tphhl$RN$Q = 0.087:0.089:0.092,
       tplhl$SN$Q = 0.069:0.071:0.073,
       tphlh$SN$Q = 0.066:0.068:0.071,
       tminpwh$CK = 0.046:0.064:0.082,
       tminpwl$CK = 0.047:0.064:0.081,
       tminpwl$RN = 0.037:0.064:0.092,
       tminpwl$SN = 0.018:0.044:0.071,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSRHQX8 (CK, D, Q, RN, SN);
input  CK ;
input  D ;
input  RN ;
input  SN ;
output Q ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0000, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);
   not (I6_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I6_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.09:0.09:0.09,
       tplhl$CK$Q = 0.095:0.095:0.095,
       tphhl$RN$Q = 0.1:0.1:0.11,
       tplhl$SN$Q = 0.085:0.086:0.088,
       tphlh$SN$Q = 0.08:0.084:0.087,
       tminpwh$CK = 0.056:0.075:0.095,
       tminpwl$CK = 0.047:0.064:0.082,
       tminpwl$RN = 0.037:0.072:0.11,
       tminpwl$SN = 0.019:0.053:0.087,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSRX1 (CK, D, Q, QN, RN, SN);
input  CK ;
input  D ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0001, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0003, P0001);
   not (Q, P0003);
   buf (QN, P0003);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.063:0.063:0.063,
       tplhl$CK$Q = 0.072:0.072:0.072,
       tpllh$CK$QN = 0.088:0.088:0.088,
       tplhl$CK$QN = 0.077:0.077:0.077,
       tphhl$RN$Q = 0.076:0.079:0.082,
       tphlh$RN$QN = 0.093:0.096:0.099,
       tplhl$SN$Q = 0.062:0.065:0.067,
       tphlh$SN$Q = 0.061:0.063:0.064,
       tpllh$SN$QN = 0.078:0.081:0.084,
       tphhl$SN$QN = 0.075:0.077:0.078,
       tminpwh$CK = 0.034:0.061:0.088,
       tminpwl$CK = 0.042:0.058:0.075,
       tminpwl$RN = 0.033:0.066:0.099,
       tminpwl$SN = 0.019:0.048:0.078,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.095:0.095:0.095,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSRX2 (CK, D, Q, QN, RN, SN);
input  CK ;
input  D ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0000, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, P0000);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.068:0.068:0.068,
       tplhl$CK$Q = 0.075:0.075:0.075,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.092:0.092:0.092,
       tphhl$RN$Q = 0.08:0.083:0.085,
       tphlh$RN$QN = 0.11:0.11:0.11,
       tplhl$SN$Q = 0.066:0.068:0.07,
       tphlh$SN$Q = 0.066:0.067:0.069,
       tpllh$SN$QN = 0.091:0.094:0.096,
       tphhl$SN$QN = 0.09:0.091:0.093,
       tminpwh$CK = 0.037:0.069:0.1,
       tminpwl$CK = 0.042:0.058:0.074,
       tminpwl$RN = 0.032:0.071:0.11,
       tminpwl$SN = 0.018:0.055:0.093,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSRX4 (CK, D, Q, QN, RN, SN);
input  CK ;
input  D ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0001, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.079:0.079:0.079,
       tplhl$CK$Q = 0.083:0.083:0.083,
       tpllh$CK$QN = 0.11:0.11:0.11,
       tplhl$CK$QN = 0.1:0.1:0.1,
       tphhl$RN$Q = 0.091:0.093:0.094,
       tphlh$RN$QN = 0.12:0.12:0.12,
       tplhl$SN$Q = 0.078:0.079:0.08,
       tphlh$SN$Q = 0.075:0.078:0.081,
       tpllh$SN$QN = 0.1:0.11:0.11,
       tphhl$SN$QN = 0.1:0.1:0.11,
       tminpwh$CK = 0.045:0.078:0.11,
       tminpwl$CK = 0.042:0.058:0.074,
       tminpwl$RN = 0.032:0.077:0.12,
       tminpwl$SN = 0.018:0.062:0.11,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.095:0.095:0.095,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSRXL (CK, D, Q, QN, RN, SN);
input  CK ;
input  D ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0001, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0003, P0001);
   not (Q, P0003);
   buf (QN, P0003);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.06:0.06:0.06,
       tplhl$CK$Q = 0.067:0.067:0.067,
       tpllh$CK$QN = 0.078:0.078:0.078,
       tplhl$CK$QN = 0.068:0.068:0.068,
       tphhl$RN$Q = 0.072:0.074:0.077,
       tphlh$RN$QN = 0.083:0.086:0.089,
       tplhl$SN$Q = 0.057:0.06:0.062,
       tphlh$SN$Q = 0.058:0.059:0.06,
       tpllh$SN$QN = 0.069:0.071:0.074,
       tphhl$SN$QN = 0.066:0.067:0.069,
       tminpwh$CK = 0.034:0.056:0.078,
       tminpwl$CK = 0.042:0.059:0.075,
       tminpwl$RN = 0.033:0.061:0.089,
       tminpwl$SN = 0.019:0.044:0.069,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.095:0.095:0.095,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSX1 (CK, D, Q, QN, SN);
input  CK ;
input  D ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (P0000, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);
   buf (QN, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.06:0.06:0.06,
       tplhl$CK$Q = 0.072:0.072:0.072,
       tpllh$CK$QN = 0.088:0.088:0.088,
       tplhl$CK$QN = 0.074:0.074:0.074,
       tphlh$SN$Q = 0.058:0.059:0.059,
       tphhl$SN$QN = 0.072:0.073:0.073,
       tminpwh$CK = 0.032:0.06:0.088,
       tminpwl$CK = 0.043:0.058:0.073,
       tminpwl$SN = 0.016:0.045:0.073,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (SN *> Q) = (tphlh$SN$Q, 0);
     (SN *> QN) = (0, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSX2 (CK, D, Q, QN, SN);
input  CK ;
input  D ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (P0003, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   buf (QN, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.064:0.064:0.064,
       tplhl$CK$Q = 0.075:0.075:0.075,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.087:0.087:0.087,
       tphlh$SN$Q = 0.061:0.063:0.064,
       tphhl$SN$QN = 0.085:0.086:0.087,
       tminpwh$CK = 0.035:0.068:0.1,
       tminpwl$CK = 0.043:0.059:0.074,
       tminpwl$SN = 0.016:0.052:0.087,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (SN *> Q) = (tphlh$SN$Q, 0);
     (SN *> QN) = (0, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSX4 (CK, D, Q, QN, SN);
input  CK ;
input  D ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (P0001, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.072:0.072:0.072,
       tplhl$CK$Q = 0.083:0.083:0.083,
       tpllh$CK$QN = 0.11:0.11:0.11,
       tplhl$CK$QN = 0.097:0.097:0.097,
       tphlh$SN$Q = 0.07:0.072:0.075,
       tphhl$SN$QN = 0.094:0.097:0.1,
       tminpwh$CK = 0.042:0.076:0.11,
       tminpwl$CK = 0.042:0.058:0.073,
       tminpwl$SN = 0.016:0.058:0.1,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (SN *> Q) = (tphlh$SN$Q, 0);
     (SN *> QN) = (0, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFSXL (CK, D, Q, QN, SN);
input  CK ;
input  D ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (P0000, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);
   buf (QN, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.056:0.056:0.056,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tpllh$CK$QN = 0.079:0.079:0.079,
       tplhl$CK$QN = 0.065:0.065:0.065,
       tphlh$SN$Q = 0.055:0.055:0.056,
       tphhl$SN$QN = 0.063:0.064:0.065,
       tminpwh$CK = 0.032:0.056:0.079,
       tminpwl$CK = 0.043:0.058:0.073,
       tminpwl$SN = 0.016:0.04:0.065,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (SN *> Q) = (tphlh$SN$Q, 0);
     (SN *> QN) = (0, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFTRX1 (CK, D, Q, QN, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_D, D, RN);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0001);
   not (Q, P0003);
   buf (QN, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.06:0.06:0.06,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tpllh$CK$QN = 0.084:0.084:0.084,
       tplhl$CK$QN = 0.074:0.074:0.074,
       tminpwh$CK = 0.033:0.058:0.084,
       tminpwl$CK = 0.044:0.051:0.059,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& D == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& D == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFTRX2 (CK, D, Q, QN, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_D, D, RN);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.064:0.064:0.064,
       tplhl$CK$Q = 0.071:0.071:0.071,
       tpllh$CK$QN = 0.095:0.095:0.095,
       tplhl$CK$QN = 0.087:0.087:0.087,
       tminpwh$CK = 0.035:0.065:0.095,
       tminpwl$CK = 0.044:0.051:0.059,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& D == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& D == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFTRX4 (CK, D, Q, QN, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_D, D, RN);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.073:0.073:0.073,
       tplhl$CK$Q = 0.076:0.076:0.076,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.098:0.098:0.098,
       tminpwh$CK = 0.042:0.073:0.1,
       tminpwl$CK = 0.044:0.051:0.059,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& D == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& D == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFTRXL (CK, D, Q, QN, RN);
input  CK ;
input  D ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_D, D, RN);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0001);
   not (Q, P0003);
   buf (QN, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.057:0.057:0.057,
       tplhl$CK$Q = 0.064:0.064:0.064,
       tpllh$CK$QN = 0.075:0.075:0.075,
       tplhl$CK$QN = 0.065:0.065:0.065,
       tminpwh$CK = 0.032:0.054:0.075,
       tminpwl$CK = 0.044:0.051:0.058,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& D == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& D == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFX1 (CK, D, Q, QN);
input  CK ;
input  D ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_dff (P0000, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);
   buf (QN, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.06:0.06:0.06,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tpllh$CK$QN = 0.084:0.084:0.084,
       tplhl$CK$QN = 0.074:0.074:0.074,
       tminpwh$CK = 0.033:0.058:0.084,
       tminpwl$CK = 0.043:0.055:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFX2 (CK, D, Q, QN);
input  CK ;
input  D ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_dff (P0001, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.064:0.064:0.064,
       tplhl$CK$Q = 0.07:0.07:0.07,
       tpllh$CK$QN = 0.095:0.095:0.095,
       tplhl$CK$QN = 0.088:0.088:0.088,
       tminpwh$CK = 0.035:0.065:0.095,
       tminpwl$CK = 0.043:0.056:0.069,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFX4 (CK, D, Q, QN);
input  CK ;
input  D ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_dff (P0001, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.072:0.072:0.072,
       tplhl$CK$Q = 0.076:0.076:0.076,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.097:0.097:0.097,
       tminpwh$CK = 0.042:0.072:0.1,
       tminpwl$CK = 0.043:0.055:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DFFXL (CK, D, Q, QN);
input  CK ;
input  D ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_dff (P0000, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);
   buf (QN, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.057:0.057:0.057,
       tplhl$CK$Q = 0.064:0.064:0.064,
       tpllh$CK$QN = 0.075:0.075:0.075,
       tplhl$CK$QN = 0.065:0.065:0.065,
       tminpwh$CK = 0.032:0.054:0.075,
       tminpwl$CK = 0.043:0.056:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = 0.093:0.093:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DLY1X1 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.048:0.048:0.048,
       tphhl$A$Y = 0.046:0.046:0.046;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DLY1X4 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.065:0.065:0.065,
       tphhl$A$Y = 0.062:0.062:0.062;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DLY2X1 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.086:0.086:0.086,
       tphhl$A$Y = 0.084:0.084:0.084;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DLY2X4 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.1:0.1:0.1,
       tphhl$A$Y = 0.1:0.1:0.1;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DLY3X1 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.12:0.12:0.12,
       tphhl$A$Y = 0.12:0.12:0.12;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DLY3X4 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.14:0.14:0.14,
       tphhl$A$Y = 0.14:0.14:0.14;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DLY4X1 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.16:0.16:0.16,
       tphhl$A$Y = 0.16:0.16:0.16;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module DLY4X4 (A, Y);
input  A ;
output Y ;

   buf (Y, A);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.18:0.18:0.18,
       tphhl$A$Y = 0.17:0.17:0.17;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFHQX1 (CK, D, E, Q);
input  CK ;
input  D ;
input  E ;
output Q ;
reg NOTIFIER ;

   not (I0_out, P0001);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (P0000, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   not (Q, P0001);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.061:0.061:0.061,
       tplhl$CK$Q = 0.07:0.07:0.07,
       tminpwh$CK = 0.038:0.054:0.07,
       tminpwl$CK = 0.048:0.057:0.067,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:0.046:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFHQX2 (CK, D, E, Q);
input  CK ;
input  D ;
input  E ;
output Q ;
reg NOTIFIER ;

   not (I0_out, P0001);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (P0000, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   not (Q, P0001);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.065:0.065:0.065,
       tplhl$CK$Q = 0.074:0.074:0.074,
       tminpwh$CK = 0.04:0.057:0.074,
       tminpwl$CK = 0.048:0.058:0.067,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:0.046:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFHQX4 (CK, D, E, Q);
input  CK ;
input  D ;
input  E ;
output Q ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, N30);
   not (Q, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.072:0.072:0.072,
       tplhl$CK$Q = 0.078:0.078:0.078,
       tminpwh$CK = 0.044:0.061:0.078,
       tminpwl$CK = 0.048:0.057:0.067,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:0.046:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFHQX8 (CK, D, E, Q);
input  CK ;
input  D ;
input  E ;
output Q ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.083:0.083:0.083,
       tplhl$CK$Q = 0.087:0.087:0.087,
       tminpwh$CK = 0.052:0.07:0.087,
       tminpwl$CK = 0.048:0.058:0.067,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:0.046:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFTRX1 (CK, D, E, Q, QN, RN);
input  CK ;
input  D ;
input  E ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, P0000);
   not (I5_out, I4_out);
   and (I0_D, I2_out, I5_out, RN);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);
   and (E_EQ_1_AN_RN_EQ_1, E, RN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.061:0.061:0.061,
       tplhl$CK$Q = 0.067:0.067:0.067,
       tpllh$CK$QN = 0.082:0.082:0.082,
       tplhl$CK$QN = 0.075:0.075:0.075,
       tminpwh$CK = 0.035:0.059:0.082,
       tminpwl$CK = 0.043:0.055:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& RN == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& RN == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFTRX2 (CK, D, E, Q, QN, RN);
input  CK ;
input  D ;
input  E ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, P0000);
   not (I5_out, I4_out);
   and (I0_D, I2_out, I5_out, RN);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);
   and (E_EQ_1_AN_RN_EQ_1, E, RN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.065:0.065:0.065,
       tplhl$CK$Q = 0.071:0.071:0.071,
       tpllh$CK$QN = 0.095:0.095:0.095,
       tplhl$CK$QN = 0.088:0.088:0.088,
       tminpwh$CK = 0.037:0.066:0.095,
       tminpwl$CK = 0.043:0.056:0.069,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& RN == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& RN == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFTRX4 (CK, D, E, Q, QN, RN);
input  CK ;
input  D ;
input  E ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, P0000);
   not (I5_out, I4_out);
   and (I0_D, I2_out, I5_out, RN);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);
   and (E_EQ_1_AN_RN_EQ_1, E, RN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.073:0.073:0.073,
       tplhl$CK$Q = 0.077:0.077:0.077,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.099:0.099:0.099,
       tminpwh$CK = 0.042:0.073:0.1,
       tminpwl$CK = 0.043:0.056:0.069,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& RN == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& RN == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFTRXL (CK, D, E, Q, QN, RN);
input  CK ;
input  D ;
input  E ;
input  RN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, P0000);
   not (I5_out, I4_out);
   and (I0_D, I2_out, I5_out, RN);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);
   and (E_EQ_1_AN_RN_EQ_1, E, RN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.059:0.059:0.059,
       tplhl$CK$Q = 0.067:0.067:0.067,
       tpllh$CK$QN = 0.078:0.078:0.078,
       tplhl$CK$QN = 0.068:0.068:0.068,
       tminpwh$CK = 0.032:0.055:0.078,
       tminpwl$CK = 0.043:0.055:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& RN == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& RN == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFX1 (CK, D, E, Q, QN);
input  CK ;
input  D ;
input  E ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.061:0.061:0.061,
       tplhl$CK$Q = 0.066:0.066:0.066,
       tpllh$CK$QN = 0.081:0.081:0.081,
       tplhl$CK$QN = 0.074:0.074:0.074,
       tminpwh$CK = 0.035:0.058:0.081,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:0.046:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFX2 (CK, D, E, Q, QN);
input  CK ;
input  D ;
input  E ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, N30);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.064:0.064:0.064,
       tplhl$CK$Q = 0.07:0.07:0.07,
       tpllh$CK$QN = 0.093:0.093:0.093,
       tplhl$CK$QN = 0.087:0.087:0.087,
       tminpwh$CK = 0.037:0.065:0.093,
       tminpwl$CK = 0.044:0.053:0.062,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:0.046:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFX4 (CK, D, E, Q, QN);
input  CK ;
input  D ;
input  E ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, N30);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.073:0.073:0.073,
       tplhl$CK$Q = 0.077:0.077:0.077,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.098:0.098:0.098,
       tminpwh$CK = 0.042:0.073:0.1,
       tminpwl$CK = 0.044:0.053:0.062,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:0.046:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module EDFFXL (CK, D, E, Q, QN);
input  CK ;
input  D ;
input  E ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.059:0.059:0.059,
       tplhl$CK$Q = 0.065:0.065:0.065,
       tpllh$CK$QN = 0.076:0.076:0.076,
       tplhl$CK$QN = 0.067:0.067:0.067,
       tminpwh$CK = 0.033:0.055:0.076,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:0.046:0.093,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module HOLDX1 (Y);
inout  Y ;

   buf (weak1, weak0) (Y, Y);


endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVX1 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.005:0.005:0.005,
       tphlh$A$Y = 0.0092:0.0092:0.0092;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVX12 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0048:0.0048:0.0048,
       tphlh$A$Y = 0.0089:0.0089:0.0089;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVX16 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.017:0.017:0.017,
       tphlh$A$Y = 0.032:0.032:0.032;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVX2 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0047:0.0047:0.0047,
       tphlh$A$Y = 0.0088:0.0088:0.0088;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVX20 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0049:0.0049:0.0049,
       tphlh$A$Y = 0.009:0.009:0.009;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVX3 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0049:0.0049:0.0049,
       tphlh$A$Y = 0.009:0.009:0.009;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVX4 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0047:0.0047:0.0047,
       tphlh$A$Y = 0.0088:0.0088:0.0088;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVX6 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.005:0.005:0.005,
       tphlh$A$Y = 0.0091:0.0091:0.0091;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVX8 (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0049:0.0049:0.0049,
       tphlh$A$Y = 0.009:0.009:0.009;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module INVXL (A, Y);
input  A ;
output Y ;

   not (Y, A);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0046:0.0046:0.0046,
       tphlh$A$Y = 0.0091:0.0091:0.0091;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MDFFHQX1 (CK, D0, D1, Q, S0);
input  CK ;
input  D0 ;
input  D1 ;
input  S0 ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D0, D1, S0);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, N30);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.058:0.058:0.058,
       tplhl$CK$Q = 0.069:0.069:0.069,
       tminpwh$CK = 0.037:0.053:0.069,
       tminpwl$CK = 0.048:0.058:0.068,
       tsetup_negedge$D0$CK = 0.095:0.095:0.095,
       thold_negedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$D1$CK = 0.095:0.095:0.095,
       thold_negedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$S0$CK = 0.095:0.095:0.095,
       thold_negedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D0$CK = 0.095:0.095:0.095,
       thold_posedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D1$CK = 0.095:0.095:0.095,
       thold_posedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$S0$CK = 0.095:0.095:0.095,
       thold_posedge$S0$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D0, posedge CK &&& S0 == 1'b0, tsetup_negedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b0, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
     $setup(negedge D1, posedge CK &&& S0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
     $setup(negedge S0, posedge CK, tsetup_negedge$S0$CK, NOTIFIER);
     $hold (posedge CK, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
     $setup(posedge D0, posedge CK &&& S0 == 1'b0, tsetup_posedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b0, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
     $setup(posedge D1, posedge CK &&& S0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
     $setup(posedge S0, posedge CK, tsetup_posedge$S0$CK, NOTIFIER);
     $hold (posedge CK, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MDFFHQX2 (CK, D0, D1, Q, S0);
input  CK ;
input  D0 ;
input  D1 ;
input  S0 ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D0, D1, S0);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, N30);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.063:0.063:0.063,
       tplhl$CK$Q = 0.074:0.074:0.074,
       tminpwh$CK = 0.037:0.055:0.074,
       tminpwl$CK = 0.048:0.058:0.068,
       tsetup_negedge$D0$CK = 0.095:0.095:0.095,
       thold_negedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$D1$CK = 0.095:0.095:0.095,
       thold_negedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$S0$CK = 0.095:0.095:0.095,
       thold_negedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D0$CK = 0.095:0.095:0.095,
       thold_posedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D1$CK = 0.095:0.095:0.095,
       thold_posedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$S0$CK = 0.095:0.095:0.095,
       thold_posedge$S0$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D0, posedge CK &&& S0 == 1'b0, tsetup_negedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b0, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
     $setup(negedge D1, posedge CK &&& S0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
     $setup(negedge S0, posedge CK, tsetup_negedge$S0$CK, NOTIFIER);
     $hold (posedge CK, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
     $setup(posedge D0, posedge CK &&& S0 == 1'b0, tsetup_posedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b0, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
     $setup(posedge D1, posedge CK &&& S0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
     $setup(posedge S0, posedge CK, tsetup_posedge$S0$CK, NOTIFIER);
     $hold (posedge CK, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MDFFHQX4 (CK, D0, D1, Q, S0);
input  CK ;
input  D0 ;
input  D1 ;
input  S0 ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D0, D1, S0);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.069:0.069:0.069,
       tplhl$CK$Q = 0.077:0.077:0.077,
       tminpwh$CK = 0.043:0.06:0.077,
       tminpwl$CK = 0.048:0.058:0.068,
       tsetup_negedge$D0$CK = 0.095:0.095:0.095,
       thold_negedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$D1$CK = 0.095:0.095:0.095,
       thold_negedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$S0$CK = 0.095:0.095:0.095,
       thold_negedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D0$CK = 0.095:0.095:0.095,
       thold_posedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D1$CK = 0.095:0.095:0.095,
       thold_posedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$S0$CK = 0.095:0.095:0.095,
       thold_posedge$S0$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D0, posedge CK &&& S0 == 1'b0, tsetup_negedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b0, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
     $setup(negedge D1, posedge CK &&& S0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
     $setup(negedge S0, posedge CK, tsetup_negedge$S0$CK, NOTIFIER);
     $hold (posedge CK, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
     $setup(posedge D0, posedge CK &&& S0 == 1'b0, tsetup_posedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b0, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
     $setup(posedge D1, posedge CK &&& S0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
     $setup(posedge S0, posedge CK, tsetup_posedge$S0$CK, NOTIFIER);
     $hold (posedge CK, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MDFFHQX8 (CK, D0, D1, Q, S0);
input  CK ;
input  D0 ;
input  D1 ;
input  S0 ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D0, D1, S0);
   udp_dff (P0000, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.082:0.082:0.082,
       tplhl$CK$Q = 0.087:0.087:0.087,
       tminpwh$CK = 0.052:0.07:0.087,
       tminpwl$CK = 0.048:0.058:0.068,
       tsetup_negedge$D0$CK = 0.095:0.095:0.095,
       thold_negedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$D1$CK = 0.095:0.095:0.095,
       thold_negedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$S0$CK = 0.095:0.095:0.095,
       thold_negedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D0$CK = 0.095:0.095:0.095,
       thold_posedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D1$CK = 0.095:0.095:0.095,
       thold_posedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$S0$CK = 0.095:0.095:0.095,
       thold_posedge$S0$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D0, posedge CK &&& S0 == 1'b0, tsetup_negedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b0, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
     $setup(negedge D1, posedge CK &&& S0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
     $setup(negedge S0, posedge CK, tsetup_negedge$S0$CK, NOTIFIER);
     $hold (posedge CK, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
     $setup(posedge D0, posedge CK &&& S0 == 1'b0, tsetup_posedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b0, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
     $setup(posedge D1, posedge CK &&& S0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
     $setup(posedge S0, posedge CK, tsetup_posedge$S0$CK, NOTIFIER);
     $hold (posedge CK, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX2X1 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.028:0.028:0.028,
       tphhl$A$Y = 0.036:0.036:0.036,
       tpllh$B$Y = 0.028:0.028:0.028,
       tphhl$B$Y = 0.036:0.036:0.036,
       tpllh$S0$Y = 0.023:0.03:0.037,
       tplhl$S0$Y = 0.027:0.032:0.036;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX2X2 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.038:0.038:0.038,
       tphhl$A$Y = 0.049:0.049:0.049,
       tpllh$B$Y = 0.038:0.038:0.038,
       tphhl$B$Y = 0.049:0.049:0.049,
       tpllh$S0$Y = 0.033:0.04:0.046,
       tplhl$S0$Y = 0.04:0.045:0.049;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX2X4 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.048:0.048:0.048,
       tphhl$A$Y = 0.059:0.059:0.059,
       tpllh$B$Y = 0.047:0.047:0.047,
       tphhl$B$Y = 0.06:0.06:0.06,
       tpllh$S0$Y = 0.042:0.05:0.058,
       tplhl$S0$Y = 0.051:0.056:0.061;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX2X6 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.062:0.062:0.062,
       tphhl$A$Y = 0.079:0.079:0.079,
       tpllh$B$Y = 0.062:0.062:0.062,
       tphhl$B$Y = 0.079:0.079:0.079,
       tpllh$S0$Y = 0.057:0.064:0.072,
       tplhl$S0$Y = 0.07:0.075:0.079;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX2X8 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.077:0.077:0.077,
       tphhl$A$Y = 0.097:0.097:0.097,
       tpllh$B$Y = 0.076:0.076:0.076,
       tphhl$B$Y = 0.098:0.098:0.098,
       tpllh$S0$Y = 0.071:0.079:0.086,
       tplhl$S0$Y = 0.089:0.094:0.098;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX2XL (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (Y, A, B, S0);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.023:0.023:0.023,
       tphhl$A$Y = 0.029:0.029:0.029,
       tpllh$B$Y = 0.023:0.023:0.023,
       tphhl$B$Y = 0.03:0.03:0.03,
       tpllh$S0$Y = 0.018:0.025:0.032,
       tplhl$S0$Y = 0.021:0.025:0.03;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX3X1 (A, B, C, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (Y, I0_out, C, S1);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.042:0.042:0.042,
       tphhl$A$Y = 0.049:0.049:0.049,
       tpllh$B$Y = 0.042:0.042:0.042,
       tphhl$B$Y = 0.05:0.05:0.05,
       tpllh$C$Y = 0.028:0.028:0.028,
       tphhl$C$Y = 0.037:0.037:0.037,
       tpllh$S0$Y = 0.037:0.043:0.05,
       tplhl$S0$Y = 0.041:0.045:0.049,
       tpllh$S1$Y = 0.024:0.03:0.036,
       tplhl$S1$Y = 0.027:0.031:0.036;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX3X2 (A, B, C, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (Y, I0_out, C, S1);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.054:0.054:0.054,
       tphhl$A$Y = 0.063:0.063:0.063,
       tpllh$B$Y = 0.053:0.053:0.053,
       tphhl$B$Y = 0.064:0.064:0.064,
       tpllh$C$Y = 0.038:0.038:0.038,
       tphhl$C$Y = 0.05:0.05:0.05,
       tpllh$S0$Y = 0.048:0.055:0.062,
       tplhl$S0$Y = 0.055:0.059:0.063,
       tpllh$S1$Y = 0.033:0.04:0.047,
       tplhl$S1$Y = 0.038:0.043:0.048;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX3X4 (A, B, C, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (Y, I0_out, C, S1);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.08:0.08:0.08,
       tphhl$A$Y = 0.097:0.097:0.097,
       tpllh$B$Y = 0.079:0.079:0.079,
       tphhl$B$Y = 0.097:0.097:0.097,
       tpllh$C$Y = 0.041:0.041:0.041,
       tphhl$C$Y = 0.053:0.053:0.053,
       tpllh$S0$Y = 0.074:0.081:0.087,
       tplhl$S0$Y = 0.088:0.092:0.096,
       tpllh$S1$Y = 0.036:0.053:0.07,
       tplhl$S1$Y = 0.054:0.059:0.064;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX3XL (A, B, C, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (Y, I0_out, C, S1);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.036:0.036:0.036,
       tphhl$A$Y = 0.042:0.042:0.042,
       tpllh$B$Y = 0.035:0.035:0.035,
       tphhl$B$Y = 0.042:0.042:0.042,
       tpllh$C$Y = 0.024:0.024:0.024,
       tphhl$C$Y = 0.03:0.03:0.03,
       tpllh$S0$Y = 0.031:0.037:0.044,
       tplhl$S0$Y = 0.034:0.038:0.042,
       tpllh$S1$Y = 0.019:0.025:0.031,
       tplhl$S1$Y = 0.022:0.026:0.03;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX4X1 (A, B, C, D, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  D ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (Y, I1_out, I0_out, S1);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.042:0.042:0.042,
       tphhl$A$Y = 0.049:0.049:0.049,
       tpllh$B$Y = 0.041:0.041:0.041,
       tphhl$B$Y = 0.05:0.05:0.05,
       tpllh$C$Y = 0.041:0.041:0.041,
       tphhl$C$Y = 0.049:0.049:0.049,
       tpllh$D$Y = 0.041:0.041:0.041,
       tphhl$D$Y = 0.049:0.049:0.049,
       tpllh$S0$Y = 0.036:0.045:0.054,
       tplhl$S0$Y = 0.041:0.047:0.052,
       tpllh$S1$Y = 0.025:0.03:0.035,
       tplhl$S1$Y = 0.027:0.027:0.028;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX4X2 (A, B, C, D, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  D ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (Y, I1_out, I0_out, S1);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.053:0.053:0.053,
       tphhl$A$Y = 0.063:0.063:0.063,
       tpllh$B$Y = 0.053:0.053:0.053,
       tphhl$B$Y = 0.063:0.063:0.063,
       tpllh$C$Y = 0.054:0.054:0.054,
       tphhl$C$Y = 0.064:0.064:0.064,
       tpllh$D$Y = 0.053:0.053:0.053,
       tphhl$D$Y = 0.064:0.064:0.064,
       tpllh$S0$Y = 0.048:0.057:0.066,
       tplhl$S0$Y = 0.055:0.061:0.067,
       tpllh$S1$Y = 0.037:0.042:0.046,
       tplhl$S1$Y = 0.038:0.039:0.039;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX4X4 (A, B, C, D, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  D ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (Y, I1_out, I0_out, S1);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.08:0.08:0.08,
       tphhl$A$Y = 0.097:0.097:0.097,
       tpllh$B$Y = 0.079:0.079:0.079,
       tphhl$B$Y = 0.097:0.097:0.097,
       tpllh$C$Y = 0.08:0.08:0.08,
       tphhl$C$Y = 0.098:0.098:0.098,
       tpllh$D$Y = 0.079:0.079:0.079,
       tphhl$D$Y = 0.097:0.097:0.097,
       tpllh$S0$Y = 0.074:0.083:0.091,
       tplhl$S0$Y = 0.088:0.094:0.099,
       tpllh$S1$Y = 0.058:0.063:0.068,
       tplhl$S1$Y = 0.065:0.066:0.068;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MX4XL (A, B, C, D, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  D ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (Y, I1_out, I0_out, S1);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.036:0.036:0.036,
       tphhl$A$Y = 0.042:0.042:0.042,
       tpllh$B$Y = 0.035:0.035:0.035,
       tphhl$B$Y = 0.042:0.042:0.042,
       tpllh$C$Y = 0.035:0.035:0.035,
       tphhl$C$Y = 0.042:0.042:0.042,
       tpllh$D$Y = 0.035:0.035:0.035,
       tphhl$D$Y = 0.042:0.042:0.042,
       tpllh$S0$Y = 0.03:0.039:0.049,
       tplhl$S0$Y = 0.034:0.04:0.045,
       tpllh$S1$Y = 0.02:0.025:0.03,
       tplhl$S1$Y = 0.022:0.022:0.022;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI2X1 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.013:0.013:0.013,
       tphlh$A$Y = 0.02:0.02:0.02,
       tplhl$B$Y = 0.012:0.012:0.012,
       tphlh$B$Y = 0.02:0.02:0.02,
       tpllh$S0$Y = 0.012:0.018:0.024,
       tplhl$S0$Y = 0.0073:0.016:0.026;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI2X2 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.045:0.045:0.045,
       tphlh$A$Y = 0.051:0.051:0.051,
       tplhl$B$Y = 0.045:0.045:0.045,
       tphlh$B$Y = 0.052:0.052:0.052,
       tpllh$S0$Y = 0.043:0.047:0.052,
       tplhl$S0$Y = 0.04:0.046:0.053;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI2X4 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.052:0.052:0.052,
       tphlh$A$Y = 0.062:0.062:0.062,
       tplhl$B$Y = 0.052:0.052:0.052,
       tphlh$B$Y = 0.062:0.062:0.062,
       tpllh$S0$Y = 0.053:0.057:0.061,
       tplhl$S0$Y = 0.047:0.054:0.06;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI2X6 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.059:0.059:0.059,
       tphlh$A$Y = 0.074:0.074:0.074,
       tplhl$B$Y = 0.058:0.058:0.058,
       tphlh$B$Y = 0.074:0.074:0.074,
       tpllh$S0$Y = 0.065:0.069:0.073,
       tplhl$S0$Y = 0.053:0.06:0.067;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI2X8 (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.064:0.064:0.064,
       tphlh$A$Y = 0.079:0.079:0.079,
       tplhl$B$Y = 0.063:0.063:0.063,
       tphlh$B$Y = 0.079:0.079:0.079,
       tpllh$S0$Y = 0.07:0.074:0.079,
       tplhl$S0$Y = 0.058:0.065:0.072;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI2XL (A, B, S0, Y);
input  A ;
input  B ;
input  S0 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.012:0.012:0.012,
       tphlh$A$Y = 0.019:0.019:0.019,
       tplhl$B$Y = 0.011:0.011:0.011,
       tphlh$B$Y = 0.02:0.02:0.02,
       tpllh$S0$Y = 0.012:0.016:0.02,
       tplhl$S0$Y = 0.0067:0.014:0.021;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI3X1 (A, B, C, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (I1_out, I0_out, C, S1);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.052:0.052:0.052,
       tphlh$A$Y = 0.055:0.055:0.055,
       tplhl$B$Y = 0.051:0.051:0.051,
       tphlh$B$Y = 0.055:0.055:0.055,
       tplhl$C$Y = 0.043:0.043:0.043,
       tphlh$C$Y = 0.041:0.041:0.041,
       tpllh$S0$Y = 0.047:0.051:0.055,
       tplhl$S0$Y = 0.046:0.053:0.06,
       tpllh$S1$Y = 0.024:0.03:0.037,
       tplhl$S1$Y = 0.028:0.032:0.037;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI3X2 (A, B, C, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (I1_out, I0_out, C, S1);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.065:0.065:0.065,
       tphlh$A$Y = 0.065:0.065:0.065,
       tplhl$B$Y = 0.064:0.064:0.064,
       tphlh$B$Y = 0.066:0.066:0.066,
       tplhl$C$Y = 0.057:0.057:0.057,
       tphlh$C$Y = 0.051:0.051:0.051,
       tpllh$S0$Y = 0.057:0.061:0.065,
       tplhl$S0$Y = 0.06:0.066:0.073,
       tpllh$S1$Y = 0.034:0.04:0.046,
       tplhl$S1$Y = 0.041:0.045:0.049;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI3X4 (A, B, C, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (I1_out, I0_out, C, S1);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.077:0.077:0.077,
       tphlh$A$Y = 0.078:0.078:0.078,
       tplhl$B$Y = 0.077:0.077:0.077,
       tphlh$B$Y = 0.078:0.078:0.078,
       tplhl$C$Y = 0.068:0.068:0.068,
       tphlh$C$Y = 0.061:0.061:0.061,
       tpllh$S0$Y = 0.07:0.074:0.078,
       tplhl$S0$Y = 0.072:0.079:0.086,
       tpllh$S1$Y = 0.042:0.05:0.058,
       tplhl$S1$Y = 0.051:0.056:0.061;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI3XL (A, B, C, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (I1_out, I0_out, C, S1);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.045:0.045:0.045,
       tphlh$A$Y = 0.049:0.049:0.049,
       tplhl$B$Y = 0.044:0.044:0.044,
       tphlh$B$Y = 0.05:0.05:0.05,
       tplhl$C$Y = 0.036:0.036:0.036,
       tphlh$C$Y = 0.035:0.035:0.035,
       tpllh$S0$Y = 0.041:0.046:0.05,
       tplhl$S0$Y = 0.039:0.046:0.053,
       tpllh$S1$Y = 0.019:0.026:0.032,
       tplhl$S1$Y = 0.022:0.026:0.03;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI4X1 (A, B, C, D, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  D ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (I2_out, I1_out, I0_out, S1);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.051:0.051:0.051,
       tphlh$A$Y = 0.054:0.054:0.054,
       tplhl$B$Y = 0.051:0.051:0.051,
       tphlh$B$Y = 0.055:0.055:0.055,
       tplhl$C$Y = 0.051:0.051:0.051,
       tphlh$C$Y = 0.054:0.054:0.054,
       tplhl$D$Y = 0.051:0.051:0.051,
       tphlh$D$Y = 0.054:0.054:0.054,
       tpllh$S0$Y = 0.046:0.052:0.058,
       tplhl$S0$Y = 0.046:0.055:0.064,
       tpllh$S1$Y = 0.023:0.03:0.037,
       tplhl$S1$Y = 0.027:0.032:0.036;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI4X2 (A, B, C, D, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  D ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (I2_out, I1_out, I0_out, S1);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.065:0.065:0.065,
       tphlh$A$Y = 0.065:0.065:0.065,
       tplhl$B$Y = 0.065:0.065:0.065,
       tphlh$B$Y = 0.066:0.066:0.066,
       tplhl$C$Y = 0.066:0.066:0.066,
       tphlh$C$Y = 0.066:0.066:0.066,
       tplhl$D$Y = 0.065:0.065:0.065,
       tphlh$D$Y = 0.066:0.066:0.066,
       tpllh$S0$Y = 0.058:0.064:0.07,
       tplhl$S0$Y = 0.06:0.069:0.078,
       tpllh$S1$Y = 0.033:0.04:0.047,
       tplhl$S1$Y = 0.04:0.044:0.049;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI4X4 (A, B, C, D, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  D ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (I2_out, I1_out, I0_out, S1);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.079:0.079:0.079,
       tphlh$A$Y = 0.079:0.079:0.079,
       tplhl$B$Y = 0.078:0.078:0.078,
       tphlh$B$Y = 0.08:0.08:0.08,
       tplhl$C$Y = 0.078:0.078:0.078,
       tphlh$C$Y = 0.078:0.078:0.078,
       tplhl$D$Y = 0.077:0.077:0.077,
       tphlh$D$Y = 0.078:0.078:0.078,
       tpllh$S0$Y = 0.07:0.077:0.084,
       tplhl$S0$Y = 0.073:0.082:0.092,
       tpllh$S1$Y = 0.042:0.05:0.059,
       tplhl$S1$Y = 0.051:0.056:0.061;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module MXI4XL (A, B, C, D, S0, S1, Y);
input  A ;
input  B ;
input  C ;
input  D ;
input  S0 ;
input  S1 ;
output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (I2_out, I1_out, I0_out, S1);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.045:0.045:0.045,
       tphlh$A$Y = 0.05:0.05:0.05,
       tplhl$B$Y = 0.044:0.044:0.044,
       tphlh$B$Y = 0.05:0.05:0.05,
       tplhl$C$Y = 0.045:0.045:0.045,
       tphlh$C$Y = 0.049:0.049:0.049,
       tplhl$D$Y = 0.045:0.045:0.045,
       tphlh$D$Y = 0.049:0.049:0.049,
       tpllh$S0$Y = 0.041:0.048:0.054,
       tplhl$S0$Y = 0.04:0.049:0.058,
       tpllh$S1$Y = 0.018:0.025:0.032,
       tplhl$S1$Y = 0.021:0.025:0.03;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
     (S0 *> Y) = (tpllh$S0$Y, tplhl$S0$Y);
     (S1 *> Y) = (tpllh$S1$Y, tplhl$S1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2BX1 (AN, B, Y);
input  AN ;
input  B ;
output Y ;

   not (I0_out, AN);
   and (I1_out, I0_out, B);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.021:0.021:0.021,
       tphhl$AN$Y = 0.025:0.025:0.025,
       tplhl$B$Y = 0.0082:0.0082:0.0082,
       tphlh$B$Y = 0.01:0.01:0.01;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2BX2 (AN, B, Y);
input  AN ;
input  B ;
output Y ;

   not (I0_out, AN);
   and (I1_out, I0_out, B);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.027:0.027:0.027,
       tphhl$AN$Y = 0.033:0.033:0.033,
       tplhl$B$Y = 0.0081:0.0081:0.0081,
       tphlh$B$Y = 0.0099:0.0099:0.0099;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2BX4 (AN, B, Y);
input  AN ;
input  B ;
output Y ;

   not (I0_out, AN);
   and (I1_out, I0_out, B);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.029:0.029:0.029,
       tphhl$AN$Y = 0.035:0.035:0.035,
       tplhl$B$Y = 0.0081:0.0081:0.0081,
       tphlh$B$Y = 0.0099:0.0099:0.0099;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2BXL (AN, B, Y);
input  AN ;
input  B ;
output Y ;

   not (I0_out, AN);
   and (I1_out, I0_out, B);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.017:0.017:0.017,
       tphhl$AN$Y = 0.021:0.021:0.021,
       tplhl$B$Y = 0.0078:0.0078:0.0078,
       tphlh$B$Y = 0.0099:0.0099:0.0099;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2X1 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0089:0.0089:0.0089,
       tphlh$A$Y = 0.012:0.012:0.012,
       tplhl$B$Y = 0.0083:0.0083:0.0083,
       tphlh$B$Y = 0.01:0.01:0.01;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2X2 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0087:0.0087:0.0087,
       tphlh$A$Y = 0.012:0.012:0.012,
       tplhl$B$Y = 0.0081:0.0081:0.0081,
       tphlh$B$Y = 0.01:0.01:0.01;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2X4 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0088:0.0088:0.0088,
       tphlh$A$Y = 0.012:0.012:0.012,
       tplhl$B$Y = 0.0082:0.0082:0.0082,
       tphlh$B$Y = 0.01:0.01:0.01;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2X6 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.009:0.009:0.009,
       tphlh$A$Y = 0.012:0.012:0.012,
       tplhl$B$Y = 0.0083:0.0083:0.0083,
       tphlh$B$Y = 0.01:0.01:0.01;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2X8 (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.009:0.009:0.009,
       tphlh$A$Y = 0.012:0.012:0.012,
       tplhl$B$Y = 0.0083:0.0083:0.0083,
       tphlh$B$Y = 0.01:0.01:0.01;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND2XL (A, B, Y);
input  A ;
input  B ;
output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0084:0.0084:0.0084,
       tphlh$A$Y = 0.012:0.012:0.012,
       tplhl$B$Y = 0.0078:0.0078:0.0078,
       tphlh$B$Y = 0.0099:0.0099:0.0099;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3BX1 (AN, B, C, Y);
input  AN ;
input  B ;
input  C ;
output Y ;

   not (I0_out, AN);
   and (I2_out, I0_out, B, C);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.023:0.023:0.023,
       tphhl$AN$Y = 0.03:0.03:0.03,
       tplhl$B$Y = 0.014:0.014:0.014,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.012:0.012:0.012,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3BX2 (AN, B, C, Y);
input  AN ;
input  B ;
input  C ;
output Y ;

   not (I0_out, AN);
   and (I2_out, I0_out, B, C);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.03:0.03:0.03,
       tphhl$AN$Y = 0.037:0.037:0.037,
       tplhl$B$Y = 0.013:0.013:0.013,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.011:0.011:0.011,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3BX4 (AN, B, C, Y);
input  AN ;
input  B ;
input  C ;
output Y ;

   not (I0_out, AN);
   and (I2_out, I0_out, B, C);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.032:0.032:0.032,
       tphhl$AN$Y = 0.039:0.039:0.039,
       tplhl$B$Y = 0.013:0.013:0.013,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.011:0.011:0.011,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3BXL (AN, B, C, Y);
input  AN ;
input  B ;
input  C ;
output Y ;

   not (I0_out, AN);
   and (I2_out, I0_out, B, C);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.02:0.02:0.02,
       tphhl$AN$Y = 0.026:0.026:0.026,
       tplhl$B$Y = 0.013:0.013:0.013,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.012:0.012:0.012,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3X1 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.014:0.014:0.014,
       tphlh$A$Y = 0.015:0.015:0.015,
       tplhl$B$Y = 0.014:0.014:0.014,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.012:0.012:0.012,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3X2 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.014:0.014:0.014,
       tphlh$A$Y = 0.014:0.014:0.014,
       tplhl$B$Y = 0.013:0.013:0.013,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.012:0.012:0.012,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3X4 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.014:0.014:0.014,
       tphlh$A$Y = 0.014:0.014:0.014,
       tplhl$B$Y = 0.013:0.013:0.013,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.011:0.011:0.011,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3X6 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.014:0.014:0.014,
       tphlh$A$Y = 0.014:0.014:0.014,
       tplhl$B$Y = 0.013:0.013:0.013,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.012:0.012:0.012,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3X8 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.014:0.014:0.014,
       tphlh$A$Y = 0.015:0.015:0.015,
       tplhl$B$Y = 0.013:0.013:0.013,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.012:0.012:0.012,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND3XL (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.014:0.014:0.014,
       tphlh$A$Y = 0.015:0.015:0.015,
       tplhl$B$Y = 0.013:0.013:0.013,
       tphlh$B$Y = 0.013:0.013:0.013,
       tplhl$C$Y = 0.012:0.012:0.012,
       tphlh$C$Y = 0.011:0.011:0.011;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4BBX1 (AN, BN, C, D, Y);
input  AN ;
input  BN ;
input  C ;
input  D ;
output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   and (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.025:0.025:0.025,
       tphhl$AN$Y = 0.036:0.036:0.036,
       tpllh$BN$Y = 0.024:0.024:0.024,
       tphhl$BN$Y = 0.035:0.035:0.035,
       tplhl$C$Y = 0.017:0.017:0.017,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4BBX2 (AN, BN, C, D, Y);
input  AN ;
input  BN ;
input  C ;
input  D ;
output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   and (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.032:0.032:0.032,
       tphhl$AN$Y = 0.044:0.044:0.044,
       tpllh$BN$Y = 0.031:0.031:0.031,
       tphhl$BN$Y = 0.043:0.043:0.043,
       tplhl$C$Y = 0.018:0.018:0.018,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4BBX4 (AN, BN, C, D, Y);
input  AN ;
input  BN ;
input  C ;
input  D ;
output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   and (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.034:0.034:0.034,
       tphhl$AN$Y = 0.046:0.046:0.046,
       tpllh$BN$Y = 0.033:0.033:0.033,
       tphhl$BN$Y = 0.045:0.045:0.045,
       tplhl$C$Y = 0.018:0.018:0.018,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4BBXL (AN, BN, C, D, Y);
input  AN ;
input  BN ;
input  C ;
input  D ;
output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   and (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.021:0.021:0.021,
       tphhl$AN$Y = 0.032:0.032:0.032,
       tpllh$BN$Y = 0.021:0.021:0.021,
       tphhl$BN$Y = 0.03:0.03:0.03,
       tplhl$C$Y = 0.017:0.017:0.017,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4BX1 (AN, B, C, D, Y);
input  AN ;
input  B ;
input  C ;
input  D ;
output Y ;

   not (I0_out, AN);
   and (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.025:0.025:0.025,
       tphhl$AN$Y = 0.036:0.036:0.036,
       tplhl$B$Y = 0.019:0.019:0.019,
       tphlh$B$Y = 0.015:0.015:0.015,
       tplhl$C$Y = 0.017:0.017:0.017,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4BX2 (AN, B, C, D, Y);
input  AN ;
input  B ;
input  C ;
input  D ;
output Y ;

   not (I0_out, AN);
   and (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.032:0.032:0.032,
       tphhl$AN$Y = 0.044:0.044:0.044,
       tplhl$B$Y = 0.02:0.02:0.02,
       tphlh$B$Y = 0.015:0.015:0.015,
       tplhl$C$Y = 0.018:0.018:0.018,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4BX4 (AN, B, C, D, Y);
input  AN ;
input  B ;
input  C ;
input  D ;
output Y ;

   not (I0_out, AN);
   and (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.034:0.034:0.034,
       tphhl$AN$Y = 0.046:0.046:0.046,
       tplhl$B$Y = 0.02:0.02:0.02,
       tphlh$B$Y = 0.015:0.015:0.015,
       tplhl$C$Y = 0.018:0.018:0.018,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4BXL (AN, B, C, D, Y);
input  AN ;
input  B ;
input  C ;
input  D ;
output Y ;

   not (I0_out, AN);
   and (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.021:0.021:0.021,
       tphhl$AN$Y = 0.031:0.031:0.031,
       tplhl$B$Y = 0.018:0.018:0.018,
       tphlh$B$Y = 0.015:0.015:0.015,
       tplhl$C$Y = 0.017:0.017:0.017,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4X1 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.02:0.02:0.02,
       tphlh$A$Y = 0.016:0.016:0.016,
       tplhl$B$Y = 0.019:0.019:0.019,
       tphlh$B$Y = 0.016:0.016:0.016,
       tplhl$C$Y = 0.018:0.018:0.018,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4X2 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.02:0.02:0.02,
       tphlh$A$Y = 0.016:0.016:0.016,
       tplhl$B$Y = 0.019:0.019:0.019,
       tphlh$B$Y = 0.015:0.015:0.015,
       tplhl$C$Y = 0.017:0.017:0.017,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4X4 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.021:0.021:0.021,
       tphlh$A$Y = 0.016:0.016:0.016,
       tplhl$B$Y = 0.02:0.02:0.02,
       tphlh$B$Y = 0.016:0.016:0.016,
       tplhl$C$Y = 0.018:0.018:0.018,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4X6 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.021:0.021:0.021,
       tphlh$A$Y = 0.016:0.016:0.016,
       tplhl$B$Y = 0.02:0.02:0.02,
       tphlh$B$Y = 0.016:0.016:0.016,
       tplhl$C$Y = 0.018:0.018:0.018,
       tphlh$C$Y = 0.015:0.015:0.015,
       tplhl$D$Y = 0.016:0.016:0.016,
       tphlh$D$Y = 0.013:0.013:0.013;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4X8 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.021:0.021:0.021,
       tphlh$A$Y = 0.016:0.016:0.016,
       tplhl$B$Y = 0.02:0.02:0.02,
       tphlh$B$Y = 0.016:0.016:0.016,
       tplhl$C$Y = 0.018:0.018:0.018,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.016:0.016:0.016,
       tphlh$D$Y = 0.013:0.013:0.013;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NAND4XL (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.019:0.019:0.019,
       tphlh$A$Y = 0.016:0.016:0.016,
       tplhl$B$Y = 0.018:0.018:0.018,
       tphlh$B$Y = 0.015:0.015:0.015,
       tplhl$C$Y = 0.017:0.017:0.017,
       tphlh$C$Y = 0.014:0.014:0.014,
       tplhl$D$Y = 0.015:0.015:0.015,
       tphlh$D$Y = 0.012:0.012:0.012;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2BX1 (AN, B, Y);
input  AN ;
input  B ;
output Y ;

   not (I0_out, AN);
   or  (I1_out, I0_out, B);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.025:0.025:0.025,
       tphhl$AN$Y = 0.023:0.023:0.023,
       tplhl$B$Y = 0.0056:0.0056:0.0056,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2BX2 (AN, B, Y);
input  AN ;
input  B ;
output Y ;

   not (I0_out, AN);
   or  (I1_out, I0_out, B);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.031:0.031:0.031,
       tphhl$AN$Y = 0.032:0.032:0.032,
       tplhl$B$Y = 0.0055:0.0055:0.0055,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2BX4 (AN, B, Y);
input  AN ;
input  B ;
output Y ;

   not (I0_out, AN);
   or  (I1_out, I0_out, B);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.043:0.043:0.043,
       tphhl$AN$Y = 0.047:0.047:0.047,
       tplhl$B$Y = 0.0055:0.0055:0.0055,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2BXL (AN, B, Y);
input  AN ;
input  B ;
output Y ;

   not (I0_out, AN);
   or  (I1_out, I0_out, B);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.021:0.021:0.021,
       tphhl$AN$Y = 0.019:0.019:0.019,
       tplhl$B$Y = 0.0052:0.0052:0.0052,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2X1 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0074:0.0074:0.0074,
       tphlh$A$Y = 0.016:0.016:0.016,
       tplhl$B$Y = 0.0056:0.0056:0.0056,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2X2 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0072:0.0072:0.0072,
       tphlh$A$Y = 0.015:0.015:0.015,
       tplhl$B$Y = 0.0055:0.0055:0.0055,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2X4 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0073:0.0073:0.0073,
       tphlh$A$Y = 0.015:0.015:0.015,
       tplhl$B$Y = 0.0055:0.0055:0.0055,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2X6 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0074:0.0074:0.0074,
       tphlh$A$Y = 0.015:0.015:0.015,
       tplhl$B$Y = 0.0055:0.0055:0.0055,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2X8 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0075:0.0075:0.0075,
       tphlh$A$Y = 0.016:0.016:0.016,
       tplhl$B$Y = 0.0056:0.0056:0.0056,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR2XL (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.007:0.007:0.007,
       tphlh$A$Y = 0.015:0.015:0.015,
       tplhl$B$Y = 0.0051:0.0051:0.0051,
       tphlh$B$Y = 0.013:0.013:0.013;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3BX1 (AN, B, C, Y);
input  AN ;
input  B ;
input  C ;
output Y ;

   not (I0_out, AN);
   or  (I2_out, I0_out, B, C);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.034:0.034:0.034,
       tphhl$AN$Y = 0.024:0.024:0.024,
       tplhl$B$Y = 0.0083:0.0083:0.0083,
       tphlh$B$Y = 0.022:0.022:0.022,
       tplhl$C$Y = 0.0064:0.0064:0.0064,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3BX2 (AN, B, C, Y);
input  AN ;
input  B ;
input  C ;
output Y ;

   not (I0_out, AN);
   or  (I2_out, I0_out, B, C);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.04:0.04:0.04,
       tphhl$AN$Y = 0.033:0.033:0.033,
       tplhl$B$Y = 0.008:0.008:0.008,
       tphlh$B$Y = 0.022:0.022:0.022,
       tplhl$C$Y = 0.0061:0.0061:0.0061,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3BX4 (AN, B, C, Y);
input  AN ;
input  B ;
input  C ;
output Y ;

   not (I0_out, AN);
   or  (I2_out, I0_out, B, C);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.042:0.042:0.042,
       tphhl$AN$Y = 0.035:0.035:0.035,
       tplhl$B$Y = 0.0081:0.0081:0.0081,
       tphlh$B$Y = 0.022:0.022:0.022,
       tplhl$C$Y = 0.0061:0.0061:0.0061,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3BXL (AN, B, C, Y);
input  AN ;
input  B ;
input  C ;
output Y ;

   not (I0_out, AN);
   or  (I2_out, I0_out, B, C);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.03:0.03:0.03,
       tphhl$AN$Y = 0.02:0.02:0.02,
       tplhl$B$Y = 0.0079:0.0079:0.0079,
       tphlh$B$Y = 0.022:0.022:0.022,
       tplhl$C$Y = 0.0061:0.0061:0.0061,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3X1 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0088:0.0088:0.0088,
       tphlh$A$Y = 0.025:0.025:0.025,
       tplhl$B$Y = 0.0083:0.0083:0.0083,
       tphlh$B$Y = 0.023:0.023:0.023,
       tplhl$C$Y = 0.0064:0.0064:0.0064,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3X2 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0085:0.0085:0.0085,
       tphlh$A$Y = 0.024:0.024:0.024,
       tplhl$B$Y = 0.008:0.008:0.008,
       tphlh$B$Y = 0.022:0.022:0.022,
       tplhl$C$Y = 0.0061:0.0061:0.0061,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3X4 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0086:0.0086:0.0086,
       tphlh$A$Y = 0.025:0.025:0.025,
       tplhl$B$Y = 0.008:0.008:0.008,
       tphlh$B$Y = 0.022:0.022:0.022,
       tplhl$C$Y = 0.0061:0.0061:0.0061,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3X6 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0086:0.0086:0.0086,
       tphlh$A$Y = 0.025:0.025:0.025,
       tplhl$B$Y = 0.0081:0.0081:0.0081,
       tphlh$B$Y = 0.022:0.022:0.022,
       tplhl$C$Y = 0.0061:0.0061:0.0061,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3X8 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0087:0.0087:0.0087,
       tphlh$A$Y = 0.025:0.025:0.025,
       tplhl$B$Y = 0.0082:0.0082:0.0082,
       tphlh$B$Y = 0.022:0.022:0.022,
       tplhl$C$Y = 0.0062:0.0062:0.0062,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR3XL (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0084:0.0084:0.0084,
       tphlh$A$Y = 0.025:0.025:0.025,
       tplhl$B$Y = 0.008:0.008:0.008,
       tphlh$B$Y = 0.022:0.022:0.022,
       tplhl$C$Y = 0.0061:0.0061:0.0061,
       tphlh$C$Y = 0.017:0.017:0.017;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4BBX1 (AN, BN, C, D, Y);
input  AN ;
input  BN ;
input  C ;
input  D ;
output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   or  (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.046:0.046:0.046,
       tphhl$AN$Y = 0.025:0.025:0.025,
       tpllh$BN$Y = 0.043:0.043:0.043,
       tphhl$BN$Y = 0.025:0.025:0.025,
       tplhl$C$Y = 0.0088:0.0088:0.0088,
       tphlh$C$Y = 0.029:0.029:0.029,
       tplhl$D$Y = 0.0068:0.0068:0.0068,
       tphlh$D$Y = 0.021:0.021:0.021;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4BBX2 (AN, BN, C, D, Y);
input  AN ;
input  BN ;
input  C ;
input  D ;
output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   or  (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.054:0.054:0.054,
       tphhl$AN$Y = 0.033:0.033:0.033,
       tpllh$BN$Y = 0.049:0.049:0.049,
       tphhl$BN$Y = 0.034:0.034:0.034,
       tplhl$C$Y = 0.0089:0.0089:0.0089,
       tphlh$C$Y = 0.029:0.029:0.029,
       tplhl$D$Y = 0.0068:0.0068:0.0068,
       tphlh$D$Y = 0.02:0.02:0.02;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4BBX4 (AN, BN, C, D, Y);
input  AN ;
input  BN ;
input  C ;
input  D ;
output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   or  (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.056:0.056:0.056,
       tphhl$AN$Y = 0.035:0.035:0.035,
       tpllh$BN$Y = 0.051:0.051:0.051,
       tphhl$BN$Y = 0.035:0.035:0.035,
       tplhl$C$Y = 0.0091:0.0091:0.0091,
       tphlh$C$Y = 0.029:0.029:0.029,
       tplhl$D$Y = 0.0072:0.0072:0.0072,
       tphlh$D$Y = 0.02:0.02:0.02;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4BBXL (AN, BN, C, D, Y);
input  AN ;
input  BN ;
input  C ;
input  D ;
output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   or  (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.042:0.042:0.042,
       tphhl$AN$Y = 0.02:0.02:0.02,
       tpllh$BN$Y = 0.039:0.039:0.039,
       tphhl$BN$Y = 0.02:0.02:0.02,
       tplhl$C$Y = 0.0085:0.0085:0.0085,
       tphlh$C$Y = 0.028:0.028:0.028,
       tplhl$D$Y = 0.0065:0.0065:0.0065,
       tphlh$D$Y = 0.02:0.02:0.02;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4BX1 (AN, B, C, D, Y);
input  AN ;
input  B ;
input  C ;
input  D ;
output Y ;

   not (I0_out, AN);
   or  (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.046:0.046:0.046,
       tphhl$AN$Y = 0.025:0.025:0.025,
       tplhl$B$Y = 0.0094:0.0094:0.0094,
       tphlh$B$Y = 0.034:0.034:0.034,
       tplhl$C$Y = 0.0088:0.0088:0.0088,
       tphlh$C$Y = 0.028:0.028:0.028,
       tplhl$D$Y = 0.0069:0.0069:0.0069,
       tphlh$D$Y = 0.021:0.021:0.021;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4BX2 (AN, B, C, D, Y);
input  AN ;
input  B ;
input  C ;
input  D ;
output Y ;

   not (I0_out, AN);
   or  (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.053:0.053:0.053,
       tphhl$AN$Y = 0.033:0.033:0.033,
       tplhl$B$Y = 0.0094:0.0094:0.0094,
       tphlh$B$Y = 0.035:0.035:0.035,
       tplhl$C$Y = 0.0089:0.0089:0.0089,
       tphlh$C$Y = 0.029:0.029:0.029,
       tplhl$D$Y = 0.0068:0.0068:0.0068,
       tphlh$D$Y = 0.02:0.02:0.02;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4BX4 (AN, B, C, D, Y);
input  AN ;
input  B ;
input  C ;
input  D ;
output Y ;

   not (I0_out, AN);
   or  (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.055:0.055:0.055,
       tphhl$AN$Y = 0.035:0.035:0.035,
       tplhl$B$Y = 0.0094:0.0094:0.0094,
       tphlh$B$Y = 0.035:0.035:0.035,
       tplhl$C$Y = 0.0089:0.0089:0.0089,
       tphlh$C$Y = 0.029:0.029:0.029,
       tplhl$D$Y = 0.0068:0.0068:0.0068,
       tphlh$D$Y = 0.02:0.02:0.02;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4BXL (AN, B, C, D, Y);
input  AN ;
input  B ;
input  C ;
input  D ;
output Y ;

   not (I0_out, AN);
   or  (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$AN$Y = 0.042:0.042:0.042,
       tphhl$AN$Y = 0.02:0.02:0.02,
       tplhl$B$Y = 0.0091:0.0091:0.0091,
       tphlh$B$Y = 0.033:0.033:0.033,
       tplhl$C$Y = 0.0084:0.0084:0.0084,
       tphlh$C$Y = 0.028:0.028:0.028,
       tplhl$D$Y = 0.0066:0.0066:0.0066,
       tphlh$D$Y = 0.02:0.02:0.02;

     // path delays
     (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4X1 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0092:0.0092:0.0092,
       tphlh$A$Y = 0.036:0.036:0.036,
       tplhl$B$Y = 0.0094:0.0094:0.0094,
       tphlh$B$Y = 0.034:0.034:0.034,
       tplhl$C$Y = 0.0088:0.0088:0.0088,
       tphlh$C$Y = 0.029:0.029:0.029,
       tplhl$D$Y = 0.0069:0.0069:0.0069,
       tphlh$D$Y = 0.021:0.021:0.021;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4X2 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.009:0.009:0.009,
       tphlh$A$Y = 0.036:0.036:0.036,
       tplhl$B$Y = 0.0093:0.0093:0.0093,
       tphlh$B$Y = 0.034:0.034:0.034,
       tplhl$C$Y = 0.0087:0.0087:0.0087,
       tphlh$C$Y = 0.028:0.028:0.028,
       tplhl$D$Y = 0.0068:0.0068:0.0068,
       tphlh$D$Y = 0.02:0.02:0.02;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4X4 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0091:0.0091:0.0091,
       tphlh$A$Y = 0.038:0.038:0.038,
       tplhl$B$Y = 0.0094:0.0094:0.0094,
       tphlh$B$Y = 0.035:0.035:0.035,
       tplhl$C$Y = 0.0089:0.0089:0.0089,
       tphlh$C$Y = 0.029:0.029:0.029,
       tplhl$D$Y = 0.0069:0.0069:0.0069,
       tphlh$D$Y = 0.02:0.02:0.02;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4X6 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0094:0.0094:0.0094,
       tphlh$A$Y = 0.038:0.038:0.038,
       tplhl$B$Y = 0.0097:0.0097:0.0097,
       tphlh$B$Y = 0.035:0.035:0.035,
       tplhl$C$Y = 0.009:0.009:0.009,
       tphlh$C$Y = 0.029:0.029:0.029,
       tplhl$D$Y = 0.0071:0.0071:0.0071,
       tphlh$D$Y = 0.021:0.021:0.021;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4X8 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0094:0.0094:0.0094,
       tphlh$A$Y = 0.037:0.037:0.037,
       tplhl$B$Y = 0.0097:0.0097:0.0097,
       tphlh$B$Y = 0.035:0.035:0.035,
       tplhl$C$Y = 0.009:0.009:0.009,
       tphlh$C$Y = 0.029:0.029:0.029,
       tplhl$D$Y = 0.0071:0.0071:0.0071,
       tphlh$D$Y = 0.021:0.021:0.021;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module NOR4XL (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A$Y = 0.0089:0.0089:0.0089,
       tphlh$A$Y = 0.036:0.036:0.036,
       tplhl$B$Y = 0.0091:0.0091:0.0091,
       tphlh$B$Y = 0.034:0.034:0.034,
       tplhl$C$Y = 0.0085:0.0085:0.0085,
       tphlh$C$Y = 0.028:0.028:0.028,
       tplhl$D$Y = 0.0066:0.0066:0.0066,
       tphlh$D$Y = 0.02:0.02:0.02;

     // path delays
     (A *> Y) = (tphlh$A$Y, tplhl$A$Y);
     (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
     (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
     (D *> Y) = (tphlh$D$Y, tplhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OA21X1 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (Y, I0_out, B0);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.028:0.028:0.028,
       tphhl$A0$Y = 0.037:0.037:0.037,
       tpllh$A1$Y = 0.026:0.026:0.026,
       tphhl$A1$Y = 0.034:0.034:0.034,
       tpllh$B0$Y = 0.021:0.024:0.027,
       tphhl$B0$Y = 0.022:0.023:0.023;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OA21X2 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (Y, I0_out, B0);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.038:0.038:0.038,
       tphhl$A0$Y = 0.05:0.05:0.05,
       tpllh$A1$Y = 0.036:0.036:0.036,
       tphhl$A1$Y = 0.047:0.047:0.047,
       tpllh$B0$Y = 0.029:0.033:0.037,
       tphhl$B0$Y = 0.03:0.03:0.031;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OA21X4 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (Y, I0_out, B0);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.041:0.041:0.041,
       tphhl$A0$Y = 0.052:0.052:0.052,
       tpllh$A1$Y = 0.038:0.038:0.038,
       tphhl$A1$Y = 0.05:0.05:0.05,
       tpllh$B0$Y = 0.031:0.035:0.04,
       tphhl$B0$Y = 0.032:0.032:0.033;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OA21XL (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (Y, I0_out, B0);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.024:0.024:0.024,
       tphhl$A0$Y = 0.03:0.03:0.03,
       tpllh$A1$Y = 0.021:0.021:0.021,
       tphhl$A1$Y = 0.028:0.028:0.028,
       tpllh$B0$Y = 0.017:0.02:0.023,
       tphhl$B0$Y = 0.018:0.019:0.019;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OA22X1 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (Y, I0_out, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.027:0.03:0.033,
       tphhl$A0$Y = 0.039:0.039:0.04,
       tpllh$A1$Y = 0.024:0.027:0.03,
       tphhl$A1$Y = 0.036:0.037:0.038,
       tpllh$B0$Y = 0.024:0.027:0.031,
       tphhl$B0$Y = 0.033:0.034:0.035,
       tpllh$B1$Y = 0.022:0.025:0.028,
       tphhl$B1$Y = 0.031:0.031:0.032;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
     (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OA22X2 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (Y, I0_out, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.034:0.039:0.043,
       tphhl$A0$Y = 0.052:0.052:0.053,
       tpllh$A1$Y = 0.032:0.036:0.04,
       tphhl$A1$Y = 0.049:0.05:0.051,
       tpllh$B0$Y = 0.032:0.036:0.041,
       tphhl$B0$Y = 0.047:0.047:0.048,
       tpllh$B1$Y = 0.029:0.034:0.038,
       tphhl$B1$Y = 0.044:0.045:0.046;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
     (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OA22X4 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (Y, I0_out, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.036:0.041:0.046,
       tphhl$A0$Y = 0.054:0.055:0.056,
       tpllh$A1$Y = 0.034:0.039:0.043,
       tphhl$A1$Y = 0.052:0.052:0.053,
       tpllh$B0$Y = 0.034:0.039:0.044,
       tphhl$B0$Y = 0.049:0.05:0.051,
       tpllh$B1$Y = 0.032:0.036:0.041,
       tphhl$B1$Y = 0.047:0.048:0.049;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
     (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OA22XL (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (Y, I0_out, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A0$Y = 0.023:0.025:0.028,
       tphhl$A0$Y = 0.032:0.033:0.033,
       tpllh$A1$Y = 0.021:0.023:0.025,
       tphhl$A1$Y = 0.029:0.03:0.031,
       tpllh$B0$Y = 0.02:0.023:0.026,
       tphhl$B0$Y = 0.026:0.027:0.028,
       tpllh$B1$Y = 0.018:0.02:0.023,
       tphhl$B1$Y = 0.024:0.025:0.026;

     // path delays
     (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);
     (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
     (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
     (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI211X1 (A0, A1, B0, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  C0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.018:0.018:0.018,
       tphlh$A0$Y = 0.024:0.024:0.024,
       tplhl$A1$Y = 0.015:0.015:0.015,
       tphlh$A1$Y = 0.022:0.022:0.022,
       tplhl$B0$Y = 0.012:0.015:0.017,
       tphlh$B0$Y = 0.013:0.014:0.014,
       tplhl$C0$Y = 0.011:0.013:0.016,
       tphlh$C0$Y = 0.011:0.012:0.012;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI211X2 (A0, A1, B0, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  C0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.018:0.018:0.018,
       tphlh$A0$Y = 0.024:0.024:0.024,
       tplhl$A1$Y = 0.015:0.015:0.015,
       tphlh$A1$Y = 0.022:0.022:0.022,
       tplhl$B0$Y = 0.012:0.015:0.017,
       tphlh$B0$Y = 0.013:0.014:0.014,
       tplhl$C0$Y = 0.011:0.013:0.015,
       tphlh$C0$Y = 0.011:0.012:0.012;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI211X4 (A0, A1, B0, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  C0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.018:0.018:0.018,
       tphlh$A0$Y = 0.024:0.024:0.024,
       tplhl$A1$Y = 0.015:0.015:0.015,
       tphlh$A1$Y = 0.022:0.022:0.022,
       tplhl$B0$Y = 0.012:0.015:0.018,
       tphlh$B0$Y = 0.013:0.014:0.014,
       tplhl$C0$Y = 0.011:0.013:0.016,
       tphlh$C0$Y = 0.011:0.012:0.012;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI211XL (A0, A1, B0, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  C0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.018:0.018:0.018,
       tphlh$A0$Y = 0.024:0.024:0.024,
       tplhl$A1$Y = 0.015:0.015:0.015,
       tphlh$A1$Y = 0.022:0.022:0.022,
       tplhl$B0$Y = 0.011:0.014:0.017,
       tphlh$B0$Y = 0.013:0.014:0.014,
       tplhl$C0$Y = 0.01:0.013:0.015,
       tphlh$C0$Y = 0.011:0.012:0.012;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI21X1 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (I1_out, I0_out, B0);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.012:0.012,
       tphlh$A0$Y = 0.02:0.02:0.02,
       tplhl$A1$Y = 0.01:0.01:0.01,
       tphlh$A1$Y = 0.018:0.018:0.018,
       tplhl$B0$Y = 0.0069:0.0092:0.011,
       tphlh$B0$Y = 0.01:0.011:0.011;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI21X2 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (I1_out, I0_out, B0);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.012:0.012,
       tphlh$A0$Y = 0.02:0.02:0.02,
       tplhl$A1$Y = 0.0099:0.0099:0.0099,
       tphlh$A1$Y = 0.018:0.018:0.018,
       tplhl$B0$Y = 0.0069:0.0091:0.011,
       tphlh$B0$Y = 0.0099:0.01:0.011;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI21X4 (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (I1_out, I0_out, B0);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.012:0.012,
       tphlh$A0$Y = 0.02:0.02:0.02,
       tplhl$A1$Y = 0.0099:0.0099:0.0099,
       tphlh$A1$Y = 0.018:0.018:0.018,
       tplhl$B0$Y = 0.007:0.0092:0.012,
       tphlh$B0$Y = 0.0099:0.01:0.011;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI21XL (A0, A1, B0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
output Y ;

   or  (I0_out, A0, A1);
   and (I1_out, I0_out, B0);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.012:0.012,
       tphlh$A0$Y = 0.02:0.02:0.02,
       tplhl$A1$Y = 0.0095:0.0095:0.0095,
       tphlh$A1$Y = 0.018:0.018:0.018,
       tplhl$B0$Y = 0.0065:0.0088:0.011,
       tphlh$B0$Y = 0.0099:0.01:0.011;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI221X1 (A0, A1, B0, B1, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.019:0.022:0.024,
       tphlh$A0$Y = 0.027:0.027:0.028,
       tplhl$A1$Y = 0.016:0.019:0.021,
       tphlh$A1$Y = 0.024:0.025:0.026,
       tplhl$B0$Y = 0.016:0.019:0.022,
       tphlh$B0$Y = 0.023:0.024:0.024,
       tplhl$B1$Y = 0.014:0.017:0.019,
       tphlh$B1$Y = 0.021:0.021:0.022,
       tplhl$C0$Y = 0.0099:0.015:0.02,
       tphlh$C0$Y = 0.012:0.013:0.014;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI221X2 (A0, A1, B0, B1, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.018:0.021:0.023,
       tphlh$A0$Y = 0.025:0.026:0.027,
       tplhl$A1$Y = 0.015:0.018:0.02,
       tphlh$A1$Y = 0.023:0.024:0.025,
       tplhl$B0$Y = 0.015:0.018:0.021,
       tphlh$B0$Y = 0.022:0.022:0.023,
       tplhl$B1$Y = 0.013:0.016:0.018,
       tphlh$B1$Y = 0.019:0.02:0.021,
       tplhl$C0$Y = 0.0091:0.014:0.019,
       tphlh$C0$Y = 0.011:0.012:0.013;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI221X4 (A0, A1, B0, B1, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.018:0.021:0.023,
       tphlh$A0$Y = 0.025:0.026:0.027,
       tplhl$A1$Y = 0.015:0.018:0.02,
       tphlh$A1$Y = 0.023:0.024:0.025,
       tplhl$B0$Y = 0.015:0.019:0.022,
       tphlh$B0$Y = 0.022:0.022:0.023,
       tplhl$B1$Y = 0.013:0.016:0.018,
       tphlh$B1$Y = 0.019:0.02:0.021,
       tplhl$C0$Y = 0.0092:0.014:0.019,
       tphlh$C0$Y = 0.011:0.012:0.013;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI221XL (A0, A1, B0, B1, C0, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.018:0.02:0.023,
       tphlh$A0$Y = 0.026:0.027:0.028,
       tplhl$A1$Y = 0.015:0.018:0.02,
       tphlh$A1$Y = 0.024:0.025:0.025,
       tplhl$B0$Y = 0.015:0.018:0.021,
       tphlh$B0$Y = 0.022:0.023:0.024,
       tplhl$B1$Y = 0.013:0.016:0.018,
       tphlh$B1$Y = 0.02:0.021:0.021,
       tplhl$C0$Y = 0.009:0.014:0.019,
       tphlh$C0$Y = 0.011:0.012:0.013;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI222X1 (A0, A1, B0, B1, C0, C1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
input  C1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, C0, C1);
   or  (I3_out, B0, B1);
   and (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.018:0.024:0.03,
       tphlh$A0$Y = 0.028:0.03:0.032,
       tplhl$A1$Y = 0.016:0.021:0.026,
       tphlh$A1$Y = 0.026:0.028:0.03,
       tplhl$B0$Y = 0.016:0.022:0.028,
       tphlh$B0$Y = 0.025:0.027:0.028,
       tplhl$B1$Y = 0.014:0.019:0.025,
       tphlh$B1$Y = 0.022:0.024:0.025,
       tplhl$C0$Y = 0.013:0.018:0.024,
       tphlh$C0$Y = 0.019:0.021:0.022,
       tplhl$C1$Y = 0.011:0.016:0.021,
       tphlh$C1$Y = 0.017:0.018:0.02;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
     (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI222X2 (A0, A1, B0, B1, C0, C1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
input  C1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, C0, C1);
   or  (I3_out, B0, B1);
   and (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.017:0.023:0.029,
       tphlh$A0$Y = 0.027:0.029:0.031,
       tplhl$A1$Y = 0.015:0.02:0.026,
       tphlh$A1$Y = 0.025:0.027:0.029,
       tplhl$B0$Y = 0.015:0.021:0.027,
       tphlh$B0$Y = 0.024:0.025:0.027,
       tplhl$B1$Y = 0.013:0.018:0.024,
       tphlh$B1$Y = 0.021:0.023:0.024,
       tplhl$C0$Y = 0.012:0.018:0.023,
       tphlh$C0$Y = 0.018:0.02:0.021,
       tplhl$C1$Y = 0.01:0.015:0.02,
       tphlh$C1$Y = 0.016:0.018:0.019;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
     (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI222X4 (A0, A1, B0, B1, C0, C1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
input  C1 ;
output Y ;

   or  (I0_out, C0, C1);
   or  (I1_out, A0, A1);
   or  (I3_out, B0, B1);
   and (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.017:0.023:0.029,
       tphlh$A0$Y = 0.027:0.029:0.031,
       tplhl$A1$Y = 0.015:0.02:0.026,
       tphlh$A1$Y = 0.025:0.027:0.029,
       tplhl$B0$Y = 0.015:0.021:0.027,
       tphlh$B0$Y = 0.024:0.025:0.027,
       tplhl$B1$Y = 0.013:0.018:0.024,
       tphlh$B1$Y = 0.021:0.023:0.024,
       tplhl$C0$Y = 0.012:0.018:0.023,
       tphlh$C0$Y = 0.018:0.02:0.021,
       tplhl$C1$Y = 0.01:0.015:0.02,
       tphlh$C1$Y = 0.016:0.018:0.019;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
     (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI222XL (A0, A1, B0, B1, C0, C1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
input  C0 ;
input  C1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, C0, C1);
   or  (I3_out, B0, B1);
   and (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.017:0.023:0.029,
       tphlh$A0$Y = 0.028:0.03:0.033,
       tplhl$A1$Y = 0.015:0.021:0.026,
       tphlh$A1$Y = 0.026:0.028:0.03,
       tplhl$B0$Y = 0.016:0.021:0.027,
       tphlh$B0$Y = 0.025:0.027:0.028,
       tplhl$B1$Y = 0.013:0.019:0.024,
       tphlh$B1$Y = 0.022:0.024:0.025,
       tplhl$C0$Y = 0.012:0.018:0.023,
       tphlh$C0$Y = 0.019:0.02:0.022,
       tplhl$C1$Y = 0.01:0.015:0.02,
       tphlh$C1$Y = 0.017:0.018:0.02;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
     (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI22X1 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I2_out, I0_out, I1_out);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.014:0.016,
       tphlh$A0$Y = 0.022:0.023:0.024,
       tplhl$A1$Y = 0.01:0.012:0.014,
       tphlh$A1$Y = 0.019:0.021:0.022,
       tplhl$B0$Y = 0.0098:0.012:0.015,
       tphlh$B0$Y = 0.017:0.017:0.018,
       tplhl$B1$Y = 0.0077:0.01:0.012,
       tphlh$B1$Y = 0.015:0.015:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI22X2 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I2_out, I0_out, I1_out);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.014:0.016,
       tphlh$A0$Y = 0.022:0.023:0.024,
       tplhl$A1$Y = 0.01:0.012:0.014,
       tphlh$A1$Y = 0.019:0.02:0.021,
       tplhl$B0$Y = 0.0098:0.012:0.014,
       tphlh$B0$Y = 0.017:0.017:0.018,
       tplhl$B1$Y = 0.0079:0.01:0.012,
       tphlh$B1$Y = 0.015:0.015:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI22X4 (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I2_out, I0_out, I1_out);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.014:0.016,
       tphlh$A0$Y = 0.022:0.023:0.024,
       tplhl$A1$Y = 0.01:0.012:0.014,
       tphlh$A1$Y = 0.019:0.02:0.021,
       tplhl$B0$Y = 0.0098:0.012:0.014,
       tphlh$B0$Y = 0.017:0.017:0.018,
       tplhl$B1$Y = 0.0079:0.01:0.012,
       tphlh$B1$Y = 0.015:0.015:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI22XL (A0, A1, B0, B1, Y);
input  A0 ;
input  A1 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I2_out, I0_out, I1_out);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.012:0.014:0.016,
       tphlh$A0$Y = 0.022:0.023:0.024,
       tplhl$A1$Y = 0.01:0.012:0.014,
       tphlh$A1$Y = 0.02:0.021:0.022,
       tplhl$B0$Y = 0.0094:0.012:0.014,
       tphlh$B0$Y = 0.016:0.017:0.018,
       tplhl$B1$Y = 0.0073:0.0096:0.012,
       tphlh$B1$Y = 0.015:0.015:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI2BB1X1 (A0N, A1N, B0, Y);
input  A0N ;
input  A1N ;
input  B0 ;
output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.025:0.025:0.025,
       tphhl$A0N$Y = 0.026:0.026:0.026,
       tpllh$A1N$Y = 0.025:0.025:0.025,
       tphhl$A1N$Y = 0.025:0.025:0.025,
       tplhl$B0$Y = 0.009:0.009:0.009,
       tphlh$B0$Y = 0.012:0.012:0.012;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI2BB1X2 (A0N, A1N, B0, Y);
input  A0N ;
input  A1N ;
input  B0 ;
output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.035:0.035:0.035,
       tphhl$A0N$Y = 0.035:0.035:0.035,
       tpllh$A1N$Y = 0.035:0.035:0.035,
       tphhl$A1N$Y = 0.033:0.033:0.033,
       tplhl$B0$Y = 0.0088:0.0088:0.0088,
       tphlh$B0$Y = 0.011:0.011:0.011;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI2BB1X4 (A0N, A1N, B0, Y);
input  A0N ;
input  A1N ;
input  B0 ;
output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.038:0.038:0.038,
       tphhl$A0N$Y = 0.036:0.036:0.036,
       tpllh$A1N$Y = 0.038:0.038:0.038,
       tphhl$A1N$Y = 0.035:0.035:0.035,
       tplhl$B0$Y = 0.009:0.009:0.009,
       tphlh$B0$Y = 0.012:0.012:0.012;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI2BB1XL (A0N, A1N, B0, Y);
input  A0N ;
input  A1N ;
input  B0 ;
output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.021:0.021:0.021,
       tphhl$A0N$Y = 0.022:0.022:0.022,
       tpllh$A1N$Y = 0.02:0.02:0.02,
       tphhl$A1N$Y = 0.02:0.02:0.02,
       tplhl$B0$Y = 0.0084:0.0084:0.0084,
       tphlh$B0$Y = 0.012:0.012:0.012;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI2BB2X1 (A0N, A1N, B0, B1, Y);
input  A0N ;
input  A1N ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, B0, B1);
   and (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.032:0.033:0.034,
       tphhl$A0N$Y = 0.028:0.03:0.032,
       tpllh$A1N$Y = 0.028:0.029:0.03,
       tphhl$A1N$Y = 0.026:0.028:0.03,
       tplhl$B0$Y = 0.0098:0.012:0.014,
       tphlh$B0$Y = 0.017:0.017:0.018,
       tplhl$B1$Y = 0.0076:0.0098:0.012,
       tphlh$B1$Y = 0.015:0.015:0.015;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI2BB2X2 (A0N, A1N, B0, B1, Y);
input  A0N ;
input  A1N ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, B0, B1);
   and (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.039:0.04:0.041,
       tphhl$A0N$Y = 0.036:0.038:0.041,
       tpllh$A1N$Y = 0.034:0.035:0.036,
       tphhl$A1N$Y = 0.034:0.036:0.038,
       tplhl$B0$Y = 0.0097:0.012:0.014,
       tphlh$B0$Y = 0.017:0.017:0.017,
       tplhl$B1$Y = 0.0078:0.0098:0.012,
       tphlh$B1$Y = 0.015:0.015:0.015;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI2BB2X4 (A0N, A1N, B0, B1, Y);
input  A0N ;
input  A1N ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, B0, B1);
   and (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.041:0.042:0.043,
       tphhl$A0N$Y = 0.038:0.041:0.043,
       tpllh$A1N$Y = 0.036:0.037:0.038,
       tphhl$A1N$Y = 0.036:0.038:0.04,
       tplhl$B0$Y = 0.0099:0.012:0.014,
       tphlh$B0$Y = 0.017:0.017:0.017,
       tplhl$B1$Y = 0.008:0.01:0.012,
       tphlh$B1$Y = 0.015:0.015:0.015;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI2BB2XL (A0N, A1N, B0, B1, Y);
input  A0N ;
input  A1N ;
input  B0 ;
input  B1 ;
output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, B0, B1);
   and (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tpllh$A0N$Y = 0.028:0.029:0.03,
       tphhl$A0N$Y = 0.023:0.025:0.028,
       tpllh$A1N$Y = 0.025:0.026:0.027,
       tphhl$A1N$Y = 0.022:0.024:0.025,
       tplhl$B0$Y = 0.0093:0.012:0.014,
       tphlh$B0$Y = 0.016:0.017:0.017,
       tplhl$B1$Y = 0.0072:0.0094:0.012,
       tphlh$B1$Y = 0.014:0.015:0.015;

     // path delays
     (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);
     (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI31X1 (A0, A1, A2, B0, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.014:0.014,
       tphlh$A0$Y = 0.031:0.031:0.031,
       tplhl$A1$Y = 0.013:0.013:0.013,
       tphlh$A1$Y = 0.029:0.029:0.029,
       tplhl$A2$Y = 0.011:0.011:0.011,
       tphlh$A2$Y = 0.023:0.023:0.023,
       tplhl$B0$Y = 0.0065:0.0098:0.013,
       tphlh$B0$Y = 0.01:0.011:0.011;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI31X2 (A0, A1, A2, B0, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.014:0.014,
       tphlh$A0$Y = 0.031:0.031:0.031,
       tplhl$A1$Y = 0.013:0.013:0.013,
       tphlh$A1$Y = 0.029:0.029:0.029,
       tplhl$A2$Y = 0.011:0.011:0.011,
       tphlh$A2$Y = 0.023:0.023:0.023,
       tplhl$B0$Y = 0.0064:0.0097:0.013,
       tphlh$B0$Y = 0.01:0.01:0.011;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI31X4 (A0, A1, A2, B0, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.014:0.014,
       tphlh$A0$Y = 0.031:0.031:0.031,
       tplhl$A1$Y = 0.013:0.013:0.013,
       tphlh$A1$Y = 0.029:0.029:0.029,
       tplhl$A2$Y = 0.01:0.01:0.01,
       tphlh$A2$Y = 0.023:0.023:0.023,
       tplhl$B0$Y = 0.0065:0.0098:0.013,
       tphlh$B0$Y = 0.01:0.01:0.011;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI31XL (A0, A1, A2, B0, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.014:0.014,
       tphlh$A0$Y = 0.031:0.031:0.031,
       tplhl$A1$Y = 0.013:0.013:0.013,
       tphlh$A1$Y = 0.029:0.029:0.029,
       tplhl$A2$Y = 0.01:0.01:0.01,
       tphlh$A2$Y = 0.023:0.023:0.023,
       tplhl$B0$Y = 0.0061:0.0094:0.013,
       tphlh$B0$Y = 0.0099:0.01:0.011;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI32X1 (A0, A1, A2, B0, B1, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   or  (I2_out, B0, B1);
   and (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.016:0.018,
       tphlh$A0$Y = 0.034:0.035:0.037,
       tplhl$A1$Y = 0.013:0.015:0.017,
       tphlh$A1$Y = 0.031:0.033:0.034,
       tplhl$A2$Y = 0.011:0.013:0.015,
       tphlh$A2$Y = 0.026:0.027:0.029,
       tplhl$B0$Y = 0.0093:0.013:0.016,
       tphlh$B0$Y = 0.017:0.017:0.018,
       tplhl$B1$Y = 0.0074:0.011:0.014,
       tphlh$B1$Y = 0.015:0.015:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI32X2 (A0, A1, A2, B0, B1, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   or  (I2_out, B0, B1);
   and (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.013:0.016:0.018,
       tphlh$A0$Y = 0.034:0.035:0.037,
       tplhl$A1$Y = 0.013:0.015:0.017,
       tphlh$A1$Y = 0.031:0.033:0.034,
       tplhl$A2$Y = 0.011:0.013:0.015,
       tphlh$A2$Y = 0.025:0.027:0.028,
       tplhl$B0$Y = 0.0091:0.013:0.016,
       tphlh$B0$Y = 0.017:0.017:0.018,
       tplhl$B1$Y = 0.0073:0.011:0.014,
       tphlh$B1$Y = 0.015:0.015:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI32X4 (A0, A1, A2, B0, B1, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   or  (I2_out, B0, B1);
   and (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.016:0.018,
       tphlh$A0$Y = 0.034:0.035:0.037,
       tplhl$A1$Y = 0.013:0.015:0.017,
       tphlh$A1$Y = 0.031:0.033:0.034,
       tplhl$A2$Y = 0.011:0.013:0.015,
       tphlh$A2$Y = 0.025:0.027:0.028,
       tplhl$B0$Y = 0.0093:0.013:0.016,
       tphlh$B0$Y = 0.017:0.017:0.018,
       tplhl$B1$Y = 0.0074:0.011:0.014,
       tphlh$B1$Y = 0.015:0.015:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI32XL (A0, A1, A2, B0, B1, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   or  (I2_out, B0, B1);
   and (I3_out, I1_out, I2_out);
   not (Y, I3_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.013:0.016:0.018,
       tphlh$A0$Y = 0.034:0.036:0.037,
       tplhl$A1$Y = 0.013:0.015:0.017,
       tphlh$A1$Y = 0.031:0.033:0.034,
       tplhl$A2$Y = 0.011:0.013:0.014,
       tphlh$A2$Y = 0.026:0.027:0.028,
       tplhl$B0$Y = 0.009:0.012:0.016,
       tphlh$B0$Y = 0.017:0.017:0.018,
       tplhl$B1$Y = 0.007:0.01:0.014,
       tphlh$B1$Y = 0.015:0.015:0.016;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI33X1 (A0, A1, A2, B0, B1, B2, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
input  B2 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   or  (I3_out, B0, B1, B2);
   and (I4_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.018:0.021,
       tphlh$A0$Y = 0.036:0.039:0.042,
       tplhl$A1$Y = 0.014:0.017:0.02,
       tphlh$A1$Y = 0.034:0.037:0.039,
       tplhl$A2$Y = 0.012:0.014:0.017,
       tphlh$A2$Y = 0.028:0.031:0.033,
       tplhl$B0$Y = 0.011:0.015:0.018,
       tphlh$B0$Y = 0.026:0.027:0.029,
       tplhl$B1$Y = 0.01:0.014:0.017,
       tphlh$B1$Y = 0.024:0.025:0.026,
       tplhl$B2$Y = 0.0081:0.011:0.015,
       tphlh$B2$Y = 0.019:0.02:0.021;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI33X2 (A0, A1, A2, B0, B1, B2, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
input  B2 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   or  (I3_out, B0, B1, B2);
   and (I4_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.018:0.021,
       tphlh$A0$Y = 0.037:0.04:0.042,
       tplhl$A1$Y = 0.014:0.017:0.02,
       tphlh$A1$Y = 0.034:0.037:0.04,
       tplhl$A2$Y = 0.012:0.014:0.017,
       tphlh$A2$Y = 0.028:0.031:0.034,
       tplhl$B0$Y = 0.011:0.015:0.018,
       tphlh$B0$Y = 0.027:0.028:0.029,
       tplhl$B1$Y = 0.01:0.014:0.017,
       tphlh$B1$Y = 0.024:0.025:0.026,
       tplhl$B2$Y = 0.0081:0.011:0.015,
       tphlh$B2$Y = 0.019:0.02:0.021;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI33X4 (A0, A1, A2, B0, B1, B2, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
input  B2 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   or  (I3_out, B0, B1, B2);
   and (I4_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.018:0.022,
       tphlh$A0$Y = 0.037:0.04:0.043,
       tplhl$A1$Y = 0.014:0.017:0.021,
       tphlh$A1$Y = 0.034:0.037:0.04,
       tplhl$A2$Y = 0.012:0.015:0.018,
       tphlh$A2$Y = 0.028:0.031:0.034,
       tplhl$B0$Y = 0.011:0.015:0.019,
       tphlh$B0$Y = 0.027:0.029:0.03,
       tplhl$B1$Y = 0.01:0.014:0.018,
       tphlh$B1$Y = 0.025:0.026:0.027,
       tplhl$B2$Y = 0.0082:0.012:0.015,
       tphlh$B2$Y = 0.019:0.02:0.021;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OAI33XL (A0, A1, A2, B0, B1, B2, Y);
input  A0 ;
input  A1 ;
input  A2 ;
input  B0 ;
input  B1 ;
input  B2 ;
output Y ;

   or  (I1_out, A0, A1, A2);
   or  (I3_out, B0, B1, B2);
   and (I4_out, I1_out, I3_out);
   not (Y, I4_out);

   specify
     // delay parameters
     specparam
       tplhl$A0$Y = 0.014:0.017:0.021,
       tphlh$A0$Y = 0.036:0.039:0.042,
       tplhl$A1$Y = 0.013:0.016:0.02,
       tphlh$A1$Y = 0.034:0.037:0.039,
       tplhl$A2$Y = 0.011:0.014:0.017,
       tphlh$A2$Y = 0.028:0.031:0.033,
       tplhl$B0$Y = 0.01:0.014:0.018,
       tphlh$B0$Y = 0.026:0.027:0.029,
       tplhl$B1$Y = 0.0098:0.013:0.017,
       tphlh$B1$Y = 0.024:0.025:0.026,
       tplhl$B2$Y = 0.0077:0.011:0.014,
       tphlh$B2$Y = 0.019:0.02:0.021;

     // path delays
     (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);
     (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
     (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
     (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
     (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
     (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR2X1 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.02:0.02:0.02,
       tphhl$A$Y = 0.032:0.032:0.032,
       tpllh$B$Y = 0.019:0.019:0.019,
       tphhl$B$Y = 0.029:0.029:0.029;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR2X2 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.045:0.045:0.045,
       tpllh$B$Y = 0.025:0.025:0.025,
       tphhl$B$Y = 0.043:0.043:0.043;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR2X4 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.028:0.028:0.028,
       tphhl$A$Y = 0.048:0.048:0.048,
       tpllh$B$Y = 0.026:0.026:0.026,
       tphhl$B$Y = 0.046:0.046:0.046;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR2X6 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.024:0.024:0.024,
       tphhl$A$Y = 0.04:0.04:0.04,
       tpllh$B$Y = 0.023:0.023:0.023,
       tphhl$B$Y = 0.038:0.038:0.038;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR2X8 (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.028:0.028:0.028,
       tphhl$A$Y = 0.048:0.048:0.048,
       tpllh$B$Y = 0.027:0.027:0.027,
       tphhl$B$Y = 0.045:0.045:0.045;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR2XL (A, B, Y);
input  A ;
input  B ;
output Y ;

   or  (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.017:0.017:0.017,
       tphhl$A$Y = 0.025:0.025:0.025,
       tpllh$B$Y = 0.015:0.015:0.015,
       tphhl$B$Y = 0.023:0.023:0.023;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR3X1 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.022:0.022:0.022,
       tphhl$A$Y = 0.046:0.046:0.046,
       tpllh$B$Y = 0.021:0.021:0.021,
       tphhl$B$Y = 0.043:0.043:0.043,
       tpllh$C$Y = 0.019:0.019:0.019,
       tphhl$C$Y = 0.038:0.038:0.038;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR3X2 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.028:0.028:0.028,
       tphhl$A$Y = 0.064:0.064:0.064,
       tpllh$B$Y = 0.027:0.027:0.027,
       tphhl$B$Y = 0.062:0.062:0.062,
       tpllh$C$Y = 0.025:0.025:0.025,
       tphhl$C$Y = 0.056:0.056:0.056;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR3X4 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.03:0.03:0.03,
       tphhl$A$Y = 0.068:0.068:0.068,
       tpllh$B$Y = 0.029:0.029:0.029,
       tphhl$B$Y = 0.066:0.066:0.066,
       tpllh$C$Y = 0.027:0.027:0.027,
       tphhl$C$Y = 0.06:0.06:0.06;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR3X6 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.058:0.058:0.058,
       tpllh$B$Y = 0.025:0.025:0.025,
       tphhl$B$Y = 0.055:0.055:0.055,
       tpllh$C$Y = 0.023:0.023:0.023,
       tphhl$C$Y = 0.049:0.049:0.049;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR3X8 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.03:0.03:0.03,
       tphhl$A$Y = 0.068:0.068:0.068,
       tpllh$B$Y = 0.029:0.029:0.029,
       tphhl$B$Y = 0.066:0.066:0.066,
       tpllh$C$Y = 0.027:0.027:0.027,
       tphhl$C$Y = 0.06:0.06:0.06;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR3XL (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   or  (Y, A, B, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.018:0.018:0.018,
       tphhl$A$Y = 0.037:0.037:0.037,
       tpllh$B$Y = 0.018:0.018:0.018,
       tphhl$B$Y = 0.034:0.034:0.034,
       tpllh$C$Y = 0.016:0.016:0.016,
       tphhl$C$Y = 0.029:0.029:0.029;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR4X1 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.023:0.023:0.023,
       tphhl$A$Y = 0.062:0.062:0.062,
       tpllh$B$Y = 0.022:0.022:0.022,
       tphhl$B$Y = 0.059:0.059:0.059,
       tpllh$C$Y = 0.021:0.021:0.021,
       tphhl$C$Y = 0.054:0.054:0.054,
       tpllh$D$Y = 0.02:0.02:0.02,
       tphhl$D$Y = 0.045:0.045:0.045;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR4X2 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.029:0.029:0.029,
       tphhl$A$Y = 0.086:0.086:0.086,
       tpllh$B$Y = 0.029:0.029:0.029,
       tphhl$B$Y = 0.084:0.084:0.084,
       tpllh$C$Y = 0.027:0.027:0.027,
       tphhl$C$Y = 0.078:0.078:0.078,
       tpllh$D$Y = 0.026:0.026:0.026,
       tphhl$D$Y = 0.069:0.069:0.069;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR4X4 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.031:0.031:0.031,
       tphhl$A$Y = 0.091:0.091:0.091,
       tpllh$B$Y = 0.031:0.031:0.031,
       tphhl$B$Y = 0.088:0.088:0.088,
       tpllh$C$Y = 0.029:0.029:0.029,
       tphhl$C$Y = 0.083:0.083:0.083,
       tpllh$D$Y = 0.028:0.028:0.028,
       tphhl$D$Y = 0.074:0.074:0.074;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR4X6 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.027:0.027:0.027,
       tphhl$A$Y = 0.077:0.077:0.077,
       tpllh$B$Y = 0.027:0.027:0.027,
       tphhl$B$Y = 0.075:0.075:0.075,
       tpllh$C$Y = 0.026:0.026:0.026,
       tphhl$C$Y = 0.07:0.07:0.07,
       tpllh$D$Y = 0.024:0.024:0.024,
       tphhl$D$Y = 0.06:0.06:0.06;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR4X8 (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.031:0.031:0.031,
       tphhl$A$Y = 0.091:0.091:0.091,
       tpllh$B$Y = 0.031:0.031:0.031,
       tphhl$B$Y = 0.089:0.089:0.089,
       tpllh$C$Y = 0.029:0.029:0.029,
       tphhl$C$Y = 0.083:0.083:0.083,
       tpllh$D$Y = 0.028:0.028:0.028,
       tphhl$D$Y = 0.074:0.074:0.074;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module OR4XL (A, B, C, D, Y);
input  A ;
input  B ;
input  C ;
input  D ;
output Y ;

   or  (Y, A, B, C, D);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.019:0.019:0.019,
       tphhl$A$Y = 0.05:0.05:0.05,
       tpllh$B$Y = 0.019:0.019:0.019,
       tphhl$B$Y = 0.048:0.048:0.048,
       tpllh$C$Y = 0.018:0.018:0.018,
       tphhl$C$Y = 0.042:0.042:0.042,
       tpllh$D$Y = 0.016:0.016:0.016,
       tphhl$D$Y = 0.034:0.034:0.034;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
     (D *> Y) = (tpllh$D$Y, tphhl$D$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFHQX1 (CK, D, Q, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, N30);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.058:0.058:0.058,
       tplhl$CK$Q = 0.069:0.069:0.069,
       tminpwh$CK = 0.037:0.053:0.069,
       tminpwl$CK = 0.048:0.058:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFHQX2 (CK, D, Q, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, N30);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.063:0.063:0.063,
       tplhl$CK$Q = 0.074:0.074:0.074,
       tminpwh$CK = 0.037:0.055:0.074,
       tminpwl$CK = 0.048:0.058:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFHQX4 (CK, D, Q, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.069:0.069:0.069,
       tplhl$CK$Q = 0.077:0.077:0.077,
       tminpwh$CK = 0.043:0.06:0.077,
       tminpwl$CK = 0.048:0.058:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFHQX8 (CK, D, Q, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (P0000, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0000);
   not (Q, P0003);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.082:0.082:0.082,
       tplhl$CK$Q = 0.087:0.087:0.087,
       tminpwh$CK = 0.052:0.07:0.087,
       tminpwl$CK = 0.048:0.058:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFNSRX1 (CKN, D, Q, QN, RN, SE, SI, SN);
input  CKN ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0002, I0_D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);
   buf (QN, P0001);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I13_out, SN);

   specify
     // delay parameters
     specparam
       tphlh$CKN$Q = 0.069:0.069:0.069,
       tphhl$CKN$Q = 0.064:0.064:0.064,
       tphlh$CKN$QN = 0.08:0.08:0.08,
       tphhl$CKN$QN = 0.083:0.083:0.083,
       tphhl$RN$Q = 0.076:0.079:0.081,
       tphlh$RN$QN = 0.093:0.095:0.097,
       tplhl$SN$Q = 0.062:0.064:0.066,
       tphlh$SN$Q = 0.061:0.063:0.064,
       tpllh$SN$QN = 0.079:0.081:0.083,
       tphhl$SN$QN = 0.075:0.077:0.078,
       tminpwh$CKN = 0.03:0.044:0.058,
       tminpwl$CKN = 0.032:0.057:0.083,
       tminpwl$RN = 0.032:0.065:0.097,
       tminpwl$SN = 0.018:0.048:0.078,
       tsetup_negedge$D$CKN = 0.094:0.094:0.094,
       thold_negedge$D$CKN = 0:0:0,
       tsetup_negedge$SE$CKN = 0.094:0.094:0.094,
       thold_negedge$SE$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_negedge$SI$CKN = 0.094:0.094:0.094,
       thold_negedge$SI$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$CKN = 0.094:0.094:0.094,
       thold_posedge$D$CKN = 0.094:0.094:0.094,
       tsetup_posedge$SE$CKN = 0.094:0.094:0.094,
       thold_posedge$SE$CKN = -0.00000000061:0.047:0.094,
       tsetup_posedge$SI$CKN = 0.094:0.094:0.094,
       thold_posedge$SI$CKN = 0.094:0.094:0.094,
       trec$RN$CKN = 0.094:0.094:0.094,
       trem$RN$CKN = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CKN = 0.094:0.094:0.094,
       trem$SN$CKN = 0.094:0.094:0.094;

     // path delays
     if (CKN == 1'b0)
       (CKN *> Q) = (tphlh$CKN$Q, tphhl$CKN$Q);
     if (CKN == 1'b0)
       (CKN *> QN) = (tphlh$CKN$QN, tphhl$CKN$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
     $setup(negedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CKN,  NOTIFIER);
     $setup(negedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CKN,  NOTIFIER);
     $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
     $setup(posedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CKN,  NOTIFIER);
     $setup(posedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CKN,  NOTIFIER);
     $recovery(posedge RN, negedge CKN &&& SN == 1'b1, trec$RN$CKN, NOTIFIER);
     $removal (posedge RN, negedge CKN &&& SN == 1'b1, trem$RN$CKN, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, negedge CKN &&& RN == 1'b1, trec$SN$CKN, NOTIFIER);
     $removal (posedge SN, negedge CKN &&& RN == 1'b1, trem$SN$CKN, NOTIFIER);
     $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
     $width(negedge CKN, tminpwl$CKN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFNSRX2 (CKN, D, Q, QN, RN, SE, SI, SN);
input  CKN ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0002, I0_D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0000, P0002);
   not (Q, P0000);
   buf (QN, P0000);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I13_out, SN);

   specify
     // delay parameters
     specparam
       tphlh$CKN$Q = 0.073:0.073:0.073,
       tphhl$CKN$Q = 0.068:0.068:0.068,
       tphlh$CKN$QN = 0.094:0.094:0.094,
       tphhl$CKN$QN = 0.097:0.097:0.097,
       tphhl$RN$Q = 0.08:0.083:0.086,
       tphlh$RN$QN = 0.11:0.11:0.11,
       tplhl$SN$Q = 0.067:0.069:0.071,
       tphlh$SN$Q = 0.066:0.068:0.069,
       tpllh$SN$QN = 0.092:0.094:0.096,
       tphhl$SN$QN = 0.09:0.091:0.093,
       tminpwh$CKN = 0.029:0.044:0.058,
       tminpwl$CKN = 0.034:0.066:0.097,
       tminpwl$RN = 0.032:0.072:0.11,
       tminpwl$SN = 0.018:0.056:0.093,
       tsetup_negedge$D$CKN = 0.094:0.094:0.094,
       thold_negedge$D$CKN = 0:0:0,
       tsetup_negedge$SE$CKN = 0.094:0.094:0.094,
       thold_negedge$SE$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_negedge$SI$CKN = 0.094:0.094:0.094,
       thold_negedge$SI$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$CKN = 0.094:0.094:0.094,
       thold_posedge$D$CKN = 0.094:0.094:0.094,
       tsetup_posedge$SE$CKN = 0.094:0.094:0.094,
       thold_posedge$SE$CKN = -0.00000000061:0.047:0.094,
       tsetup_posedge$SI$CKN = 0.094:0.094:0.094,
       thold_posedge$SI$CKN = 0.094:0.094:0.094,
       trec$RN$CKN = 0.094:0.094:0.094,
       trem$RN$CKN = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CKN = 0.094:0.094:0.094,
       trem$SN$CKN = 0.094:0.094:0.094;

     // path delays
     if (CKN == 1'b0)
       (CKN *> Q) = (tphlh$CKN$Q, tphhl$CKN$Q);
     if (CKN == 1'b0)
       (CKN *> QN) = (tphlh$CKN$QN, tphhl$CKN$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
     $setup(negedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CKN,  NOTIFIER);
     $setup(negedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CKN,  NOTIFIER);
     $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
     $setup(posedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CKN,  NOTIFIER);
     $setup(posedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CKN,  NOTIFIER);
     $recovery(posedge RN, negedge CKN &&& SN == 1'b1, trec$RN$CKN, NOTIFIER);
     $removal (posedge RN, negedge CKN &&& SN == 1'b1, trem$RN$CKN, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, negedge CKN &&& RN == 1'b1, trec$SN$CKN, NOTIFIER);
     $removal (posedge SN, negedge CKN &&& RN == 1'b1, trem$SN$CKN, NOTIFIER);
     $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
     $width(negedge CKN, tminpwl$CKN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFNSRX4 (CKN, D, Q, QN, RN, SE, SI, SN);
input  CKN ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0002, I0_D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0000, P0002);
   not (Q, P0000);
   buf (QN, P0000);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I13_out, SN);

   specify
     // delay parameters
     specparam
       tphlh$CKN$Q = 0.083:0.083:0.083,
       tphhl$CKN$Q = 0.077:0.077:0.077,
       tphlh$CKN$QN = 0.1:0.1:0.1,
       tphhl$CKN$QN = 0.11:0.11:0.11,
       tphhl$RN$Q = 0.091:0.092:0.094,
       tphlh$RN$QN = 0.12:0.12:0.12,
       tplhl$SN$Q = 0.078:0.079:0.08,
       tphlh$SN$Q = 0.075:0.078:0.081,
       tpllh$SN$QN = 0.1:0.11:0.11,
       tphhl$SN$QN = 0.1:0.1:0.11,
       tminpwh$CKN = 0.029:0.044:0.058,
       tminpwl$CKN = 0.04:0.074:0.11,
       tminpwl$RN = 0.032:0.077:0.12,
       tminpwl$SN = 0.018:0.062:0.11,
       tsetup_negedge$D$CKN = 0.094:0.094:0.094,
       thold_negedge$D$CKN = 0:0:0,
       tsetup_negedge$SE$CKN = 0.094:0.094:0.094,
       thold_negedge$SE$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_negedge$SI$CKN = 0.094:0.094:0.094,
       thold_negedge$SI$CKN = 0:0:0,
       tsetup_posedge$D$CKN = 0.094:0.094:0.094,
       thold_posedge$D$CKN = 0.094:0.094:0.094,
       tsetup_posedge$SE$CKN = 0.094:0.094:0.094,
       thold_posedge$SE$CKN = -0.00000000061:0.047:0.094,
       tsetup_posedge$SI$CKN = 0.094:0.094:0.094,
       thold_posedge$SI$CKN = 0.094:0.094:0.094,
       trec$RN$CKN = 0.094:0.094:0.094,
       trem$RN$CKN = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CKN = 0.094:0.094:0.094,
       trem$SN$CKN = 0.094:0.094:0.094;

     // path delays
     if (CKN == 1'b0)
       (CKN *> Q) = (tphlh$CKN$Q, tphhl$CKN$Q);
     if (CKN == 1'b0)
       (CKN *> QN) = (tphlh$CKN$QN, tphhl$CKN$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
     $setup(negedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CKN,  NOTIFIER);
     $setup(negedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CKN,  NOTIFIER);
     $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
     $setup(posedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CKN,  NOTIFIER);
     $setup(posedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CKN,  NOTIFIER);
     $recovery(posedge RN, negedge CKN &&& SN == 1'b1, trec$RN$CKN, NOTIFIER);
     $removal (posedge RN, negedge CKN &&& SN == 1'b1, trem$RN$CKN, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, negedge CKN &&& RN == 1'b1, trec$SN$CKN, NOTIFIER);
     $removal (posedge SN, negedge CKN &&& RN == 1'b1, trem$SN$CKN, NOTIFIER);
     $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
     $width(negedge CKN, tminpwl$CKN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFNSRXL (CKN, D, Q, QN, RN, SE, SI, SN);
input  CKN ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   buf (QN, P0002);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I13_out, SN);

   specify
     // delay parameters
     specparam
       tphlh$CKN$Q = 0.065:0.065:0.065,
       tphhl$CKN$Q = 0.06:0.06:0.06,
       tphlh$CKN$QN = 0.071:0.071:0.071,
       tphhl$CKN$QN = 0.074:0.074:0.074,
       tphhl$RN$Q = 0.072:0.074:0.076,
       tphlh$RN$QN = 0.083:0.086:0.088,
       tplhl$SN$Q = 0.058:0.06:0.062,
       tphlh$SN$Q = 0.057:0.059:0.061,
       tpllh$SN$QN = 0.069:0.071:0.073,
       tphhl$SN$QN = 0.066:0.068:0.069,
       tminpwh$CKN = 0.03:0.044:0.058,
       tminpwl$CKN = 0.032:0.053:0.074,
       tminpwl$RN = 0.032:0.06:0.088,
       tminpwl$SN = 0.018:0.044:0.069,
       tsetup_negedge$D$CKN = 0.094:0.094:0.094,
       thold_negedge$D$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_negedge$SE$CKN = 0.094:0.094:0.094,
       thold_negedge$SE$CKN = 0:0.00000000000000041:0.00000000000000083,
       tsetup_negedge$SI$CKN = 0.094:0.094:0.094,
       thold_negedge$SI$CKN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$CKN = 0.094:0.094:0.094,
       thold_posedge$D$CKN = 0.094:0.094:0.094,
       tsetup_posedge$SE$CKN = 0.094:0.094:0.094,
       thold_posedge$SE$CKN = -0.00000000061:0.047:0.094,
       tsetup_posedge$SI$CKN = 0.094:0.094:0.094,
       thold_posedge$SI$CKN = 0.094:0.094:0.094,
       trec$RN$CKN = 0.094:0.094:0.094,
       trem$RN$CKN = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CKN = 0.094:0.094:0.094,
       trem$SN$CKN = 0.094:0.094:0.094;

     // path delays
     if (CKN == 1'b0)
       (CKN *> Q) = (tphlh$CKN$Q, tphhl$CKN$Q);
     if (CKN == 1'b0)
       (CKN *> QN) = (tphlh$CKN$QN, tphhl$CKN$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
     $setup(negedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CKN,  NOTIFIER);
     $setup(negedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CKN,  NOTIFIER);
     $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
     $setup(posedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CKN,  NOTIFIER);
     $setup(posedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CKN, NOTIFIER);
     $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CKN,  NOTIFIER);
     $recovery(posedge RN, negedge CKN &&& SN == 1'b1, trec$RN$CKN, NOTIFIER);
     $removal (posedge RN, negedge CKN &&& SN == 1'b1, trem$RN$CKN, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, negedge CKN &&& RN == 1'b1, trec$SN$CKN, NOTIFIER);
     $removal (posedge SN, negedge CKN &&& RN == 1'b1, trem$SN$CKN, NOTIFIER);
     $width(posedge CKN, tminpwh$CKN, 0, NOTIFIER);
     $width(negedge CKN, tminpwl$CKN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFQX1 (CK, D, Q, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.056:0.056:0.056,
       tplhl$CK$Q = 0.064:0.064:0.064,
       tminpwh$CK = 0.032:0.048:0.064,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFQX2 (CK, D, Q, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (P0002, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.061:0.061:0.061,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tminpwh$CK = 0.035:0.051:0.068,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFQX4 (CK, D, Q, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.069:0.069:0.069,
       tplhl$CK$Q = 0.073:0.073:0.073,
       tminpwh$CK = 0.042:0.058:0.073,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFQXL (CK, D, Q, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.052:0.052:0.052,
       tplhl$CK$Q = 0.06:0.06:0.06,
       tminpwh$CK = 0.032:0.046:0.06,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFRHQX1 (CK, D, Q, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (P0003, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I7_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I7_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.067:0.067:0.067,
       tplhl$CK$Q = 0.07:0.07:0.07,
       tphhl$RN$Q = 0.025:0.025:0.025,
       tminpwh$CK = 0.037:0.053:0.07,
       tminpwl$CK = 0.048:0.057:0.067,
       tminpwl$RN = 0.02:0.035:0.051,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFRHQX2 (CK, D, Q, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (P0002, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I7_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I7_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.074:0.074:0.074,
       tplhl$CK$Q = 0.075:0.075:0.075,
       tphhl$RN$Q = 0.03:0.031:0.031,
       tminpwh$CK = 0.037:0.056:0.075,
       tminpwl$CK = 0.048:0.057:0.067,
       tminpwl$RN = 0.025:0.038:0.052,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFRHQX4 (CK, D, Q, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (P0002, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0003, P0002);
   not (Q, P0003);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I7_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I7_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.078:0.078:0.078,
       tplhl$CK$Q = 0.078:0.078:0.078,
       tphhl$RN$Q = 0.028:0.028:0.028,
       tminpwh$CK = 0.043:0.06:0.078,
       tminpwl$CK = 0.048:0.058:0.068,
       tminpwl$RN = 0.022:0.04:0.057,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFRHQX8 (CK, D, Q, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (P0000, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0001, P0000);
   not (Q, P0001);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I7_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I7_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.091:0.091:0.091,
       tplhl$CK$Q = 0.088:0.088:0.088,
       tphhl$RN$Q = 0.029:0.029:0.029,
       tminpwh$CK = 0.051:0.071:0.091,
       tminpwl$CK = 0.048:0.057:0.067,
       tminpwl$RN = 0.021:0.043:0.065,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFRX1 (CK, D, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (P0002, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);
   buf (QN, P0001);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I9_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.071:0.071:0.071,
       tplhl$CK$Q = 0.07:0.07:0.07,
       tpllh$CK$QN = 0.086:0.086:0.086,
       tplhl$CK$QN = 0.086:0.086:0.086,
       tphhl$RN$Q = 0.032:0.032:0.032,
       tphlh$RN$QN = 0.048:0.048:0.049,
       tminpwh$CK = 0.033:0.06:0.086,
       tminpwl$CK = 0.044:0.053:0.062,
       tminpwl$RN = 0.026:0.039:0.051,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFRX2 (CK, D, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (N30, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I9_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.075:0.075:0.075,
       tplhl$CK$Q = 0.072:0.072:0.072,
       tpllh$CK$QN = 0.097:0.097:0.097,
       tplhl$CK$QN = 0.1:0.1:0.1,
       tphhl$RN$Q = 0.031:0.032:0.032,
       tphlh$RN$QN = 0.057:0.057:0.058,
       tminpwh$CK = 0.035:0.068:0.1,
       tminpwl$CK = 0.044:0.053:0.062,
       tminpwl$RN = 0.026:0.042:0.058,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFRX4 (CK, D, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (P0001, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I9_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.082:0.082:0.082,
       tplhl$CK$Q = 0.077:0.077:0.077,
       tpllh$CK$QN = 0.11:0.11:0.11,
       tplhl$CK$QN = 0.11:0.11:0.11,
       tphhl$RN$Q = 0.03:0.03:0.03,
       tphlh$RN$QN = 0.058:0.058:0.058,
       tminpwh$CK = 0.041:0.075:0.11,
       tminpwl$CK = 0.044:0.053:0.062,
       tminpwl$RN = 0.024:0.042:0.059,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFRXL (CK, D, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (P0003, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   buf (QN, P0002);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I9_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.066:0.066:0.066,
       tplhl$CK$Q = 0.065:0.065:0.065,
       tpllh$CK$QN = 0.076:0.076:0.076,
       tplhl$CK$QN = 0.075:0.075:0.075,
       tphhl$RN$Q = 0.028:0.028:0.028,
       tphlh$RN$QN = 0.039:0.039:0.04,
       tminpwh$CK = 0.033:0.055:0.076,
       tminpwl$CK = 0.044:0.053:0.062,
       tminpwl$RN = 0.023:0.037:0.051,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.001:0.001:0.001,
       trem$RN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK, trem$RN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSRX1 (CK, D, Q, QN, RN, SE, SI, SN);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   buf (QN, P0002);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I12_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.063:0.063:0.063,
       tplhl$CK$Q = 0.072:0.072:0.072,
       tpllh$CK$QN = 0.088:0.088:0.088,
       tplhl$CK$QN = 0.077:0.077:0.077,
       tphhl$RN$Q = 0.076:0.079:0.081,
       tphlh$RN$QN = 0.093:0.095:0.097,
       tplhl$SN$Q = 0.062:0.064:0.066,
       tphlh$SN$Q = 0.061:0.063:0.064,
       tpllh$SN$QN = 0.078:0.081:0.083,
       tphhl$SN$QN = 0.075:0.077:0.078,
       tminpwh$CK = 0.034:0.061:0.088,
       tminpwl$CK = 0.043:0.056:0.069,
       tminpwl$RN = 0.032:0.064:0.097,
       tminpwl$SN = 0.018:0.048:0.078,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.095:0.095:0.095,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSHQX1 (CK, D, Q, SE, SI, SN);
input  CK ;
input  D ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0001, N35);
   not (Q, P0001);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I7_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I7_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.058:0.058:0.058,
       tplhl$CK$Q = 0.072:0.072:0.072,
       tphlh$SN$Q = 0.051:0.052:0.052,
       tminpwh$CK = 0.037:0.055:0.072,
       tminpwl$CK = 0.048:0.06:0.072,
       tminpwl$SN = 0.016:0.034:0.052,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (SN *> Q) = (tphlh$SN$Q, 0);
     $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSHQX2 (CK, D, Q, SE, SI, SN);
input  CK ;
input  D ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I7_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I7_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.063:0.063:0.063,
       tplhl$CK$Q = 0.078:0.078:0.078,
       tphlh$SN$Q = 0.056:0.057:0.057,
       tminpwh$CK = 0.037:0.058:0.078,
       tminpwl$CK = 0.048:0.06:0.072,
       tminpwl$SN = 0.016:0.037:0.057,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (SN *> Q) = (tphlh$SN$Q, 0);
     $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSHQX4 (CK, D, Q, SE, SI, SN);
input  CK ;
input  D ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I7_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I7_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.07:0.07:0.07,
       tplhl$CK$Q = 0.083:0.083:0.083,
       tphlh$SN$Q = 0.062:0.063:0.065,
       tminpwh$CK = 0.043:0.063:0.083,
       tminpwl$CK = 0.048:0.06:0.073,
       tminpwl$SN = 0.016:0.04:0.065,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (SN *> Q) = (tphlh$SN$Q, 0);
     $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSHQX8 (CK, D, Q, SE, SI, SN);
input  CK ;
input  D ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I7_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I7_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.082:0.082:0.082,
       tplhl$CK$Q = 0.096:0.096:0.096,
       tphlh$SN$Q = 0.074:0.078:0.082,
       tminpwh$CK = 0.052:0.074:0.096,
       tminpwl$CK = 0.048:0.06:0.072,
       tminpwl$SN = 0.016:0.049:0.082,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (SN *> Q) = (tphlh$SN$Q, 0);
     $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSRHQX1 (CK, D, Q, RN, SE, SI, SN);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I10_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.061:0.061:0.061,
       tplhl$CK$Q = 0.071:0.071:0.071,
       tphhl$RN$Q = 0.073:0.076:0.079,
       tplhl$SN$Q = 0.056:0.058:0.06,
       tphlh$SN$Q = 0.054:0.056:0.057,
       tminpwh$CK = 0.039:0.055:0.071,
       tminpwl$CK = 0.048:0.061:0.073,
       tminpwl$RN = 0.037:0.058:0.079,
       tminpwl$SN = 0.018:0.038:0.057,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSRHQX2 (CK, D, Q, RN, SE, SI, SN);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I10_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.067:0.067:0.067,
       tplhl$CK$Q = 0.078:0.078:0.078,
       tphhl$RN$Q = 0.08:0.083:0.085,
       tplhl$SN$Q = 0.062:0.064:0.066,
       tphlh$SN$Q = 0.06:0.062:0.063,
       tminpwh$CK = 0.039:0.058:0.078,
       tminpwl$CK = 0.048:0.061:0.073,
       tminpwl$RN = 0.037:0.061:0.085,
       tminpwl$SN = 0.018:0.04:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSRHQX4 (CK, D, Q, RN, SE, SI, SN);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I10_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.074:0.074:0.074,
       tplhl$CK$Q = 0.082:0.082:0.082,
       tphhl$RN$Q = 0.087:0.089:0.092,
       tplhl$SN$Q = 0.069:0.071:0.073,
       tphlh$SN$Q = 0.066:0.068:0.071,
       tminpwh$CK = 0.046:0.064:0.082,
       tminpwl$CK = 0.047:0.06:0.073,
       tminpwl$RN = 0.037:0.064:0.092,
       tminpwl$SN = 0.018:0.044:0.071,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSRHQX8 (CK, D, Q, RN, SE, SI, SN);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0002, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0003, P0002);
   not (Q, P0003);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I10_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.091:0.091:0.091,
       tplhl$CK$Q = 0.095:0.095:0.095,
       tphhl$RN$Q = 0.1:0.1:0.11,
       tplhl$SN$Q = 0.086:0.086:0.087,
       tphlh$SN$Q = 0.08:0.084:0.088,
       tminpwh$CK = 0.056:0.076:0.095,
       tminpwl$CK = 0.048:0.061:0.073,
       tminpwl$RN = 0.037:0.072:0.11,
       tminpwl$SN = 0.018:0.053:0.088,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     (RN *> Q) = (0, tphhl$RN$Q);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSRX2 (CK, D, Q, QN, RN, SE, SI, SN);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0000, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, P0000);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I12_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.069:0.069:0.069,
       tplhl$CK$Q = 0.075:0.075:0.075,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.093:0.093:0.093,
       tphhl$RN$Q = 0.08:0.083:0.085,
       tphlh$RN$QN = 0.11:0.11:0.11,
       tplhl$SN$Q = 0.066:0.068:0.07,
       tphlh$SN$Q = 0.066:0.067:0.069,
       tpllh$SN$QN = 0.092:0.094:0.096,
       tphhl$SN$QN = 0.089:0.091:0.092,
       tminpwh$CK = 0.037:0.069:0.1,
       tminpwl$CK = 0.044:0.056:0.069,
       tminpwl$RN = 0.032:0.071:0.11,
       tminpwl$SN = 0.018:0.055:0.092,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.095:0.095:0.095,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSRX4 (CK, D, Q, QN, RN, SE, SI, SN);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0002, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0000, P0002);
   not (Q, P0000);
   buf (QN, P0000);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I12_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.079:0.079:0.079,
       tplhl$CK$Q = 0.083:0.083:0.083,
       tpllh$CK$QN = 0.11:0.11:0.11,
       tplhl$CK$QN = 0.1:0.1:0.1,
       tphhl$RN$Q = 0.091:0.093:0.094,
       tphlh$RN$QN = 0.12:0.12:0.12,
       tplhl$SN$Q = 0.078:0.079:0.08,
       tphlh$SN$Q = 0.075:0.078:0.081,
       tpllh$SN$QN = 0.1:0.11:0.11,
       tphhl$SN$QN = 0.1:0.1:0.11,
       tminpwh$CK = 0.045:0.078:0.11,
       tminpwl$CK = 0.043:0.056:0.069,
       tminpwl$RN = 0.031:0.077:0.12,
       tminpwl$SN = 0.018:0.062:0.11,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.095:0.095:0.095,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSRXL (CK, D, Q, QN, RN, SE, SI, SN);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   buf (QN, P0002);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I12_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.059:0.059:0.059,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tpllh$CK$QN = 0.079:0.079:0.079,
       tplhl$CK$QN = 0.068:0.068:0.068,
       tphhl$RN$Q = 0.072:0.074:0.076,
       tphlh$RN$QN = 0.083:0.085:0.088,
       tplhl$SN$Q = 0.058:0.06:0.062,
       tphlh$SN$Q = 0.057:0.059:0.06,
       tpllh$SN$QN = 0.069:0.071:0.073,
       tphhl$SN$QN = 0.066:0.068:0.069,
       tminpwh$CK = 0.034:0.057:0.079,
       tminpwl$CK = 0.043:0.056:0.069,
       tminpwl$RN = 0.032:0.06:0.088,
       tminpwl$SN = 0.018:0.044:0.069,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$RN$CK = 0.095:0.095:0.095,
       trem$RN$CK = -0.001:-0.001:-0.001,
       trec$RN$SN = 0.094:0.094:0.094,
       trec$SN$CK = 0.095:0.095:0.095,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (RN *> Q) = (0, tphhl$RN$Q);
     (RN *> QN) = (tphlh$RN$QN, 0);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
     $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
     $recovery(posedge RN, posedge SN, trec$RN$SN, NOTIFIER);
     $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSX1 (CK, D, Q, QN, SE, SI, SN);
input  CK ;
input  D ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0002, N35);
   not (Q, P0002);
   buf (QN, P0002);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I9_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I9_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.06:0.06:0.06,
       tplhl$CK$Q = 0.072:0.072:0.072,
       tpllh$CK$QN = 0.089:0.089:0.089,
       tplhl$CK$QN = 0.074:0.074:0.074,
       tphlh$SN$Q = 0.058:0.058:0.059,
       tphhl$SN$QN = 0.072:0.072:0.072,
       tminpwh$CK = 0.033:0.061:0.089,
       tminpwl$CK = 0.044:0.056:0.068,
       tminpwl$SN = 0.016:0.044:0.072,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (SN *> Q) = (tphlh$SN$Q, 0);
     (SN *> QN) = (0, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSX2 (CK, D, Q, QN, SE, SI, SN);
input  CK ;
input  D ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (P0003, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   buf (QN, P0002);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I9_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I9_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.065:0.065:0.065,
       tplhl$CK$Q = 0.076:0.076:0.076,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.088:0.088:0.088,
       tphlh$SN$Q = 0.062:0.062:0.063,
       tphhl$SN$QN = 0.085:0.086:0.087,
       tminpwh$CK = 0.035:0.068:0.1,
       tminpwl$CK = 0.044:0.056:0.068,
       tminpwl$SN = 0.016:0.051:0.087,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (SN *> Q) = (tphlh$SN$Q, 0);
     (SN *> QN) = (0, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSX4 (CK, D, Q, QN, SE, SI, SN);
input  CK ;
input  D ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (P0002, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);
   buf (QN, P0001);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I9_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I9_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.073:0.073:0.073,
       tplhl$CK$Q = 0.084:0.084:0.084,
       tpllh$CK$QN = 0.11:0.11:0.11,
       tplhl$CK$QN = 0.099:0.099:0.099,
       tphlh$SN$Q = 0.07:0.073:0.076,
       tphhl$SN$QN = 0.096:0.099:0.1,
       tminpwh$CK = 0.042:0.077:0.11,
       tminpwl$CK = 0.044:0.056:0.068,
       tminpwl$SN = 0.016:0.059:0.1,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (SN *> Q) = (tphlh$SN$Q, 0);
     (SN *> QN) = (0, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFSXL (CK, D, Q, QN, SE, SI, SN);
input  CK ;
input  D ;
input  SE ;
input  SI ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (P0002, N35);
   not (Q, P0002);
   buf (QN, P0002);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I9_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I9_out, SN);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.057:0.057:0.057,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tpllh$CK$QN = 0.079:0.079:0.079,
       tplhl$CK$QN = 0.066:0.066:0.066,
       tphlh$SN$Q = 0.054:0.055:0.055,
       tphhl$SN$QN = 0.063:0.063:0.064,
       tminpwh$CK = 0.033:0.056:0.079,
       tminpwl$CK = 0.044:0.056:0.068,
       tminpwl$SN = 0.016:0.04:0.064,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001,
       trec$SN$CK = 0.001:0.001:0.001,
       trem$SN$CK = 0.093:0.093:0.093;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     (SN *> Q) = (tphlh$SN$Q, 0);
     (SN *> QN) = (0, tphhl$SN$QN);
     $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $recovery(posedge SN, posedge CK, trec$SN$CK, NOTIFIER);
     $removal (posedge SN, posedge CK, trem$SN$CK, NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFTRX1 (CK, D, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_out, D, RN);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   buf (QN, P0002);
   not (I8_out, SE);
   and (D_EQ_1_AN_SE_EQ_0, D, I8_out);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I10_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.06:0.06:0.06,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tpllh$CK$QN = 0.084:0.084:0.084,
       tplhl$CK$QN = 0.074:0.074:0.074,
       tminpwh$CK = 0.032:0.058:0.084,
       tminpwl$CK = 0.044:0.052:0.061,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFTRX2 (CK, D, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_out, D, RN);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (P0002, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);
   buf (QN, P0001);
   not (I8_out, SE);
   and (D_EQ_1_AN_SE_EQ_0, D, I8_out);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I10_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.064:0.064:0.064,
       tplhl$CK$Q = 0.071:0.071:0.071,
       tpllh$CK$QN = 0.096:0.096:0.096,
       tplhl$CK$QN = 0.087:0.087:0.087,
       tminpwh$CK = 0.035:0.065:0.096,
       tminpwl$CK = 0.044:0.053:0.061,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFTRX4 (CK, D, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_out, D, RN);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, N30);
   not (Q, P0000);
   buf (QN, P0000);
   not (I8_out, SE);
   and (D_EQ_1_AN_SE_EQ_0, D, I8_out);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I10_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.073:0.073:0.073,
       tplhl$CK$Q = 0.076:0.076:0.076,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.098:0.098:0.098,
       tminpwh$CK = 0.042:0.073:0.1,
       tminpwl$CK = 0.044:0.052:0.061,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFTRXL (CK, D, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_out, D, RN);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (P0002, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);
   buf (QN, P0001);
   not (I8_out, SE);
   and (D_EQ_1_AN_SE_EQ_0, D, I8_out);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I10_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.056:0.056:0.056,
       tplhl$CK$Q = 0.064:0.064:0.064,
       tpllh$CK$QN = 0.075:0.075:0.075,
       tplhl$CK$QN = 0.065:0.065:0.065,
       tminpwh$CK = 0.032:0.054:0.075,
       tminpwl$CK = 0.044:0.053:0.061,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFX1 (CK, D, Q, QN, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (P0002, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);
   buf (QN, P0001);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.06:0.06:0.06,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tpllh$CK$QN = 0.084:0.084:0.084,
       tplhl$CK$QN = 0.074:0.074:0.074,
       tminpwh$CK = 0.032:0.058:0.084,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFX2 (CK, D, Q, QN, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (P0000, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   not (Q, P0001);
   buf (QN, P0001);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.064:0.064:0.064,
       tplhl$CK$Q = 0.071:0.071:0.071,
       tpllh$CK$QN = 0.096:0.096:0.096,
       tplhl$CK$QN = 0.088:0.088:0.088,
       tminpwh$CK = 0.035:0.065:0.096,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFX4 (CK, D, Q, QN, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, N30);
   not (Q, P0000);
   buf (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.073:0.073:0.073,
       tplhl$CK$Q = 0.076:0.076:0.076,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.098:0.098:0.098,
       tminpwh$CK = 0.042:0.073:0.1,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SDFFXL (CK, D, Q, QN, SE, SI);
input  CK ;
input  D ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   buf (QN, P0002);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.057:0.057:0.057,
       tplhl$CK$Q = 0.064:0.064:0.064,
       tpllh$CK$QN = 0.075:0.075:0.075,
       tplhl$CK$QN = 0.065:0.065:0.065,
       tminpwh$CK = 0.032:0.054:0.075,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFHQX1 (CK, D, E, Q, SE, SI);
input  CK ;
input  D ;
input  E ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   not (I7_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I7_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.062:0.062:0.062,
       tplhl$CK$Q = 0.073:0.073:0.073,
       tminpwh$CK = 0.037:0.055:0.073,
       tminpwl$CK = 0.048:0.057:0.067,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFHQX2 (CK, D, E, Q, SE, SI);
input  CK ;
input  D ;
input  E ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   not (I7_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I7_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.066:0.066:0.066,
       tplhl$CK$Q = 0.076:0.076:0.076,
       tminpwh$CK = 0.038:0.057:0.076,
       tminpwl$CK = 0.048:0.057:0.067,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFHQX4 (CK, D, E, Q, SE, SI);
input  CK ;
input  D ;
input  E ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   not (I7_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I7_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.073:0.073:0.073,
       tplhl$CK$Q = 0.08:0.08:0.08,
       tminpwh$CK = 0.044:0.062:0.08,
       tminpwl$CK = 0.048:0.058:0.067,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFHQX8 (CK, D, E, Q, SE, SI);
input  CK ;
input  D ;
input  E ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   not (I0_out, P0001);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0003);
   not (Q, P0001);
   not (I7_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I7_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.086:0.086:0.086,
       tplhl$CK$Q = 0.092:0.092:0.092,
       tminpwh$CK = 0.053:0.072:0.092,
       tminpwl$CK = 0.048:0.058:0.068,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFTRX1 (CK, D, E, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  E ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, P0000);
   not (I5_out, I4_out);
   and (I7_out, I2_out, I5_out, RN);
   udp_mux2 (I0_D, I7_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, N30);
   not (Q, P0000);
   buf (QN, P0000);
   not (I15_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I15_out);
   not (I18_out, SE);
   and (E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0, E, RN, I18_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.063:0.063:0.063,
       tplhl$CK$Q = 0.071:0.071:0.071,
       tpllh$CK$QN = 0.087:0.087:0.087,
       tplhl$CK$QN = 0.077:0.077:0.077,
       tminpwh$CK = 0.033:0.06:0.087,
       tminpwl$CK = 0.044:0.053:0.062,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& SE == 1'b0, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& SE == 1'b0, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFTRX2 (CK, D, E, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  E ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, P0000);
   not (I5_out, I4_out);
   and (I7_out, I2_out, I5_out, RN);
   udp_mux2 (I0_D, I7_out, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0003);
   not (Q, P0000);
   buf (QN, P0000);
   not (I15_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I15_out);
   not (I18_out, SE);
   and (E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0, E, RN, I18_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.066:0.066:0.066,
       tplhl$CK$Q = 0.072:0.072:0.072,
       tpllh$CK$QN = 0.098:0.098:0.098,
       tplhl$CK$QN = 0.09:0.09:0.09,
       tminpwh$CK = 0.035:0.066:0.098,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& SE == 1'b0, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& SE == 1'b0, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFTRX4 (CK, D, E, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  E ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, P0000);
   not (I5_out, I4_out);
   and (I7_out, I2_out, I5_out, RN);
   udp_mux2 (I0_D, I7_out, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0003);
   not (Q, P0000);
   buf (QN, P0000);
   not (I15_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I15_out);
   not (I18_out, SE);
   and (E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0, E, RN, I18_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.074:0.074:0.074,
       tplhl$CK$Q = 0.077:0.077:0.077,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.099:0.099:0.099,
       tminpwh$CK = 0.042:0.073:0.1,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& SE == 1'b0, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& SE == 1'b0, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFTRXL (CK, D, E, Q, QN, RN, SE, SI);
input  CK ;
input  D ;
input  E ;
input  RN ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, P0000);
   not (I5_out, I4_out);
   and (I7_out, I2_out, I5_out, RN);
   udp_mux2 (I0_D, I7_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, N30);
   not (Q, P0000);
   buf (QN, P0000);
   not (I15_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I15_out);
   not (I18_out, SE);
   and (E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0, E, RN, I18_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.06:0.06:0.06,
       tplhl$CK$Q = 0.067:0.067:0.067,
       tpllh$CK$QN = 0.078:0.078:0.078,
       tplhl$CK$QN = 0.069:0.069:0.069,
       tminpwh$CK = 0.033:0.055:0.078,
       tminpwl$CK = 0.044:0.053:0.062,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$RN$CK = 0.095:0.095:0.095,
       thold_negedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$RN$CK = 0.095:0.095:0.095,
       thold_posedge$RN$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge RN, posedge CK &&& SE == 1'b0, tsetup_negedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge RN, posedge CK &&& SE == 1'b0, tsetup_posedge$RN$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFX1 (CK, D, E, Q, QN, SE, SI);
input  CK ;
input  D ;
input  E ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);
   not (I9_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.06:0.06:0.06,
       tplhl$CK$Q = 0.068:0.068:0.068,
       tpllh$CK$QN = 0.089:0.089:0.089,
       tplhl$CK$QN = 0.078:0.078:0.078,
       tminpwh$CK = 0.032:0.061:0.089,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFX2 (CK, D, E, Q, QN, SE, SI);
input  CK ;
input  D ;
input  E ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, P0002);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   buf (QN, P0002);
   not (I9_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.065:0.065:0.065,
       tplhl$CK$Q = 0.071:0.071:0.071,
       tpllh$CK$QN = 0.1:0.1:0.1,
       tplhl$CK$QN = 0.093:0.093:0.093,
       tminpwh$CK = 0.036:0.068:0.1,
       tminpwl$CK = 0.044:0.053:0.062,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFX4 (CK, D, E, Q, QN, SE, SI);
input  CK ;
input  D ;
input  E ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, P0003);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0003, P0001);
   not (Q, P0003);
   buf (QN, P0003);
   not (I9_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.073:0.073:0.073,
       tplhl$CK$Q = 0.076:0.076:0.076,
       tpllh$CK$QN = 0.11:0.11:0.11,
       tplhl$CK$QN = 0.1:0.1:0.1,
       tminpwh$CK = 0.042:0.074:0.11,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SEDFFXL (CK, D, E, Q, QN, SE, SI);
input  CK ;
input  D ;
input  E ;
input  SE ;
input  SI ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, P0000);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (P0001, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   not (Q, P0000);
   buf (QN, P0000);
   not (I9_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.057:0.057:0.057,
       tplhl$CK$Q = 0.064:0.064:0.064,
       tpllh$CK$QN = 0.08:0.08:0.08,
       tplhl$CK$QN = 0.07:0.07:0.07,
       tminpwh$CK = 0.032:0.056:0.08,
       tminpwl$CK = 0.044:0.053:0.063,
       tsetup_negedge$D$CK = 0.095:0.095:0.095,
       thold_negedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D$CK = 0.095:0.095:0.095,
       thold_posedge$D$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     if (CK == 1'b1)
       (CK *> QN) = (tpllh$CK$QN, tplhl$CK$QN);
     $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
     $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SMDFFHQX1 (CK, D0, D1, Q, S0, SE, SI);
input  CK ;
input  D0 ;
input  D1 ;
input  S0 ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_out, D0, D1, S0);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (P0002, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);
   not (I6_out, SE);
   and (S0_EQ_1_AN_SE_EQ_0, S0, I6_out);
   not (I8_out, S0);
   not (I9_out, SE);
   and (S0_EQ_0_AN_SE_EQ_0, I8_out, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.059:0.059:0.059,
       tplhl$CK$Q = 0.069:0.069:0.069,
       tminpwh$CK = 0.037:0.053:0.069,
       tminpwl$CK = 0.048:0.059:0.069,
       tsetup_negedge$D0$CK = 0.095:0.095:0.095,
       thold_negedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$D1$CK = 0.095:0.095:0.095,
       thold_negedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$S0$CK = 0.095:0.095:0.095,
       thold_negedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D0$CK = 0.095:0.095:0.095,
       thold_posedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D1$CK = 0.095:0.095:0.095,
       thold_posedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$S0$CK = 0.095:0.095:0.095,
       thold_posedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
     $setup(negedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
     $setup(negedge S0, posedge CK &&& SE == 1'b0, tsetup_negedge$S0$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
     $setup(posedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
     $setup(posedge S0, posedge CK &&& SE == 1'b0, tsetup_posedge$S0$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SMDFFHQX2 (CK, D0, D1, Q, S0, SE, SI);
input  CK ;
input  D0 ;
input  D1 ;
input  S0 ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_out, D0, D1, S0);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, N30);
   not (Q, P0001);
   not (I6_out, SE);
   and (S0_EQ_1_AN_SE_EQ_0, S0, I6_out);
   not (I8_out, S0);
   not (I9_out, SE);
   and (S0_EQ_0_AN_SE_EQ_0, I8_out, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.063:0.063:0.063,
       tplhl$CK$Q = 0.073:0.073:0.073,
       tminpwh$CK = 0.039:0.056:0.073,
       tminpwl$CK = 0.048:0.059:0.07,
       tsetup_negedge$D0$CK = 0.095:0.095:0.095,
       thold_negedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$D1$CK = 0.095:0.095:0.095,
       thold_negedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$S0$CK = 0.095:0.095:0.095,
       thold_negedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D0$CK = 0.095:0.095:0.095,
       thold_posedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D1$CK = 0.095:0.095:0.095,
       thold_posedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$S0$CK = 0.095:0.095:0.095,
       thold_posedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
     $setup(negedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
     $setup(negedge S0, posedge CK &&& SE == 1'b0, tsetup_negedge$S0$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
     $setup(posedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
     $setup(posedge S0, posedge CK &&& SE == 1'b0, tsetup_posedge$S0$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SMDFFHQX4 (CK, D0, D1, Q, S0, SE, SI);
input  CK ;
input  D0 ;
input  D1 ;
input  S0 ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_out, D0, D1, S0);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (P0002, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0002);
   not (Q, P0001);
   not (I6_out, SE);
   and (S0_EQ_1_AN_SE_EQ_0, S0, I6_out);
   not (I8_out, S0);
   not (I9_out, SE);
   and (S0_EQ_0_AN_SE_EQ_0, I8_out, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.07:0.07:0.07,
       tplhl$CK$Q = 0.077:0.077:0.077,
       tminpwh$CK = 0.043:0.06:0.077,
       tminpwl$CK = 0.048:0.059:0.069,
       tsetup_negedge$D0$CK = 0.095:0.095:0.095,
       thold_negedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$D1$CK = 0.095:0.095:0.095,
       thold_negedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$S0$CK = 0.095:0.095:0.095,
       thold_negedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D0$CK = 0.095:0.095:0.095,
       thold_posedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D1$CK = 0.095:0.095:0.095,
       thold_posedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$S0$CK = 0.095:0.095:0.095,
       thold_posedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
     $setup(negedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
     $setup(negedge S0, posedge CK &&& SE == 1'b0, tsetup_negedge$S0$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
     $setup(posedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
     $setup(posedge S0, posedge CK &&& SE == 1'b0, tsetup_posedge$S0$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module SMDFFHQX8 (CK, D0, D1, Q, S0, SE, SI);
input  CK ;
input  D0 ;
input  D1 ;
input  S0 ;
input  SE ;
input  SI ;
output Q ;
reg NOTIFIER ;

   udp_mux2 (I0_out, D0, D1, S0);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (P0003, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (P0002, P0003);
   not (Q, P0002);
   not (I6_out, SE);
   and (S0_EQ_1_AN_SE_EQ_0, S0, I6_out);
   not (I8_out, S0);
   not (I9_out, SE);
   and (S0_EQ_0_AN_SE_EQ_0, I8_out, I9_out);

   specify
     // delay parameters
     specparam
       tpllh$CK$Q = 0.082:0.082:0.082,
       tplhl$CK$Q = 0.088:0.088:0.088,
       tminpwh$CK = 0.053:0.07:0.088,
       tminpwl$CK = 0.048:0.059:0.07,
       tsetup_negedge$D0$CK = 0.095:0.095:0.095,
       thold_negedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$D1$CK = 0.095:0.095:0.095,
       thold_negedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$S0$CK = 0.095:0.095:0.095,
       thold_negedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SI$CK = 0.095:0.095:0.095,
       thold_negedge$SI$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D0$CK = 0.095:0.095:0.095,
       thold_posedge$D0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$D1$CK = 0.095:0.095:0.095,
       thold_posedge$D1$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$S0$CK = 0.095:0.095:0.095,
       thold_posedge$S0$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SI$CK = 0.095:0.095:0.095,
       thold_posedge$SI$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b1)
       (CK *> Q) = (tpllh$CK$Q, tplhl$CK$Q);
     $setup(negedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
     $setup(negedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
     $setup(negedge S0, posedge CK &&& SE == 1'b0, tsetup_negedge$S0$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
     $setup(posedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D0$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
     $setup(posedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
     $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
     $setup(posedge S0, posedge CK &&& SE == 1'b0, tsetup_posedge$S0$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
     $width(posedge CK, tminpwh$CK, 0, NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFX1 (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.02:0.02:0.02,
       tphhl$A$Y = 0.023:0.023:0.023,
       tpzh$OE$Y = 0.019:0.019:0.019,
       tpzl$OE$Y = 0.024:0.024:0.024,
       tplz$OE$Y = 0.023:0.023:0.023,
       tphz$OE$Y = 0.021:0.021:0.021;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFX12 (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.03:0.03:0.03,
       tpzh$OE$Y = 0.025:0.025:0.025,
       tpzl$OE$Y = 0.037:0.037:0.037,
       tplz$OE$Y = 0.041:0.041:0.041,
       tphz$OE$Y = 0.032:0.032:0.032;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFX16 (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.047:0.047:0.047,
       tphhl$A$Y = 0.051:0.051:0.051,
       tpzh$OE$Y = 0.048:0.048:0.048,
       tpzl$OE$Y = 0.062:0.062:0.062,
       tplz$OE$Y = 0.064:0.064:0.064,
       tphz$OE$Y = 0.047:0.047:0.047;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFX2 (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.024:0.024:0.024,
       tphhl$A$Y = 0.027:0.027:0.027,
       tpzh$OE$Y = 0.023:0.023:0.023,
       tpzl$OE$Y = 0.027:0.027:0.027,
       tplz$OE$Y = 0.027:0.027:0.027,
       tphz$OE$Y = 0.03:0.03:0.03;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFX20 (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.028:0.028:0.028,
       tphhl$A$Y = 0.031:0.031:0.031,
       tpzh$OE$Y = 0.027:0.027:0.027,
       tpzl$OE$Y = 0.037:0.037:0.037,
       tplz$OE$Y = 0.044:0.044:0.044,
       tphz$OE$Y = 0.033:0.033:0.033;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFX3 (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.023:0.023:0.023,
       tphhl$A$Y = 0.026:0.026:0.026,
       tpzh$OE$Y = 0.022:0.022:0.022,
       tpzl$OE$Y = 0.03:0.03:0.03,
       tplz$OE$Y = 0.031:0.031:0.031,
       tphz$OE$Y = 0.027:0.027:0.027;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFX4 (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.025:0.025:0.025,
       tphhl$A$Y = 0.028:0.028:0.028,
       tpzh$OE$Y = 0.024:0.024:0.024,
       tpzl$OE$Y = 0.032:0.032:0.032,
       tplz$OE$Y = 0.033:0.033:0.033,
       tphz$OE$Y = 0.031:0.031:0.031;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFX6 (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.023:0.023:0.023,
       tphhl$A$Y = 0.026:0.026:0.026,
       tpzh$OE$Y = 0.022:0.022:0.022,
       tpzl$OE$Y = 0.036:0.036:0.036,
       tplz$OE$Y = 0.041:0.041:0.041,
       tphz$OE$Y = 0.027:0.027:0.027;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFX8 (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.026:0.026:0.026,
       tphhl$A$Y = 0.029:0.029:0.029,
       tpzh$OE$Y = 0.025:0.025:0.025,
       tpzl$OE$Y = 0.038:0.038:0.038,
       tplz$OE$Y = 0.043:0.043:0.043,
       tphz$OE$Y = 0.032:0.032:0.032;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TBUFXL (A, OE, Y);
input  A ;
input  OE ;
output Y ;

   bufif1 (Y, A, OE);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.017:0.017:0.017,
       tphhl$A$Y = 0.02:0.02:0.02,
       tpzh$OE$Y = 0.016:0.016:0.016,
       tpzl$OE$Y = 0.021:0.021:0.021,
       tplz$OE$Y = 0.021:0.021:0.021,
       tphz$OE$Y = 0.017:0.017:0.017;

     // path delays
     (A *> Y) = (tpllh$A$Y, tphhl$A$Y);
     (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TIEHI (Y);
output Y ;

   buf (Y, 'B1);


endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TIELO (Y);
output Y ;

   buf (Y, 'B0);


endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNCAX12 (CK, E, ECK);
input  CK ;
input  E ;
output ECK ;
reg NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (P0000, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.11:0.11:0.11,
       tphhl$CK$ECK = 0.1:0.1:0.1,
       tminpwl$CK = 0.082:0.092:0.1,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNCAX16 (CK, E, ECK);
input  CK ;
input  E ;
output ECK ;
reg NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (P0000, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.12:0.12:0.12,
       tphhl$CK$ECK = 0.11:0.11:0.11,
       tminpwl$CK = 0.098:0.11:0.11,
       tsetup_negedge$E$CK = 0.059:0.059:0.059,
       thold_negedge$E$CK = 0.035:0.035:0.035,
       tsetup_posedge$E$CK = 0.059:0.059:0.059,
       thold_posedge$E$CK = 0.035:0.035:0.035;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNCAX2 (CK, E, ECK);
input  CK ;
input  E ;
output ECK ;
reg NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (P0000, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.16:0.16:0.16,
       tphhl$CK$ECK = 0.13:0.13:0.13,
       tminpwl$CK = 0.056:0.094:0.13,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNCAX20 (CK, E, ECK);
input  CK ;
input  E ;
output ECK ;
reg NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (P0000, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.13:0.13:0.13,
       tphhl$CK$ECK = 0.11:0.11:0.11,
       tminpwl$CK = 0.11:0.12:0.13,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNCAX3 (CK, E, ECK);
input  CK ;
input  E ;
output ECK ;
reg NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (P0000, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.13:0.13:0.13,
       tphhl$CK$ECK = 0.11:0.11:0.11,
       tminpwl$CK = 0.06:0.086:0.11,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNCAX4 (CK, E, ECK);
input  CK ;
input  E ;
output ECK ;
reg NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (P0000, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.12:0.12:0.12,
       tphhl$CK$ECK = 0.11:0.11:0.11,
       tminpwl$CK = 0.06:0.083:0.11,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNCAX6 (CK, E, ECK);
input  CK ;
input  E ;
output ECK ;
reg NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (P0000, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.11:0.11:0.11,
       tphhl$CK$ECK = 0.099:0.099:0.099,
       tminpwl$CK = 0.071:0.085:0.099,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNCAX8 (CK, E, ECK);
input  CK ;
input  E ;
output ECK ;
reg NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (P0000, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.11:0.11:0.11,
       tphhl$CK$ECK = 0.099:0.1:0.1,
       tminpwl$CK = 0.071:0.086:0.1,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNSRX1 (D, GN, Q, QN, RN, SN);
input  D ;
input  GN ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, GN);
   and (I0_ENABLE, I0_out, RN);
   not (I0_SET, SN);
   udp_tlat (P0001, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (P0000, P0001);
   buf (Q, P0001);
   not (QN, P0001);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.062:0.062:0.062,
       tphhl$D$Q = 0.077:0.077:0.077,
       tplhl$D$QN = 0.049:0.049:0.049,
       tphlh$D$QN = 0.067:0.067:0.067,
       tphlh$GN$Q = 0.097:0.097:0.097,
       tphhl$GN$Q = 0.097:0.097:0.097,
       tphlh$GN$QN = 0.087:0.087:0.087,
       tphhl$GN$QN = 0.084:0.084:0.084,
       tpllh$RN$Q = 0.087:0.087:0.087,
       tphhl$RN$Q = 0.083:0.083:0.083,
       tplhl$RN$QN = 0.074:0.074:0.074,
       tphlh$RN$QN = 0.073:0.073:0.073,
       tplhl$SN$Q = 0.049:0.049:0.049,
       tphlh$SN$Q = 0.047:0.048:0.048,
       tpllh$SN$QN = 0.039:0.039:0.039,
       tphhl$SN$QN = 0.034:0.035:0.035,
       tminpwl$GN = 0.044:0.071:0.097,
       tminpwl$RN = 0.029:0.056:0.083,
       tminpwl$SN = 0.029:0.043:0.057,
       tsetup_negedge$D$GN = 0.094:0.094:0.094,
       thold_negedge$D$GN = 0.00000000061:0.00000000061:0.00000000061,
       tsetup_posedge$D$GN = 0.094:0.094:0.094,
       thold_posedge$D$GN = 0:0:0,
       tsetup_posedge$RN$GN = 0.094:0.094:0.094,
       thold_posedge$RN$GN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       trec$SN$GN = 0.094:0.094:0.094,
       trem$SN$GN = 0.094:0.094:0.094,
       trec$SN$RN = 0.094:0.094:0.094,
       trem$SN$RN = 0.00000000000000083:0.00000000000000083:0.00000000000000083;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (GN == 1'b0)
       (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
     if (GN == 1'b0)
       (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
     if (RN == 1'b0)
       (RN *> Q) = (0, tphhl$RN$Q);
     if (RN == 1'b1)
       (RN *> Q) = (tpllh$RN$Q, 0);
     if (RN == 1'b0)
       (RN *> QN) = (tphlh$RN$QN, 0);
     if (RN == 1'b1)
       (RN *> QN) = (0, tplhl$RN$QN);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$GN, NOTIFIER);
     $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$GN,  NOTIFIER);
     $setup(posedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$GN, NOTIFIER);
     $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$GN,  NOTIFIER);
     $setup(posedge RN, posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$GN, NOTIFIER);
     $hold (posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$GN,  NOTIFIER);
     $recovery(posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$GN, NOTIFIER);
     $removal (posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$GN, NOTIFIER);
     $recovery(posedge SN, posedge RN &&& GN == 1'b1, trec$SN$RN, NOTIFIER);
     $removal (posedge SN, posedge RN &&& GN == 1'b1, trem$SN$RN, NOTIFIER);
     $width(negedge GN, tminpwl$GN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNSRX2 (D, GN, Q, QN, RN, SN);
input  D ;
input  GN ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, GN);
   and (I0_ENABLE, I0_out, RN);
   not (I0_SET, SN);
   udp_tlat (P0001, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (P0000, P0001);
   buf (Q, P0001);
   not (QN, P0001);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.071:0.071:0.071,
       tphhl$D$Q = 0.09:0.09:0.09,
       tplhl$D$QN = 0.058:0.058:0.058,
       tphlh$D$QN = 0.079:0.079:0.079,
       tphlh$GN$Q = 0.11:0.11:0.11,
       tphhl$GN$Q = 0.11:0.11:0.11,
       tphlh$GN$QN = 0.099:0.099:0.099,
       tphhl$GN$QN = 0.092:0.092:0.092,
       tpllh$RN$Q = 0.095:0.095:0.095,
       tphhl$RN$Q = 0.095:0.095:0.095,
       tplhl$RN$QN = 0.082:0.082:0.082,
       tphlh$RN$QN = 0.084:0.084:0.084,
       tplhl$SN$Q = 0.058:0.058:0.058,
       tphlh$SN$Q = 0.053:0.053:0.054,
       tpllh$SN$QN = 0.047:0.047:0.047,
       tphhl$SN$QN = 0.039:0.039:0.04,
       tminpwl$GN = 0.048:0.079:0.11,
       tminpwl$RN = 0.033:0.064:0.095,
       tminpwl$SN = 0.034:0.05:0.066,
       tsetup_negedge$D$GN = 0.094:0.094:0.094,
       thold_negedge$D$GN = 0.00000000061:0.00000000061:0.00000000061,
       tsetup_posedge$D$GN = 0.094:0.094:0.094,
       thold_posedge$D$GN = 0:0:0,
       tsetup_posedge$RN$GN = 0.094:0.094:0.094,
       thold_posedge$RN$GN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       trec$SN$GN = 0.094:0.094:0.094,
       trem$SN$GN = 0.094:0.094:0.094,
       trec$SN$RN = 0.094:0.094:0.094,
       trem$SN$RN = 0.00000000000000083:0.00000000000000083:0.00000000000000083;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (GN == 1'b0)
       (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
     if (GN == 1'b0)
       (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
     if (RN == 1'b0)
       (RN *> Q) = (0, tphhl$RN$Q);
     if (RN == 1'b1)
       (RN *> Q) = (tpllh$RN$Q, 0);
     if (RN == 1'b0)
       (RN *> QN) = (tphlh$RN$QN, 0);
     if (RN == 1'b1)
       (RN *> QN) = (0, tplhl$RN$QN);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$GN, NOTIFIER);
     $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$GN,  NOTIFIER);
     $setup(posedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$GN, NOTIFIER);
     $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$GN,  NOTIFIER);
     $setup(posedge RN, posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$GN, NOTIFIER);
     $hold (posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$GN,  NOTIFIER);
     $recovery(posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$GN, NOTIFIER);
     $removal (posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$GN, NOTIFIER);
     $recovery(posedge SN, posedge RN &&& GN == 1'b1, trec$SN$RN, NOTIFIER);
     $removal (posedge SN, posedge RN &&& GN == 1'b1, trem$SN$RN, NOTIFIER);
     $width(negedge GN, tminpwl$GN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNSRX4 (D, GN, Q, QN, RN, SN);
input  D ;
input  GN ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, GN);
   and (I0_ENABLE, I0_out, RN);
   not (I0_SET, SN);
   udp_tlat (P0000, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (P0001, P0000);
   buf (Q, P0000);
   not (QN, P0000);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.08:0.08:0.08,
       tphhl$D$Q = 0.1:0.1:0.1,
       tplhl$D$QN = 0.065:0.065:0.065,
       tphlh$D$QN = 0.089:0.089:0.089,
       tphlh$GN$Q = 0.11:0.11:0.11,
       tphhl$GN$Q = 0.12:0.12:0.12,
       tphlh$GN$QN = 0.11:0.11:0.11,
       tphhl$GN$QN = 0.099:0.099:0.099,
       tpllh$RN$Q = 0.1:0.1:0.1,
       tphhl$RN$Q = 0.11:0.11:0.11,
       tplhl$RN$QN = 0.089:0.089:0.089,
       tphlh$RN$QN = 0.095:0.095:0.095,
       tplhl$SN$Q = 0.059:0.059:0.059,
       tphlh$SN$Q = 0.053:0.053:0.054,
       tpllh$SN$QN = 0.047:0.047:0.047,
       tphhl$SN$QN = 0.037:0.038:0.038,
       tminpwl$GN = 0.057:0.09:0.12,
       tminpwl$RN = 0.043:0.076:0.11,
       tminpwl$SN = 0.034:0.055:0.075,
       tsetup_negedge$D$GN = 0.094:0.094:0.094,
       thold_negedge$D$GN = 0.00000000061:0.00000000061:0.00000000061,
       tsetup_posedge$D$GN = 0.094:0.094:0.094,
       thold_posedge$D$GN = 0:0:0,
       tsetup_posedge$RN$GN = 0.094:0.094:0.094,
       thold_posedge$RN$GN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       trec$SN$GN = 0.094:0.094:0.094,
       trem$SN$GN = 0.094:0.094:0.094,
       trec$SN$RN = 0.094:0.094:0.094,
       trem$SN$RN = 0.00000000000000083:0.00000000000000083:0.00000000000000083;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (GN == 1'b0)
       (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
     if (GN == 1'b0)
       (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
     if (RN == 1'b0)
       (RN *> Q) = (0, tphhl$RN$Q);
     if (RN == 1'b1)
       (RN *> Q) = (tpllh$RN$Q, 0);
     if (RN == 1'b0)
       (RN *> QN) = (tphlh$RN$QN, 0);
     if (RN == 1'b1)
       (RN *> QN) = (0, tplhl$RN$QN);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$GN, NOTIFIER);
     $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$GN,  NOTIFIER);
     $setup(posedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$GN, NOTIFIER);
     $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$GN,  NOTIFIER);
     $setup(posedge RN, posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$GN, NOTIFIER);
     $hold (posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$GN,  NOTIFIER);
     $recovery(posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$GN, NOTIFIER);
     $removal (posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$GN, NOTIFIER);
     $recovery(posedge SN, posedge RN &&& GN == 1'b1, trec$SN$RN, NOTIFIER);
     $removal (posedge SN, posedge RN &&& GN == 1'b1, trem$SN$RN, NOTIFIER);
     $width(negedge GN, tminpwl$GN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNSRXL (D, GN, Q, QN, RN, SN);
input  D ;
input  GN ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_out, GN);
   and (I0_ENABLE, I0_out, RN);
   not (I0_SET, SN);
   udp_tlat (P0001, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (P0000, P0001);
   buf (Q, P0001);
   not (QN, P0001);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.053:0.053:0.053,
       tphhl$D$Q = 0.066:0.066:0.066,
       tplhl$D$QN = 0.041:0.041:0.041,
       tphlh$D$QN = 0.057:0.057:0.057,
       tphlh$GN$Q = 0.087:0.087:0.087,
       tphhl$GN$Q = 0.087:0.087:0.087,
       tphlh$GN$QN = 0.077:0.077:0.077,
       tphhl$GN$QN = 0.076:0.076:0.076,
       tpllh$RN$Q = 0.077:0.077:0.077,
       tphhl$RN$Q = 0.073:0.073:0.073,
       tplhl$RN$QN = 0.066:0.066:0.066,
       tphlh$RN$QN = 0.063:0.063:0.063,
       tplhl$SN$Q = 0.039:0.039:0.039,
       tphlh$SN$Q = 0.038:0.038:0.039,
       tpllh$SN$QN = 0.03:0.03:0.03,
       tphhl$SN$QN = 0.027:0.027:0.028,
       tminpwl$GN = 0.044:0.066:0.087,
       tminpwl$RN = 0.03:0.051:0.073,
       tminpwl$SN = 0.022:0.035:0.048,
       tsetup_negedge$D$GN = 0.094:0.094:0.094,
       thold_negedge$D$GN = 0.00000000061:0.00000000061:0.00000000061,
       tsetup_posedge$D$GN = 0.094:0.094:0.094,
       thold_posedge$D$GN = 0.094:0.094:0.094,
       tsetup_posedge$RN$GN = 0.094:0.094:0.094,
       thold_posedge$RN$GN = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       trec$SN$GN = 0:0:0,
       trem$SN$GN = 0.094:0.094:0.094,
       trec$SN$RN = 0.094:0.094:0.094,
       trem$SN$RN = 0.00000000000000083:0.00000000000000083:0.00000000000000083;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (GN == 1'b0)
       (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
     if (GN == 1'b0)
       (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
     if (RN == 1'b0)
       (RN *> Q) = (0, tphhl$RN$Q);
     if (RN == 1'b1)
       (RN *> Q) = (tpllh$RN$Q, 0);
     if (RN == 1'b0)
       (RN *> QN) = (tphlh$RN$QN, 0);
     if (RN == 1'b1)
       (RN *> QN) = (0, tplhl$RN$QN);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$GN, NOTIFIER);
     $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$GN,  NOTIFIER);
     $setup(posedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$GN, NOTIFIER);
     $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$GN,  NOTIFIER);
     $setup(posedge RN, posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$GN, NOTIFIER);
     $hold (posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$GN,  NOTIFIER);
     $recovery(posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$GN, NOTIFIER);
     $removal (posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$GN, NOTIFIER);
     $recovery(posedge SN, posedge RN &&& GN == 1'b1, trec$SN$RN, NOTIFIER);
     $removal (posedge SN, posedge RN &&& GN == 1'b1, trem$SN$RN, NOTIFIER);
     $width(negedge GN, tminpwl$GN, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNTSCAX12 (CK, E, ECK, SE);
input  CK ;
input  E ;
input  SE ;
output ECK ;
reg NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (P0000, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.11:0.11:0.11,
       tphhl$CK$ECK = 0.1:0.1:0.1,
       tminpwl$CK = 0.066:0.084:0.1,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNTSCAX16 (CK, E, ECK, SE);
input  CK ;
input  E ;
input  SE ;
output ECK ;
reg NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (P0000, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.12:0.12:0.12,
       tphhl$CK$ECK = 0.11:0.11:0.11,
       tminpwl$CK = 0.079:0.093:0.11,
       tsetup_negedge$E$CK = 0.059:0.059:0.059,
       thold_negedge$E$CK = 0.035:0.035:0.035,
       tsetup_negedge$SE$CK = 0.059:0.059:0.059,
       thold_negedge$SE$CK = 0.035:0.035:0.035,
       tsetup_posedge$E$CK = 0.059:0.059:0.059,
       thold_posedge$E$CK = 0.035:0.035:0.035,
       tsetup_posedge$SE$CK = 0.059:0.059:0.059,
       thold_posedge$SE$CK = 0.035:0.035:0.035;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNTSCAX2 (CK, E, ECK, SE);
input  CK ;
input  E ;
input  SE ;
output ECK ;
reg NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (P0000, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.16:0.16:0.16,
       tphhl$CK$ECK = 0.13:0.13:0.13,
       tminpwl$CK = 0.049:0.091:0.13,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNTSCAX20 (CK, E, ECK, SE);
input  CK ;
input  E ;
input  SE ;
output ECK ;
reg NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (P0000, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.13:0.13:0.13,
       tphhl$CK$ECK = 0.11:0.11:0.11,
       tminpwl$CK = 0.089:0.1:0.11,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNTSCAX3 (CK, E, ECK, SE);
input  CK ;
input  E ;
input  SE ;
output ECK ;
reg NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (P0000, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.13:0.13:0.13,
       tphhl$CK$ECK = 0.11:0.11:0.11,
       tminpwl$CK = 0.052:0.082:0.11,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNTSCAX4 (CK, E, ECK, SE);
input  CK ;
input  E ;
input  SE ;
output ECK ;
reg NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (P0000, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.12:0.12:0.12,
       tphhl$CK$ECK = 0.11:0.11:0.11,
       tminpwl$CK = 0.052:0.08:0.11,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNTSCAX6 (CK, E, ECK, SE);
input  CK ;
input  E ;
input  SE ;
output ECK ;
reg NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (P0000, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.11:0.11:0.11,
       tphhl$CK$ECK = 0.098:0.098:0.099,
       tminpwl$CK = 0.06:0.079:0.099,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNTSCAX8 (CK, E, ECK, SE);
input  CK ;
input  E ;
input  SE ;
output ECK ;
reg NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (P0000, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   and (ECK, CK, P0000);

   specify
     // delay parameters
     specparam
       tpllh$CK$ECK = 0.11:0.11:0.11,
       tphhl$CK$ECK = 0.098:0.099:0.1,
       tminpwl$CK = 0.059:0.08:0.1,
       tsetup_negedge$E$CK = 0.095:0.095:0.095,
       thold_negedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_negedge$SE$CK = 0.095:0.095:0.095,
       thold_negedge$SE$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$E$CK = 0.095:0.095:0.095,
       thold_posedge$E$CK = -0.001:-0.001:-0.001,
       tsetup_posedge$SE$CK = 0.095:0.095:0.095,
       thold_posedge$SE$CK = -0.001:-0.001:-0.001;

     // path delays
     if (CK == 1'b0)
       (CK *> ECK) = (0, tphhl$CK$ECK);
     if (CK == 1'b1)
       (CK *> ECK) = (tpllh$CK$ECK, 0);
     $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
     $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
     $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
     $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
     $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
     $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
     $width(negedge CK, tminpwl$CK, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNX1 (D, GN, Q, QN);
input  D ;
input  GN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_ENABLE, GN);
   udp_tlat (P0001, D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   buf (Q, P0001);
   not (QN, P0001);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.061:0.061:0.061,
       tphhl$D$Q = 0.065:0.065:0.065,
       tplhl$D$QN = 0.048:0.048:0.048,
       tphlh$D$QN = 0.055:0.055:0.055,
       tphlh$GN$Q = 0.073:0.073:0.073,
       tphhl$GN$Q = 0.08:0.08:0.08,
       tphlh$GN$QN = 0.071:0.071:0.071,
       tphhl$GN$QN = 0.061:0.061:0.061,
       tminpwl$GN = 0.026:0.053:0.08,
       tsetup_negedge$D$GN = 0.094:0.094:0.094,
       thold_negedge$D$GN = 0.00000000061:0.00000000061:0.00000000061,
       tsetup_posedge$D$GN = 0.094:0.094:0.094,
       thold_posedge$D$GN = 0:0:0;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (GN == 1'b0)
       (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
     if (GN == 1'b0)
       (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
     $setup(negedge D, posedge GN, tsetup_negedge$D$GN, NOTIFIER);
     $hold (posedge GN, negedge D, thold_negedge$D$GN,  NOTIFIER);
     $setup(posedge D, posedge GN, tsetup_posedge$D$GN, NOTIFIER);
     $hold (posedge GN, posedge D, thold_posedge$D$GN,  NOTIFIER);
     $width(negedge GN, tminpwl$GN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNX2 (D, GN, Q, QN);
input  D ;
input  GN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_ENABLE, GN);
   udp_tlat (P0000, D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   buf (Q, P0000);
   not (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.07:0.07:0.07,
       tphhl$D$Q = 0.074:0.074:0.074,
       tplhl$D$QN = 0.056:0.056:0.056,
       tphlh$D$QN = 0.064:0.064:0.064,
       tphlh$GN$Q = 0.082:0.082:0.082,
       tphhl$GN$Q = 0.089:0.089:0.089,
       tphlh$GN$QN = 0.079:0.079:0.079,
       tphhl$GN$QN = 0.068:0.068:0.068,
       tminpwl$GN = 0.028:0.059:0.089,
       tsetup_negedge$D$GN = 0.094:0.094:0.094,
       thold_negedge$D$GN = 0.00000000061:0.00000000061:0.00000000061,
       tsetup_posedge$D$GN = 0.094:0.094:0.094,
       thold_posedge$D$GN = 0:0:0;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (GN == 1'b0)
       (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
     if (GN == 1'b0)
       (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
     $setup(negedge D, posedge GN, tsetup_negedge$D$GN, NOTIFIER);
     $hold (posedge GN, negedge D, thold_negedge$D$GN,  NOTIFIER);
     $setup(posedge D, posedge GN, tsetup_posedge$D$GN, NOTIFIER);
     $hold (posedge GN, posedge D, thold_posedge$D$GN,  NOTIFIER);
     $width(negedge GN, tminpwl$GN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNX4 (D, GN, Q, QN);
input  D ;
input  GN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_ENABLE, GN);
   udp_tlat (P0000, D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   buf (Q, P0000);
   not (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.079:0.079:0.079,
       tphhl$D$Q = 0.088:0.088:0.088,
       tplhl$D$QN = 0.063:0.063:0.063,
       tphlh$D$QN = 0.077:0.077:0.077,
       tphlh$GN$Q = 0.091:0.091:0.091,
       tphhl$GN$Q = 0.1:0.1:0.1,
       tphlh$GN$QN = 0.091:0.091:0.091,
       tphhl$GN$QN = 0.076:0.076:0.076,
       tminpwl$GN = 0.035:0.069:0.1,
       tsetup_negedge$D$GN = 0.094:0.094:0.094,
       thold_negedge$D$GN = 0.00000000061:0.00000000061:0.00000000061,
       tsetup_posedge$D$GN = 0.094:0.094:0.094,
       thold_posedge$D$GN = 0:0:0;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (GN == 1'b0)
       (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
     if (GN == 1'b0)
       (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
     $setup(negedge D, posedge GN, tsetup_negedge$D$GN, NOTIFIER);
     $hold (posedge GN, negedge D, thold_negedge$D$GN,  NOTIFIER);
     $setup(posedge D, posedge GN, tsetup_posedge$D$GN, NOTIFIER);
     $hold (posedge GN, posedge D, thold_posedge$D$GN,  NOTIFIER);
     $width(negedge GN, tminpwl$GN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATNXL (D, GN, Q, QN);
input  D ;
input  GN ;
output Q ;
output QN ;
reg NOTIFIER ;

   not (I0_ENABLE, GN);
   udp_tlat (P0001, D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (P0000, P0001);
   buf (Q, P0001);
   not (QN, P0001);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.052:0.052:0.052,
       tphhl$D$Q = 0.058:0.058:0.058,
       tplhl$D$QN = 0.041:0.041:0.041,
       tphlh$D$QN = 0.049:0.049:0.049,
       tphlh$GN$Q = 0.065:0.065:0.065,
       tphhl$GN$Q = 0.073:0.073:0.073,
       tphlh$GN$QN = 0.064:0.064:0.064,
       tphhl$GN$QN = 0.054:0.054:0.054,
       tminpwl$GN = 0.027:0.05:0.073,
       tsetup_negedge$D$GN = 0.094:0.094:0.094,
       thold_negedge$D$GN = 0.00000000061:0.00000000061:0.00000000061,
       tsetup_posedge$D$GN = 0.094:0.094:0.094,
       thold_posedge$D$GN = 0:0:0;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (GN == 1'b0)
       (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
     if (GN == 1'b0)
       (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
     $setup(negedge D, posedge GN, tsetup_negedge$D$GN, NOTIFIER);
     $hold (posedge GN, negedge D, thold_negedge$D$GN,  NOTIFIER);
     $setup(posedge D, posedge GN, tsetup_posedge$D$GN, NOTIFIER);
     $hold (posedge GN, posedge D, thold_posedge$D$GN,  NOTIFIER);
     $width(negedge GN, tminpwl$GN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATSRX1 (D, G, Q, QN, RN, SN);
input  D ;
input  G ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_ENABLE, G, RN);
   not (I0_SET, SN);
   udp_tlat (P0000, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (P0001, P0000);
   buf (Q, P0000);
   not (QN, P0000);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.062:0.062:0.062,
       tphhl$D$Q = 0.077:0.077:0.077,
       tplhl$D$QN = 0.049:0.049:0.049,
       tphlh$D$QN = 0.066:0.066:0.066,
       tpllh$G$Q = 0.085:0.085:0.085,
       tplhl$G$Q = 0.085:0.085:0.085,
       tpllh$G$QN = 0.075:0.075:0.075,
       tplhl$G$QN = 0.072:0.072:0.072,
       tpllh$RN$Q = 0.086:0.086:0.086,
       tphhl$RN$Q = 0.083:0.083:0.083,
       tplhl$RN$QN = 0.073:0.073:0.073,
       tphlh$RN$QN = 0.073:0.073:0.073,
       tplhl$SN$Q = 0.049:0.049:0.049,
       tphlh$SN$Q = 0.047:0.048:0.048,
       tpllh$SN$QN = 0.039:0.039:0.039,
       tphhl$SN$QN = 0.034:0.035:0.035,
       tminpwh$G = 0.032:0.059:0.085,
       tminpwl$RN = 0.029:0.056:0.083,
       tminpwl$SN = 0.029:0.043:0.057,
       tsetup_negedge$D$G = 0.094:0.094:0.094,
       thold_negedge$D$G = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$G = 0.094:0.094:0.094,
       thold_posedge$D$G = -0.00000000061:-0.00000000061:-0.00000000061,
       tsetup_posedge$RN$G = 0.094:0.094:0.094,
       thold_posedge$RN$G = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$SN$G = 0.094:0.094:0.094,
       trem$SN$G = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$SN$RN = 0.094:0.094:0.094,
       trem$SN$RN = 0.00000000000000083:0.00000000000000083:0.00000000000000083;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (G == 1'b1)
       (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
     if (G == 1'b1)
       (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
     if (RN == 1'b0)
       (RN *> Q) = (0, tphhl$RN$Q);
     if (RN == 1'b1)
       (RN *> Q) = (tpllh$RN$Q, 0);
     if (RN == 1'b0)
       (RN *> QN) = (tphlh$RN$QN, 0);
     if (RN == 1'b1)
       (RN *> QN) = (0, tplhl$RN$QN);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$G, NOTIFIER);
     $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$G,  NOTIFIER);
     $setup(posedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$G, NOTIFIER);
     $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$G,  NOTIFIER);
     $setup(posedge RN, negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$G, NOTIFIER);
     $hold (negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$G,  NOTIFIER);
     $recovery(posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$G, NOTIFIER);
     $removal (posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$G, NOTIFIER);
     $recovery(posedge SN, posedge RN &&& G == 1'b0, trec$SN$RN, NOTIFIER);
     $removal (posedge SN, posedge RN &&& G == 1'b0, trem$SN$RN, NOTIFIER);
     $width(posedge G, tminpwh$G, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATSRX2 (D, G, Q, QN, RN, SN);
input  D ;
input  G ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_ENABLE, G, RN);
   not (I0_SET, SN);
   udp_tlat (P0001, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (P0000, P0001);
   buf (Q, P0001);
   not (QN, P0001);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.071:0.071:0.071,
       tphhl$D$Q = 0.089:0.089:0.089,
       tplhl$D$QN = 0.057:0.057:0.057,
       tphlh$D$QN = 0.078:0.078:0.078,
       tpllh$G$Q = 0.094:0.094:0.094,
       tplhl$G$Q = 0.098:0.098:0.098,
       tpllh$G$QN = 0.087:0.087:0.087,
       tplhl$G$QN = 0.08:0.08:0.08,
       tpllh$RN$Q = 0.094:0.094:0.094,
       tphhl$RN$Q = 0.094:0.094:0.094,
       tplhl$RN$QN = 0.081:0.081:0.081,
       tphlh$RN$QN = 0.083:0.083:0.083,
       tplhl$SN$Q = 0.058:0.058:0.058,
       tphlh$SN$Q = 0.053:0.053:0.054,
       tpllh$SN$QN = 0.047:0.047:0.047,
       tphhl$SN$QN = 0.039:0.039:0.04,
       tminpwh$G = 0.036:0.067:0.098,
       tminpwl$RN = 0.032:0.063:0.094,
       tminpwl$SN = 0.034:0.05:0.066,
       tsetup_negedge$D$G = 0.094:0.094:0.094,
       thold_negedge$D$G = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$G = 0.094:0.094:0.094,
       thold_posedge$D$G = -0.00000000061:-0.00000000061:-0.00000000061,
       tsetup_posedge$RN$G = 0.094:0.094:0.094,
       thold_posedge$RN$G = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$SN$G = 0.094:0.094:0.094,
       trem$SN$G = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$SN$RN = 0.094:0.094:0.094,
       trem$SN$RN = 0.00000000000000083:0.00000000000000083:0.00000000000000083;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (G == 1'b1)
       (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
     if (G == 1'b1)
       (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
     if (RN == 1'b0)
       (RN *> Q) = (0, tphhl$RN$Q);
     if (RN == 1'b1)
       (RN *> Q) = (tpllh$RN$Q, 0);
     if (RN == 1'b0)
       (RN *> QN) = (tphlh$RN$QN, 0);
     if (RN == 1'b1)
       (RN *> QN) = (0, tplhl$RN$QN);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$G, NOTIFIER);
     $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$G,  NOTIFIER);
     $setup(posedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$G, NOTIFIER);
     $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$G,  NOTIFIER);
     $setup(posedge RN, negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$G, NOTIFIER);
     $hold (negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$G,  NOTIFIER);
     $recovery(posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$G, NOTIFIER);
     $removal (posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$G, NOTIFIER);
     $recovery(posedge SN, posedge RN &&& G == 1'b0, trec$SN$RN, NOTIFIER);
     $removal (posedge SN, posedge RN &&& G == 1'b0, trem$SN$RN, NOTIFIER);
     $width(posedge G, tminpwh$G, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATSRX4 (D, G, Q, QN, RN, SN);
input  D ;
input  G ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_ENABLE, G, RN);
   not (I0_SET, SN);
   udp_tlat (P0000, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (P0001, P0000);
   buf (Q, P0000);
   not (QN, P0000);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.081:0.081:0.081,
       tphhl$D$Q = 0.1:0.1:0.1,
       tplhl$D$QN = 0.065:0.065:0.065,
       tphlh$D$QN = 0.09:0.09:0.09,
       tpllh$G$Q = 0.1:0.1:0.1,
       tplhl$G$Q = 0.11:0.11:0.11,
       tpllh$G$QN = 0.099:0.099:0.099,
       tplhl$G$QN = 0.087:0.087:0.087,
       tpllh$RN$Q = 0.1:0.1:0.1,
       tphhl$RN$Q = 0.11:0.11:0.11,
       tplhl$RN$QN = 0.088:0.088:0.088,
       tphlh$RN$QN = 0.095:0.095:0.095,
       tplhl$SN$Q = 0.06:0.06:0.06,
       tphlh$SN$Q = 0.053:0.054:0.054,
       tpllh$SN$QN = 0.047:0.047:0.047,
       tphhl$SN$QN = 0.037:0.038:0.038,
       tminpwh$G = 0.045:0.078:0.11,
       tminpwl$RN = 0.043:0.076:0.11,
       tminpwl$SN = 0.031:0.053:0.075,
       tsetup_negedge$D$G = 0.094:0.094:0.094,
       thold_negedge$D$G = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$G = 0.094:0.094:0.094,
       thold_posedge$D$G = -0.00000000061:-0.00000000061:-0.00000000061,
       tsetup_posedge$RN$G = 0.094:0.094:0.094,
       thold_posedge$RN$G = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$SN$G = 0.094:0.094:0.094,
       trem$SN$G = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$SN$RN = 0.094:0.094:0.094,
       trem$SN$RN = 0.00000000000000083:0.00000000000000083:0.00000000000000083;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (G == 1'b1)
       (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
     if (G == 1'b1)
       (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
     if (RN == 1'b0)
       (RN *> Q) = (0, tphhl$RN$Q);
     if (RN == 1'b1)
       (RN *> Q) = (tpllh$RN$Q, 0);
     if (RN == 1'b0)
       (RN *> QN) = (tphlh$RN$QN, 0);
     if (RN == 1'b1)
       (RN *> QN) = (0, tplhl$RN$QN);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$G, NOTIFIER);
     $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$G,  NOTIFIER);
     $setup(posedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$G, NOTIFIER);
     $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$G,  NOTIFIER);
     $setup(posedge RN, negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$G, NOTIFIER);
     $hold (negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$G,  NOTIFIER);
     $recovery(posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$G, NOTIFIER);
     $removal (posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$G, NOTIFIER);
     $recovery(posedge SN, posedge RN &&& G == 1'b0, trec$SN$RN, NOTIFIER);
     $removal (posedge SN, posedge RN &&& G == 1'b0, trem$SN$RN, NOTIFIER);
     $width(posedge G, tminpwh$G, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATSRXL (D, G, Q, QN, RN, SN);
input  D ;
input  G ;
input  RN ;
input  SN ;
output Q ;
output QN ;
reg NOTIFIER ;

   and (I0_ENABLE, G, RN);
   not (I0_SET, SN);
   udp_tlat (P0000, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (P0001, P0000);
   buf (Q, P0000);
   not (QN, P0000);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.053:0.053:0.053,
       tphhl$D$Q = 0.066:0.066:0.066,
       tplhl$D$QN = 0.042:0.042:0.042,
       tphlh$D$QN = 0.057:0.057:0.057,
       tpllh$G$Q = 0.076:0.076:0.076,
       tplhl$G$Q = 0.075:0.075:0.075,
       tpllh$G$QN = 0.065:0.065:0.065,
       tplhl$G$QN = 0.065:0.065:0.065,
       tpllh$RN$Q = 0.077:0.077:0.077,
       tphhl$RN$Q = 0.072:0.072:0.072,
       tplhl$RN$QN = 0.065:0.065:0.065,
       tphlh$RN$QN = 0.063:0.063:0.063,
       tplhl$SN$Q = 0.039:0.039:0.039,
       tphlh$SN$Q = 0.038:0.038:0.039,
       tpllh$SN$QN = 0.03:0.03:0.03,
       tphhl$SN$QN = 0.027:0.027:0.028,
       tminpwh$G = 0.032:0.054:0.076,
       tminpwl$RN = 0.029:0.051:0.072,
       tminpwl$SN = 0.022:0.035:0.048,
       tsetup_negedge$D$G = 0.094:0.094:0.094,
       thold_negedge$D$G = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$G = 0.094:0.094:0.094,
       thold_posedge$D$G = -0.00000000061:-0.00000000061:-0.00000000061,
       tsetup_posedge$RN$G = 0.094:0.094:0.094,
       thold_posedge$RN$G = -0.00000000061:-0.00000000061:-0.00000000061,
       trec$SN$G = 0.00000000061:0.00000000061:0.00000000061,
       trem$SN$G = 0.094:0.094:0.094,
       trec$SN$RN = 0.094:0.094:0.094,
       trem$SN$RN = 0.00000000000000083:0.00000000000000083:0.00000000000000083;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (G == 1'b1)
       (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
     if (G == 1'b1)
       (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
     if (RN == 1'b0)
       (RN *> Q) = (0, tphhl$RN$Q);
     if (RN == 1'b1)
       (RN *> Q) = (tpllh$RN$Q, 0);
     if (RN == 1'b0)
       (RN *> QN) = (tphlh$RN$QN, 0);
     if (RN == 1'b1)
       (RN *> QN) = (0, tplhl$RN$QN);
     (SN *> Q) = (tphlh$SN$Q, tplhl$SN$Q);
     (SN *> QN) = (tpllh$SN$QN, tphhl$SN$QN);
     $setup(negedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$G, NOTIFIER);
     $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$G,  NOTIFIER);
     $setup(posedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$G, NOTIFIER);
     $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$G,  NOTIFIER);
     $setup(posedge RN, negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$G, NOTIFIER);
     $hold (negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$G,  NOTIFIER);
     $recovery(posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$G, NOTIFIER);
     $removal (posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$G, NOTIFIER);
     $recovery(posedge SN, posedge RN &&& G == 1'b0, trec$SN$RN, NOTIFIER);
     $removal (posedge SN, posedge RN &&& G == 1'b0, trem$SN$RN, NOTIFIER);
     $width(posedge G, tminpwh$G, 0, NOTIFIER);
     $width(negedge RN, tminpwl$RN, 0, NOTIFIER);
     $width(negedge SN, tminpwl$SN, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATX1 (D, G, Q, QN);
input  D ;
input  G ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_tlat (QINT, D, G, 1'B0, 1'B0, NOTIFIER);
   not (P0000, QINT);
   buf (Q, QINT);
   not (QN, QINT);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.061:0.061:0.061,
       tphhl$D$Q = 0.065:0.065:0.065,
       tplhl$D$QN = 0.049:0.049:0.049,
       tphlh$D$QN = 0.056:0.056:0.056,
       tpllh$G$Q = 0.078:0.078:0.078,
       tplhl$G$Q = 0.067:0.067:0.067,
       tpllh$G$QN = 0.057:0.057:0.057,
       tplhl$G$QN = 0.065:0.065:0.065,
       tminpwh$G = 0.026:0.052:0.078,
       tsetup_negedge$D$G = 0.094:0.094:0.094,
       thold_negedge$D$G = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$G = 0.094:0.094:0.094,
       thold_posedge$D$G = -0.00000000061:-0.00000000061:-0.00000000061;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (G == 1'b1)
       (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
     if (G == 1'b1)
       (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
     $setup(negedge D, negedge G, tsetup_negedge$D$G, NOTIFIER);
     $hold (negedge G, negedge D, thold_negedge$D$G,  NOTIFIER);
     $setup(posedge D, negedge G, tsetup_posedge$D$G, NOTIFIER);
     $hold (negedge G, posedge D, thold_posedge$D$G,  NOTIFIER);
     $width(posedge G, tminpwh$G, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATX2 (D, G, Q, QN);
input  D ;
input  G ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_tlat (P0000, D, G, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   buf (Q, P0000);
   not (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.07:0.07:0.07,
       tphhl$D$Q = 0.075:0.075:0.075,
       tplhl$D$QN = 0.056:0.056:0.056,
       tphlh$D$QN = 0.065:0.065:0.065,
       tpllh$G$Q = 0.086:0.086:0.086,
       tplhl$G$Q = 0.076:0.076:0.076,
       tpllh$G$QN = 0.066:0.066:0.066,
       tplhl$G$QN = 0.072:0.072:0.072,
       tminpwh$G = 0.029:0.058:0.086,
       tsetup_negedge$D$G = 0.094:0.094:0.094,
       thold_negedge$D$G = 0:0:0,
       tsetup_posedge$D$G = 0.094:0.094:0.094,
       thold_posedge$D$G = -0.00000000061:-0.00000000061:-0.00000000061;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (G == 1'b1)
       (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
     if (G == 1'b1)
       (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
     $setup(negedge D, negedge G, tsetup_negedge$D$G, NOTIFIER);
     $hold (negedge G, negedge D, thold_negedge$D$G,  NOTIFIER);
     $setup(posedge D, negedge G, tsetup_posedge$D$G, NOTIFIER);
     $hold (negedge G, posedge D, thold_posedge$D$G,  NOTIFIER);
     $width(posedge G, tminpwh$G, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATX4 (D, G, Q, QN);
input  D ;
input  G ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_tlat (P0000, D, G, 1'B0, 1'B0, NOTIFIER);
   not (P0001, P0000);
   buf (Q, P0000);
   not (QN, P0000);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.079:0.079:0.079,
       tphhl$D$Q = 0.088:0.088:0.088,
       tplhl$D$QN = 0.064:0.064:0.064,
       tphlh$D$QN = 0.077:0.077:0.077,
       tpllh$G$Q = 0.095:0.095:0.095,
       tplhl$G$Q = 0.089:0.089:0.089,
       tpllh$G$QN = 0.077:0.077:0.077,
       tplhl$G$QN = 0.08:0.08:0.08,
       tminpwh$G = 0.039:0.067:0.095,
       tsetup_negedge$D$G = 0.094:0.094:0.094,
       thold_negedge$D$G = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$G = 0.094:0.094:0.094,
       thold_posedge$D$G = -0.00000000061:-0.00000000061:-0.00000000061;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (G == 1'b1)
       (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
     if (G == 1'b1)
       (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
     $setup(negedge D, negedge G, tsetup_negedge$D$G, NOTIFIER);
     $hold (negedge G, negedge D, thold_negedge$D$G,  NOTIFIER);
     $setup(posedge D, negedge G, tsetup_posedge$D$G, NOTIFIER);
     $hold (negedge G, posedge D, thold_posedge$D$G,  NOTIFIER);
     $width(posedge G, tminpwh$G, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module TLATXL (D, G, Q, QN);
input  D ;
input  G ;
output Q ;
output QN ;
reg NOTIFIER ;

   udp_tlat (QINT, D, G, 1'B0, 1'B0, NOTIFIER);
   not (P0000, QINT);
   buf (Q, QINT);
   not (QN, QINT);

   specify
     // delay parameters
     specparam
       tpllh$D$Q = 0.052:0.052:0.052,
       tphhl$D$Q = 0.058:0.058:0.058,
       tplhl$D$QN = 0.041:0.041:0.041,
       tphlh$D$QN = 0.049:0.049:0.049,
       tpllh$G$Q = 0.069:0.069:0.069,
       tplhl$G$Q = 0.059:0.059:0.059,
       tpllh$G$QN = 0.051:0.051:0.051,
       tplhl$G$QN = 0.057:0.057:0.057,
       tminpwh$G = 0.026:0.047:0.069,
       tsetup_negedge$D$G = 0.094:0.094:0.094,
       thold_negedge$D$G = 0.00000000000000083:0.00000000000000083:0.00000000000000083,
       tsetup_posedge$D$G = 0.094:0.094:0.094,
       thold_posedge$D$G = -0.00000000061:-0.00000000061:-0.00000000061;

     // path delays
     (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
     (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
     if (G == 1'b1)
       (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
     if (G == 1'b1)
       (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
     $setup(negedge D, negedge G, tsetup_negedge$D$G, NOTIFIER);
     $hold (negedge G, negedge D, thold_negedge$D$G,  NOTIFIER);
     $setup(posedge D, negedge G, tsetup_posedge$D$G, NOTIFIER);
     $hold (negedge G, posedge D, thold_posedge$D$G,  NOTIFIER);
     $width(posedge G, tminpwh$G, 0, NOTIFIER);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XNOR2X1 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.031:0.037:0.042,
       tplhl$A$Y = 0.035:0.039:0.044,
       tpllh$B$Y = 0.022:0.03:0.037,
       tplhl$B$Y = 0.024:0.026:0.028;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XNOR2X2 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.039:0.046:0.053,
       tplhl$A$Y = 0.044:0.05:0.057,
       tpllh$B$Y = 0.03:0.038:0.047,
       tplhl$B$Y = 0.032:0.036:0.041;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XNOR2X4 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.058:0.059:0.061,
       tplhl$A$Y = 0.063:0.065:0.067,
       tpllh$B$Y = 0.041:0.047:0.054,
       tplhl$B$Y = 0.044:0.045:0.046;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XNOR2XL (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (I0_out, A, B);
   not (Y, I0_out);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.027:0.032:0.038,
       tplhl$A$Y = 0.03:0.034:0.037,
       tpllh$B$Y = 0.018:0.025:0.033,
       tplhl$B$Y = 0.021:0.022:0.022;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XNOR3X1 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   xor (I0_out, A, B);
   xor (I1_out, I0_out, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.044:0.053:0.062,
       tplhl$A$Y = 0.044:0.053:0.061,
       tpllh$B$Y = 0.034:0.039:0.044,
       tplhl$B$Y = 0.033:0.036:0.039,
       tpllh$C$Y = 0.021:0.026:0.031,
       tplhl$C$Y = 0.024:0.025:0.026;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XNOR3XL (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   xor (I0_out, A, B);
   xor (I1_out, I0_out, C);
   not (Y, I1_out);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.043:0.054:0.064,
       tplhl$A$Y = 0.041:0.046:0.051,
       tpllh$B$Y = 0.034:0.038:0.043,
       tplhl$B$Y = 0.028:0.03:0.031,
       tpllh$C$Y = 0.021:0.026:0.032,
       tplhl$C$Y = 0.019:0.02:0.021;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XOR2X1 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.031:0.036:0.041,
       tplhl$A$Y = 0.034:0.039:0.043,
       tpllh$B$Y = 0.023:0.027:0.031,
       tplhl$B$Y = 0.023:0.03:0.036;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XOR2X2 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.039:0.045:0.051,
       tplhl$A$Y = 0.043:0.05:0.056,
       tpllh$B$Y = 0.033:0.036:0.039,
       tplhl$B$Y = 0.031:0.04:0.048;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XOR2X4 (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.058:0.059:0.06,
       tplhl$A$Y = 0.064:0.065:0.066,
       tpllh$B$Y = 0.036:0.044:0.053,
       tplhl$B$Y = 0.042:0.048:0.055;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XOR2XL (A, B, Y);
input  A ;
input  B ;
output Y ;

   xor (Y, A, B);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.027:0.032:0.037,
       tplhl$A$Y = 0.029:0.033:0.037,
       tpllh$B$Y = 0.018:0.023:0.027,
       tplhl$B$Y = 0.019:0.024:0.03;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XOR3X1 (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   xor (I0_out, A, B);
   xor (Y, I0_out, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.044:0.053:0.062,
       tplhl$A$Y = 0.044:0.052:0.06,
       tpllh$B$Y = 0.033:0.038:0.044,
       tplhl$B$Y = 0.034:0.036:0.039,
       tpllh$C$Y = 0.021:0.027:0.032,
       tplhl$C$Y = 0.024:0.025:0.026;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
`celldefine
module XOR3XL (A, B, C, Y);
input  A ;
input  B ;
input  C ;
output Y ;

   xor (I0_out, A, B);
   xor (Y, I0_out, C);

   specify
     // delay parameters
     specparam
       tpllh$A$Y = 0.044:0.054:0.064,
       tplhl$A$Y = 0.041:0.046:0.052,
       tpllh$B$Y = 0.034:0.038:0.043,
       tplhl$B$Y = 0.028:0.03:0.032,
       tpllh$C$Y = 0.021:0.026:0.032,
       tplhl$C$Y = 0.02:0.02:0.021;

     // path delays
     (A *> Y) = (tpllh$A$Y, tplhl$A$Y);
     (B *> Y) = (tpllh$B$Y, tplhl$B$Y);
     (C *> Y) = (tpllh$C$Y, tplhl$C$Y);

   endspecify

endmodule
`endcelldefine

primitive udp_dff (out, in, clk, clr, set, NOTIFIER);
   output out;
   input  in, clk, clr, set, NOTIFIER;
   reg    out;

   table

// in  clk  clr   set  NOT  : Qt : Qt+1
//
   0  r   ?   0   ?   : ?  :  0  ; // clock in 0
   1  r   0   ?   ?   : ?  :  1  ; // clock in 1
   1  *   0   ?   ?   : 1  :  1  ; // reduce pessimism
   0  *   ?   0   ?   : 0  :  0  ; // reduce pessimism
   ?  f   ?   ?   ?   : ?  :  -  ; // no changes on negedge clk
   *  b   ?   ?   ?   : ?  :  -  ; // no changes when in switches
   ?  ?   ?   1   ?   : ?  :  1  ; // set output
   ?  b   0   *   ?   : 1  :  1  ; // cover all transistions on set
   1  x   0   *   ?   : 1  :  1  ; // cover all transistions on set
   ?  ?   1   0   ?   : ?  :  0  ; // reset output
   ?  b   *   0   ?   : 0  :  0  ; // cover all transistions on clr
   0  x   *   0   ?   : 0  :  0  ; // cover all transistions on clr
   ?  ?   ?   ?   *   : ?  :  x  ; // any notifier changed

   endtable
endprimitive // udp_dff

primitive udp_tlat (out, in, enable, clr, set, NOTIFIER);

   output out;
   input  in, enable, clr, set, NOTIFIER;
   reg    out;

   table

// in  enable  clr   set  NOT  : Qt : Qt+1
//
   1  1   0   ?   ?   : ?  :  1  ; //
   0  1   ?   0   ?   : ?  :  0  ; //
   1  *   0   ?   ?   : 1  :  1  ; // reduce pessimism
   0  *   ?   0   ?   : 0  :  0  ; // reduce pessimism
   *  0   ?   ?   ?   : ?  :  -  ; // no changes when in switches
   ?  ?   ?   1   ?   : ?  :  1  ; // set output
   ?  0   0   *   ?   : 1  :  1  ; // cover all transistions on set
   1  ?   0   *   ?   : 1  :  1  ; // cover all transistions on set
   ?  ?   1   0   ?   : ?  :  0  ; // reset output
   ?  0   *   0   ?   : 0  :  0  ; // cover all transistions on clr
   0  ?   *   0   ?   : 0  :  0  ; // cover all transistions on clr
   ?  ?   ?   ?   *   : ?  :  x  ; // any notifier changed

   endtable
endprimitive // udp_tlat

primitive udp_rslat (out, clr, set, NOTIFIER);

   output out;
   input  clr, set, NOTIFIER;
   reg    out;

   table

// clr   set  NOT  : Qt : Qt+1
//
   ?   1   ?   : ?  :  1  ; // set output
   0   *   ?   : 1  :  1  ; // cover all transistions on set
   1   0   ?   : ?  :  0  ; // reset output
   *   0   ?   : 0  :  0  ; // cover all transistions on clr
   ?   ?   *   : ?  :  x  ; // any notifier changed

   endtable
endprimitive // udp_tlat

primitive udp_mux2 (out, in0, in1, sel);
   output out;
   input  in0, in1, sel;

   table

// in0 in1 sel :  out
//
    1  ?  0 :  1 ;
    0  ?  0 :  0 ;
    ?  1  1 :  1 ;
    ?  0  1 :  0 ;
    0  0  x :  0 ;
    1  1  x :  1 ;

   endtable
endprimitive // udp_mux2


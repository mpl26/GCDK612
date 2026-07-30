
/****************************************************************************
 Module : logic2elect - An AMS connection module
 
 Input :
        dVal : digital equivalent of the input analog signal.

 Output :
        aVal : an analog output 
 
This is a simple connection module which is used for automatic connection
module insertion during elaboration. This module polls the digital value and
creates an analog signal transition if needed. 

Algorithm:

if the digital input is 1, transition the analog output to 5.0 volts
if the digital input is 0,x,z, transition the analog output to 0.0 volts

(This conversion threshold assumes 0 to 5 volt logic)

Sensitivity and Timing:

This module is not sensitive to the digital input signal changing.
The analog kernel will not realize that digital has changed until
the next analog solution beyond the digital transition. This may introduce
some delays in the digital-to-analog conversion.

Handling of Driver-Receiver Segregation:

This module performs a direct mapping from digital ordinary module 
drivers to ordinary module receivers, with no delay introduced.

Compatible Disciplines:

This module is intended to be used for converting signal values
from digital signals with the "logic" discipline, to analog
signals with the "electrical" discipline.

Port Directions:

The output aVal is assumed to be an (output) analog port of discipline 
"electrical", and the input dVal is assumed to be an (input) digital port 
of discipline "logic".
 
****************************************************************************/
`include "disciplines.vams"

connectmodule logic2elect(dVal, aVal);
  input dVal;
  output aVal;
  logic dVal;
  electrical aVal;

  real a;
  parameter vhi = 5.0;
  parameter tr = 1n;
  parameter tf = 1n; 
  reg dValTwoState; // dVal mapped from quad state (0,1,x,z to two-state
                    // Mapping: 0,x,z->0, 1->1

  assign dVal = dVal;		// direct driver-receiver propagation

  analog begin
    // make a decision on what the analog output should be
    a = (dValTwoState == 1) ? vhi : 0.0;

    // and transition it, using 1ns rise/fall/delay times
    V(aVal) <+ transition(a,1n,tr,tf);
  end

  initial
     // Initialize dValTwoState using mapping
    case(dVal)
    1'b0: dValTwoState = 0;
    1'b1: dValTwoState = 1;
    1'bx: dValTwoState = 0;
    1'bz: dValTwoState = 0;
    endcase

  always @dVal begin
    // Remap dVal to dValTwoState everytime dVal changes.
    case(dVal)
    1'b0: dValTwoState = 0;
    1'b1: dValTwoState = 1;
    1'bx: dValTwoState = 0;
    1'bz: dValTwoState = 0;
    endcase
  end

endmodule

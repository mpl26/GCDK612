
/****************************************************************************
 Module : logic2elect_2 - An AMS connection module
 
 Input :
        dVal : digital equivalent of the input analog signal.

 Output :
        aVal : an analog output 

 Parameters:

  real thresh = 2.5V // threshold that controls dx-rx propagation
  real voh = 5.0;    // analog output high voltage
  real vol = 0.0;    // analog output low voltage
  real tr = 1n;      // rise time for analog transition
  real tf = 1n;      // fall time for analog transition
  real td = 1n;      // delay time for analog transition

This is a simple connection module which can be used for automatic connection
module insertion during elaboration. This module polls the digital value and
creates an analog signal transition if needed. Additionally, it propagates
the digital ordinary module drivers to the digital ordinary module receivers
under the control of the analog transition...when the analog value transitions
to a certain threshold, only then is the resolved digital driver's value
propagated to the receivers.

Algorithm:

if the digital input is 1, transition the analog output to 5.0 volts
if the digital input is 0,x,z, transition the analog output to 0.0 volts
when the analog output crosses the given threshold, do driver receiver
propagation.


Sensitivity and Timing:

The analog block is sensitive to changes on the digital input dVal.
The digital output changes under the control of the analog voltage
reaching a certain threshold

Handling of Driver-Receiver Segregation:

This module performs an indirect mapping from digital ordinary module 
drivers to ordinary module receivers, via a register d. The register
is only written to when the analog voltage transitions to a given
threshold value. Hence, the propagation from drivers to receivers
is completely under the control of the analog solver.

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

connectmodule logic2elect_2(dVal, aVal);
  input dVal;
  output aVal;
  logic dVal;
  electrical aVal;

  parameter vol = 0.0     // analog output low voltage
            from [0:inf];
  parameter voh = 5.0     // analog output high voltage
            from (vol:inf];
  parameter thresh = 2.5  // threshold that controls dx-rx propagation
            from (vol:voh);
  parameter tr = 1n       // rise time for analog transition
            from (0:inf];
  parameter tf = 1n       // fall time for analog transition
            from (0:inf];
  parameter td = 0        // delay time for analog transition
            from [0:inf];

  reg d;    	// a register to hold the digital output
  real a;       // an analog variable to hold the analog output

  reg dValTwoState; // dVal mapped from quad state (0,1,x,z to two-state
		    // Mapping: 0,x,z->0, 1->1

  // bind the digital port to the register d. Writing to the register
  // d then effectivly writes to the digital receivers.

  assign dVal = d;		

  // handle DC case
  initial begin
    d = dVal;     // initially, digital receivers see value from digital drivers
  end

  analog begin
    // make a decision on what the analog output should be, by looking
    // at the resolved value of the ordinary module digital drivers
    // (i.e. look at dVal)

    a = (dValTwoState == 1) ? voh : vol;

    // and transition it, using given rise/fall/delay times
    V(aVal) <+ transition(a,td,tr,tf);

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


  // whenever analog rises above 'thresh' volts...
  always @ (cross( V(aVal) - thresh, +1 ))
     d = 1'b1;    // ... write a 1 to digital ordinary module receivers

  // whenever analog falls below 'thresh' volts...
  always @ (cross( V(aVal) - thresh, -1 ))
     d = 1'b0;    // ... write a 0 to digital ordinary module receivers

endmodule

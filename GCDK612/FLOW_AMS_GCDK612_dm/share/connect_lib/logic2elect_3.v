
/****************************************************************************
 Module : logic2elect_3 - An AMS connection module,, with similar
                   functionality to the SpectreVerilog d2a
                   interface element
 Input :
        dVal : digital signal

 Output :
        aVal : an analog output

  Parameters:

  real val0 = 0;  // Final analog value for logical 0
  real val1 = 5;  // Final analog value for logical 1
  real valx= 2.5; // Final analog value for logical X
  real valz= 2.5; // Final analog value for logical Z
  real tr = 1n;   // rise time for trans. from `val0' to `val1', `valx', `valz'
  real tf = 1n;   // fall time for trans. from `val1' to `val0', `valx', `valz'
  real td = 1n;   // delay time for these transitions.
  real ron = 100; // Output resistance when in active state
  real roff = 1M; // Output resistance when in 'Z' state


This is a connection module which can be used for automatic connection
module insertion during elaboration. This module polls the digital value and
creates an analog signal transition if needed. Different analog output
values are driven for logic signals 0,1,X,Z respectively. In addition,
the module exhibits a finite output resistance

Algorithm:

if the digital input is 1, transition the analog output to val1, 5.0 volts
if the digital input is 0, transition the analog output to val0, 0.0 volts
if the digital input is x, transition the analog output to valx, 2.5 volts
if the digital input is z, transition the analog output to valz, 2.5 volts

if the digital input is 1, 0, or X, add an output resistance of 100 ohms.
if the digital input is Z, add an output resistance of 1M ohms.

(This conversion threshold assumes 0 to 5 volt logic)

Sensitivity and Timing:

The analog block is sensitive to the digital variable "eval".
This value is changed whenever the digital input dVal changes, and
thus the analog block is evaluated whenever the digital input dVal changes.

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

connectmodule logic2elect_3(dVal, aVal);
  input dVal;
  output aVal;
  logic dVal;
  electrical aVal;

  parameter val0 = 0;  // Final analog value for logical 0
  parameter val1 = 5   // Final analog value for logical 1
            from (val0:inf];
  parameter valx= 2.5  // Final analog value for logical X
            from (val0:val1);
  parameter valz= 2.5  // Final analog value for logical Z
            from [val0:val1];
  parameter tr = 1n    // Time for trans. from `val0' to `val1',`valx',`valz'
            from (0:inf];
  parameter tf = 1n    // Time for trans. from `val1' to `val0',`valx',`valz'
            from (0:inf];
  parameter td = 1n    // delay time for these transitions
            from [0:inf];
  parameter ron = 100  // Output resistance when in active state
            from (0:inf];
  parameter roff = 1M  // Output resistance when in 'Z' state
            from (0:inf];

  // local declarations...

  electrical e;   // intermediate node, needed to implement output resistance
  real eval;      // real variable, to hold that nodes voltage
  real rout;      // real variable, to hold actual output resistance
 

  // initialize some variables...
  initial begin
      eval = valx;
      rout = ron;
  end

  // direct propagation of digital drivers to receivers...
  assign dVal = dVal;

  // figure out what value (eval) and output impedance analog should get...
  always @(dVal) begin
    case (dVal)
      1'b1 : begin
               eval = val1;
               rout = ron;
             end
      1'b0 : begin
               eval = val0;
               rout = ron;
             end
      1'bx : begin
               eval = valx;
               rout = ron;
             end
      1'bz : begin
               eval = valz;
               rout = roff;   // high output impedance in 'Z' state
             end
    endcase
  end

  // handle DC values
  initial begin
    case (dVal)
      1'b1 : begin
               eval = val1;
               rout = ron;
             end
      1'b0 : begin
               eval = val0;
               rout = ron;
             end
      1'bx : begin
               eval = valx;
               rout = ron;
             end
      1'bz : begin
               eval = valz;
               rout = roff;
             end
    endcase
  end

  analog begin

    // ... above we figured out what value (eval) analog should get, so 
    // transition it, using given rise/fall times
    V(e) <+ transition(eval,td,tr,tf);

    // implement the output resistance
    V(e,aVal) <+ rout * I(e,aVal);
  end

endmodule

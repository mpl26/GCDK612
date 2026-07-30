
/****************************************************************************
 Module : elect2logic_2 - An AMS connection module with hysteresis

 Input :
        aVal : an analog input

 Output :
        dVal : digital equivalent of the input analog signal.

  Parameters:

  real thresholdLo = 1.5;  // value below which digital is 0
  real thresholdHi = 3.5;  // value above which digital is 1

This connect module automatically detects when the analog input
crosses the appropriate thresholds, and creates the corresponding
digital signal change

Algorithm:

If the analog input is > hi threshold voltage(thresholdHi)
the digital output is set to 1

If the analog input is <= lo threshold voltage (thresholdLo)
the digital output is set to 0

(This conversion threshold assumes 0 to 5 volt logic by default,
with the high threshold set at 3.5 volts and the low threshold
set at 1.5 volts)

Timing and Sensitivity:

This module is re-evaluated every time the analog value crosses
one of the thresholds in the appropriate direction. It then inspects
the analog value in order to make a decision on what the digital value
should be changed to. Since the model is evaluated only when the 
analog node solution crosses one of the thresholds, it is reasonably
fast, however the simulator has to resolve the cross statements accurately,
which results in some simulation time penalty.

In addition, the hysteresis (low threshold < high threshold) may
help the analog kernel's convergence properties and hence reduce 
the overall simulation time.

Handling of Driver-Receiver Segregation:

This connect module drives the digital output in response to the analog
input only. Any ordinary module drivers which are connected to the digital
port of this module are not considered when driving any ordinary module
digital receivers which are connected to the digital port of this module.

This module is thus intended to be used in situations calling for pure
analog to digital conversion only. It is not really intended to be used
in cases where both analog and digital are simultaneously driving a
mixed net.

Compatible Disciplines:

This module is intended to be used for converting signal values
from analog signals with the "electrical" discipline, to digital
signals with the "logic" discipline.

Port Directions:

The input aVal is assumed to be an (input) analog port of discipline electrical,
and the output dVal is assumed to be an (output) digital port of discipline 
logic

*****************************************************************************/
`include "disciplines.vams"

connectmodule elect2logic_2(aVal, dVal);
  input aVal;
  output dVal;
  electrical aVal;
  logic dVal;

  parameter real thresholdLo = 1.5;  // value below which digital is 0
  parameter real thresholdHi = 3.5;  // value above which digital is 1

  integer iVal;

  assign dVal = iVal;  		// direct driver-receiver propagation

  // whenever analog rises above the high threshold, digital becomes 1
  always @(cross(V(aVal) - thresholdHi, +1))
    iVal = 1;

  // whenever analog falls below the low threshold, digital becomes 0
  always @(cross(V(aVal) - thresholdLo, -1))
    iVal = 0;

  // handle DC values
  initial begin
    if ( V(aVal) >= thresholdHi )
      iVal = 1'b1;
    else if ( V(aVal) <= thresholdLo )
      iVal = 1'b0;
  end

endmodule

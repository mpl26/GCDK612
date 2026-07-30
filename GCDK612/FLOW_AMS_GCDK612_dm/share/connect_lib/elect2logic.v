
/****************************************************************************
 Module : elect2logic - An AMS connection module
 
 Input :
        aVal : an analog input 
 
 Output :
        dVal : digital equivalent of the input analog signal.
 
This is a simple connection module which is used for automatic connection
module insertion during elaboration. This module continually polls the 
analog value and creates a digital signal change if needed. 

Algorithm:

If the analog input is > threshold voltage(vthresh)
the digital output is set to 1, after a delay of 1 time unit 

If the analog input is <= threshold voltage (vthresh)
the digital output is set to 0, after a delay of 1 time unit

(This conversion threshold assumes 0 to 5 volt logic by default,
i.e. the default value of the vthresh parameter is set to 2.5 volts)

Timing and Sensitivity:

This module is re-evaluated every digital time tick. It then inspects
the analog value in order to make a decision on what the digital value
should be changed to. By re-evaluating the model every digital time
tick, the model may be somewhat inefficient.

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
 
****************************************************************************/
`include "disciplines.vams"

connectmodule elect2logic(aVal, dVal);
  output dVal;
  input aVal;
  logic dVal;
  electrical aVal;

  parameter real vthresh = 2.5;         // threshold voltage for A->D conversion
  reg temp;
 
  always begin	   			// digital, do this always
    if(V(aVal) > vthresh)         	// sample the analog port value
      #1 temp = 1;                	// delay 1 time unit,drive output 1
    else
      #1 temp = 0;                	// or drive output 0, depending on aVal
  end

  // handle DC case (is this needed?)
  initial begin
    if(V(aVal) > vthresh)         	// sample the analog port value
      temp = 1;                		// drive output 1
    else
      temp = 0;                		// or drive output 0, depending on aVal
  end
 
  assign dVal = temp;                  // bind register to digital output
 
endmodule

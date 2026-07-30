
/****************************************************************************
 Module : elect2logic_3 - An AMS connection module, with similar
                   functionality to the SpectreVerilog a2d 
                   interface element

 Input :
        aVal : an analog input

 Output :
        dVal : digital equivalent of the input analog signal.

  Parameters:

  real thresholdLo = 1.5;  // voltage value below which digital is 0
  real thresholdHi = 3.5;  // voltage above which digital is 1
  real timex = 1;          // the time that analog voltage can linger
                           // between low and high thresholds before
                           // digital becomes unknown (x)
  parameter real tr = 1n;  // rise time for internal transition
  parameter real tf = 1n;  // fall time for internal transition
  parameter real td = 1n;  // delay time for internal transitio

This connect module automatically detects when the analog input
crosses the appropriate thresholds, and creates the corresponding
digital signal change

Algorithm:

If the analog input is > hi threshold voltage(thresholdHi)
the digital output is set to 1

If the analog input is <= lo threshold voltage (thresholdLo)
the digital output is set to 0

if the analog input enters the dead zone between the threshold voltages,
then start a timer based on the timex parameter value. 
If the analog input leaves the dead zone, then
cancel the timer. If the timer event matures, then analog has been in 
the dead zone for >= timex, so cause the digital output to change to x.

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

The input aVal is assumed to be an (input) analog port of discipline 
electrical, and the output dVal is assumed to be an (output) digital
port of discipline logic

****************************************************************************/
`include "disciplines.vams"

connectmodule elect2logic_3(aVal, dVal);
  input aVal;
  output dVal;
  electrical aVal;
  logic dVal;

  parameter real thresholdLo = 1.5;	// value below which digital is 0
  parameter real thresholdHi = 3.5      // value above which digital is 1
               from [thresholdLo:inf];	
                                       

  parameter real timex = 1 from (0:inf];// time in dead zone after which
                                        // digital becomes x
  parameter real tr = 1n from (0:inf];  // rise time for internal transition
  parameter real tf = 1n from (0:inf];  // fall time for internal transition
  parameter real td = 1n from [0:inf];  // delay time for internal transition

  integer iVal;				// a variable to hold digital value

  real time_enter_dz;                   // time we entered dead zone
  real eval;                            // a real (analog) variable

  electrical e;				// an analog internal node

  // bind digital output to variable iVal
  assign dVal = iVal;

  // when analog rises above high threshold, digital iVal becomes 1
  always @(cross(V(aVal) - thresholdHi, +1))
      iVal = 1'b1;

  // when analog falls below low threshold, digital iVal becomes 0
  always @(cross(V(aVal) - thresholdLo, -1))
      iVal = 1'b0;


  // whenever a transition happens on analog node e, digital iVal becomes x
  always @(cross(V(e),0))
      iVal = 1'bx;

  // the analog block is responsible for handling the dead zone and timing
  analog begin

       // initialize some variables
       @(initial_step) begin
         time_enter_dz = 0.0;
         eval = -1.0;
       end

       // if we exit the deadzone, then set the time we entered the dead
       // zone so far back in the past that the timer will not trigger
       // i.e. cancel the timer

       if (V(aVal) > thresholdHi)
           time_enter_dz = -timex - 1.0;

       if (V(aVal) < thresholdLo)
           time_enter_dz = -timex - 1.0;

       // as soon as we enter the dead zone, store the time we did so.

       @(cross(V(aVal) - thresholdHi, -1) or
           cross(V(aVal) - thresholdLo, +1)) begin
           time_enter_dz =  $abstime();  
       end

       // set a timer that expires either timex seconds after we entered
       // the dead zone (if we are still in the dead zone), or that expires
       // in the past (i.e. effectively cancel the timer if time_enter_dz
       // is sufficiently negative.

       @(timer(time_enter_dz + timex)) begin
           // timer has expired. Its time to cause a digital x to be output.
           // do this by toggling the voltage of internal node "e" to which
           // digital is transition sensitive.
           eval = (eval == 1.0) ?  -1.0 : 1.0;
       end

       // drive the internal node with the appropriate value.
       // 1ns rise, fall and delay times are assumed.
       V(e) <+ transition(eval,td,tr,tf);
  end

  // the initial block is responsible for handling DC values
  initial begin
      if ( V(aVal) >= thresholdHi )
          iVal = 1'b1;
      else if ( V(aVal) <= thresholdLo )
          iVal = 1'b0;
      else
          iVal = 1'bx;
  end


endmodule



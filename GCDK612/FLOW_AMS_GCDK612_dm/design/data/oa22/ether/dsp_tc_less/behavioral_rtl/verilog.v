// Created by ihdl
module dsp_tc_less(IN1,IN2,LT);
   parameter width = 16;
   input [width-1 : 0] IN1;
   input [width-1 : 0] IN2;
   output 	       LT;
   
   assign LT = {~IN1[width-1], IN1[width-2:0]} <
	       {~IN2[width-1], IN2[width-2:0]};

endmodule

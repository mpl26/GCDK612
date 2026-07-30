// Verilog HDL for "shawnee_ms", "pi_dig_STIM" "behavioral"


`timescale 1ps/1ps

module top_sim_pi_dig_STIM ( PH_DN, PH_UP, RST,  REFCLK);
    output PH_DN;
    output PH_UP;
    output RST;
    input REFCLK;


reg    PH_DN;
reg    PH_UP;
reg    RST;


initial begin 
   PH_DN    <= 1'b0;
   PH_UP    <= 1'b0;
   RST       = 1'b1;
   #2500 RST  = 1'b0;
end 

reg [10:0] cntr;

initial begin
 cntr <= 0;
end
/*
always @(posedge REFCLK) begin
  cntr <= cntr + 1;
  if(cntr == 11'd020) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd040) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd050) begin PH_DN <= 1'b1;  #8000 PH_DN <= 1'b0; end
  if(cntr == 11'd060) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd080) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd100) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd120) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd140) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd160) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd180) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd200) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd220) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd240) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd260) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd280) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd300) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd320) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd360) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd340) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd380) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd400) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd420) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd440) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd460) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd480) begin PH_UP <= 1'b1;  #8000 PH_UP <= 1'b0; end
  if(cntr == 11'd500) begin PH_DN <= 1'b1; #12000 PH_DN <= 1'b0; end
  if(cntr == 11'd540) begin PH_DN <= 1'b1; #12000 PH_DN <= 1'b0; end
  if(cntr == 11'd580) begin PH_DN <= 1'b1; #12000 PH_DN <= 1'b0; end
  if(cntr == 11'd620) begin PH_DN <= 1'b1; #12000 PH_DN <= 1'b0; end
  if(cntr == 11'd660) begin PH_DN <= 1'b1; #12000 PH_DN <= 1'b0; end
  if(cntr == 11'd700) begin PH_DN <= 1'b1; #12000 PH_DN <= 1'b0; end
 end 
*/

initial begin
   #(500000);

// wait 350ns and test pi for increment and decrement phase
    
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
   
    #25000 PH_DN = 1'b1; #25000 PH_DN = 1'b0;
    #25000 PH_DN = 1'b1; #25000 PH_DN = 1'b0;
    #25000 PH_DN = 1'b1; #25000 PH_DN = 1'b0;
    #25000 PH_DN = 1'b1; #25000 PH_DN = 1'b0;

   #(25000);

// wait 25ns and verify data capture
    
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;
    #25000 PH_UP = 1'b1; #25000 PH_UP = 1'b0;

end

endmodule


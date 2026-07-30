// Created by ihdl
module dsp_slice_mult(DATA,COEF,DOUT);

input    [1:0]    DATA;
input    [7:0]    COEF;
output   [7:0]    DOUT;

reg      [7:0]    DOUT;

   always @(DATA or COEF)
   begin
         case(DATA)
            2'b01: DOUT = COEF;    // +1
            2'b00: DOUT = 8'h00;   //  0
            2'b11: DOUT = -COEF;   // -1
            2'b10: DOUT = 8'h00;   // not used
         endcase
      end
endmodule

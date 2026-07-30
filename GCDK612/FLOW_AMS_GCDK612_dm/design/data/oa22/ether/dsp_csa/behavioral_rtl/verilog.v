// Created by ihdl
module dsp_csa(X,Y,Z,C,S);

parameter wordlength = 8;

input    [wordlength-1:0]  X;
input    [wordlength-1:0]  Y;
input    [wordlength-1:0]  Z;
output   [wordlength-1:0]  C;
output   [wordlength-1:0]  S;

assign S = (X^Y) ^ Z;
assign C = ((X&Y) | (X&Z)) | (Y&Z);

endmodule

// Created by ihdl
module dsp_mult_cursor(DATA,COEF,CLK,PRODUCT,RESET);

input    [5:0] DATA;
input    [9:0] COEF;
input          CLK;
input    RESET;
output   [9:0] PRODUCT;

parameter nA = 6;
parameter nB = 10;
parameter nC = nA+nB;

reg   [15:4]   full_product_ff;
wire  [15:0]   full_product;
wire  [11:0]   product_round;
reg   [9:0]    PRODUCT;


wire negA, negB, signProd;
wire [nA-1:0] A_pos;
wire [nB-1:0] B_pos;
wire [nC-1:0] Prod;
wire [nC-1:0] TmpProd;


// Two's complement arithmetic

assign negA = DATA[nA-1];
assign negB = COEF[nB-1];
assign signProd = negA ^ negB;
assign A_pos = negA ? -DATA : DATA;
assign B_pos = negB ? -COEF : COEF;
assign TmpProd = A_pos * B_pos;
assign full_product = signProd ? -TmpProd : TmpProd;


always @(posedge CLK or posedge RESET)
      if (RESET)
    full_product_ff[15:4] <= 12'h0;
    else
    full_product_ff[15:4] <= full_product[15:4];

//round
assign product_round = full_product_ff[15:4] + 12'b000000000001;

//clip
always @(product_round)
begin
  case(product_round[11:10])	// ambit synthesis case = full, parallel
                                // synopsys full_case parallel_case
    2'b01: PRODUCT = 10'b0111111111;        // overflow pos
    2'b10: PRODUCT = 10'b1000000000;        // overflow neg
    2'b00: PRODUCT = product_round[10:1];  // no overflow
    2'b11: PRODUCT = product_round[10:1];  // no overflow
  endcase
end
endmodule

// Created by ihdl
module dsp_mult(DATA,COEF,CLK,PRODUCT,RESET);

input    [5:0]   DATA;
input   [7:0]   COEF;
input      CLK;
input       RESET;
output   [7:0]   PRODUCT;


parameter nA = 6;
parameter nB = 8;
parameter nC = nA+nB;


reg    [13:4]   full_product_ff;
wire    [13:0]   full_product;
wire   [9:0]   product_round;
reg   [7:0]    PRODUCT;


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

// Register multiplication
always @(posedge CLK or posedge RESET)
   if (RESET)
      full_product_ff <= 10'h0;
    else
      full_product_ff[13:4] <= full_product[13:4];

//round
assign product_round = full_product_ff[13:4] + 10'b0000000001;

//clip
always @(product_round)
begin
  case(product_round[9:8])   // ambit synthesis case = full, parallel
                                // synopsys full_case parallel_case
    2'b01: PRODUCT = 8'b01111111;         // overflow pos
    2'b10: PRODUCT = 8'b10000000;         // overflow neg
    2'b00: PRODUCT = product_round[8:1];  // no overflow
    2'b11: PRODUCT = product_round[8:1];  // no overflow
  endcase
end

endmodule

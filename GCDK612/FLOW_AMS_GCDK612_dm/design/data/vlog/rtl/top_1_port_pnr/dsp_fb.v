// Created by ihdl
module dsp_fb(DIN,ERROR,CLK,FAST_UPDATE,SOUT,COUT,TAP0,RESET,FREEZE,MU,
              C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11);

input    [1:0]    DIN;    //2,0
input    [1:0]    ERROR;  //2,0
input             RESET;
input             CLK;
input             FAST_UPDATE;
output   [11:0]   SOUT;
output   [11:0]   COUT;
output   [7:0]    TAP0;

// test modes
input             FREEZE;
input    [1:0]     MU;  // 00:2^-14 .. 11:2^-17
output   [7:0]   C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11;

reg      [1:0]    data_0, data_1, data_2, data_3;
reg      [1:0]    data_4, data_5, data_6, data_7;
reg      [1:0]    data_8, data_9, data_10, data_11;
reg      [1:0]    data_12;
reg      [11:0]    SOUT;
reg      [11:0]    COUT;
reg      [6:0]    count;
reg               freeze0;
reg               freeze1;
reg               freeze2;
reg               freeze3;
reg               freeze4;
reg               freeze5;
reg               freeze6;
reg               freeze7;
reg               freeze8;
reg               freeze9;
reg               freeze10;
reg               freeze11;

wire     [7:0]   coef_0;
wire     [7:0]   coef_1;
wire     [7:0]   coef_2;
wire     [7:0]   coef_3;
wire     [7:0]   coef_4;
wire     [7:0]   coef_5;
wire     [7:0]   coef_6;
wire     [7:0]   coef_7;
wire     [7:0]   coef_8;
wire     [7:0]   coef_9;
wire     [7:0]   coef_10;
wire     [7:0]   coef_11;

wire     [7:0]   product_0;
wire     [7:0]   product_1;
wire     [7:0]   product_2;
wire     [7:0]   product_3;
wire     [7:0]   product_4;
wire     [7:0]   product_5;
wire     [7:0]   product_6;
wire     [7:0]   product_7;
wire     [7:0]   product_8;
wire     [7:0]   product_9;
wire     [7:0]   product_10;
wire     [7:0]   product_11;

wire     [7:0]   s1_0,s1_1,s1_2,s1_3;
wire     [7:0]   c1_0,c1_1,c1_2,c1_3;
wire     [8:0]   s2_0,s2_1;
wire     [8:0]   c2_0,c2_1;
wire     [9:0]   s3_0,s3_1;
wire     [9:0]   c3_0,c3_1;
wire     [10:0]  s4_0;
wire     [10:0]  c4_0;
wire     [11:0]  s5_0;
wire     [11:0]  c5_0;

always @(posedge CLK or posedge RESET) 
begin
  if (RESET)
    count <= 7'b0000000;
  else if (FAST_UPDATE)
    count <= 7'b0000000;
  else
    count <= count + 1;
end

always @(count or FREEZE or FAST_UPDATE) 
begin
  if (FAST_UPDATE) begin  // update every cycle
    freeze0  = FREEZE;
    freeze1  = FREEZE;
    freeze2  = FREEZE;
    freeze3  = FREEZE;
    freeze4  = FREEZE;
    freeze5  = FREEZE;
    freeze6  = FREEZE;
    freeze7  = FREEZE;
    freeze8  = FREEZE;
    freeze9  = FREEZE;
    freeze10 = FREEZE;
    freeze11 = FREEZE;
  end
  else begin // divide by 16 updates
    freeze0  = ~((count[6:3]==4'b0000)) | FREEZE;
    freeze1  = ~((count[6:3]==4'b0001)) | FREEZE;
    freeze2  = ~((count[6:3]==4'b0010)) | FREEZE;
    freeze3  = ~((count[6:3]==4'b0011)) | FREEZE;
    freeze4  = ~((count[6:3]==4'b0100)) | FREEZE;
    freeze5  = ~((count[6:3]==4'b0101)) | FREEZE;
    freeze6  = ~((count[6:3]==4'b0110)) | FREEZE;
    freeze7  = ~((count[6:3]==4'b0111)) | FREEZE;
    freeze8  = ~((count[6:3]==4'b1000)) | FREEZE;
    freeze9  = ~((count[6:3]==4'b1001)) | FREEZE;
    freeze10 = ~((count[6:3]==4'b1010)) | FREEZE;
    freeze11 = ~((count[6:3]==4'b1011)) | FREEZE;
  end
end

always @(posedge CLK or posedge RESET)

   if (RESET)
      begin
         data_12 <= 2'b00;
         data_11 <= 2'b00;
         data_10 <= 2'b00;
         data_9 <= 2'b00;
         data_8 <= 2'b00;
         data_7 <= 2'b00;
         data_6 <= 2'b00;
         data_5 <= 2'b00;
         data_4 <= 2'b00;
         data_3 <= 2'b00;
         data_2 <= 2'b00;
         data_1 <= 2'b00;
         data_0 <= 2'b00;
      end

   else
      begin
         data_12 <= data_11;
         data_11 <= data_10;
         data_10 <= data_9;
         data_9 <= data_8;
         data_8 <= data_7;
         data_7 <= data_6;
         data_6 <= data_5;
         data_5 <= data_4;
         data_4 <= data_3;
         data_3 <= data_2;
         data_2 <= data_1;
         data_1 <= data_0;
         data_0 <= DIN;
      end

dsp_fb_update i_dsp_fb_update_0 ( .DATA(data_1),
                                 .ERROR(ERROR),
                                 .CLK(CLK),
                                 .RESET(RESET),
                                 .COEF_OUT(coef_0),
                                 .MU(MU),
                                 .FREEZE(freeze0));

dsp_fb_update i_dsp_fb_update_1 ( .DATA(data_2),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .COEF_OUT(coef_1),
                                  .MU(MU),
                                  .FREEZE(freeze1));

dsp_fb_update i_dsp_fb_update_2 ( .DATA(data_3),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .COEF_OUT(coef_2),
                                  .MU(MU),
                                  .FREEZE(freeze2));

dsp_fb_update i_dsp_fb_update_3 ( .DATA(data_4),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .COEF_OUT(coef_3),
                                  .MU(MU),
                                  .FREEZE(freeze3));

dsp_fb_update i_dsp_fb_update_4 ( .DATA(data_5),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .COEF_OUT(coef_4),
                                  .MU(MU),
                                  .FREEZE(freeze4));

dsp_fb_update i_dsp_fb_update_5 ( .DATA(data_6),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .COEF_OUT(coef_5),
                                  .MU(MU),
                                  .FREEZE(freeze5));

dsp_fb_update i_dsp_fb_update_6 ( .DATA(data_7),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .COEF_OUT(coef_6),
                                  .MU(MU),
                                  .FREEZE(freeze6));

dsp_fb_update i_dsp_fb_update_7 ( .DATA(data_8),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .COEF_OUT(coef_7),
                                  .MU(MU),
                                  .FREEZE(freeze7));

dsp_fb_update i_dsp_fb_update_8 ( .DATA(data_9),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .COEF_OUT(coef_8),
                                  .MU(MU),
                                  .FREEZE(freeze8));

dsp_fb_update i_dsp_fb_update_9 ( .DATA(data_10),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .COEF_OUT(coef_9),
                                  .MU(MU),
                                  .FREEZE(freeze9));

dsp_fb_update i_dsp_fb_update_10 ( .DATA(data_11),
                                   .ERROR(ERROR),
                                   .CLK(CLK),
                                   .RESET(RESET),
                                   .COEF_OUT(coef_10),
                                   .MU(MU),
                                   .FREEZE(freeze10));

dsp_fb_update i_dsp_fb_update_11 ( .DATA(data_12),
                                   .ERROR(ERROR),
                                   .CLK(CLK),
                                   .RESET(RESET),
                                   .COEF_OUT(coef_11),
                                   .MU(MU),
                                   .FREEZE(freeze11));


dsp_slice_mult m0(DIN,coef_0,product_0);
dsp_slice_mult m1(DIN,coef_1,product_1);  //shifted data due to output reg
dsp_slice_mult m2(data_0,coef_2,product_2);
dsp_slice_mult m3(data_1,coef_3,product_3);
dsp_slice_mult m4(data_2,coef_4,product_4);
dsp_slice_mult m5(data_3,coef_5,product_5);
dsp_slice_mult m6(data_4,coef_6,product_6);
dsp_slice_mult m7(data_5,coef_7,product_7);
dsp_slice_mult m8(data_6,coef_8,product_8);
dsp_slice_mult m9(data_7,coef_9,product_9);
dsp_slice_mult m10(data_8,coef_10,product_10);
dsp_slice_mult m11(data_9,coef_11,product_11);


// level 1
dsp_csa #(8)  i_dsp_csa1_0(product_11,
                          product_10,
                          product_9,
                          c1_0,s1_0);
dsp_csa #(8)  i_dsp_csa1_1(product_8,
                          product_7,
                          product_6,
                          c1_1,s1_1);
dsp_csa #(8)  i_dsp_csa1_2(product_5,
                          product_4,
                          product_3,
                          c1_2,s1_2);

// level 2
dsp_csa #(9)  i_dsp_csa2_0({c1_0,1'b0},
                          {s1_0[7],s1_0},
                          {c1_1,1'b0},
                          c2_0,s2_0);
dsp_csa #(9)  i_dsp_csa2_1({s1_1[7],s1_1},
                          {c1_2,1'b0},
                          {s1_2[7],s1_2},
                          c2_1,s2_1);

// level 3
dsp_csa #(10) i_dsp_csa3_0({c2_0,1'b0},
                          {s2_0[8],s2_0},
                          {c2_1,1'b0},
                          c3_0,s3_0);
dsp_csa #(10) i_dsp_csa3_1({s2_1[8],s2_1},
                          {product_2[7],product_2[7],product_2},
                          {product_1[7],product_1[7],product_1},
                          c3_1,s3_1);
// level 4
dsp_csa #(11) i_dsp_csa4_0({c3_0,1'b0},
                          {s3_0[9],s3_0},
                          {c3_1,1'b0},
                          c4_0,s4_0);

// level 5
dsp_csa #(12) i_dsp_csa5_0({c4_0,1'b0},
                          {s4_0[10],s4_0},
                          {s3_1[9],s3_1[9],s3_1},
                          c5_0,s5_0);

always @(posedge CLK or posedge RESET)

   if (RESET)
      begin
         SOUT <= 12'h000;
         COUT <= 12'h000;
      end
   else
      begin
         SOUT <= s5_0;
         COUT <= c5_0;
      end

assign TAP0 = product_0;

assign C0 = coef_0;
assign C1 = coef_1;
assign C2 = coef_2;
assign C3 = coef_3;
assign C4 = coef_4;
assign C5 = coef_5;
assign C6 = coef_6;
assign C7 = coef_7;
assign C8 = coef_8;
assign C9 = coef_9;
assign C10 = coef_10;
assign C11 = coef_11;

endmodule

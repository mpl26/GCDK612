// Created by ihdl
module dsp_ff(DIN,ERROR,RESET,CLK,FAST_UPDATE,SOUT,COUT,FREEZE,FREEZE_CURSOR,
              CURSOR_INIT,MU,C1,C2,C3,C4,C5,DDELAY);

input    [5:0]    DIN;
input    [1:0]    ERROR;
input             RESET;
input             CLK;
input             FAST_UPDATE;
output   [9:0]    SOUT;
output   [9:0]    COUT;
output   [5:0]    DDELAY;  // Latency matched delayed version of DIN

// test modes
input             FREEZE;
input             FREEZE_CURSOR;
input    [2:0]    CURSOR_INIT;
input    [1:0]    MU;  // 00:2^-14 .. 11:2^-17
output   [7:0]    C1,C2,C4,C5;
output   [9:0]    C3;


reg      [5:0]    data_0, data_1, data_2, data_3;
reg      [5:0]    data_4, data_5, data_6, data_7;
reg      [5:0]    data_8;
reg      [9:0]    SOUT;
reg      [9:0]    COUT;
reg      [5:0]    count;

reg      freeze1;
reg      freeze2;
reg      freeze3;
reg      freeze4;
reg      freeze5;

wire     [7:0]   coef_1;
wire     [7:0]   coef_2;
wire     [9:0]   coef_3; // cursor
wire     [7:0]   coef_4;
wire     [7:0]   coef_5;

wire     [7:0]   product_1;
wire     [7:0]   product_2;
wire     [9:0]   product_3; // cursor
wire     [7:0]   product_4;
wire     [7:0]   product_5;

wire   [7:0]   c1,s1;
wire   [8:0]   c2,s2;
wire   [9:0]   c3,s3;

always @(posedge CLK or posedge RESET)
if (RESET)
   begin
      data_8 <= 6'b0;
      data_7 <= 6'b0;
      data_6 <= 6'b0;
      data_5 <= 6'b0;
      data_4 <= 6'b0;
      data_3 <= 6'b0;
      data_2 <= 6'b0;
      data_1 <= 6'b0;
      data_0 <= 6'h0;
   end
else
   begin
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

always @(posedge CLK or posedge RESET) 
begin
  if (RESET)
    count <= 6'b000000;
  else if (FAST_UPDATE)
    count <= 6'b000000;
  else
    count <= count + 6'b000001;
end


always @(count or FREEZE or FREEZE_CURSOR or FAST_UPDATE)
begin
   if (FAST_UPDATE) 
      begin  // update every cycle
         freeze1 = FREEZE;
         freeze2 = FREEZE;
         freeze3 = FREEZE_CURSOR;
         freeze4 = FREEZE;
         freeze5 = FREEZE;
      end
  else
      begin   // divide by 8 update
         freeze1 = ~((count[5:3]==3'b001)) | FREEZE;
         freeze2 = ~((count[5:3]==3'b010)) | FREEZE;
         freeze3 = ~((count[5:3]==3'b011)) | FREEZE_CURSOR;
         freeze4 = ~((count[5:3]==3'b100)) | FREEZE;
         freeze5 = ~((count[5:3]==3'b101)) | FREEZE;
      end
end

dsp_ff_update i_dsp_ff_update_1 ( .DATA(data_4),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .MU(MU),
                                  .COEF_OUT(coef_1),
                                  .FREEZE(freeze1));

dsp_ff_update i_dsp_ff_update_2 ( .DATA(data_5),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .MU(MU),
                                  .COEF_OUT(coef_2),
                                  .FREEZE(freeze2));

dsp_ff_update_cursor i_dsp_ff_update_cursor_3 ( .DATA(data_6),
                                                .ERROR(ERROR),
                                                .CLK(CLK),
                                                .RESET(RESET),
                                                .MU(MU),
                                                .COEF_OUT(coef_3),
                                                .FREEZE(freeze3),
                                                .CURSOR_INIT(CURSOR_INIT));

dsp_ff_update i_dsp_ff_update_4 ( .DATA(data_7),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .MU(MU),
                                  .COEF_OUT(coef_4),
                                  .FREEZE(freeze4));

dsp_ff_update i_dsp_ff_update_5 ( .DATA(data_8),
                                  .ERROR(ERROR),
                                  .CLK(CLK),
                                  .RESET(RESET),
                                  .MU(MU),
                                  .COEF_OUT(coef_5),
                                  .FREEZE(freeze5));

dsp_mult        m1(  .DATA    (data_0), 
                     .COEF    (coef_1), 
                     .CLK     (CLK), 
                     .PRODUCT (product_1),
                     .RESET   (RESET)
                     );

dsp_mult        m2(  .DATA    (data_1), 
                     .COEF    (coef_2), 
                     .CLK     (CLK), 
                     .PRODUCT (product_2),
                     .RESET   (RESET)
                     );

dsp_mult_cursor m3(  .DATA    (data_2), 
                     .COEF    (coef_3), 
                     .CLK     (CLK), 
                     .PRODUCT (product_3),
                     .RESET   (RESET)
                     );

dsp_mult        m4(  .DATA    (data_3), 
                     .COEF    (coef_4), 
                     .CLK     (CLK), 
                     .PRODUCT (product_4),
                     .RESET   (RESET)
                     );

dsp_mult        m5(  .DATA    (data_4), 
                     .COEF    (coef_5), 
                     .CLK     (CLK), 
                     .PRODUCT (product_5),
                     .RESET   (RESET)
                     );

// level 1
dsp_csa #(8) i_dsp_csa1(product_1,
                   product_2,
                   product_4,
                   c1,s1);

// level 2
dsp_csa #(9) i_dsp_csa2({s1[7],s1},
                   {c1,1'b0},
                   {product_5[7],product_5},
                    c2,s2);

// level 3
dsp_csa #(10) i_dsp_csa3(product_3,
                  {s2[8],s2},
                  {c2,1'b0},
                   c3,s3);

   always @(posedge CLK or posedge RESET)
      begin : p_SOUT
      if (RESET)
         begin
         SOUT <= 10'b0;
         COUT <= 10'b0;
         end
      else
         begin
         SOUT <= s3;
         COUT <= c3;
         end
      end // p_SOUT

   // DDELAY latency should match SOUT latency
   assign DDELAY = data_4;

   assign C1 = coef_1;
   assign C2 = coef_2;
   assign C3 = coef_3;
   assign C4 = coef_4;
   assign C5 = coef_5;

endmodule

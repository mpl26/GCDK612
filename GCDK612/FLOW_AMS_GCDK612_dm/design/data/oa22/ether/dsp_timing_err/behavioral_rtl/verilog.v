// Created by ihdl
module dsp_timing_err(SLICE,UNSLICE,CLK,RESET,TIMING_ERR,T_SEL);

input    [1:0]    SLICE;
input    [5:0]    UNSLICE;
input             CLK;
input             RESET;
output   [6:0]    TIMING_ERR;
input             T_SEL;      // 0:select 2T design, 1:select 1T design

reg      [6:0]    TIMING_ERR;

reg      [1:0]    slice_ff2;
reg      [1:0]    slice_ff;
reg      [5:0]    unslice_ff2;
reg      [5:0]    unslice_ff;
reg      [7:0]    t_err1;
reg      [7:0]    t_err2;
reg      [6:0]    t_err1_clip;
reg      [6:0]    t_err2_clip;
reg      [8:0]    t_err;

reg      [7:0]    mult1;
reg      [7:0]    mult2;
reg      [7:0]    mult3;
reg      [7:0]    mult4;


always @(posedge CLK or posedge RESET) 
if (RESET)
   begin
      slice_ff2   <= 2'b00;
      slice_ff    <= 2'b00;
      unslice_ff2 <= 6'b000000;
      unslice_ff  <= 6'b000000;
   end
else
   begin
      slice_ff2   <= slice_ff;
      slice_ff    <= SLICE;
      unslice_ff2 <= unslice_ff;
      unslice_ff  <= UNSLICE;
   end

always @(UNSLICE or slice_ff) 
begin
  case(slice_ff)
      2'b01: mult1 = {UNSLICE[5],UNSLICE[5],UNSLICE};    // +1
      2'b00: mult1 = 8'h00;                              //  0
      2'b11: mult1 = -{UNSLICE[5],UNSLICE[5],UNSLICE};   // -1
      2'b10: mult1 = 8'h00;                              // not used
  endcase
end

always @(SLICE or unslice_ff) 
begin
  case(SLICE)
      2'b01: mult2 = {unslice_ff[5],unslice_ff[5],unslice_ff};    // +1
      2'b00: mult2 = 8'h00;                                           //  0
      2'b11: mult2 = -{unslice_ff[5],unslice_ff[5],unslice_ff};   // -1
      2'b10: mult2 = 8'h00;                                           // not used
  endcase
end

always @(posedge CLK or posedge RESET) 
  if (RESET)
      t_err1 <= 8'h00;
  else
      t_err1 <= mult1 - mult2;

//clip
always @(t_err1) 
begin
  case(t_err1[7:6])
    2'b01: t_err1_clip = 7'b0111111;       // overflow pos
    2'b10: t_err1_clip = 7'b1000000;       // overflow neg
    2'b00: t_err1_clip = t_err1[6:0];      // no overflow
    2'b11: t_err1_clip = t_err1[6:0];      // no overflow
  endcase
end

// h+2/h-2

always @(UNSLICE or slice_ff2)
begin
  case(slice_ff2)
      2'b01: mult3 = {UNSLICE[5],UNSLICE[5],UNSLICE};    // +1
      2'b00: mult3 = 8'h00;                              //  0
      2'b11: mult3 = -{UNSLICE[5],UNSLICE[5],UNSLICE};   // -1
      2'b10: mult3 = 8'h00;                              // not used
  endcase
end

always @(SLICE or unslice_ff2) 
begin
  case(SLICE)
      2'b01: mult4 = {unslice_ff2[5],unslice_ff2[5],unslice_ff2};   // +1
      2'b00: mult4 = 8'h00;                                         //  0
      2'b11: mult4 = -{unslice_ff2[5],unslice_ff2[5],unslice_ff2};  // -1
      2'b10: mult4 = 8'h00;                                         // not used
  endcase
end

always @(posedge CLK or posedge RESET) 
   if (RESET)  
      t_err2 <= 8'h00;
   else
      t_err2 <= mult3 - mult4;



//clip
always @(t_err2 or T_SEL)
begin
  if (T_SEL)
    t_err2_clip = 0;
  else
    case(t_err2[7:6])
      2'b01: t_err2_clip = 7'b0111111;       // overflow pos
      2'b10: t_err2_clip = 7'b1000000;       // overflow neg
      2'b00: t_err2_clip = t_err2[6:0];      // no overflow
      2'b11: t_err2_clip = t_err2[6:0];      // no overflow
    endcase
end

// final add

always @(t_err1_clip or t_err2_clip) 
begin
  t_err =   {t_err1_clip[6],t_err1_clip,1'b0}
          - {t_err2_clip[6],t_err2_clip[6],t_err2_clip}; // t_err2_clip/2
end

//clip/trucate and latch
always @(posedge CLK or posedge RESET) 
if (RESET)
   TIMING_ERR <= 7'b0;
else begin
  case(t_err[8:7])
    2'b01: TIMING_ERR <= 7'b0111111;       // overflow pos
    2'b10: TIMING_ERR <= 7'b1000000;       // overflow neg
    2'b00: TIMING_ERR <= t_err[7:1];       // no overflow
    2'b11: TIMING_ERR <= t_err[7:1];       // no overflow
  endcase
end


endmodule

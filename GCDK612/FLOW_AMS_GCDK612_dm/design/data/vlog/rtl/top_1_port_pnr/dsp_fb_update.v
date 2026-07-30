// Created by ihdl
module dsp_fb_update(DATA,ERROR,CLK,RESET,COEF_OUT,MU,FREEZE);

input    [1:0]    DATA;
input    [1:0]    ERROR;
input             CLK;
input             RESET;
output   [7:0]    COEF_OUT;
// test modes
input    [1:0]    MU;
input             FREEZE;

reg      [17:0]   coefficient;
reg      [17:0]   scaled_mult;
wire     [18:0]   coef_i;
reg      [17:0]   coef_i_clip;
reg      [7:0]    COEF_OUT;
reg      [1:0]    error_freeze;
reg      [1:0]    mult;
wire     [10:0]   coef_round;

always @(ERROR or FREEZE) 
begin
  if (FREEZE)
    error_freeze = 2'b00;
  else
    error_freeze = ERROR;
end

    
always @(DATA or error_freeze) 
begin
  case(error_freeze)  
    2'b00: mult = 2'b00;
    2'b01: mult = DATA;
    2'b10: mult = 2'b00;
    2'b11: mult = -DATA;
  endcase
end


always @(mult or MU) 
begin
  case(MU)
    2'b00: scaled_mult = {mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult[1], mult[1], mult[1], mult, 3'b000};
    2'b01: scaled_mult = {mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult[1], mult[1], mult[1], mult[1], mult, 2'b00};
    2'b10: scaled_mult = {mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult, 1'b0};
    2'b11: scaled_mult = {mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult[1], mult[1], mult[1], mult[1], mult[1],
                          mult[1], mult};
  endcase
end


assign coef_i = {coefficient[17],coefficient} +
                {scaled_mult[17],scaled_mult};

// clip
always @(coef_i)
begin
  case(coef_i[18:17])
    2'b01: coef_i_clip = 18'b011111111111111111;  // overflow pos
    2'b10: coef_i_clip = 18'b100000000000000000;  // overflow neg
    2'b00: coef_i_clip = coef_i[17:0];            // no overflow
    2'b11: coef_i_clip = coef_i[17:0];            // no overflow
  endcase
end

always @(posedge CLK or posedge RESET)
begin
  if (RESET)
    coefficient <= 18'b000000000000000000;
  else
    coefficient <= coef_i_clip;
end

// round/clip
assign coef_round = {coefficient[17],coefficient[17:9]} + 10'b0000000001;

always @(posedge CLK or posedge RESET)
   if (RESET)
      COEF_OUT <= 8'b00000000;
   else
      case(coef_round[9:8]) 
         2'b01: COEF_OUT <= 8'b01111111;      // overflow pos
         2'b10: COEF_OUT <= coef_round[8:1];  // can't overflow neg
         2'b00: COEF_OUT <= coef_round[8:1];  // no overflow
         2'b11: COEF_OUT <= coef_round[8:1];  // no overflow
      endcase

endmodule

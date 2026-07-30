// Created by ihdl
module dsp_ff_update(DATA,ERROR,CLK,RESET,COEF_OUT,MU,FREEZE);

input   [5:0]   DATA;
input   [1:0]   ERROR;
input             CLK;
input      RESET;
output   [7:0]    COEF_OUT;
input      FREEZE;
input   [1:0]   MU;

reg   [22:0]    coefficient;
reg   [22:0]    scaled_mult;
reg   [23:0]    coef_i;
reg   [22:0]    coef_i_clip;

reg   [7:0]   COEF_OUT;
reg     [6:0]   se_data;
reg     [6:0]   mult;
reg   [1:0]   error_freeze;
wire    [9:0]   coef_round;

always @(FREEZE or DATA)
begin
  if (FREEZE)
    se_data = 7'b0000000;
  else
    se_data = {DATA[5],DATA};
end

always @(ERROR or se_data or FREEZE or error_freeze) 
begin
  if (FREEZE)
    error_freeze = 2'b00;
  else
      error_freeze = ERROR;
      case(error_freeze)
         2'b00: mult = 7'b0000000;
         2'b01: mult = se_data;
         2'b10: mult = 7'b0000000;
         2'b11: mult = -se_data;
  endcase
end

always @(mult or MU) 
begin
  case(MU)
    2'b00: scaled_mult = {mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult, 3'b000};
    2'b01: scaled_mult = {mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult, 2'b00};
    2'b10: scaled_mult = {mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult, 1'b0};
    2'b11: scaled_mult = {mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult};
  endcase
end

always @(posedge CLK or posedge RESET) 
begin
  if (RESET)
    coef_i <= 24'b00000000000000000000000;
  else
    coef_i <= {coefficient[22],coefficient} +
              {scaled_mult[22],scaled_mult};
end


// clip
always @(coef_i)
begin
  case(coef_i[23:22])
    2'b01: coef_i_clip = 23'b01111111111111111111111;  // overflow pos
    2'b10: coef_i_clip = 23'b10000000000000000000000;  // overflow neg
    2'b00: coef_i_clip = coef_i[22:0];                 // no overflow
    2'b11: coef_i_clip = coef_i[22:0];                 // no overflow
  endcase
end

always @(coef_i_clip)
    coefficient = coef_i_clip;

// round/clip
assign coef_round = {coefficient[22],coefficient[22:14]} + 10'b0000000001;

always @(posedge CLK or posedge RESET)

   if (RESET)
      COEF_OUT <= 8'b00000000; 
   else
      begin
         case(coef_round[9:8])
            2'b01: COEF_OUT <= 8'b01111111;      // overflow pos
            2'b10: COEF_OUT <= coef_round[8:1];  // can't overflow neg
            2'b00: COEF_OUT <= coef_round[8:1];  // no overflow
            2'b11: COEF_OUT <= coef_round[8:1];  // no overflow
         endcase
      end

endmodule

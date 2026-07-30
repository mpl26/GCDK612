// Created by ihdl
module dsp_ff_update_cursor(DATA,ERROR,CLK,RESET,COEF_OUT,MU,FREEZE,
                            CURSOR_INIT);

input   [5:0]   DATA;
input   [1:0]   ERROR;
input             CLK;
input      RESET;
output   [9:0]    COEF_OUT;
// test
input      FREEZE;
input   [2:0]   CURSOR_INIT;
input   [1:0]   MU;

reg   [24:0]    coefficient;
reg   [24:0]    scaled_mult;
reg   [25:0]    coef_i;
reg   [24:0]    coef_i_clip;

reg   [9:0]    COEF_OUT;
reg     [6:0]   se_data;
reg     [6:0]   mult;
reg   [1:0]   error_freeze;
reg   [1:0]    count;

wire    [11:0]   coef_round;

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
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult, 3'b000};
    2'b01: scaled_mult = {mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult, 2'b00};
    2'b10: scaled_mult = {mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult, 1'b0};
    2'b11: scaled_mult = {mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult[6], mult[6],
                          mult[6], mult[6], mult[6], mult};
  endcase
end


always @(posedge CLK or posedge RESET)

   if (RESET)
      count <= 2'b00;
   else if (count != 2'b11)
      count <= count + 2'b01;
   else
      count <= count;




always @(posedge CLK or posedge RESET)
  if (RESET)
    coef_i <= {2'b0,3'b000,21'b000000000000000000000};
  else if (count == 2'b10)
    coef_i <= {2'b0,CURSOR_INIT,21'b000000000000000000000};
  else
    coef_i <= {coefficient[24],coefficient} +
              {scaled_mult[24],scaled_mult};

// clip
always @(coef_i)
begin
  case(coef_i[25:24]) 
    2'b01: coef_i_clip = 25'b0111111111111111111111111;  // overflow pos
    2'b10: coef_i_clip = 25'b1000000000000000000000000;  // overflow neg
    2'b00: coef_i_clip = coef_i[24:0];                   // no overflow
    2'b11: coef_i_clip = coef_i[24:0];                   // no overflow
  endcase
end

always @(coef_i_clip)
    coefficient = coef_i_clip;

// round/clip
assign coef_round = {coefficient[24],coefficient[24:14]} + 12'b000000000001;

always @(posedge CLK or posedge RESET)

   if (RESET)
      COEF_OUT <= 10'b0000000000; 
   else
      begin
         case(coef_round[11:10])
            2'b01: COEF_OUT <= 10'b0111111111;      // overflow pos
            2'b10: COEF_OUT <= coef_round[10:1];  // can't overflow neg
            2'b00: COEF_OUT <= coef_round[10:1];  // no overflow
            2'b11: COEF_OUT <= coef_round[10:1];  // no overflow
         endcase
      end

endmodule

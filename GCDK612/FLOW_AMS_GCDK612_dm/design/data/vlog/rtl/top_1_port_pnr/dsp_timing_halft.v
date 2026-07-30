// Created by ihdl
module dsp_timing_halft(ADC_TIMING,SLICE,TIMING_ERR_1T,TIMING_MODE,CLK,RESET,
         TIMING_ERR);

input    [2:0]    ADC_TIMING;
input    [1:0]    SLICE;
input    [6:0]    TIMING_ERR_1T;
input             TIMING_MODE;   // 1:select Half-T design, 0:select 1-T design
input             CLK;
input             RESET;
output   [6:0]    TIMING_ERR;

wire     [6:0]    TIMING_ERR;

reg      [2:0]    adc_timing_d1, adc_timing_d2;
reg      [1:0]    slice_d1;
reg      [2:0]    neg_adc_timing_d1, neg_adc_timing_d2;
reg      [2:0]    neg_slice_d1;
reg               code_1_detected;
reg               code_1_detected_d1;
reg               poscode_detected;
reg               poscode_detected_d1;
reg      [2:0]    top_out, bottom_out;



always @(posedge CLK or posedge RESET) 
begin
  if (RESET) begin
    adc_timing_d1 <= 3'b000;
    slice_d1      <= 2'b00;
  end
  else begin
    adc_timing_d1 <= ADC_TIMING;
    slice_d1      <= SLICE;
  end
end

// Top path of SPW Diagram

always @(posedge CLK or posedge RESET) 
begin
  if (RESET) begin
    code_1_detected <= 1'b0;
    code_1_detected_d1 <= 1'b0;
  end
  else begin
    code_1_detected <= (slice_d1 == 2'b01);
    code_1_detected_d1 <= code_1_detected;
  end
end

always @(posedge CLK or posedge RESET) 
begin
  if (RESET) begin
    adc_timing_d2 <= 3'b000;
  end
  else begin
    adc_timing_d2 <= adc_timing_d1;
  end
end

always @(posedge CLK or posedge RESET) 
begin
  if (RESET)
    top_out <= 3'b000;
  else begin
    if (code_1_detected_d1 & !code_1_detected)
      top_out <= adc_timing_d2;
    else
      if (!code_1_detected_d1 & code_1_detected)
        top_out <= neg_adc_timing_d2;
      else
        top_out <= 3'b000;
  end
end

// Bottom path of SPW diagram

always @(posedge CLK or posedge RESET) 
begin
  if (RESET) begin
    neg_adc_timing_d2 <= 3'b000;
  end
  else begin
    neg_adc_timing_d2 <= neg_adc_timing_d1;
  end
end

always @(adc_timing_d1) 
begin
  case (adc_timing_d1) 
    3'b000: neg_adc_timing_d1 = 3'b000;
    3'b001: neg_adc_timing_d1 = 3'b111;
    3'b010: neg_adc_timing_d1 = 3'b110;
    3'b011: neg_adc_timing_d1 = 3'b101;
    3'b100: neg_adc_timing_d1 = 3'b000; // This case never occurs,
                // choose easy to generate output
    3'b101: neg_adc_timing_d1 = 3'b011;
    3'b110: neg_adc_timing_d1 = 3'b010;
    3'b111: neg_adc_timing_d1 = 3'b001;
  endcase
end

always @(slice_d1)
begin
  case (slice_d1)
    2'b00: neg_slice_d1 = 3'b000;
    2'b01: neg_slice_d1 = 3'b111;
    2'b10: neg_slice_d1 = 3'b000;   // This case never occurs, choose easy
    2'b11: neg_slice_d1 = 3'b001;
  endcase
end

always @(posedge CLK or posedge RESET)
  if (RESET)
    poscode_detected <= 1'b0;
  else
    poscode_detected <= (neg_slice_d1[2] == 1'b0) & (neg_slice_d1[1] == 1'b1 |
                    (neg_slice_d1[0] == 1'b1) );

always @(posedge CLK or posedge RESET) 
begin
  if (RESET)
    poscode_detected_d1 <= 1'b0;
  else
    poscode_detected_d1 <= poscode_detected;
end

always @(posedge CLK or posedge RESET) 
begin
  if (RESET)
    bottom_out <= 3'b000;
  else begin
    if (poscode_detected_d1 & !poscode_detected)
      bottom_out <= neg_adc_timing_d2;
    else
      if (!poscode_detected_d1 & poscode_detected)
        bottom_out <= adc_timing_d2;
      else
        bottom_out <= 3'b000;
  end
end

assign TIMING_ERR = TIMING_MODE ? {(top_out | bottom_out),4'b0000} :
              TIMING_ERR_1T;

endmodule

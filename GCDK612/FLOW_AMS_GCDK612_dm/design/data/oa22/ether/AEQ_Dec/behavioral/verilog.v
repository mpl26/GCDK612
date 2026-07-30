// Verilog HDL for "umc05001/analog_eq_5_14_decode"
// This block is a 5 to 14 bit decoder.  
//
// Updated to match ahdl (Luca Ravezzi 12/15/00)
// By Tom Wilson 1/29/01
//
//
// input:  agc_eq        (5 bits) from DSP
//         timing_modes  (1 bit)  from DSP, sets decode for T/2 timing
// output: zero          (7 bits) control zero freq
//         pole 	 (2 bits) control bandlimit pole freq
//         gain 	 (5 bits) control gain 
//	   agc_eq_bypass (1 bit)  from DSP, sets bypass mode for testing

module AEQ_Dec (gain, pole, zero,  agc_eq, timing_mode, agc_eq_bypass);

    output [4:0] gain;
    output [1:0] pole;
    output [6:0] zero;

    input [4:0] agc_eq;
    input timing_mode;
    input agc_eq_bypass;

    reg [13:0] output_bits;

    wire [6:0] zero = output_bits[13:7];
    wire [1:0] pole = output_bits[6:5];
    wire [4:0] gain = output_bits[4:0];

always @(agc_eq or timing_mode or agc_eq_bypass) begin

  if (agc_eq_bypass) begin
  
     //                     Zero      Pole     Gain
  	output_bits = { 7'b000_0000, 2'b00, 5'b10000 };
	
  end else if (!timing_mode) begin
     // T Space Mode 
     case(agc_eq[4:0])
     //                         Zero      Pole     Gain
     5'd00: output_bits = { 7'b000_0000, 2'b10, 5'b00001 }; //
     5'd01: output_bits = { 7'b000_0001, 2'b10, 5'b00001 }; //
     5'd02: output_bits = { 7'b000_0000, 2'b01, 5'b00001 }; //
     5'd03: output_bits = { 7'b000_0010, 2'b01, 5'b00001 }; //
     5'd04: output_bits = { 7'b000_0100, 2'b01, 5'b00001 }; //
     5'd05: output_bits = { 7'b000_0100, 2'b01, 5'b00010 }; //
     5'd06: output_bits = { 7'b000_0110, 2'b01, 5'b00010 }; //
     5'd07: output_bits = { 7'b000_0110, 2'b01, 5'b00100 }; //
     5'd08: output_bits = { 7'b000_1000, 2'b01, 5'b00100 }; //
     5'd09: output_bits = { 7'b000_1000, 2'b01, 5'b01000 }; //
     5'd10: output_bits = { 7'b000_1010, 2'b00, 5'b01000 }; //
     5'd11: output_bits = { 7'b000_1010, 2'b00, 5'b10000 }; //
     5'd12: output_bits = { 7'b000_1100, 2'b00, 5'b10000 }; //
     5'd13: output_bits = { 7'b001_0001, 2'b00, 5'b10000 }; //
     5'd14: output_bits = { 7'b001_0010, 2'b00, 5'b10000 }; //
     5'd15: output_bits = { 7'b001_0111, 2'b00, 5'b10000 }; //
     5'd16: output_bits = { 7'b001_1111, 2'b01, 5'b10000 }; //
     5'd17: output_bits = { 7'b010_0010, 2'b01, 5'b10000 }; //
     5'd18: output_bits = { 7'b010_0111, 2'b01, 5'b10000 }; //
     5'd19: output_bits = { 7'b010_1110, 2'b01, 5'b10000 }; //
     5'd20: output_bits = { 7'b011_0011, 2'b01, 5'b10000 }; //
     5'd21: output_bits = { 7'b011_0110, 2'b01, 5'b10000 }; //
     5'd22: output_bits = { 7'b011_1111, 2'b10, 5'b10000 }; //
     5'd23: output_bits = { 7'b100_0110, 2'b10, 5'b10000 }; //
     5'd24: output_bits = { 7'b100_1101, 2'b10, 5'b10000 }; //
     5'd25: output_bits = { 7'b101_0100, 2'b10, 5'b10000 }; //
     5'd26: output_bits = { 7'b101_1001, 2'b10, 5'b10000 }; //
     5'd27: output_bits = { 7'b110_0001, 2'b10, 5'b10000 }; //
     5'd28: output_bits = { 7'b110_1100, 2'b10, 5'b10000 }; //
     5'd29: output_bits = { 7'b111_0000, 2'b10, 5'b10000 }; //
     5'd30: output_bits = { 7'b111_0101, 2'b10, 5'b10000 }; //
     5'd31: output_bits = { 7'b111_1111, 2'b10, 5'b10000 }; //
     endcase
     
  end else

     // T/2 space Mode
     case(agc_eq[4:0])
     //                         Zero      Pole     Gain
     5'd00: output_bits = { 7'b000_0000, 2'b01, 5'b00001 };
     5'd01: output_bits = { 7'b000_0001, 2'b01, 5'b00001 };
     5'd02: output_bits = { 7'b000_0000, 2'b00, 5'b00001 };
     5'd03: output_bits = { 7'b000_0010, 2'b00, 5'b00001 };
     5'd04: output_bits = { 7'b000_0100, 2'b00, 5'b00001 };
     5'd05: output_bits = { 7'b000_0100, 2'b00, 5'b00010 };
     5'd06: output_bits = { 7'b000_0110, 2'b00, 5'b00010 };
     5'd07: output_bits = { 7'b000_0110, 2'b00, 5'b00100 };
     5'd08: output_bits = { 7'b000_1000, 2'b00, 5'b00100 };
     5'd09: output_bits = { 7'b000_1000, 2'b00, 5'b01000 };
     5'd10: output_bits = { 7'b000_1010, 2'b00, 5'b01000 };
     5'd11: output_bits = { 7'b000_1010, 2'b00, 5'b10000 };
     5'd12: output_bits = { 7'b000_1100, 2'b00, 5'b10000 };
     5'd13: output_bits = { 7'b001_0001, 2'b00, 5'b10000 };
     5'd14: output_bits = { 7'b001_0010, 2'b00, 5'b10000 };
     5'd15: output_bits = { 7'b001_0111, 2'b00, 5'b10000 };
     5'd16: output_bits = { 7'b001_1111, 2'b01, 5'b10000 };
     5'd17: output_bits = { 7'b010_0010, 2'b01, 5'b10000 };
     5'd18: output_bits = { 7'b010_0111, 2'b01, 5'b10000 };
     5'd19: output_bits = { 7'b010_1110, 2'b01, 5'b10000 };
     5'd20: output_bits = { 7'b011_0011, 2'b01, 5'b10000 };
     5'd21: output_bits = { 7'b011_0110, 2'b01, 5'b10000 };
     5'd22: output_bits = { 7'b011_1111, 2'b10, 5'b10000 };
     5'd23: output_bits = { 7'b100_0110, 2'b10, 5'b10000 };
     5'd24: output_bits = { 7'b100_1101, 2'b10, 5'b10000 };
     5'd25: output_bits = { 7'b101_0100, 2'b10, 5'b10000 };
     5'd26: output_bits = { 7'b101_1001, 2'b10, 5'b10000 };
     5'd27: output_bits = { 7'b110_0001, 2'b10, 5'b10000 };
     5'd28: output_bits = { 7'b110_1100, 2'b10, 5'b10000 };
     5'd29: output_bits = { 7'b111_0000, 2'b10, 5'b10000 };
     5'd30: output_bits = { 7'b111_0101, 2'b10, 5'b10000 };
     5'd31: output_bits = { 7'b111_1111, 2'b10, 5'b10000 };
     endcase
end

endmodule


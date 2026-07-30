// Verilog HDL for "umc05001", "dig_tx10_filter" "behavioral"


// 2's complement values
`define neg_13 5'b10011
`define neg_12 5'b10100
`define neg_9  5'b10111
`define neg_8  5'b11000
`define neg_7  5'b11001
`define neg_6  5'b11010
`define neg_5  5'b11011
`define zero   5'b00000
`define pos_5  5'b00101
`define pos_6  5'b00110
`define pos_7  5'b00111
`define pos_8  5'b01000
`define pos_9  5'b01001
`define pos_12 5'b01100
`define pos_13 5'b01101


module dig_tx10_filter( ENC_DATA, EOF_HOLD, TXD_B1_0, FILT_ENAB, LINK_DOWN,
                        LINK_GEN_PULSE, AN_PULSE, MR_BYPASS10TX_FILTER,
                        MR_100MBS, CFG1_I,
                        CLKFASTD8, CLKFAST, CLKFASTN,
                        RESET, RESETF,
                        DACDATA );

input           ENC_DATA;       // Manchester encoded data
input           EOF_HOLD;       // 1= Hold filter output constant for EOF marker
input   [1:0]   TXD_B1_0;       // Lowest two bits of txd
input           FILT_ENAB;      // Filter Enable
input           LINK_DOWN;      // 1= Link is down
input           LINK_GEN_PULSE; // 1= Transmit a link gen pulse
input           AN_PULSE;       // 1= Transmit an autoneg link pulse
input           MR_BYPASS10TX_FILTER; // 1= Bypass this filter
input           MR_100MBS;      // 1= 100 MB/s Link Speed
input           CFG1_I;         // CFG1 Pin from Pad
input           CLKFASTD8;      // 20 MHz Clock or 15.5 MHz clock with Autoneg
input           CLKFAST;        // 160 MHz Clock or 125 MHz clock with Autoneg
input           CLKFASTN;       // Inverted 160 or 125 MHz Clock
input           RESET;          // System RESET, active high
input           RESETF;

output  [4:0]   DACDATA;        // Filter output to DAC

reg     [4:0]   DACDATA;
reg     [4:0]   tabledata, lgpulsedata, anpulsedata;
reg     [3:0]   lg_pulse_count, an_pulse_count;

reg     [2:0]   clkcount;
reg             data_prev, lg_pulse_prev, an_pulse_prev;
reg             prev1_clkfastd8, prev2_clkfastd8, prev3_clkfastd8;
reg             prev4_clkfastd8;
reg             prev1_cfg1, prev2_cfg1, prev3_cfg1;

wire            pulse = LINK_GEN_PULSE | AN_PULSE;
wire            start_count;

always @(posedge CLKFASTD8 or posedge RESET) begin
    if (RESET) begin
        data_prev <= 1'b1;
    end
    else if (FILT_ENAB)
            data_prev <= ENC_DATA;
         else
            data_prev <= 1'b1;
end

always @(posedge CLKFAST or posedge RESET) begin
    if (RESET) begin
        lg_pulse_prev <= 1'b0;
        an_pulse_prev <= 1'b0;
    end
    else begin
        lg_pulse_prev <= LINK_GEN_PULSE;
        an_pulse_prev <= AN_PULSE;
    end
end

always @(posedge CLKFAST or posedge RESET) begin
    if (RESET) begin
        prev1_cfg1 <= 1'b1;
        prev2_cfg1 <= 1'b1;
        prev3_cfg1 <= 1'b1;
    end
    else begin
        prev1_cfg1 <= CFG1_I;
        prev2_cfg1 <= prev1_cfg1;
        prev3_cfg1 <= prev2_cfg1;
    end
end

// Single-Phase Clock Implementation (commented out)
// always @(negedge CLKFAST) begin
always @(posedge CLKFASTN or posedge RESETF) begin
    if (RESETF) begin
        prev4_clkfastd8 <= 1'b1;
        prev3_clkfastd8 <= 1'b1;
        prev2_clkfastd8 <= 1'b1;
        prev1_clkfastd8 <= 1'b1;
    end
    else begin
        prev4_clkfastd8 <= prev3_clkfastd8;
        prev3_clkfastd8 <= prev2_clkfastd8;
        prev2_clkfastd8 <= prev1_clkfastd8;
        prev1_clkfastd8 <= CLKFASTD8;
    end
end

assign start_count = !prev1_clkfastd8 & !prev2_clkfastd8 & !prev3_clkfastd8 &
                        !prev4_clkfastd8;

always @(posedge CLKFAST or posedge RESET) begin
    if (RESET) begin
        clkcount <= 3'd0;
    end
    else begin
        if (start_count)
            clkcount <= 3'd0;
        else
            clkcount <= clkcount + 3'd1;
    end
end

`define lg_max 14
always @(posedge CLKFAST or posedge RESET) begin
    if (RESET) begin
        lg_pulse_count <= 4'd0;
    end
    else
        if (({lg_pulse_prev,LINK_GEN_PULSE} == 2'b01) |
            (!MR_100MBS & {prev3_cfg1,prev2_cfg1} == 2'b01))
            lg_pulse_count <= 4'd1;
        else
            if (lg_pulse_count > 4'd0 && lg_pulse_count < `lg_max)
                lg_pulse_count <= lg_pulse_count + 4'd1;
            else
                lg_pulse_count <= 4'd0;
end

`define an_max 11
always @(posedge CLKFAST or posedge RESET) begin
    if (RESET) begin
        an_pulse_count <= 4'd0;
    end
    else
        if (({an_pulse_prev,AN_PULSE} == 2'b01) |
            (MR_100MBS & {prev3_cfg1,prev2_cfg1} == 2'b01))
            an_pulse_count <= 4'd1;
        else
            if (an_pulse_count > 4'd0 && an_pulse_count < `an_max)
                an_pulse_count <= an_pulse_count + 4'd1;
            else
                an_pulse_count <= 4'd0;
end

always @(ENC_DATA or data_prev or clkcount) begin
    case ({ENC_DATA,data_prev}) //synopsys full_case parallel_case
        2'b00:  case (clkcount) //synopsys full_case parallel_case
                        3'd0: tabledata = `neg_9;
                        3'd1: tabledata = `neg_8;
                        3'd2: tabledata = `neg_7;
                        3'd3: tabledata = `neg_7;
                        3'd4: tabledata = `neg_6;
                        3'd5: tabledata = `neg_6;
                        3'd6: tabledata = `neg_5;
                        3'd7: tabledata = `neg_5;
                endcase
        2'b01:  case (clkcount) //synopsys full_case parallel_case
                        3'd0: tabledata = `pos_5;
                        3'd1: tabledata = `zero;
                        3'd2: tabledata = `neg_5;
                        3'd3: tabledata = `neg_9;
                        3'd4: tabledata = `neg_12;
                        3'd5: tabledata = `neg_13;
                        3'd6: tabledata = `neg_12;
                        3'd7: tabledata = `neg_9;
                endcase
        2'b10:  case (clkcount) //synopsys full_case parallel_case
                        3'd0: tabledata = `neg_5;
                        3'd1: tabledata = `zero;
                        3'd2: tabledata = `pos_5;
                        3'd3: tabledata = `pos_9;
                        3'd4: tabledata = `pos_12;
                        3'd5: tabledata = `pos_13;
                        3'd6: tabledata = `pos_12;
                        3'd7: tabledata = `pos_9;
                endcase
        2'b11:  case (clkcount) //synopsys full_case parallel_case
                        3'd0: tabledata = `pos_9;
                        3'd1: tabledata = `pos_8;
                        3'd2: tabledata = `pos_7;
                        3'd3: tabledata = `pos_7;
                        3'd4: tabledata = `pos_6;
                        3'd5: tabledata = `pos_6;
                        3'd6: tabledata = `pos_5;
                        3'd7: tabledata = `pos_5;
                endcase
    endcase
end

always @(lg_pulse_count) begin
        case (lg_pulse_count) //synopsys full_case parallel_case
            4'd0: lgpulsedata = `zero;
            4'd1: lgpulsedata = `pos_5;
            4'd2: lgpulsedata = `pos_9;
            4'd3: lgpulsedata = `pos_12;
            4'd4,4'd5,4'd6,4'd7: lgpulsedata = `pos_13;
            4'd8: lgpulsedata = `pos_12;
            4'd9: lgpulsedata = `pos_9;
            4'd10,4'd11,4'd12,4'd13,4'd14: lgpulsedata = `pos_5;
            4'd15: lgpulsedata = `zero;
        endcase
end

always @(an_pulse_count) begin
        case (an_pulse_count) //synopsys full_case parallel_case
            4'd0: anpulsedata = `zero;
            4'd1: anpulsedata = `pos_5;
            4'd2: anpulsedata = `pos_9;
            4'd3,4'd4,4'd5,4'd6: anpulsedata = `pos_13;
            4'd7: anpulsedata = `pos_9;
            4'd8,4'd9,4'd10,4'd11: anpulsedata = `pos_5;
            4'd12,4'd13,4'd14,4'd15: anpulsedata = `zero;
        endcase
end

wire pulse_on = (lg_pulse_count != 4'd0) | an_pulse_count != 4'd0;

always @(posedge CLKFAST or posedge RESET) begin
    if (RESET)
        DACDATA <= 5'd0;
    else begin
        casex ({MR_BYPASS10TX_FILTER,LINK_DOWN,FILT_ENAB,EOF_HOLD,
                pulse_on}) //synopsys parallel_case
            5'b1xxxx: casex (TXD_B1_0) //synopsys full_case parallel_case
                          2'b1x: DACDATA <= `zero;
                          2'b01: DACDATA <= `pos_13;
                          2'b00: DACDATA <= `neg_13;
                      endcase
            5'b01xx0: DACDATA <= `zero;
            5'b001x0: DACDATA <= tabledata;
  //
  //             5'b00010: DACDATA <= DACDATA; // Unspecified gives
                                                         // same results
  //
            5'b0xxx1: DACDATA <= lgpulsedata | anpulsedata;
            5'b00000: DACDATA <= `zero;
        endcase
    end
end

endmodule

// Created by ihdl
module dig_tx10_filter(
                       //Inputs
                       ENC_DATA,
                       EOF_HOLD,
                       TXD_B1_0,
                       FILT_ENAB,
                       LINK_DOWN,
                       LINK_GEN_PULSE,
                       AN_PULSE,
                       MR_BYPASS10TX_FILTER,
                       MR_100MBS,
                       CFG1_I,
                       CLKPLL_IN,
                       clkfast_enable,
                       clkfastd8_gate,
                       RESET,

                       //Output
                       DACDATA 
                       );

input         ENC_DATA;             // Manchester encoded data
input         EOF_HOLD;             // 1= Hold filter o/p constant EOF marker
input [1:0]   TXD_B1_0;             // Lowest two bits of txd
input         FILT_ENAB;            // Filter Enable
input         LINK_DOWN;            // 1= Link is down
input         LINK_GEN_PULSE;       // 1= Transmit a link gen pulse
input         AN_PULSE;             // 1= Transmit an autoneg link pulse
input         MR_BYPASS10TX_FILTER; // 1= Bypass this filter
input         MR_100MBS;            // 1= 100 MB/s Link Speed
input         CFG1_I;               // CFG1 Pin from Pad
input         CLKPLL_IN;            // System Clock
input         clkfast_enable;       // Fast clock enable
input         clkfastd8_gate;       // Gate 20MHz Clk/15.5MHz clk with Autoneg
input         RESET;                // System RESET, active high

output [4:0]  DACDATA;              // Filter output to DAC
//
// I/O Type Declarations
//
wire          ENC_DATA;            
wire          EOF_HOLD;            
wire  [1:0]   TXD_B1_0;            
wire          FILT_ENAB;           
wire          LINK_DOWN;           
wire          LINK_GEN_PULSE;      
wire          AN_PULSE;            
wire          MR_BYPASS10TX_FILTER;
wire          MR_100MBS;           
wire          CFG1_I;
wire          CLKPLL_IN;     
wire          clkfast_enable;              
wire          clkfastd8_gate;      
wire          RESET;               

reg  [4:0]    DACDATA;

//
// Internal Signal Declarations
//
reg  [4:0]    tabledata;
reg  [4:0]    lgpulsedata;
reg  [4:0]    anpulsedata;
reg  [3:0]    lg_pulse_count;
reg  [3:0]    an_pulse_count;
reg  [2:0]    clkcount;
reg           data_prev;
reg           lg_pulse_prev;
reg           an_pulse_prev;
reg           prev1_cfg1;
reg           prev2_cfg1;
reg           prev3_cfg1;
wire          pulse;
wire          pulse_on;

//
// Parameter Declarations
//
// 2's complement values
`define neg_13 5'b10011
`define	neg_12 5'b10100
`define	neg_9  5'b10111
`define	neg_8  5'b11000
`define	neg_7  5'b11001
`define	neg_6  5'b11010
`define	neg_5  5'b11011
`define	zero   5'b00000
`define	pos_5  5'b00101
`define	pos_6  5'b00110
`define	pos_7  5'b00111
`define	pos_8  5'b01000
`define	pos_9  5'b01001
`define	pos_12 5'b01100
`define	pos_13 5'b01101

`define lg_max 14
`define an_max 11

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
   assign pulse = LINK_GEN_PULSE | AN_PULSE;

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_data_prev
      if (RESET)
         data_prev <= 1'b1;
      else if (clkfastd8_gate) 
         if (FILT_ENAB)
            data_prev <= ENC_DATA;
         else
            data_prev <= 1'b1;
      else
            data_prev <= data_prev;
      end // p_data_prev

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_pulse_prev
      if (RESET)
         begin
         lg_pulse_prev <= 1'b0;
         an_pulse_prev <= 1'b0;
         end
      else if (clkfast_enable)
         begin
         lg_pulse_prev <= LINK_GEN_PULSE;
         an_pulse_prev <= AN_PULSE;
         end
      else
         begin
         lg_pulse_prev <= lg_pulse_prev;
         an_pulse_prev <= an_pulse_prev;
         end
      end // p_pulse_prev

//------------------------------------------------------------------------------
// This process synchronises CFG1_I to the CLKPLL_IN 
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_cfg1
      if (RESET)
         begin
         prev1_cfg1 <= 1'b1;
         prev2_cfg1 <= 1'b1;
         prev3_cfg1 <= 1'b1;
         end
      else if (clkfast_enable)
         begin
         prev1_cfg1 <= CFG1_I;
         prev2_cfg1 <= prev1_cfg1;
         prev3_cfg1 <= prev2_cfg1;
         end
      else
         begin
         prev1_cfg1 <= prev1_cfg1;
         prev2_cfg1 <= prev2_cfg1;
         prev3_cfg1 <= prev3_cfg1;
         end
      end // p_cfg1

//------------------------------------------------------------------------------
// This process counts to 8 and is reset by the clkfastd8_gate signal on the
// eighth pulse.
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_clkcount
      if (RESET)
         clkcount <= 3'd0;
      else if (clkfast_enable)
         begin
         if (clkfastd8_gate)
            clkcount <= 3'd0;
         else
            clkcount <= clkcount + 3'd1;
         end
      else
         clkcount <= clkcount;
      end // p_clkcount

//------------------------------------------------------------------------------
// This process counts clocks when it a LINK_GEN_PULSE edge is detected upto a
// an `lg_max max value
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_lg_pulse
      if (RESET)
         lg_pulse_count <= 4'd0;
      else if (clkfast_enable)
         if (({lg_pulse_prev,LINK_GEN_PULSE} == 2'b01) |
               (!MR_100MBS & {prev3_cfg1,prev2_cfg1} == 2'b01))
            lg_pulse_count <= 4'd1;
         else
            if (lg_pulse_count > 4'd0 && lg_pulse_count < `lg_max)
               lg_pulse_count <= lg_pulse_count + 4'd1;
            else
               lg_pulse_count <= 4'd0;
      else
         lg_pulse_count <= lg_pulse_count;
      end // p_lg_pulse

//------------------------------------------------------------------------------
// This process counts clocks when it a AN_PULSE edge is detected upto a 
// maximum of `an_max
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_an_pulse_count
      if (RESET)
         an_pulse_count <= 4'd0;
      else if (clkfast_enable)
         if (({an_pulse_prev,AN_PULSE} == 2'b01) |
              (MR_100MBS & {prev3_cfg1,prev2_cfg1} == 2'b01))
            an_pulse_count <= 4'd1;
         else
            if (an_pulse_count > 4'd0 && an_pulse_count < `an_max)
               an_pulse_count <= an_pulse_count + 4'd1;
            else
               an_pulse_count <= 4'd0;
      else
         an_pulse_count <= an_pulse_count;
      end // p_an_pulse_count

//------------------------------------------------------------------------------
// This process is used to determine the DAC value from the ENC_DATA and its
// previous value.
//------------------------------------------------------------------------------
//
   always @(ENC_DATA or data_prev or clkcount)
      begin : p_tabledata
      case ({ENC_DATA,data_prev})   //synopsys full_case parallel_case
         2'b00: case (clkcount)     //synopsys full_case parallel_case
                   3'd0: tabledata = `neg_9;
                   3'd1: tabledata = `neg_8;
                   3'd2: tabledata = `neg_7;
                   3'd3: tabledata = `neg_7;
                   3'd4: tabledata = `neg_6;
                   3'd5: tabledata = `neg_6;
                   3'd6: tabledata = `neg_5;
                   3'd7: tabledata = `neg_5;
                endcase
         2'b01: case (clkcount)     //synopsys full_case parallel_case
                   3'd0: tabledata = `pos_5;
                   3'd1: tabledata = `zero;
                   3'd2: tabledata = `neg_5;
                   3'd3: tabledata = `neg_9;
                   3'd4: tabledata = `neg_12;
                   3'd5: tabledata = `neg_13;
                   3'd6: tabledata = `neg_12;
                   3'd7: tabledata = `neg_9;
                endcase
         2'b10: case (clkcount)     //synopsys full_case parallel_case
                   3'd0: tabledata = `neg_5;
                   3'd1: tabledata = `zero;
                   3'd2: tabledata = `pos_5;
                   3'd3: tabledata = `pos_9;
                   3'd4: tabledata = `pos_12;
                   3'd5: tabledata = `pos_13;
                   3'd6: tabledata = `pos_12;
                   3'd7: tabledata = `pos_9;
                endcase
         2'b11: case (clkcount)     //synopsys full_case parallel_case
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
      end // p_tabledata

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(lg_pulse_count)
      begin : p_lgpulsedata
      case (lg_pulse_count)         //synopsys full_case parallel_case
         4'd0:  lgpulsedata = `zero;
         4'd1:  lgpulsedata = `pos_5;
         4'd2:  lgpulsedata = `pos_9;
         4'd3:  lgpulsedata = `pos_12;
         4'd4:  lgpulsedata = `pos_13;
         4'd5:  lgpulsedata = `pos_13;
         4'd6:  lgpulsedata = `pos_13;
         4'd7:  lgpulsedata = `pos_13;
         4'd8:  lgpulsedata = `pos_12;
         4'd9:  lgpulsedata = `pos_9;
         4'd10: lgpulsedata = `pos_5;
         4'd11: lgpulsedata = `pos_5;
         4'd12: lgpulsedata = `pos_5;
         4'd13: lgpulsedata = `pos_5;
         4'd14: lgpulsedata = `pos_5;
         4'd15: lgpulsedata = `zero;
      endcase
      end // p_lgpulsedata

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(an_pulse_count)
      begin : p_anpulsedata
      case (an_pulse_count) //synopsys full_case parallel_case
         4'd0:  anpulsedata = `zero;
         4'd1:  anpulsedata = `pos_5;
         4'd2:  anpulsedata = `pos_9;
         4'd3:  anpulsedata = `pos_13;
         4'd4:  anpulsedata = `pos_13;
         4'd5:  anpulsedata = `pos_13;
         4'd6:  anpulsedata = `pos_13;
         4'd7:  anpulsedata = `pos_9;
         4'd8:  anpulsedata = `pos_5;
         4'd9:  anpulsedata = `pos_5;
         4'd10: anpulsedata = `pos_5;
         4'd11: anpulsedata = `pos_5;
         4'd12: anpulsedata = `zero;
         4'd13: anpulsedata = `zero;
         4'd14: anpulsedata = `zero;
         4'd15: anpulsedata = `zero;
      endcase
      end // p_anpulsedata

   assign pulse_on = (lg_pulse_count != 4'd0) | an_pulse_count != 4'd0;

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_DACDATA
      if (RESET)
         DACDATA <= 5'd0;
      else if (clkfast_enable)
         begin
         casex ({MR_BYPASS10TX_FILTER,LINK_DOWN,FILT_ENAB,EOF_HOLD,
                 pulse_on})            //synopsys parallel_case
            5'b1xxxx: casex (TXD_B1_0) //synopsys full_case parallel_case
                         2'b1x: DACDATA <= `zero;
                         2'b01: DACDATA <= `pos_13;
                         2'b00: DACDATA <= `neg_13;
                      endcase
            5'b01xx0: DACDATA <= `zero;
            5'b001x0: DACDATA <= tabledata;
            5'b0xxx1: DACDATA <= lgpulsedata | anpulsedata;
            5'b00000: DACDATA <= `zero;
         endcase
         end
      else
         DACDATA <= DACDATA;
      end // p_DACDATA

endmodule

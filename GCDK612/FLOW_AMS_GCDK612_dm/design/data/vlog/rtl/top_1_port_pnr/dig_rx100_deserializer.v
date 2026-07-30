// Created by ihdl
module dig_rx100_deserializer (
                               //Inputs
                               BYPASS_DESC_DATA,
                               MR_ALIGN_DISB,
                               MR_SYMBOL_MODE,
                               RXCLK125,
                               RESET,
                               RX100_STABLE,
                               nRX100_STABLE,
                               LINK100_DOWN,
                               SIGNAL_DETECT,

                               //Outputs
                               RXC25N,
                               DES100_DATA,
                               DES100_DV,
                               DES100_ER,
                               DES100_BADSSD,
                               RX100_ACTIVE,
                               IDLE_DSP_RESET,
                               DATA_RECEIVE,
                               rclk25_pos_neg_en,
                               rclk25_pos_pos_en
                               );

//
// I/O Declarations
//
input         BYPASS_DESC_DATA;  // Serial Input Data
input         MR_ALIGN_DISB;     // Bypass Alignment indicator
input         MR_SYMBOL_MODE;    // Symbol mode
input         RXCLK125;          // 125MHz Parallel Data Clock
input         RESET;             // System reset
input         RX100_STABLE;      // Receive Channel is stable
input         nRX100_STABLE;     // Receive Channel is stable sync'ed to negedge
input         LINK100_DOWN;      // 100TX link is down (link_status != OK)
input         SIGNAL_DETECT;     //

output        RXC25N;            // Inverted 25MHz Recovered Data Clock
output [4:0]  DES100_DATA;       // Receive Parallel Data
output        DES100_DV;         // Deserializer Enable Signal
output        DES100_ER;         // Deserializer Error Signal
output        DES100_BADSSD;     // Deserializer Bad SSD Error Signal
output        RX100_ACTIVE;      // Channel Activity Detected
output        IDLE_DSP_RESET;    // Resets DSP if <20 consecutive idles in 1.5ms
output        DATA_RECEIVE;      // Indicates data part of frame
output        rclk25_pos_neg_en; // Clock enable for RXCLK125
output        rclk25_pos_pos_en; // Clock enable for RXCLK125

//
// I/O Type Declarations
//
wire          BYPASS_DESC_DATA;    
wire          MR_ALIGN_DISB;
wire          MR_SYMBOL_MODE;
wire          RXCLK125;
wire          RESET;
wire          RX100_STABLE;
wire          nRX100_STABLE;
wire          LINK100_DOWN;
wire          SIGNAL_DETECT;

reg    [4:0]  DES100_DATA;
reg           DES100_DV;
reg           DES100_ER;
wire          DES100_BADSSD;
reg           DATA_RECEIVE;
wire          RX100_ACTIVE;
wire          RXC25N;
wire          IDLE_DSP_RESET;
wire          rclk25_pos_pos_en;
wire          rclk25_pos_neg_en;

//
// Internal Signal Declarations
//
reg           aligned;
reg           bad_ssd;
reg    [2:0]  rxb_state;
reg    [3:0]  rx_state;
reg    [3:0]  next_rx_state;
reg           receiving;
reg    [10:0] shiftregister;         // shift register for alignment
reg           block_clk_aligned;
reg    [1:0]  pre_block_clk;
reg           clk_aligned ;
reg    [17:0] count_idle;
reg    [8:0]  idle_check;

reg           clk_align;
wire          carrier_det;
wire   [4:0]  first_symbol;
wire   [4:0]  second_symbol;
wire          gotCGindicate;
wire          idle_bit_20;
wire          idle_count_reset;
wire          CLEAR_1_5;            // Resets 1.5msec idle counter

//
// Parameter Declarations
//
`define symbolH 5'b00100    // Transmit Error Value
`define symbolI 5'b11111    // Idle value
`define symbolJ 5'b11000    // Start-of-Stream delimiter 1 of 2
`define symbolK 5'b10001    // Start-of-Stream delimiter 2 of 2
`define symbolT 5'b01101    // End-of-Stream delimiter 1 of 2
`define symbolR 5'b00111    // End-of-Stream delimiter 2 of 2

// State defs for RX bits state diagram (802.3 Fig 24-10)
`define rx100_INITIALIZE  3'b111
`define rx100_UNALIGNED   3'b000
`define rx100_ALIGNED1    3'b001
`define rx100_ALIGNED2    3'b010
`define rx100_ALIGNED3    3'b011
`define rx100_ALIGNED4    3'b100
`define rx100_ALIGNED5    3'b101

// State defs for RX state diagram (802.3 Fig 24-11)
`define rx100_IDLE      4'b0000
`define rx100_LINK_FAIL 4'b0001
`define rx100_BAD_SSD   4'b0010
`define rx100_CAR_DET   4'b0011
`define rx100_CONFIRM_K 4'b0100
`define rx100_SOS_J     4'b0101
`define rx100_SOS_K     4'b0110
`define rx100_RECEIVE   4'b0111
`define rx100_EOS       4'b1000
`define rx100_PREM_END  4'b1001

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign DES100_BADSSD = bad_ssd;          // Deserializer Bad SSD Error Signal
   assign RX100_ACTIVE  = receiving;        // Channel Activity Detected
   assign carrier_det   = ~shiftregister[0] & ~(&shiftregister[9:2])
                          & ~block_clk_aligned;
   assign first_symbol  = shiftregister[9:5];
   assign second_symbol = shiftregister[4:0];

//------------------------------------------------------------------------------
// This instantiates the module dig_gen_rclk25
//------------------------------------------------------------------------------
//
dig_gen_rclk25 i_dig_gen_rclk25 (
                                 .RXCLK125(RXCLK125),
                                 .aligned(aligned),
                                 .clk_aligned(clk_align),
                                 .RESET_SC(RESET),
                                 .RXC25N(RXC25N),
                                 .rclk25_pos_pos_en(rclk25_pos_pos_en),
                                 .rclk25_pos_neg_en(rclk25_pos_neg_en)
                                 );

//------------------------------------------------------------------------------
// This process uses the rclk25 clock enable. The logic is not very good with 
// both the set and reset of the flop being used for control logic. I have seen
// issues with control signals being generated from the same clock edge causing
// glitches on the set. This was fixed by ensuring that these control signals
// are on opposite edges.
//------------------------------------------------------------------------------
//
   always @ (negedge RXCLK125 or posedge RESET or negedge RX100_STABLE
             or posedge clk_align)
      begin : p_pre_block_clk
      if (RESET) 
         pre_block_clk <= 2'b00;
      else if (~RX100_STABLE)
         pre_block_clk <= 2'b00;
      else if (clk_align)
         pre_block_clk <= 2'b11;
      else if (rclk25_pos_neg_en)
         pre_block_clk <= {pre_block_clk[0], 1'b0};
      else
         pre_block_clk <= pre_block_clk;

      end // p_pre_block_clk

//------------------------------------------------------------------------------
// This process....
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET or negedge RX100_STABLE)
      begin : p_block_clk_aligned
      if (RESET)
         block_clk_aligned <= 1'b0;
      else if (~RX100_STABLE)
         block_clk_aligned <= 1'b0;
      else
         block_clk_aligned <= pre_block_clk[1] | bad_ssd;
      end // p_block_clk_aligned

//------------------------------------------------------------------------------
// This process will check the number of consecutive idle bits is at least 20.
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET)
      begin : p_idle_check
      if (RESET)
         begin
         idle_check <= 9'd0;
         end
      else 
         begin
         idle_check <= {idle_check[7:0], shiftregister[10]};
         end
      end // p_idle_check


   assign idle_bit_20 = ({idle_check[8:0],shiftregister[10:0]} == 20'hfffff); 


//------------------------------------------------------------------------------
//  This process checks the 20 consective idles fall inside a 1.5msec window.
//------------------------------------------------------------------------------
   always @(posedge RXCLK125 or posedge RESET)
      begin : p_count_idle
      if (RESET)
         begin
         count_idle <= 18'd0;
         end
      else if (idle_count_reset)
         begin
         count_idle <= 18'd0;
         end
      else 
         begin
         count_idle <= count_idle + 1'b1;
         end
      end // p_count_idle

   assign IDLE_DSP_RESET = (count_idle > 18'h2DC6C);

   assign CLEAR_1_5 = (count_idle == 18'h2DC71);

//------------------------------------------------------------------------------
//  Reset 1.5 msec counter after 1.5msec time out or 20 consecutive idle bits.
//  Only want to check for idles if there is already a link.
//------------------------------------------------------------------------------
   assign idle_count_reset = (idle_bit_20 | CLEAR_1_5 | LINK100_DOWN);


//------------------------------------------------------------------------------
// This process will update the shift register
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET or negedge RX100_STABLE)
      begin : p_rxb_state
      if (RESET)
         begin
         shiftregister <= 11'b1_11111_11111;
         clk_aligned   <= 1'b0;
         rxb_state     <= `rx100_INITIALIZE;
         end
      else if (~RX100_STABLE)
         begin
         shiftregister <= 11'b1_11111_11111;
         clk_aligned   <= 1'b0;
         rxb_state     <= `rx100_INITIALIZE;
         end
      else
         begin
         shiftregister  <= {shiftregister[9:0], BYPASS_DESC_DATA} ;
         clk_aligned    <=  carrier_det;
            case (rxb_state)
            `rx100_INITIALIZE: rxb_state <= (MR_SYMBOL_MODE) ?
                                            `rx100_ALIGNED1 : `rx100_UNALIGNED;
            `rx100_UNALIGNED:  rxb_state <= (DES100_DV) ? 
                                            `rx100_ALIGNED1 : `rx100_UNALIGNED;
            `rx100_ALIGNED1:   rxb_state <= `rx100_ALIGNED2;
            `rx100_ALIGNED2:   rxb_state <= `rx100_ALIGNED3;
            `rx100_ALIGNED3:   rxb_state <= `rx100_ALIGNED4;
            `rx100_ALIGNED4:   rxb_state <= `rx100_ALIGNED5;
            `rx100_ALIGNED5:   rxb_state <= (DES100_DV) ? 
                                            `rx100_ALIGNED1 : `rx100_UNALIGNED;
            default:           rxb_state <= `rx100_UNALIGNED;
            endcase
         end
      end // p_rxb_state

   assign gotCGindicate = (rxb_state == `rx100_ALIGNED5);

   // last minute change to remove a race between set and reset of
   // p_pre_block_clk
   always @(negedge RXCLK125 or posedge RESET or negedge nRX100_STABLE)
      begin :p_bodge
      if (RESET)
         clk_align <= 1'b0;
      else if (~nRX100_STABLE)
         clk_align <= 1'b0;
      else
         clk_align <= clk_aligned;
      end // p_bodge

//------------------------------------------------------------------------------
// This process is RX state machine next state logic used to determine Alignment
// SSD, ESD
//------------------------------------------------------------------------------
//
   always @(rx_state or LINK100_DOWN or DES100_DV or receiving or gotCGindicate
            or shiftregister or first_symbol or second_symbol or carrier_det)
      begin : p_next_rx_state
      if (LINK100_DOWN & receiving & DES100_DV & gotCGindicate)
         next_rx_state = `rx100_LINK_FAIL;
      else if (LINK100_DOWN & ~DES100_DV)
         next_rx_state = `rx100_IDLE ;
      else
         case (rx_state)
         `rx100_IDLE: if (~LINK100_DOWN & carrier_det)
                         next_rx_state = `rx100_CAR_DET;
                      else
                         next_rx_state = `rx100_IDLE;

         `rx100_LINK_FAIL: if (gotCGindicate)
                              next_rx_state = `rx100_IDLE;
                           else
                              next_rx_state = `rx100_LINK_FAIL;

          // The shift register has shifted an extra bit by the time the next
          // test is done.
         `rx100_CAR_DET: if (shiftregister[10:1] == {`symbolI, `symbolJ})
                            next_rx_state = `rx100_CONFIRM_K;
                         else
                            next_rx_state = `rx100_BAD_SSD;

         `rx100_CONFIRM_K: if (first_symbol == `symbolJ && 
                               second_symbol == `symbolK)
                              next_rx_state = `rx100_SOS_J;
                           else if (first_symbol == `symbolJ &&
                                    second_symbol != `symbolK)
                              next_rx_state = `rx100_BAD_SSD;
                           else
                              next_rx_state = `rx100_CONFIRM_K;

         `rx100_SOS_J: if (gotCGindicate)
                              next_rx_state = `rx100_SOS_K;
                           else
                              next_rx_state = `rx100_SOS_J;

         `rx100_SOS_K: next_rx_state = `rx100_RECEIVE;

         `rx100_RECEIVE: if (first_symbol == `symbolT && 
                             second_symbol == `symbolR && gotCGindicate)
                            next_rx_state = `rx100_EOS;
                         else if (first_symbol == `symbolI &&
                                  second_symbol == `symbolI && gotCGindicate)
                            next_rx_state = `rx100_PREM_END;
                         else
                            next_rx_state = `rx100_RECEIVE;

         `rx100_PREM_END: if (gotCGindicate)
                              next_rx_state = `rx100_IDLE;
                           else
                              next_rx_state = `rx100_PREM_END;

         `rx100_EOS: next_rx_state = `rx100_IDLE;

         `rx100_BAD_SSD: if (first_symbol == `symbolI &&
                             second_symbol == `symbolI)
                            next_rx_state = `rx100_IDLE;
                         else
                            next_rx_state = `rx100_BAD_SSD;

         default: next_rx_state = `rx100_IDLE;

         endcase
      end // p_next_rx_state

//------------------------------------------------------------------------------
// This process is RX state machine state transition & output logic
//------------------------------------------------------------------------------
//
   always @(negedge RXCLK125 or posedge RESET or negedge nRX100_STABLE)
      begin : p_op
      if (RESET)
         begin
         aligned   <= 1'b0;
         rx_state  <= `rx100_IDLE;
         DES100_ER <= 1'b0;
         DES100_DV <= 1'b0;
         receiving <= 1'b0;
         bad_ssd   <= 1'b0;
         end
      else if (~nRX100_STABLE)
         begin
         aligned   <= 1'b0;
         rx_state  <= `rx100_IDLE;
         DES100_ER <= 1'b0;
         DES100_DV <= 1'b0;
         receiving <= 1'b0;
         bad_ssd   <= 1'b0;
         end
      else if (MR_ALIGN_DISB)
         begin
         aligned   <= 1'b1 ;
         rx_state  <= `rx100_IDLE ;
         DES100_DV <= SIGNAL_DETECT;
         DES100_ER <= 1'b0;
         if (shiftregister[9:0]==10'b11111_11111)
            receiving <= 1'b0;
         else
            receiving <= 1'b1;
         end
      else
         begin
         rx_state <= next_rx_state;
         case (next_rx_state)
            `rx100_LINK_FAIL: begin
                              DES100_ER <= 1'b1;
                              receiving <= 1'b0;
                              end

            `rx100_IDLE: begin
                         DES100_ER <= 1'b0;
                         DES100_DV <= 1'b0;
                         receiving <= 1'b0;
                         bad_ssd   <= 1'b0;
                         end

            `rx100_CAR_DET: begin
                            receiving <= 1'b1;
                            end

            `rx100_SOS_J: begin
                          aligned   <= 1'b1;
                          DES100_DV <= 1'b1;
                          end

            `rx100_EOS: begin
                        DES100_ER <= 1'b0;
                        DES100_DV <= 1'b0;
                        receiving <= 1'b0;
                        aligned   <= 1'b0;
                        end

            `rx100_PREM_END: begin
                             DES100_ER <= 1'b1;
                             aligned   <= 1'b0;
                             end

            `rx100_BAD_SSD: begin
                            DES100_ER <= 1'b1;
                            bad_ssd   <= 1'b1;
                            end
         endcase
         end
      end // p_op


//------------------------------------------------------------------------------
// Generate an enable to indicate in data part of frame for 4B/5B decoder
// Required to indicate whether it is valid to decode J/K SSD symbols
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET)
      begin : p_DATA_RECEIVE
      if (RESET)
         DATA_RECEIVE <= 1'b0;
      else if (rclk25_pos_pos_en)
         begin
         if (rx_state == 4'd7)
            DATA_RECEIVE <= 1'b1;
         else
            DATA_RECEIVE <= 1'b0;
         end
      else 
         DATA_RECEIVE <= DATA_RECEIVE;
      end


//------------------------------------------------------------------------------
// This process is....
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET)
      begin : p_DES100_DATA
      if (RESET)
         DES100_DATA <= 5'b0;
      else if (gotCGindicate || (rxb_state == `rx100_UNALIGNED))
         DES100_DATA <= first_symbol;
      else
         DES100_DATA <= DES100_DATA;
      end // p_DES100_DATA

endmodule

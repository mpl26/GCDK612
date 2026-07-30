// Created by ihdl
module dig_rx100_path (
                       //Inputs
                       LPBK_MLT3DATA,
                       RXCLK125,
                       MR_AN_ENAB,
                       MR_FEF_DISB,
                       MR_SYMBOL_MODE,
                       MR_BYPASS_SCRAMBLER,
                       MR_ALIGN_DISB,
                       RESET,
                       RX100_STABLE,
                       LINK100_DOWN,
                       SIGNAL_DETECT,

                       //Outputs
                       LOCKED2IDLES,
                       RX100_DATA,
                       RX100_DV,
                       RX100_ER,
                       RX100_ACTIVE,
                       RXC25N,
                       FE_FAULT,
                       IDLE_DSP_RESET
                       );

//
// I/O Declarations
//
input   [1:0]  LPBK_MLT3DATA;       // MLT3 Data from Equalizer
input          RXCLK125;            // 125MHz recovered clock
input          MR_AN_ENAB;          // Autonegotiate enable
input          MR_FEF_DISB;         // 
input          MR_SYMBOL_MODE;      // Bypass Decoder Flag
input          MR_BYPASS_SCRAMBLER; // Bypass Scrambler Flag
input          MR_ALIGN_DISB;       // Disable Aligner Flag
input          RESET;               // System Reset
input          RX100_STABLE;        // MSE is stable for rx path
input          LINK100_DOWN;        // 100TX link is down (link_status != OK)
input          SIGNAL_DETECT;       // Signal Detect

output         LOCKED2IDLES;        // Descrambler locked to idles
output  [4:0]  RX100_DATA;          // Received Data
output         RX100_DV;            // Data Valid
output         RX100_ER;            // Error In Data
output         RX100_ACTIVE;        // Channel is Active
output         RXC25N;              // Inverted 25 MHz recovered clock
output         FE_FAULT;            // Far end fault
output         IDLE_DSP_RESET;      // Resets DSP if <20 consecutive idles in 1.5msec

//
// I/O Type Declarations
//
wire    [1:0]  LPBK_MLT3DATA;      
wire           RXCLK125;           
wire           MR_AN_ENAB;         
wire           MR_FEF_DISB;        
wire           MR_SYMBOL_MODE;     
wire           MR_BYPASS_SCRAMBLER;
wire           MR_ALIGN_DISB;      
wire           RESET;              
wire           RX100_STABLE;       
wire           LINK100_DOWN;       
wire           SIGNAL_DETECT;      

wire           LOCKED2IDLES;
wire    [4:0]  RX100_DATA;
wire           RX100_DV;
wire           RX100_ER;
wire           RX100_ACTIVE;
wire           RXC25N;
wire           FE_FAULT;

//
// Internal Signal Declarations
//
reg     [1:0]  sync_MR_SYMBOL_MODE;
reg     [1:0]  sync_MR_BYPASS_SCRAMBLER;
reg     [1:0]  sync_RX100_STABLE;
reg     [1:0]  syncn_MR_ALIGN_DISB;
reg     [1:0]  syncn_RX100_STABLE;
reg     [1:0]  meta_LINK100_DOWN;
wire           DESCRAMBLER_DATA;    // Descrambler Output
wire           BYPASS_DESC_DATA;    // Bypass Descrambler Output
wire    [4:0]  DES100_DATA;         // Deserializer Output Data
wire           DES100_DV;           // Deserializer Data Valid Indicator
wire           DES100_ER;           // Deserializer Error Indicator
wire           DES100_BADSSD;       // Deserializer Bad SSD Error Indicator
wire    [3:0]  DEC4B5B_DATA;        // 4b5b Decoder Output Data
wire           DEC4B5B_DV;          // 4b5b Decoder Data Valid Indicator
wire           DEC4B5B_ER;          // 4b5b Decoder Error Indicator
wire           MLT3DEC_DATA;        // MLT3 Decoder Output (NRZ)
wire           rclk25_pos_neg_en;   // Clock enable for RXCLK125
wire           rclk25_pos_pos_en;   // Clock enable for RXCLK125
//
// Parameter Declarations
//
// none


//------------------------------------------------------------------------------
// This process synchronises the MR_control signals to this clock domain
//------------------------------------------------------------------------------
//
   always @(negedge RXCLK125 or posedge RESET)
      begin : p_syncn_MR
      if (RESET)
         begin
         syncn_MR_ALIGN_DISB       <= 2'b00;
         syncn_RX100_STABLE        <= 2'b00;
         end
      else
         begin
         syncn_MR_ALIGN_DISB[0]    <= MR_ALIGN_DISB;
         syncn_MR_ALIGN_DISB[1]    <= syncn_MR_ALIGN_DISB[0];
         syncn_RX100_STABLE[0]     <= RX100_STABLE;
         syncn_RX100_STABLE[1]     <= syncn_RX100_STABLE[0];
         end
      end // p_syncn_MR

  
   always @(posedge RXCLK125 or posedge RESET)
      begin : p_sync_MR
      if (RESET)
         begin
         sync_MR_SYMBOL_MODE      <= 2'b00;
         sync_MR_BYPASS_SCRAMBLER <= 2'b00;
         sync_RX100_STABLE        <= 2'b00;
         end
      else
         begin
         sync_MR_SYMBOL_MODE[0]      <= MR_SYMBOL_MODE;
         sync_MR_SYMBOL_MODE[1]      <= sync_MR_SYMBOL_MODE[0];
         sync_MR_BYPASS_SCRAMBLER[0] <= MR_BYPASS_SCRAMBLER;
         sync_MR_BYPASS_SCRAMBLER[1] <= sync_MR_BYPASS_SCRAMBLER[0];
         sync_RX100_STABLE[0]        <= RX100_STABLE;
         sync_RX100_STABLE[1]        <= sync_RX100_STABLE[0];
         end
      end // p_sync_MR



//------------------------------------------------------------------------------
// Synchronise LINK100_DOWN to the RXCLK125 clock domain.  
// This is required for the 4B5B decoder but also needs to be used for the
// deserialiser as both blocks need to be cleared together when a link is lost.
//------------------------------------------------------------------------------
//
   always @(posedge RXCLK125 or posedge RESET)
      begin : p_meta_LINK100_DOWN
      if (RESET)
         meta_LINK100_DOWN <= 2'b00;
      else
         begin
         meta_LINK100_DOWN[0] <= LINK100_DOWN;
         meta_LINK100_DOWN[1] <= meta_LINK100_DOWN;
         end
      end // p_meta_LINK100_DOWN 


//------------------------------------------------------------------------------
// Instantiate modules
//------------------------------------------------------------------------------
//
dig_rx100_mlt3_dec i_dig_rx100_mlt3_dec (
                                         .LPBK_MLT3DATA(LPBK_MLT3DATA), 
                                         .RXCLK125(RXCLK125), 
                                         .MLT3DEC_DATA(MLT3DEC_DATA), 
                                         .RX100_STABLE(sync_RX100_STABLE[1])
                                         );

dig_rx100_descrambler i_dig_rx100_descrambler (
                          .RESET(RESET),
                          .MLT3DEC_DATA(MLT3DEC_DATA), 
                          .RXCLK125(RXCLK125), 
                          .RX100_STABLE(sync_RX100_STABLE[1]),
                          .DESCRAMBLER_DATA(DESCRAMBLER_DATA),
                          .MR_BYPASS_SCRAMBLER(sync_MR_BYPASS_SCRAMBLER[1]),
                          .LOCKED2IDLES(LOCKED2IDLES)
                          );

dig_rx100_bypass_descrambler i_dig_rx100_bypass_descrambler (
                          .DESCRAMBLER_DATA(DESCRAMBLER_DATA),
                          .MLT3DEC_DATA(MLT3DEC_DATA),
                          .BYPASS_DESC_DATA(BYPASS_DESC_DATA),
                          .MR_BYPASS_SCRAMBLER(sync_MR_BYPASS_SCRAMBLER[1])
                          );


dig_rx100_deserializer i_dig_rx100_deserializer (
                          .BYPASS_DESC_DATA(BYPASS_DESC_DATA),
                          .MR_ALIGN_DISB(syncn_MR_ALIGN_DISB[1]), 
                          .MR_SYMBOL_MODE(sync_MR_SYMBOL_MODE[1]), 
                          .RXC25N(RXC25N),
                          .RXCLK125(RXCLK125),
                          .DES100_DATA(DES100_DATA), 
                          .DES100_DV(DES100_DV), 
                          .DES100_ER(DES100_ER),
                          .DES100_BADSSD(DES100_BADSSD),
                          .RX100_ACTIVE(RX100_ACTIVE),
                          .RX100_STABLE(sync_RX100_STABLE[1]),
                          .nRX100_STABLE(syncn_RX100_STABLE[1]),
                          .LINK100_DOWN(meta_LINK100_DOWN[1]),
                          .SIGNAL_DETECT(SIGNAL_DETECT),
                          .RESET(RESET),
                          .IDLE_DSP_RESET(IDLE_DSP_RESET),
                          .DATA_RECEIVE(DATA_RECEIVE),
                          .rclk25_pos_neg_en(rclk25_pos_neg_en),
                          .rclk25_pos_pos_en(rclk25_pos_pos_en)
                          );

dig_rx100_dec4b5b i_dig_rx100_dec4b5b (
                          .DES100_DATA(DES100_DATA), 
                          .DES100_DV(DES100_DV),
                          .DES100_ER(DES100_ER),
                          .DES100_BADSSD(DES100_BADSSD),
                          .MR_SYMBOL_MODE(sync_MR_SYMBOL_MODE[1]),
                          .RX100_STABLE(sync_RX100_STABLE[1]),
                          .RESET(RESET),
                          .LINK100_DOWN(meta_LINK100_DOWN[1]),
                          .DATA_RECEIVE(DATA_RECEIVE),
                          .rclk25_pos_pos_en(rclk25_pos_pos_en),
                          .RXCLK125(RXCLK125),
                          .DEC4B5B_DATA(DEC4B5B_DATA), 
                          .DEC4B5B_DV(DEC4B5B_DV),
                          .DEC4B5B_ER(DEC4B5B_ER)
                          );

dig_rx100_bypass_dec4b5b i_dig_rx100_bypass_dec4b5b (
                          .DES100_DATA(DES100_DATA), 
                          .DES100_DV(DES100_DV), 
                          .DES100_ER(DES100_ER),
                          .DEC4B5B_DATA(DEC4B5B_DATA),
                          .DEC4B5B_DV(DEC4B5B_DV),
                          .DEC4B5B_ER(DEC4B5B_ER),
                          .MR_SYMBOL_MODE(sync_MR_SYMBOL_MODE[1]),
                          .RESET(RESET),
                          .rclk25_pos_neg_en(rclk25_pos_neg_en),
                          .RXCLK125(RXCLK125),
                          .RX100_DATA(RX100_DATA),
                          .RX100_DV(RX100_DV),
                          .RX100_ER(RX100_ER)
                          );

dig_fef_det i_dig_fef_det (
                           .CLK125(RXCLK125),
                           .MR_AN_ENAB(MR_AN_ENAB),
                           .MR_FEF_DISB(MR_FEF_DISB),
                           .BYPASS_DESC_DATA(BYPASS_DESC_DATA),
                           .RESET(RESET), 
                           .FE_FAULT(FE_FAULT)
                           );

endmodule

// Created by ihdl
module dig_tx10_manch_enc (
                            //Inputs
                            CLKPLL_IN,
                            TXD,
                            TXEN,
                            MR_ISOLATE_TX,
                            RESET,
                            clk10_enable,
                            clk10n_enable,
                            txc2_5_enable,
                            CLK2_5_NO_FF,
                            LINK_DOWN,
                            JABBER_DETECTED,

                            //Outputs
                            EOF_HOLD,
                            ENC_DATA,
                            FILT_ENAB,
                            TX10_ACTIVE,
                            TX10_PRESENT
                            );

//
// I/O Declarations
//
input       CLKPLL_IN;        // system clock either 125MHz/160MHz
input [3:0] TXD;              // Transmit Data
input       TXEN;             // Transmit Enable
input       MR_ISOLATE_TX;    // 1= Don't respond to TXEN
input       RESET;            // System Reset (postive polarity)
input       clk10_enable;     // 10MHz Clock enable
input       clk10n_enable;    // Inverted 10MHz Clock enable
input       txc2_5_enable;    // 2.5 MHz Clock enable
input       CLK2_5_NO_FF;     // 2.5 MHz square wave framing CLK_2_5 -
                              // Not for use in clocking flip-flops!
input       LINK_DOWN;        // Link is down
input       JABBER_DETECTED;  // Jabber Detected

output      ENC_DATA;         // Encoded data
output      FILT_ENAB;        // Filter Enable
output      EOF_HOLD;         // 1= Hold constant level for End of Frame markr
output      TX10_ACTIVE;      // Post preamble data is active
output      TX10_PRESENT;     // Any output data is present

//
// I/O Type Declarations
//
wire        CLKPLL_IN;
wire  [3:0] TXD;            
wire        TXEN;           
wire        MR_ISOLATE_TX;  
wire        RESET;          
wire        clk10_enable;
wire        clk10n_enable;
wire        txc2_5_enable;
wire        CLK2_5_NO_FF;   
wire        LINK_DOWN;      
wire        JABBER_DETECTED;

wire        ENC_DATA;       
wire        FILT_ENAB;      
wire        EOF_HOLD;       
reg         TX10_ACTIVE;    
reg         TX10_PRESENT;   

//
// Internal Signal Declarations
//
reg        enc_h1_data;       // Two signals that are xor'ed
reg        enc_h2_data;       // to generate ENC_DATA. One
                              // changes value at rising 
                              // CLK10, the other at falling

reg        eof_hold_h1;       // Two signals that are xor'ed
reg        eof_hold_h2;       // to generate EOF_HOLD. One
                              // changes value at rising 
                              // CLK10, the other at falling

reg [3:1]  capture_data;      // Registered data to be transmitted later
reg        prev1_txc2_5;      // Clock phase history
reg        prev2_txc2_5;      // Clock phase history
reg        prev_txen;         // Previous cycle value of TXEN
reg [3:0]  eof_count;         // Cycle # after end of frame
reg        filt_enab_extend;  // Extension for marker start
reg        prev1_filt_enab_frame;
reg        prev2_filt_enab_frame;
wire       filt_enab_delayed;
wire       int_txen;


//
// Parameter Declarations
//
// None


//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------

   assign int_txen          = TXEN & !MR_ISOLATE_TX;
   assign ENC_DATA          = enc_h1_data ^ enc_h2_data;
   assign EOF_HOLD          = eof_hold_h1 ^ eof_hold_h2;
   assign filt_enab_delayed = TX10_PRESENT & prev2_filt_enab_frame;
   assign FILT_ENAB         = filt_enab_delayed | filt_enab_extend;

//------------------------------------------------------------------------------
// This process indicates that the 10BaseT Tx is active
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_TX10_ACTIVE
      if (RESET)
         begin
         TX10_PRESENT <= 1'b0;
         capture_data <= 3'd0;
         TX10_ACTIVE  <= 1'b0;
         end
      else if (txc2_5_enable)
         begin
         if (int_txen && !LINK_DOWN && !JABBER_DETECTED)
            begin
            TX10_PRESENT <= 1'b1;
            capture_data <= TXD[3:1];
            if (TXD[3:0] == 4'b1101)
               TX10_ACTIVE <= 1'b1;
            end
         else
            begin
            TX10_PRESENT <= 1'b0;
            if (!int_txen)
               TX10_ACTIVE <= 1'b0;
            end
         end
      else
         begin
         TX10_PRESENT <= TX10_PRESENT;
         capture_data <= capture_data;
         TX10_ACTIVE  <= TX10_ACTIVE;
         end
      end // p_TX10_ACTIVE

//------------------------------------------------------------------------------
// This process is used to synchronise TX10_PRESENT. The signal is loaded when
// the clk10_enable is active.
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_enab_frame
      if (RESET)
         begin
         prev1_filt_enab_frame <= 1'b0;
         prev2_filt_enab_frame <= 1'b0;
         end
      else if (clk10_enable)
         begin
         prev1_filt_enab_frame <= TX10_PRESENT;
         prev2_filt_enab_frame <= prev1_filt_enab_frame;
         end
      else
         begin
         prev1_filt_enab_frame <= prev1_filt_enab_frame;
         prev2_filt_enab_frame <= prev2_filt_enab_frame;
         end
      end // p_enab_frame

//------------------------------------------------------------------------------
// This process is used to set the filt_enab_extend indicator
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_enab_extend
      if (RESET)
         filt_enab_extend <= 1'b0;
      else if (clk10n_enable)
         if (ENC_DATA && filt_enab_delayed)
            filt_enab_extend <= 1'b1;
         else
            filt_enab_extend <= 1'b0;
      else
         filt_enab_extend <= filt_enab_extend;
      end // p_enab_extend

//------------------------------------------------------------------------------
// This process is used to synchronise the CLK2_5_NO_FF with CLK10N
// Added the reset to this process (JM V1.5)
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_txc2_5
      if (RESET)
         begin
         prev2_txc2_5 <= 1'b0;
         prev1_txc2_5 <= 1'b0;
         end
      else if (clk10n_enable)
         begin
         prev2_txc2_5 <= prev1_txc2_5;
         prev1_txc2_5 <= CLK2_5_NO_FF;
         end
      else
         begin
         prev2_txc2_5 <= prev2_txc2_5;
         prev1_txc2_5 <= prev1_txc2_5;
         end
      end // p_txc2_5

//------------------------------------------------------------------------------
// This process performs the manchester encoding of the data stream. 
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_enc_h1_data
      if (RESET)
         begin
         enc_h1_data <= 1'b0;
         prev_txen   <= 1'b0;
         end
      else if (clk10_enable)
         case ({prev2_txc2_5,prev1_txc2_5})
            2'b00:  begin
                    if (!LINK_DOWN && !JABBER_DETECTED)
                       begin
                       if (int_txen) // First data bit to transmit
                          enc_h1_data <= ~TXD[0] ^ enc_h2_data;
                       else
                          if (prev_txen) // End of frame
                             enc_h1_data <= !enc_h2_data; // Force 1
                          else
                             enc_h1_data <= enc_h2_data;  // Force 0
                       prev_txen <= int_txen;
                       end
                    else
                       begin
                       enc_h1_data <= enc_h2_data;        // Force 0 ENC_DATA
                       prev_txen <= 1'b0;
                       end
                    end

            2'b01: begin
                   if (TX10_PRESENT) // Second data bit to transmit
                      enc_h1_data <= ~capture_data[1] ^ enc_h2_data;
                   else
                      enc_h1_data <= enc_h2_data; // Force 0 ENC_DATA
                   end

            2'b11: begin
                   if (TX10_PRESENT) // Third data bit to transmit
                      enc_h1_data <= ~capture_data[2] ^ enc_h2_data;
                   else
                      enc_h1_data <= enc_h2_data; // Force 0 ENC_DATA
                   end

            2'b10: begin
                   if (TX10_PRESENT) // Fourth data bit to transmit
                      enc_h1_data <= ~capture_data[3] ^ enc_h2_data;
                   else
                      enc_h1_data <= enc_h2_data; // Force 0 ENC_DATA
                   end
         endcase
     else
        begin
        enc_h1_data <= enc_h1_data;
        prev_txen   <= prev_txen;
        end
     end // p_enc_h1_data

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_enc_h2_data
      if (RESET)
         enc_h2_data <= 1'b0;
      else if (clk10n_enable)
         if (TX10_PRESENT)
            enc_h2_data <= ~ENC_DATA ^ enc_h1_data;  // Force !ENC_DATA
         else
            enc_h2_data <= enc_h1_data;              // Force 0 ENC_DATA
      else
         enc_h2_data <= enc_h2_data;
      end //p_enc_h2_data

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_eof_hold_h1
      if (RESET)
         begin
         eof_hold_h1 <= 1'b0;
         eof_count   <= 4'b0000;
         end
      else if (clk10_enable)
         if ({prev_txen,int_txen,prev2_txc2_5,prev1_txc2_5} == 4'b1000 &&
              !JABBER_DETECTED && !LINK_DOWN && eof_count == 4'b0000)
            begin
            eof_count <= 4'b0001;
            if (ENC_DATA == 1'b1)
               eof_hold_h1 <= !eof_hold_h2; // set EOF_HOLD = 1
            end
         else if (eof_count != 4'b0000)
            begin
            eof_count <= eof_count + 4'b0001;
            if (eof_count == 4'b0011)
               eof_hold_h1 <= eof_hold_h2; // Set EOF_HOLD = 0
            end
      else
         begin
         eof_hold_h1 <= eof_hold_h1;
         eof_count   <= eof_count;
         end

      end // p_eof_hold_h1

//------------------------------------------------------------------------------
// This process...
//------------------------------------------------------------------------------
//
   always @(posedge CLKPLL_IN or posedge RESET)
      begin : p_eof_hold_h2
      if (RESET)
         eof_hold_h2 <= 1'b0;
      else if (clk10n_enable)
         if (eof_count == 4'b0001)
            eof_hold_h2 <= ! eof_hold_h1; // Set EOF_HOLD = 1
      else
         eof_hold_h2 <= eof_hold_h2;
      end // p_eof_hold_h2

endmodule

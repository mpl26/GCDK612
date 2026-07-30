// Created by ihdl
module dig_tx100_path (
                       //Inputs
                       TXD,
                       TXEN,
                       TXER,
                       CLKPLL_IN,
                       txc25_enable,
                       TXC25_ALIGN,
                       clk125_enable,
                       RESET,
                       MR_100MBS,
                       LINK100_DOWN,
                       MR_SYMBOL_MODE,
                       MR_BYPASS_SCRAMBLER,
                       MR_SCRAMBLER_SEED,
                       MR_SCRAMBLER_LOAD,
                       MR_ISOLATE_TX,
                       MSE_GOOD,
                       MR_AN_ENAB,
                       MR_FEF_DISB,
                       MR_DIG_LOOP_BACK_ENAB,

                       //Outputs
                       TX100_ACTIVE,
                       MLT3ENC_DATA
                       );

//
// I/O Declarations
//
input   [4:0]  TXD;                    // Transmit Data
input          TXEN;                   // Transmit Enable
input          TXER;                   // Transmit Error
input          CLKPLL_IN;              // System clock 125MHz or 160MHz
input          txc25_enable;           // 25MHz clock enable
input          TXC25_ALIGN;            // Alignment mark for 25 MHz Data
input          clk125_enable;          // 125MHz clock enable
input          RESET;                  // Reset signal
input          MR_100MBS;              // Enable 100 MHz path
input          LINK100_DOWN;           // Link Down Indicator
input          MR_SYMBOL_MODE;         // Symbol Mode indicator
input          MR_BYPASS_SCRAMBLER;    // Symbol Mode indicator
input   [4:0]  MR_SCRAMBLER_SEED;      // Scrambler seed value
input          MR_SCRAMBLER_LOAD;      // Load scrambler from seed value
input          MR_ISOLATE_TX;          // Isolate from MII
input          MSE_GOOD;               //
input          MR_AN_ENAB;             // Autonegotiation enable
input          MR_FEF_DISB;            // 
input          MR_DIG_LOOP_BACK_ENAB;  // Loopback enable

output         TX100_ACTIVE;           // 100MHz path transmitting data
output  [1:0]  MLT3ENC_DATA;           // MLT3 data

//
// I/O Type Declarations
//
wire    [4:0]  TXD;                  
wire           TXEN;                 
wire           TXER;                 
wire           CLKPLL_IN;             // System clock 125MHz or 160MHz
wire           txc25_enable;          // 25MHz clock enable
wire           TXC25_ALIGN;          
wire           clk125_enable;               
wire           RESET;                
wire           MR_100MBS;            
wire           LINK100_DOWN;         
wire           MR_SYMBOL_MODE;       
wire           MR_BYPASS_SCRAMBLER;  
wire    [4:0]  MR_SCRAMBLER_SEED;    
wire           MR_SCRAMBLER_LOAD;    
wire           MR_ISOLATE_TX;        
wire           MSE_GOOD;             
wire           MR_AN_ENAB;           
wire           MR_FEF_DISB;          
wire           MR_DIG_LOOP_BACK_ENAB;

wire           TX100_ACTIVE;           // 100MHz path transmitting data
wire    [1:0]  MLT3ENC_DATA;           // MLT3 data

//
// Internal Signal Declarations
//
wire    [4:0]  ENC4B5B_DATA;           // 4B/5B Encoded data
wire    [4:0]  BYPASS4B5B_DATA;
wire           SERIALIZER_DATA;
wire           SCRAMBLER_DATA;
wire           BYPASS_SCRAMBLER_DATA;
wire           FE_DATA;
wire           FE_BYPASS_SCRAMBLER;   // 100TX FEF.  Takes control of
                                      // scrambler mux under FEF conditions.
wire           TX100_ACTIVE_NORMAL;
wire           TX100_ACTIVE_SYMBOL;
wire           TXEN_ISOLATE;

//
// Parameter Declarations
//
// None

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign TXEN_ISOLATE = TXEN & (!MR_ISOLATE_TX);
   assign TX100_ACTIVE = TX100_ACTIVE_NORMAL | TX100_ACTIVE_SYMBOL;

//------------------------------------------------------------------------------
// Module instantiations
//------------------------------------------------------------------------------
//
dig_tx100_enc4b5b i_dig_tx100_enc4b5b (
                                      .TXD(TXD[3:0]),
                                      .TXEN(TXEN_ISOLATE),
                                      .TXER(TXER), 
                                      .CLKPLL_IN(CLKPLL_IN),
                                      .txc25_enable(txc25_enable),
                                      .ENC4B5B_DATA(ENC4B5B_DATA), 
                                      .TX100_ACTIVE_NORMAL(TX100_ACTIVE_NORMAL), 
                                      .RESET(RESET), 
                                      .MR_100MBS(MR_100MBS),
                                      .LINK100_DOWN(LINK100_DOWN),
                                      .MR_SYMBOL_MODE(MR_SYMBOL_MODE)
                                      );

dig_tx100_bypass4b5b i_dig_tx100_bypass4b5b(
                                      .TXD(TXD),
                                      .TXEN(TXEN_ISOLATE),
                                      .CLKPLL_IN(CLKPLL_IN),
                                      .txc25_enable(txc25_enable),
                                      .ENC4B5B_DATA(ENC4B5B_DATA), 
                                      .TX100_ACTIVE_SYMBOL(TX100_ACTIVE_SYMBOL),
                                      .BYPASS4B5B_DATA(BYPASS4B5B_DATA), 
                                      .MR_SYMBOL_MODE(MR_SYMBOL_MODE),
                                      .RESET(RESET)
                                      );

dig_tx100_serializer i_dig_tx100_serializer (
                                             .BYPASS4B5B_DATA(BYPASS4B5B_DATA),
                                             .TXC25_ALIGN(TXC25_ALIGN),
                                             .CLKPLL_IN(CLKPLL_IN),
                                             .clk125_enable(clk125_enable), 
                                             .SERIALIZER_DATA(SERIALIZER_DATA),
                                             .RESET(RESET)
                                             );

dig_tx100_scrambler i_dig_tx100_scrambler (
                                      .SERIALIZER_DATA(FE_DATA), 
                                      .SCRAMBLER_DATA(SCRAMBLER_DATA),
                                      .CLKPLL_IN(CLKPLL_IN),
                                      .clk125_enable(clk125_enable), 
                                      .RESET(RESET),
                                      .MR_100MBS(MR_100MBS),
                                      .MR_SCRAMBLER_SEED(MR_SCRAMBLER_SEED),
                                      .MR_SCRAMBLER_LOAD(MR_SCRAMBLER_LOAD),
                                      .MR_BYPASS_SCRAMBLER(MR_BYPASS_SCRAMBLER)
                                      );

dig_tx100_bypass_scrambler i_dig_tx100_bypass_scrambler( 
                                  .SCRAMBLER_DATA(SCRAMBLER_DATA), 
                                  .SERIALIZER_DATA(FE_DATA),
                                  .BYPASS_SCRAMBLER_DATA(BYPASS_SCRAMBLER_DATA), 
                                  .MR_BYPASS_SCRAMBLER(MR_BYPASS_SCRAMBLER)
                                  );

dig_tx100_mlt3_enc i_dig_tx100_mlt3_enc (
                                  .BYPASS_SCRAMBLER_DATA(BYPASS_SCRAMBLER_DATA), 
                                  .CLKPLL_IN(CLKPLL_IN),
                                  .clk125_enable(clk125_enable), 
                                  .RESET(RESET), 
                                  .MLT3ENC_DATA(MLT3ENC_DATA),
                                  .MR_100MBS(MR_100MBS)
                                  );
   
dig_fef_gen i_dig_fef_gen ( 
                           .CLKPLL_IN(CLKPLL_IN),
                           .clk125_enable(clk125_enable), 
                           .SIGNAL_STATUS(MSE_GOOD),
                           .RESET(RESET),
                           .MR_AN_ENAB(MR_AN_ENAB),
                           .MR_FEF_DISB(MR_FEF_DISB),
                           .SERIALIZER_DATA(SERIALIZER_DATA),
                           .FE_DATA(FE_DATA), 
                           .MR_DIG_LOOP_BACK_ENAB(MR_DIG_LOOP_BACK_ENAB)
                           );

endmodule

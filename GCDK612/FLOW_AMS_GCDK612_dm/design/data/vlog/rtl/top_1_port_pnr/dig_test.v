// Created by ihdl
`timescale 1 ns / 1 ps

module dig_test (
                 // Inputs
                 TEST_MODE, 
                 ADC_OUT, 
                 FLASH_OUT, 
                 PHY,
                 DEC10_RCLK10, 
                 DEC10_DATA_D1,
                 SLICER_OUT, 
                 TIMING_UP_DSP,
                 TIMING_DN_DSP, 
                 AEQ_CNT_DSP,  
                 WANDER_CNT_DSP,
                 TXER_I, 
                 TXC, 
                 RXDV, 
                 RXC, 
                 RXD, 
                 TXEN_I, 
                 CLKFAST,
                 DACDATA, 
                 TXD, 
                 MLT3ENC_DATA, 
                 MR_100MBS,
                 LINK100_DOWN, 
                 LINK10_DOWN,
                 COL, 
                 RESET, 
                 RCLK125, 
                 LINE_DRIVER10_ENAB, 
                 X_125, 
                 X_160,
                 MLT3_DATAIN, 
                 MDIX, 
                 TP_DISC,

                 // Outputs
                 AEQ_BYPASS, 
                 AEQ_CNT_ANLG, 
                 TIMING_UP_ANLG, 
                 TIMING_DN_ANLG,
                 WANDER_CNT_ANLG, 
                 RXDV_O, 
                 RXC_O, 
                 TENBT_CLK160,
                 RXD_O, 
                 TENBT_FILTER, 
                 MLT3_TDATA, 
                 LEDL_OUT_topdig, 
                 LEDC_OUT_topdig, 
                 BASE10_TX_DIS, 
                 MDIX_O, 
                 TP_DISC_O, 
                 TXC_O
                 );

//
// I/O Declarations
//
input [2:0]  TEST_MODE;             // Test mode
input [5:0]  ADC_OUT;               // ADC data
input [2:0]  FLASH_OUT;             // 
input [4:0]  PHY;                   // PHY address
input        DEC10_RCLK10;          // 
input        DEC10_DATA_D1;         // 
input        SLICER_OUT;            // 
input        TIMING_UP_DSP;         // 
input        TIMING_DN_DSP;         // 
input [4:0]  AEQ_CNT_DSP;           // 
input [6:0]  WANDER_CNT_DSP;        //
input        TXER_I;                // Transmit error
input        TXC;                   // Transmit clock
input        RXDV;                  // Receive data valid
input        RXC;                   // Receive clock
input [4:0]  RXD;                   // Receive data
input        TXEN_I;                // Transmit enable
input        CLKFAST;               // Register clock
input [4:0]  DACDATA;               // DAC data
input [4:0]  TXD;                   // Transmit data
input [1:0]  MLT3ENC_DATA;          //
input        MR_100MBS;             // 100Mbps mode 
input        LINK100_DOWN;          // 100BaseT link down
input        LINK10_DOWN;           // 10BaseT link down
input        COL;                   // Collision detection 
input        RESET;                 // Reset
input        RCLK125;               // 125MHz Clock sync'ed to the rx
input        LINE_DRIVER10_ENAB;    // 10BaseT line driver active
input        X_125;                 // Clock 125MHz
input        X_160;                 // Clock 160MHz
input        MLT3_DATAIN;           // MLT3 data
input        MDIX;                  // MDIX enabled
input        TP_DISC;               // Twisted Pair disabled

output       AEQ_BYPASS;            // Analog equaliser bypass
output [4:0] AEQ_CNT_ANLG;          //
output       TIMING_UP_ANLG;        //
output       TIMING_DN_ANLG;        //
output [6:0] WANDER_CNT_ANLG;       //
output       RXDV_O;                // Receive data valid
output       RXC_O;                 // Receive clock
output       TENBT_CLK160;          // 10BaseT 160MHz clock
output [4:0] RXD_O;                 // Receive data
output [4:0] TENBT_FILTER;          // 10BaseT filter setting
output [1:0] MLT3_TDATA;            // 
output       LEDL_OUT_topdig;       // Link active LED active low
output       LEDC_OUT_topdig;       // Collision LED active low
output       BASE10_TX_DIS;         // 10BaseT Transmit disable
output       MDIX_O;                //
output       TP_DISC_O;             //
output       TXC_O;                 // Transmit clock

//
// I/O Type Declarations
//
wire  [2:0]  TEST_MODE;             
wire  [5:0]  ADC_OUT;               
wire  [2:0]  FLASH_OUT;             
wire  [4:0]  PHY;                   
wire         DEC10_RCLK10;          
wire         DEC10_DATA_D1;         
wire         SLICER_OUT;            
wire         TIMING_UP_DSP;         
wire         TIMING_DN_DSP;         
wire  [4:0]  AEQ_CNT_DSP;           
wire  [6:0]  WANDER_CNT_DSP;        
wire         TXER_I;                
wire         TXC;                   
wire         RXDV;                  
wire         RXC;                   
wire  [4:0]  RXD;                   
wire         TXEN_I;                
wire         CLKFAST;
wire  [4:0]  DACDATA;               
wire  [4:0]  TXD;                   
wire  [1:0]  MLT3ENC_DATA;          
wire         MR_100MBS;             
wire         LINK100_DOWN;          
wire         LINK10_DOWN;           
wire         COL;                   
wire         RESET;                 
wire         RCLK125;               
wire         LINE_DRIVER10_ENAB;    
wire         X_125;                 
wire         X_160;                 
wire         MLT3_DATAIN;           
wire         MDIX;                  
wire         TP_DISC;               

reg          AEQ_BYPASS;            
reg   [4:0]  AEQ_CNT_ANLG;          
reg          TIMING_UP_ANLG;        
reg          TIMING_DN_ANLG;        
reg   [6:0]  WANDER_CNT_ANLG;       
reg          RXDV_O;                
reg          RXC_O;                 
reg          TENBT_CLK160;          
reg   [4:0]  RXD_O;                 
reg   [4:0]  TENBT_FILTER;          
reg   [1:0]  MLT3_TDATA;            
wire         LEDL_OUT_topdig;                
wire         LEDC_OUT_topdig;                
reg          BASE10_TX_DIS;         
reg          MDIX_O;                
reg          TP_DISC_O;             
reg          TXC_O;                 

//
// Internal Signal Declarations
//
wire  [4:0]  TXD_I;

reg   [5:0]  adc_flash;      //
reg   [5:0]  decimate;       //
reg   [2:0]  count;          //

//
// Parameter Declarations
//
// None

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign LEDC_OUT_topdig = !COL;
   assign LEDL_OUT_topdig = MR_100MBS ? LINK100_DOWN : LINK10_DOWN;
   assign TXD_I  = {PHY[0], TXD[3:0]};


//------------------------------------------------------------------------------
// This process decodes the testmodes and selects the appropriate
// outputs for the various tests.
//
//------------------------------------------------------------------------------
   always @ (TEST_MODE or RXD or RXDV or TXC or CLKFAST or
             LINE_DRIVER10_ENAB or DACDATA or WANDER_CNT_DSP or 
             MLT3ENC_DATA or AEQ_CNT_DSP or TIMING_UP_DSP or TIMING_DN_DSP or 
             MDIX or ADC_OUT or TP_DISC or decimate or adc_flash or FLASH_OUT or
             TXD or PHY or RCLK125 or X_160 or X_125 or TXER_I or TXEN_I or 
             SLICER_OUT or DEC10_DATA_D1 or DEC10_RCLK10 or MLT3_DATAIN or 
             TXD_I or RXC
            )

   begin : p_test_muxes
   casex (TEST_MODE)

      3'b000 : begin
               RXD_O = RXD;
               RXC_O = RXC;
               RXDV_O = RXDV;
               TXC_O    = TXC;
               TENBT_CLK160 = CLKFAST;
               BASE10_TX_DIS = !LINE_DRIVER10_ENAB;
               AEQ_BYPASS = 1'b0;
               TENBT_FILTER = DACDATA;
               WANDER_CNT_ANLG = WANDER_CNT_DSP;
               MLT3_TDATA = MLT3ENC_DATA;
               AEQ_CNT_ANLG = AEQ_CNT_DSP;
               TIMING_UP_ANLG = TIMING_UP_DSP;
               TIMING_DN_ANLG = TIMING_DN_DSP;
               MDIX_O = ~MDIX;
               adc_flash = ADC_OUT;
               TP_DISC_O = TP_DISC;
               end

      // ADC test mode --TST_ADC_ONLY
      3'b001 : begin
               if (PHY[2])
                  begin
                  RXD_O = decimate[4:0];
                  RXC_O = decimate[5];
                  end
               else
                  begin
                  RXD_O = adc_flash[4:0];
                  RXC_O = adc_flash[5];
                  end
               RXDV_O = RXDV;
               TXC_O    = TXC;
               TENBT_CLK160 = CLKFAST;
               BASE10_TX_DIS = !LINE_DRIVER10_ENAB;
               AEQ_BYPASS = 1'b0;
               TENBT_FILTER = DACDATA;
               WANDER_CNT_ANLG = WANDER_CNT_DSP;
               MLT3_TDATA = MLT3ENC_DATA;
               AEQ_CNT_ANLG = AEQ_CNT_DSP;
               TIMING_UP_ANLG = TIMING_UP_DSP;
               TIMING_DN_ANLG = TIMING_DN_DSP;
               MDIX_O = 1'b0;
               if (PHY[3])
                  adc_flash = {3'b0, FLASH_OUT};
               else
                  adc_flash = ADC_OUT;
               TP_DISC_O = 1'b0;
               end

      // AEQ test mode -- TST_100_R_AEQ
      3'b010 : begin
               RXD_O = RXD;
               RXC_O = RXC;
               RXDV_O = RXDV;
               TXC_O    = TXC;
               TENBT_CLK160 = CLKFAST;
               BASE10_TX_DIS = !LINE_DRIVER10_ENAB;
               if (PHY[1])
                  AEQ_BYPASS = 1'b1;
               else
                  AEQ_BYPASS = 1'b0;
               TENBT_FILTER = DACDATA;
               WANDER_CNT_ANLG = WANDER_CNT_DSP;
               MLT3_TDATA = MLT3ENC_DATA;
               AEQ_CNT_ANLG[3:0] = TXD[3:0];
               AEQ_CNT_ANLG[4] = PHY[0];
               TIMING_UP_ANLG = TIMING_UP_DSP;
               TIMING_DN_ANLG = TIMING_DN_DSP;
               MDIX_O = ~MDIX;
               if (PHY[3])
                  adc_flash = {3'b0, FLASH_OUT};
               else
                  adc_flash = ADC_OUT;
               TP_DISC_O = 1'b0;

               end

      // 100Base-T Tx test mode  -- TST_100_TX
      3'b011 : begin
               RXD_O = RXD;
               RXC_O = RXC;
               RXDV_O = RXDV;
               TXC_O    = TXC;
               TENBT_CLK160 = CLKFAST;
               BASE10_TX_DIS = !LINE_DRIVER10_ENAB;
               AEQ_BYPASS = 1'b0;
               TENBT_FILTER = DACDATA;
               WANDER_CNT_ANLG = WANDER_CNT_DSP;
               MLT3_TDATA = TXD[1:0];
               AEQ_CNT_ANLG = AEQ_CNT_DSP;
               TIMING_UP_ANLG = TIMING_UP_DSP;
               TIMING_DN_ANLG = TIMING_DN_DSP;
               MDIX_O = 1'b0;
               adc_flash = ADC_OUT;
               TP_DISC_O = 1'b0;
               end

      // PLL/PI test mode -- TST_PLL
      3'b100 : begin
               RXD_O[0] = RCLK125;
               RXD_O[1] = X_160;
               RXD_O[2] = X_125;
               RXD_O[3] = 1'b0;
               RXD_O[4] = 1'b0;
               RXC_O = 1'b0;
               RXDV_O   = RXDV;
               TXC_O    = TXC;
               if (PHY[2])
                  TENBT_CLK160 = TXER_I;
               else
                  TENBT_CLK160 = CLKFAST;
               BASE10_TX_DIS = !LINE_DRIVER10_ENAB;
               AEQ_BYPASS = 1'b0;
               TENBT_FILTER = DACDATA;
               WANDER_CNT_ANLG = WANDER_CNT_DSP;
               MLT3_TDATA = MLT3ENC_DATA;
               AEQ_CNT_ANLG = AEQ_CNT_DSP;
               TIMING_UP_ANLG = TXER_I;                         
               TIMING_DN_ANLG = TXEN_I;
               MDIX_O = 1'b0;
               adc_flash = ADC_OUT;
               TP_DISC_O = 1'b0;
               end

      // 10Base-T test mode -- TST_10
      3'b101 : begin
               RXD_O[0] = SLICER_OUT;
               RXC_O = 1'b0;
               RXD_O[1] = DEC10_DATA_D1;
               RXD_O[2] = DEC10_RCLK10;
               RXD_O[3] = 1'b0;
               RXD_O[4] = 1'b0;
               RXDV_O   = RXDV;
               TXC_O    = TXC;
               TENBT_CLK160 = CLKFAST;
               BASE10_TX_DIS = !TXEN_I;
               AEQ_BYPASS = 1'b0;
               TENBT_FILTER = TXD_I;
               WANDER_CNT_ANLG = WANDER_CNT_DSP;
               MLT3_TDATA = MLT3ENC_DATA;
               AEQ_CNT_ANLG = AEQ_CNT_DSP;
               TIMING_UP_ANLG = TIMING_UP_DSP;
               TIMING_DN_ANLG = TIMING_DN_DSP;
               MDIX_O = 1'b0;
               adc_flash = ADC_OUT;
               TP_DISC_O = 1'b0;
               end

      // Fiber test mode -- TST_FIBER
      3'b110 : begin
               RXD_O  = RXD;
               RXC_O = RXC;
               RXDV_O = MLT3_DATAIN;
               TXC_O  = RCLK125;
               TENBT_CLK160 = CLKFAST;
               BASE10_TX_DIS = !LINE_DRIVER10_ENAB;
               AEQ_BYPASS = 1'b0;
               TENBT_FILTER = DACDATA;
               WANDER_CNT_ANLG = WANDER_CNT_DSP;
               MLT3_TDATA = MLT3ENC_DATA;
               AEQ_CNT_ANLG = AEQ_CNT_DSP;
               TIMING_UP_ANLG = TIMING_UP_DSP;
               TIMING_DN_ANLG = TIMING_DN_DSP;
               MDIX_O = ~MDIX;
               if (PHY[3])
                  adc_flash = {3'b0, FLASH_OUT};
               else
                  adc_flash = ADC_OUT;
               TP_DISC_O = 1'b1;
               end

      // Base Line Wander test mode -- TST_100_R_BLW
      3'b111: begin
              RXD_O = RXD;
              RXC_O = RXC;
              RXDV_O = RXDV;
              TXC_O    = TXC;
              TENBT_CLK160 = CLKFAST;
              BASE10_TX_DIS = !LINE_DRIVER10_ENAB;
              AEQ_BYPASS = 1'b1;
              TENBT_FILTER = DACDATA;
              WANDER_CNT_ANLG[0] = TXEN_I;
              WANDER_CNT_ANLG[4:1] = TXD[3:0];
              WANDER_CNT_ANLG[6:5] = PHY[1:0];
              MLT3_TDATA = MLT3ENC_DATA;
              AEQ_CNT_ANLG = AEQ_CNT_DSP;
              TIMING_UP_ANLG = TIMING_UP_DSP;
              TIMING_DN_ANLG = TIMING_DN_DSP;
              MDIX_O = ~MDIX;
              if (PHY[3])
                 adc_flash = {3'b0, FLASH_OUT};
              else
                 adc_flash = ADC_OUT;
              TP_DISC_O = 1'b0;
              end

      default : begin
                RXD_O = RXD;
                RXC_O = RXC;
                RXDV_O = RXDV;
                TXC_O    = TXC;
                TENBT_CLK160 = CLKFAST;
                BASE10_TX_DIS = !LINE_DRIVER10_ENAB;
                AEQ_BYPASS = 1'b0;
                TENBT_FILTER = DACDATA;
                WANDER_CNT_ANLG = WANDER_CNT_DSP;
                MLT3_TDATA = MLT3ENC_DATA;
                AEQ_CNT_ANLG = AEQ_CNT_DSP;
                TIMING_UP_ANLG = TIMING_UP_DSP;
                TIMING_DN_ANLG = TIMING_DN_DSP;
                MDIX_O = ~MDIX;
                adc_flash = ADC_OUT;
                TP_DISC_O = TP_DISC;
                end

      endcase
   end // p_test_muxes


//------------------------------------------------------------------------------
// Counter for controlling the output ADC value
//
//------------------------------------------------------------------------------
   always @(posedge RCLK125 or posedge RESET)
      begin : p_decimate
      if (RESET)
         begin
         count <= 3'd0;
         decimate <= 6'd0;
         end
      else
         // increments a counter in test mode
         // When the counter reaches 4 the counter is reset
         // When the counter = 4 the ADC is output 
         begin
         if (count < 3'd4 & (TEST_MODE == 3'b001))
            count <= count + 3'd1;
         else if (count == 3'd4)
            begin
            decimate <= adc_flash;
            count    <= 3'd0;
            end
         else
             count <= 3'd0;
         end
      end //p_decimate



//------------------------------------------------------------------------------
endmodule

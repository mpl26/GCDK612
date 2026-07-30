// Created by ihdl
module dig_mdio (
                 //Inputs
                 MDIO_I,
                 MDC,
                 REG_DOUT,
                 PHYADDR,
                 RESET,

                   //Outputs
                 MDIO_O,
                 MDIO_OE,
                 REG_ENAB,
                 REG_R_NW,
                 REG_ADDR,
                 REG_DIN
                 );
//
// I/O Declarations
//
input         MDIO_I;    // Management Data input
input         MDC;       // Management Clock
input  [15:0] REG_DOUT;  // Output of Register File
input  [4:0]  PHYADDR;   // Assigned Pin PHYADDR
input         RESET;     // Reset the Chip

output        MDIO_O;    // Management Data output
output        MDIO_OE;   // Management Data output enable
output        REG_ENAB;  // Enable Data R/W
output        REG_R_NW;  // Read/Write Indicator 0=Read, 1= Write
output [4:0]  REG_ADDR;  // Register Address
output [15:0] REG_DIN;   // Input to Register File

//
// I/O Type Declarations
//
wire          MDIO_I;  
wire          MDC;     
wire   [15:0] REG_DOUT;
wire   [4:0]  PHYADDR; 
wire          RESET;

wire          MDIO_O;  
wire          MDIO_OE; 
reg           REG_ENAB;
reg           REG_R_NW;
reg    [4:0]  REG_ADDR;
reg    [15:0] REG_DIN; 

//
// Internal Signal Declarations
//
reg           MDIO_OE_N;         // Select R/W from/to MDIO
reg           prev_reg_enable;   //
reg           prev2_reg_enable;  //
reg    [15:0] mdioin;            // Input Data shift register
reg    [15:0] mr_read;           // Output Data shift register
reg    [15:0] reg_input_data;    // Register REG_DOUT
reg    [5:0]  bit_pos;           // Keeps track of bit position within a frame
reg           preamble_state;    // Waiting for preamble
reg           st_state;          // start of frame
reg           op_state;          // Opcode
reg           read_state;        // Read request
reg           write_state;       // Write request
reg           phy_state;         // PHY Address
reg           bad_frame_state;   // Received bad frame or PHY addr
                                 // Wait until end of frame
                                 // before looking for sof again
reg           reg_state;         // Register Address
wire          mdio_one;          //
wire          mdio_zero;         //
wire          phyaddr_match;     //
//
// Parameter Declarations
//
//-----------------------------------------------//
// avail = MDIO not in use; inuse - MDIO in use  //
//-----------------------------------------------//
`define mdio_inuse 1'b0   // MDIO being used
`define mdio_avail 1'b1   // MDIO not being used
`define read  1'b1        // read  - active high (read is output)
`define write 1'b0        // write - active low (write is input)

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   assign mdio_one      = (MDIO_I   == 1'b1);
   assign mdio_zero     = (MDIO_I   == 1'b0);
   assign phyaddr_match = ({mdioin[4:1],MDIO_I} == PHYADDR);

//------------------------------------------------------------------------------
// This process is used to register the input data
//------------------------------------------------------------------------------
//
   always @(posedge MDC or posedge RESET)
      begin : p_reg_input_data
      if (RESET)
         reg_input_data <= 16'b0;
      else
         reg_input_data <= REG_DOUT;
      end // p_reg_input_data

//------------------------------------------------------------------------------
// This process is a shift register for the management data input stream
//------------------------------------------------------------------------------
//
   always @(posedge MDC or posedge RESET)
      begin : p_mdioin
      if (RESET)
         mdioin[15:1] <= 15'b0;
      else
         mdioin[15:1] <= {mdioin[14:1],MDIO_I};
      end // p_mdioin

   assign MDIO_O = mr_read[15];

//------------------------------------------------------------------------------
// This process gets the Frame Data
//------------------------------------------------------------------------------
//
   always @(negedge MDC or posedge RESET)
      begin
      if (RESET)
         bit_pos <= 6'b0 ;
      else
         bit_pos <= (preamble_state) ? 6'b0 : bit_pos + 1 ;
      end

//------------------------------------------------------------------------------
// This process is the state machine that controls MDIO accesses.
//------------------------------------------------------------------------------
//
   always @(posedge MDC or posedge RESET)
      begin : p_mdio_sm
      if (RESET)
         begin
         preamble_state   <= 1'b1;
         st_state         <= 1'b0;
         op_state         <= 1'b0;
         read_state       <= 1'b0;
         write_state      <= 1'b0;
         phy_state        <= 1'b0;
         bad_frame_state  <= 1'b0;
         reg_state        <= 1'b0;
         REG_ENAB         <= 1'b0;
         prev_reg_enable  <= 1'b0;
         prev2_reg_enable <= 1'b0 ;
         REG_R_NW         <= `read;
         REG_ADDR         <= 5'b00000;
         MDIO_OE_N        <= `mdio_avail;
         REG_DIN          <= 16'b0;
         mr_read          <= 16'b0;
         end
      else if (preamble_state)
         begin
         REG_ENAB         <= prev_reg_enable;
         prev_reg_enable  <= prev2_reg_enable;
         prev2_reg_enable <= 1'b0;
         st_state         <= mdio_zero;
         preamble_state   <= mdio_one;
         end
      else if (st_state)
         begin
         st_state         <= 1'b0;
         op_state         <= mdio_one;
         bad_frame_state  <= mdio_zero;
         REG_ENAB         <= prev_reg_enable;
         prev_reg_enable  <= prev2_reg_enable;
         prev2_reg_enable <= 1'b0 ;
         end
      else if (op_state)
         begin
         if (read_state)
            begin
            REG_R_NW        <= `read;
            read_state      <= mdio_zero;
            bad_frame_state <= mdio_one;
            op_state        <= 1'b0;
            phy_state       <= mdio_zero;
            end
         else if (write_state)
            begin
            REG_R_NW        <= `write;
            write_state     <= mdio_one;
            bad_frame_state <= mdio_zero;
            op_state        <= 1'b0;
            phy_state       <= mdio_one;
            end
         else
            begin
            read_state      <= mdio_one;
            write_state     <= mdio_zero;
            end
         REG_ENAB         <= prev_reg_enable;
         prev_reg_enable  <= prev2_reg_enable;
         prev2_reg_enable <= 1'b0 ;
         end
      else if (phy_state)
         begin
         if (bit_pos == 6'h08)
            begin
            phy_state       <= 1'b0;
            reg_state       <= phyaddr_match;
            bad_frame_state <= ~phyaddr_match;
            end
         end
      else if (bad_frame_state)
         begin
         if (bit_pos == 6'h1f)
            begin
            bad_frame_state <= 1'b0;
            preamble_state  <= 1'b1;
            end
         read_state  <= 1'b0;
         write_state <= 1'b0;
         end
      else if (reg_state)
         begin
         if (bit_pos == 6'h0c)
            reg_state <= 1'b0;
         end
      else if (read_state)
         begin
         if (bit_pos == 6'h0d)
            begin
            REG_ADDR <= {mdioin[4:1],MDIO_I};
            REG_ENAB <= 1'b1;
            end
         else if (bit_pos == 6'h0e)
            begin
            mr_read[15] <= 1'b0;
            MDIO_OE_N   <= `mdio_inuse;
            end
         else if (bit_pos == 6'h0f)
            mr_read <= reg_input_data;
         else if (bit_pos == 6'h1f)
            begin
            REG_ENAB       <= 1'b0;
            preamble_state <= 1'b1;
            read_state     <= 1'b0;
            MDIO_OE_N      <= `mdio_avail;
            end
         else
            mr_read <= {mr_read[14:0],1'b0};
         end
      else if (write_state)
         begin
         if (bit_pos == 6'h0d)
            REG_ADDR  <= {mdioin[4:1],MDIO_I};
         else if (bit_pos == 6'h1f)
            begin
            REG_ENAB         <= 1'b1;
            prev_reg_enable  <= 1'b1;
            prev2_reg_enable <= 1'b1;
            REG_DIN          <= {mdioin[15:1],MDIO_I};
            write_state      <= 1'b0;
            preamble_state   <= 1'b1;
            end
         end
      end // p_mdio_sm

   assign MDIO_OE = ~MDIO_OE_N;

endmodule

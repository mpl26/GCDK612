// Created by ihdl
module dsp_sm_interface(ADDRESS, DATA_READ, DATA_WRITE, WRITE, CLK,
                        RESET, REG0, REG1, REG2, REG3, REG4, REG5);

   input    [2:0]    ADDRESS;
   output   [15:0]   DATA_READ;
   input    [15:0]   DATA_WRITE;
   input             WRITE;
   input             CLK;
   input             RESET;

   input    [15:0]   REG0;
   input    [15:0]   REG1;
   input    [15:0]   REG2;
   output   [15:0]   REG3;
   output   [15:0]   REG4;
   output   [15:0]   REG5;

   reg      [15:0]   DATA_READ;
   reg      [15:0]   register0[1:0];
   reg      [15:0]   register1[1:0];
   reg      [15:0]   register2[1:0];
   reg      [15:0]   register3;
   reg      [15:0]   register4;
   reg      [15:0]   register5;
   reg               write_ff1,write_ff2,write_ff3;
   wire              strobe3;
   wire              strobe4;
   wire              strobe5;
   reg               write_strobe;



   // write strobe is rising edge of write sync'ed to CLK & delayed 2 cycles
   always @(posedge CLK or posedge RESET)   
      if (RESET)
         begin
            write_ff2    <= 1'b0;
            write_ff1    <= 1'b0;
            write_strobe <= 1'b0;
         end
      else   
         begin
            write_ff2    <= write_ff1;
            write_ff1    <= WRITE;
            write_strobe <= ((~write_ff2) & write_ff1);
         end

   assign strobe3 = write_strobe & (ADDRESS==3'h3);
   assign strobe4 = write_strobe & (ADDRESS==3'h4);
   assign strobe5 = write_strobe & (ADDRESS==3'h5);


   always @(ADDRESS or register0[1] or register1[1] or register2[1] or
            register3 or register4 or register5) begin
      case(ADDRESS)	                               
	3'h0: DATA_READ = register0[1];
	3'h1: DATA_READ = register1[1];
	3'h2: DATA_READ = register2[1];
	3'h3: DATA_READ = register3;       // read out WRITE reg
	3'h4: DATA_READ = register4;       // read out WRITE reg
	3'h5: DATA_READ = register5;       // read out WRITE reg
   default : DATA_READ = 16'h0;
      endcase
   end
 

   always @(posedge CLK or posedge RESET) begin
      if (RESET) begin
	 register0[0] <= 16'b0000_0000_0000_0000;    // default values
	 register0[1] <= 16'b0000_0000_0000_0000;    // default values
	 register1[0] <= 16'b0000_0000_0000_0000;
	 register1[1] <= 16'b0000_0000_0000_0000;
	 register2[0] <= 16'b0000_0000_0000_0000;
	 register2[1] <= 16'b0000_0000_0000_0000;
	 register3 <= 16'b0000_0010_0101_1010;
	 register4 <= 16'b0001_0000_1010_0000;
	 register5 <= 16'b0001_0001_0100_0000;
      end
      else begin
	 register0[0] <= REG0 ;
	 register0[1] <= register0[0] ;
	 register1[0] <= REG1 ;
	 register1[1] <= register1[0] ;
	 register2[0] <= REG2 ;
	 register2[1] <= register2[0] ;
	 register3 <= strobe3 ? DATA_WRITE : register3;
	 register4 <= strobe4 ? DATA_WRITE : register4;
	 register5 <= strobe5 ? DATA_WRITE : register5;
      end
   end 


   assign REG3 = register3;
   assign REG4 = register4;
   assign REG5 = register5;

endmodule

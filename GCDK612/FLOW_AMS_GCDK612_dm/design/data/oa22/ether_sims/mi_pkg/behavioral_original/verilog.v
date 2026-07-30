//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
// Title   :  mi_pkg
// Project :  umc18a01
// Author  :  dshelton
// Notes   :  this is the bus-functional of the two-wire MI serial 
//            interface. The syncronous interface may be driven at the 
//            specified 2.5MHz or, in the interest of reducing simulation
//            times, it may be driven at 25MHz.
//            
//            the clock task both enables/disables the MDC clock and  
//            selects the interface rate:
// 
//            clock(mode, go)  where: mode is an input from the 
//                                      testbench selecting the rate
//                                      mode = 1'b0  => MDC = sim_clk2p5
//                                      mode = 1'b1  => MDC = sim_clk25
//
//                                    go is an input from the 
//                                      testbench enabling the clock 
//                                      go = 1'b0  => MDC = low
//                                      go = 1'b1  => MDC = sim_clk
//
//
//            the read_only task drives the MDDIS pin synchonously with 
//            timing parameters equivalent to the MDIO specification.
//
//            read_only(port_num, active) 
//                              where: port_num port_num is a single bit from
//                                       the testbench selecting 
//                                       which bus to drive
//                                     active is an input from the 
//                                       testbench enabling read-only mode 
//                                       active = 1'b0  => MDDIS = low
//                                       active = 1'b1  => MDDIS = high
//
//
//
//            the read task drives MDIO three-wire implementation of the 
//            IEEE specified inout port per the umc18a01 specification.
//            It drives the output port per the specified setup/hold time,
//            and samples the respons at the earliest required time:
//
//            read(phy_addr, pre_suppress, reg_addr, data)  
//                              where: phy_addr is 5 bits supplied from
//                                       testbench
//                                     pre_suppress is a bit supplied from
//                                       testbench indicating no preamble
//                                       to be sent
//                                     reg_addr is 5 bits supplied from 
//                                       testbench
//                                     data is 16 bits recieved from the 
//                                       dut and returned to the testbench
//
//
//            the write task drives MDIO three-wire implementation of the
//            IEEE specified inout port per the umc18a01 specification.
//            It drives the output port per the specified setup/hold time,
//            and samples the response at earliest required time:
//
//            write(phy_addr, pre_suppress, reg_addr, data)  
//                              where: phy_addr is 5 bits supplied from
//                                       testbench
//                                     pre_suppress is a bit supplied from
//                                       testbench indicating no preamble
//                                       to be sent
//                                     reg_addr is 5 bits supplied from 
//                                       testbench
//                                     data is 16 bits supplied from the 
//                                       testbench to the dut
//                                     
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
`timescale 1ns/10ps

//`define OLD_NL
//-----------------------------------------------------------------------
// mi frame record
//-----------------------------------------------------------------------
`define MI_FRAME_TYP [ 63:  0]
`define DATA         [ 15:  0]
`define TA           [ 17: 16]
`define REGAD        [ 22: 18]
`define PHYAD        [ 27: 23]
`define OP           [ 29: 28]
`define SFD          [ 31: 30]
`define PRE          [ 63: 32]

//-----------------------------------------------------------------------
// mi bus bus functional models
//-----------------------------------------------------------------------
module mi_pkg (
  sim_clk2p5,
  sim_clk25,
  MDIO_OE_0,
  MDIO_OUT_0,
  MDIO_OE_1,
  MDIO_OUT_1,
	       
  MDC,
  MDDIS_0,
  MDDIS_1,
  MDIO_IN);

   input  sim_clk2p5;
   input  sim_clk25;
   input  MDIO_OE_0;   
   input  MDIO_OUT_0;
   input  MDIO_OE_1;
   input  MDIO_OUT_1;
   
   output MDC;
   output MDDIS_0;
   output MDDIS_1;
   output MDIO_IN;

   reg    MDC;
   reg    MDDIS_0;
   reg    MDDIS_1;
   reg    MDIO_IN;
   reg    `MI_FRAME_TYP sta;
   reg    mdc_go;
   reg 	  mdc_fast;

   tri    MDIO_OUT;
   
   // sum multiple PHYs output and condition if both tristated
   assign MDIO_OUT = (MDIO_OE_0 == 1) ? MDIO_OUT_0 : 1'bZ;
   assign MDIO_OUT = (MDIO_OE_1 == 1) ? MDIO_OUT_1 : 1'bZ;   
   pullup (weak1) cond (MDIO_OUT); 

   // timing parameters
   parameter SpecPeriod  = 400,
             SpecThold   = 10,
             SpecTsetup  = 10,
             FastPeriod  = 40,
             FastThold   = 10,
             FastTsetup  = 10;

   initial begin
      // intialize static bits of MI frame
      sta`PRE <= 32'hFFFFFFFF;
      sta`SFD <= 2'b01;
      
      //initalize MDIO_IN, MDDIS, and MDC
      MDC      <= 1'b0;
      MDDIS_0  <= 1'b0;
      MDDIS_1  <= 1'b0;
      MDIO_IN  <= 1'b1;

      // initialize mdc_go and mdc_fast signals
      mdc_go   <= 1'b0;
      mdc_fast <= 1'b0;
      
   end 

   //--------------------------------------------------------------------   
   // combinatorial mux to select MDC driver
   //--------------------------------------------------------------------
   always @(sim_clk2p5 or sim_clk25 or mdc_go or mdc_fast)
      if (!mdc_go)
         MDC <= 1'b0;
      else if (mdc_fast)
         MDC <= sim_clk25;
      else 
         MDC <= sim_clk2p5;


   //--------------------------------------------------------------------
   // clock enabling task      mode = 1'b0  => MDC = sim_clk2p5
   //                          mode = 1'b1  => MDC = sim_clk25
   //                          go = 1'b0    => MDC = low
   //                          go = 1'b1    => MDC = sim_clk
   //--------------------------------------------------------------------
   task clock;
      input mode;
      input go;

      reg   in_use;

      begin
	 // check non-reentrant task guard semaphore
	 if (in_use === 1'b1) begin
	    $display("E: Call to mi.clock was reentrant\n");
	    $finish;
	 end 
	 in_use = 1'b1;

	 @ (negedge sim_clk25);
         // set go register
         if (!go)
            mdc_go <= 1'b0;
         else
            mdc_go <= 1'b1;
 
         // set speed control register
         if (!mode)
            mdc_fast <= 1'b0;
         else
            mdc_fast <= 1'b1;
	 @ (negedge sim_clk25);         

	 in_use = 1'b0;
      end
         
   endtask // clock

   //--------------------------------------------------------------------   
   //  read_only (MDDIS) task    active = 1'b0  => MDDIS = low
   //                            active = 1'b1  => MDDIS = high
   //--------------------------------------------------------------------
   task read_only;
      input  port_num;
      input  active;

      reg    in_use;
   
      begin
	 // check non-reentrant task guard semaphore
	 if (in_use === 1'b1) begin
	    $display("E: Call to miread_only was reentrant\n");
	    $finish;
	 end 
	 in_use = 1'b1;
         
	 // sync to next clock
	 @ (posedge MDC);

         // fastmode timing
	 if (mdc_fast)

            // send bit to specified port
            if (!port_num) begin
	       #(FastPeriod - FastTsetup);
               MDDIS_0 <= active;
	       #(FastThold + FastTsetup);
            end

            else begin
	       #(FastPeriod - FastTsetup);
               MDDIS_1 <= active;
	       #(FastThold + FastTsetup);
            end

         // spec timing
         else 
            // send bit to specified port
            if (!port_num) begin
	       #(SpecPeriod - SpecTsetup);
               MDDIS_0 <= active;
	       #(SpecThold + SpecTsetup);
            end

            else begin
	       #(SpecPeriod - SpecTsetup);
               MDDIS_1 <= active;
	       #(SpecThold + SpecTsetup);
            end

	 @ (negedge MDC);	 
	 in_use = 1'b0;
      end
   endtask // read_only


   //--------------------------------------------------------------------
   // read task
   //--------------------------------------------------------------------
   task read;
      input  [4:0]   phy_addr;
      input          pre_suppress;
      input  [4:0]   reg_addr;
      output [15:0]  data;

      integer 	     i;

      reg 	     in_use;      

      begin
	 // check non-reentrant task guard semaphore
	 if (in_use === 1'b1) begin
	    $display("E: Call to mi.read was reentrant\n");
	    $finish;
	 end 
	 in_use = 1'b1;
	 
         // setup MI frame for read
	 sta`PHYAD <= phy_addr;
	 sta`REGAD <= reg_addr;
	 sta`OP    <= 2'b10;
	 sta`TA    <= 2'bZZ;

	 // sync to next clock
	 @ (posedge MDC);
	 if (mdc_fast) begin

	    // send first sta`PRE bit
            // if pre_suppress set this is only bit sent
	    #(FastPeriod - FastTsetup);
	    MDIO_IN <= sta[63];
	    #(FastThold + FastTsetup);

            if (!pre_suppress) begin
	       // send remaining preamble bits
	       for (i=62; i>=32; i=i-1) begin
	          MDIO_IN <= 1'bX;
	          #(FastPeriod - FastThold - FastTsetup);	
	          MDIO_IN <= sta[i];
	          #(FastThold + FastTsetup);  
	       end 
            end

	    // send next sta bits up to high-Z PHY
	    for (i=31; i>=18; i=i-1) begin
	       MDIO_IN <= 1'bX;
	       #(FastPeriod - FastThold - FastTsetup);	
	       MDIO_IN <= sta[i];
	       #(FastThold + FastTsetup);  
	    end 

	    // would drive high-Z for a bit with MDIO implemented as inout
	    MDIO_IN <= 1'bX;
            #(FastPeriod);

	    // receive and check PHY TA bit
	    //
            // note that MDIO_IN would see reflection of MDIO_OUT if
	    // MDIO is implemented as inout.
	    //	    
            // note that spec has Thold in and max MDC to MDIO out of dut
            // the same, thus this is correct. If the timing changes
            // such that these two requirements differ, a new parameter
            // will need to be introduced
            sta[16] <= MDIO_OUT;
            if (!MDIO_OUT)
               $write("");
            else 
	       $write("W: PHY failed to issue TA low bit during MI read at %0d ns\n", $time);

            // receive PHY data
	    for (i=15; i>=0; i=i-1) begin
	       #(FastPeriod);
	       sta[i] <= MDIO_OUT;
	    end

	    // condition MDIO_IN to preamble
	    #(FastPeriod - FastThold - FastTsetup);
	    MDIO_IN <= 1'b1;
	    #(FastThold + FastTsetup);
	    
            // go idle for 35 clocks
	    for (i=1; i<=35; i=i+1)
	       #(FastPeriod);

	    @(negedge MDC);

            data = sta`DATA;
	    
	 end

	 else begin

	    // send first sta`PRE bit
            // if pre_suppress set this is only bit sent
	    #(SpecPeriod - SpecTsetup);
	    MDIO_IN <= sta[63];
	    #(SpecThold + SpecTsetup);

            if (!pre_suppress) begin
	       // send remaining preamble bits
	       for (i=62; i>=32; i=i-1) begin
	          MDIO_IN <= 1'bX;
	          #(SpecPeriod - SpecThold - SpecTsetup);	
	          MDIO_IN <= sta[i];
	          #(SpecThold + SpecTsetup);  
	       end 
            end

	    // send next sta bits up to high-Z 
	    for (i=31; i>=18; i=i-1) begin
	       MDIO_IN <= 1'bX;
	       #(SpecPeriod - SpecThold - SpecTsetup);	
	       MDIO_IN <= sta[i];
	       #(SpecThold + SpecTsetup);  
	    end 

	    // would drive high-Z for a bit with MDIO implemented as inout
	    MDIO_IN <= 1'bX;
            #(SpecPeriod);


	    // receive and check PHY TA bit
	    //
            // note that MDIO_IN would see reflection of MDIO_OUT if
	    // MDIO is implemented as inout.
	    //
            // also note that spec has Thold in and max MDC to MDIO out 
            // of dut the same, thus this is correct. If the timing changes
            // such that these two requirements differ, a new parameter
            // will need to be introduced	    
            sta[16] <= MDIO_OUT;
            if (!MDIO_OUT)
               $write("");
            else 
	       $write("W: PHY failed to issue TA low bit during MI read at %0d ns\n", $time);
            
            // receive PHY data
	    for (i=15; i>=0; i=i-1) begin
	       #(SpecPeriod);       
	       sta[i]  <= MDIO_OUT;
	    end

	    // condition MDIO_IN to preamble	    
	    #(SpecPeriod - SpecThold - SpecTsetup);	
	    MDIO_IN <= 1'b1;
	    #(SpecThold + SpecTsetup);	    

            // go idle for 3 clocks
	    #(SpecPeriod);

	    repeat (3) @(negedge MDC);

            data = sta`DATA;
	    
	 end
	 
	 in_use = 1'b0;
      end
   endtask // read


   //--------------------------------------------------------------------
   // write task
   //--------------------------------------------------------------------
   task write;
      input  [4:0]   phy_addr;
      input          pre_suppress;
      input  [4:0]   reg_addr;
      input [15:0]   data;

      integer 	     i;

      reg 	     in_use;    
  
      begin
	 // check non-reentrant task guard semaphore
	 if (in_use === 1'b1) begin
	    $display("E: Call to mi.write was reentrant\n");
	    $finish;
	 end 
	 in_use = 1'b1;
	 
         // setup MI frame for write
	 sta`PHYAD <= phy_addr;
	 sta`REGAD <= reg_addr;
	 sta`DATA  <= data;
	 sta`OP    <= 2'b01;
	 sta`TA    <= 2'b10;

	 // sync to next clock
	 @ (posedge MDC);
	 if (mdc_fast) begin

	    // send first sta`PRE bit
            // if pre_suppress set this is only bit sent
	    #(FastPeriod - FastTsetup);
	    MDIO_IN <= sta[63];
	    #(FastThold + FastTsetup);

            if (!pre_suppress) begin
	       // send remaining preamble bits
	       for (i=62; i>=32; i=i-1) begin
	          MDIO_IN <= 1'bX;
	          #(FastPeriod - FastThold - FastTsetup);	
	          MDIO_IN <= sta[i];
	          #(FastThold + FastTsetup);  
	       end 
            end

	    // send remaining sta bits up 
	    for (i=31; i>=0; i=i-1) begin
	       MDIO_IN <= 1'bX;
	       #(FastPeriod - FastThold - FastTsetup);	
	       MDIO_IN <= sta[i];
	       #(FastThold + FastTsetup);  
	    end 

            MDIO_IN <= 1'b1;

            // go idle for 36 clocks
	    for (i=1; i<=36; i=i+1)
	       #(FastPeriod);

	    @(negedge MDC);

         end

         else begin

	    // send first sta`PRE bit
            // if pre_suppress set this is only bit sent
	    #(SpecPeriod - SpecTsetup);
	    MDIO_IN <= sta[63];
	    #(SpecThold + SpecTsetup);

            if (!pre_suppress) begin
	       // send remaining preamble bits
	       for (i=62; i>=32; i=i-1) begin
	          MDIO_IN <= 1'bX;
	          #(SpecPeriod - SpecThold - SpecTsetup);	
	          MDIO_IN <= sta[i];
	          #(SpecThold + SpecTsetup);  
	       end 
            end

	    // send remaining sta bits up 
	    for (i=31; i>=0; i=i-1) begin
	       MDIO_IN <= 1'bX;
	       #(SpecPeriod - SpecThold - SpecTsetup);	
	       MDIO_IN <= sta[i];
	       #(SpecThold + SpecTsetup);  
	    end 

            MDIO_IN <= 1'b1;

            // go idle for 3 clocks
	    #(SpecPeriod);

	    repeat (3) @(negedge MDC);

	 end

	 in_use = 1'b0;
      end

   endtask // write

   //--------------------------------------------------------------------
   // force_reg task
   // note wolverine register space is currently implemented
   //--------------------------------------------------------------------
   task force_reg;
      input          port_num;
      input  [4:0]   reg_addr;
      input [15:0]   data;

      reg 	     in_use;
      reg   [15:0]   reg0;
      reg   [15:0]   reg4;
      reg   [15:0]   reg7;
      reg   [15:0]   reg16;      
      reg   [15:0]   reg18;
      reg   [15:0]   reg19;
      reg   [15:0]   reg20;
      reg   [15:0]   reg21;
      reg   [15:0]   reg23;      
      reg   [15:0]   reg27;
    
  
      begin
	 // check non-reentrant task guard semaphore
	 if (in_use === 1'b1) begin
	    $display("E: Call to mi.force_reg was reentrant\n");
	    $finish;
	 end 
	 in_use = 1'b1;

         // initiate on falling edge of sim_clk25
         @(negedge sim_clk25);

         if (port_num) begin
            case (reg_addr)
               5'b00000 : begin
		             reg0 <= data;
		             
                             `ifdef DIG_GATES   

//                             `else 
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_RESET_TO_RCB = reg0[15];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_DIG_LOOP_BACK_ENAB = reg0[14];
//   		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_100MBS       = reg0[13];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_ENAB      = reg0[12];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_POWER_DOWN   = reg0[11];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_ISOLATE_TX      = reg0[10];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_RESTART   = reg0[9];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_FULL_DUPLEX  = reg0[8];
 //                               force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_COL_TEST     = reg0[7];
		             `endif
                          end

               5'b00100 : begin
		             reg4 <= data;

		             `ifdef DIG_GATES

//		             `else
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_NP_ENAB       = reg4[15];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR4_REMOTE_FAULT = reg4[13];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_FLOW_CTL      = reg4[10];
//                               force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TAF_100FULL   = reg4[8];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TAF_100HALF   = reg4[7];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TAF_10FULL    = reg4[6];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TAF_10HALF    = reg4[5];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SELECTOR      = reg4[4:0];
		             `endif
                          end

              5'b00111 : begin
		             reg7 <= data;
		 
                             `ifdef DIG_GATES
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MORE      = reg7[15];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MSG_PAGE_reg.Q  = reg7[13];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_ACK2      = reg7[12];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MESSAGE   = reg7[10:0];
//		             `else
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MORE      = reg7[15];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MSG_PAGE  = reg7[13];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_ACK2      = reg7[12];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MESSAGE   = reg7[10:0];
		             `endif
                          end	   

               5'b10000 : begin
		             reg16 <= data;

		             `ifdef DIG_GATES

//		             `else
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.ack_rcvd_intr_enab      = reg16[14];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.page_rx_intr_enab       = reg16[13];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.link_chgd_intr_enab     = reg16[12];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.an_chgd_intr_enab       = reg16[11];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.par_det_fault_intr_enab = reg16[10];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.rmt_fault_intr_enab     = reg16[9];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.jabber_intr_enab        = reg16[8];
		             `endif
                          end	      
	      
               5'b10010 : begin
		             reg18 <= data;

		             `ifdef DIG_GATES

//                             `else
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_FEF_DISB            = reg18[14];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_MII_LOOP_BACK_DISB  = reg18[13];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_MDIX_DISB           = reg18[12];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_MDIX_FORCE          = reg18[11];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_JABBER_ENAB         = reg18[10];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_LINK_TEST_DISB      = reg18[9];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_POL_CORR_DISB       = reg18[8];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_ALIGN_DISB          = reg18[7];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SYMBOL_MODE         = reg18[6];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_BYPASS_SCRAMBLER    = reg18[5];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TP_DISC             = reg18[4];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_RXTX_TEST           = reg18[3];
                             `endif	  
                          end

               5'b10011 : begin
		             reg19 <= data;

		             `ifdef DIG_GATES

//		             `else
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_BYPASS10TX_FILTER      = reg19[15];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_BYPASS10RX_FILTER      = reg19[14];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SQUELCH_RANGE          = reg19[13:12];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SQUELCH_DISB           = reg19[11];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SQE_ENAB               = reg19[10];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_RX10_PLL_MAX_ADJ_SHIFT = reg19[9:7];
		             `endif
                          end

               5'b10100 : begin
		             reg20 <= data;

		             `ifdef DIG_GATES
			      `ifdef OLD_NL
		              `else

		              `endif

		             `else
			      `ifdef OLD_NL
//		              `else
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.trim_reg_enab     = reg20[15];
		              `endif
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_PHASE_ADJ      = reg20[14:12];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.TX_AMPTRIM        = reg20[11:10];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.TX_SLOPETRIM      = reg20[9:8];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.TEST_MODE         = reg20[7:5];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SCRAMBLER_SEED = reg20[4:0];
		             `endif
                          end	      

               5'b10101 : begin
		             reg21 <= data;

		             `ifdef DIG_GATES

//		             `else
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.rsvd_21_15_5 = reg21[15:5];
//                               force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_PHY       = reg21[4:0];
		             `endif
                          end

               5'b10111 : begin
		             reg23 <= data;

		             `ifdef DIG_GATES

//		             `else
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_ERR_THRESH  = reg23[15:11];
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_ERR_TIMER   = reg23[10:1];
//		                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_MSE_NORESET = reg23[0];
		             `endif
                          end	      
	      
	      
               (5'b11011 | 5'b11100 | 5'b11101)  : begin
		             reg27 <= data;

		             `ifdef DIG_GATES
 
//		             `else
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.SM_DATA_WRITE = reg27[15:0];
		             `endif
                          end

               default :
                          $write("E: Register address %0d not valid\n", reg_addr); 
            endcase
	 end 

         else begin
            case (reg_addr)
               5'b00000 : begin
		             reg0 <= data;

		             `ifdef DIG_GATES	             
 
		             `else
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_RESET_TO_RCB = reg0[15];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_DIG_LOOP_BACK_ENAB 
                                                                       = reg0[14];
   		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_100MBS       = reg0[13];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_ENAB      = reg0[12];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_POWER_DOWN   = reg0[11];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_ISOLATE_TX      = reg0[10];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_RESTART   = reg0[9];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_FULL_DUPLEX  = reg0[8];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_COL_TEST     = reg0[7];
		             `endif		  
                          end

               5'b00100 : begin
		             reg4 <= data;

		  	     `ifdef DIG_GATES

		             `else
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_NP_ENAB       = reg4[15];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR4_REMOTE_FAULT = reg4[13];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_FLOW_CTL      = reg4[10];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TAF_100FULL   = reg4[8];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TAF_100HALF   = reg4[7];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TAF_10FULL    = reg4[6];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TAF_10HALF    = reg4[5];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SELECTOR      = reg4[4:0];
		             `endif
                          end

              5'b00111 : begin
		             reg7 <= data;

		             `ifdef DIG_GATES
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MORE      = reg7[15];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MSG_PAGE_reg.Q  = reg7[13];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_ACK2      = reg7[12];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MESSAGE   = reg7[10:0];
		             `else
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MORE      = reg7[15];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MSG_PAGE  = reg7[13];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_ACK2      = reg7[12];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MESSAGE   = reg7[10:0];
		             `endif
                          end	   

               5'b10000 : begin
		             reg16 <= data;

		             `ifdef DIG_GATES

		             `else
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.ack_rcvd_intr_enab      = reg16[14];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.page_rx_intr_enab       = reg16[13];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.link_chgd_intr_enab     = reg16[12];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.an_chgd_intr_enab       = reg16[11];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.par_det_fault_intr_enab = reg16[10];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.rmt_fault_intr_enab     = reg16[9];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.jabber_intr_enab        = reg16[8];
		             `endif
                          end	      
	      
               5'b10010 : begin
		             reg18 <= data;

		             `ifdef DIG_GATES
		  
		             `else
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_FEF_DISB            = reg18[14];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_MII_LOOP_BACK_DISB  = reg18[13];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_MDIX_DISB           = reg18[12];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_MDIX_FORCE          = reg18[11];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_JABBER_ENAB         = reg18[10];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_LINK_TEST_DISB      = reg18[9];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_POL_CORR_DISB       = reg18[8];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_ALIGN_DISB          = reg18[7];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SYMBOL_MODE         = reg18[6];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_BYPASS_SCRAMBLER    = reg18[5];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TP_DISC             = reg18[4];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_RXTX_TEST           = reg18[3];		  
		             `endif
                          end

               5'b10011 : begin
		             reg19 <= data;

		             `ifdef DIG_GATES

		             `else
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_BYPASS10TX_FILTER      = reg19[15];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_BYPASS10RX_FILTER      = reg19[14];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SQUELCH_RANGE          = reg19[13:12];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SQUELCH_DISB           = reg19[11];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SQE_ENAB               = reg19[10];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_RX10_PLL_MAX_ADJ_SHIFT = reg19[9:7];
		             `endif
                          end

               5'b10100 : begin
		             reg20 <= data;

		             `ifdef DIG_GATES
			      `ifdef OLD_NL
		              `else

		              `endif
 
		             `else
			      `ifdef OLD_NL
//		              `else
//                                force test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.trim_reg_enab     = reg20[15];
                              `endif
//                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_PHASE_ADJ      = reg20[14:12];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.TX_AMPTRIM        = reg20[11:10];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.TX_SLOPETRIM      = reg20[9:8];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.TEST_MODE         = reg20[7:5];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SCRAMBLER_SEED = reg20[4:0];
		             `endif
                          end	      

               5'b10101 : begin
		             reg21 <= data;

		             `ifdef DIG_GATES

		             `else
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.rsvd_21_15_5 = reg21[15:5];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_PHY       = reg21[4:0];
		             `endif
                          end

               5'b10111 : begin
		             reg23 <= data;

		             `ifdef DIG_GATES

		             `else
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_ERR_THRESH  = reg23[15:11];
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_ERR_TIMER   = reg23[10:1];
		                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_MSE_NORESET = reg23[0];
		             `endif
                          end	      
	      
	      
               (5'b11011 | 5'b11100 | 5'b11101)  : begin
		             reg27 <= data;

		             `ifdef DIG_GATES

		             `else
                                force test.top.I0.I00.I0.i_top_digital.i_dig_regs.SM_DATA_WRITE = reg27[15:0];
		             `endif
                          end

               default :
                          $write("E: Register address %0d not valid\n", reg_addr); 
            endcase	    
    
         end

         @(negedge sim_clk25); 
	 in_use = 1'b0;
      end

   endtask // force_reg


   //--------------------------------------------------------------------
   // release_reg task
   // note wolverine register space is currently implemented
   //--------------------------------------------------------------------
   task release_reg;
      input          port_num;
      input  [4:0]   reg_addr;
      input [15:0]   data;

      reg 	     in_use;    
  
      begin
	 // check non-reentrant task guard semaphore
	 if (in_use === 1'b1) begin
	    $display("E: Call to mi.release_reg was reentrant\n");
	    $finish;
	 end 
	 in_use = 1'b1;

         // initiate on falling edge of sim_clk25
         @(negedge sim_clk25);

         if (port_num) begin
            case (reg_addr)
               5'b00000 : begin
		             `ifdef DIG_GATES

//		             `else
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_RESET_TO_RCB;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_DIG_LOOP_BACK_ENAB;
//   		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_100MBS;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_ENAB;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_POWER_DOWN;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_ISOLATE_TX;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_RESTART;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_FULL_DUPLEX;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_COL_TEST;
		             `endif
                          end

               5'b00100 : begin
		             `ifdef DIG_GATES  

//		             `else
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_NP_ENAB;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR4_REMOTE_FAULT;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_FLOW_CTL;
//                               release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TAF_100FULL;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TAF_100HALF;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TAF_10FULL;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TAF_10HALF;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SELECTOR;
		             `endif
                          end

              5'b00111 : begin
		             `ifdef DIG_GATES
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MORE;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MSG_PAGE_reg.Q;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_ACK2;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MESSAGE;
//		             `else
//                               release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MORE;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MSG_PAGE;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_ACK2;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_AN_NP_MESSAGE;
		             `endif
                          end	   

               5'b10000 : begin
		             `ifdef DIG_GATES

//		             `else
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.ack_rcvd_intr_enab;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.page_rx_intr_enab;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.link_chgd_intr_enab;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.an_chgd_intr_enab;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.par_det_fault_intr_enab;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.rmt_fault_intr_enab;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.jabber_intr_enab;
		             `endif
                          end	      
	      
               5'b10010 : begin
		             `ifdef DIG_GATES
	
//		             `else 
//	   	                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_FEF_DISB;		  
//                               release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_MII_LOOP_BACK_DISB;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_MDIX_DISB;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_MDIX_FORCE;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_JABBER_ENAB;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_LINK_TEST_DISB;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_POL_CORR_DISB;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_ALIGN_DISB;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SYMBOL_MODE;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_BYPASS_SCRAMBLER;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_TP_DISC;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_RXTX_TEST;	
		             `endif	  
                          end

               5'b10011 : begin
		             `ifdef DIG_GATES

//		             `else
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_BYPASS10TX_FILTER;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_BYPASS10RX_FILTER;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SQUELCH_RANGE;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SQUELCH_DISB;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SQE_ENAB;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_RX10_PLL_MAX_ADJ_SHIFT;
		             `endif
                          end

               5'b10100 : begin
		             `ifdef DIG_GATES
			      `ifdef OLD_NL
		              `else
 
                              `endif

		             `else
			      `ifdef OLD_NL
//		              `else
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.trim_reg_enab;
                              `endif
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_PHASE_ADJ;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.TX_AMPTRIM;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.TX_SLOPETRIM;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.TEST_MODE;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_SCRAMBLER_SEED;
		             `endif
                          end	      

               5'b10101 : begin
		             `ifdef DIG_GATES
 
//		             `else
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.rsvd_21_15_5;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_PHY;
		             `endif
                          end

               5'b10111 : begin
		             `ifdef DIG_GATES
// 
//		             `else
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_ERR_THRESH;
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_ERR_TIMER;
//		                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.MR_MSE_NORESET;
		             `endif
                          end	      
	      
	      
               (5'b11011 | 5'b11100 | 5'b11101)  : begin
		             `ifdef DIG_GATES
 
//		             `else
//                                release test.top.I0.I1.I01.I0.i_top_digital.i_dig_regs.SM_DATA_WRITE;
		             `endif
                          end

               default :
                          $write("E: Register address %0d not valid\n", reg_addr); 
            endcase
         end

         else begin
            case (reg_addr)
               5'b00000 : begin	             
		             `ifdef DIG_GATES

		             `else
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_RESET_TO_RCB;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_DIG_LOOP_BACK_ENAB;
   		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_100MBS;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_ENAB;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_POWER_DOWN;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_ISOLATE_TX;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_RESTART;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_FULL_DUPLEX;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_COL_TEST;
		             `endif
                          end

               5'b00100 : begin
		             `ifdef DIG_GATES

		             `else
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_NP_ENAB;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR4_REMOTE_FAULT;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_FLOW_CTL;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TAF_100FULL;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TAF_100HALF;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TAF_10FULL;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TAF_10HALF;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SELECTOR;
		             `endif
                          end

              5'b00111 : begin
		             `ifdef DIG_GATES
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MORE;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MSG_PAGE_reg.Q;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_ACK2;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MESSAGE;
		             `else
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MORE;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MSG_PAGE;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_ACK2;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_AN_NP_MESSAGE;
		             `endif
                          end	   

               5'b10000 : begin
		             `ifdef DIG_GATES

		             `else
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.ack_rcvd_intr_enab;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.page_rx_intr_enab;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.link_chgd_intr_enab;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.an_chgd_intr_enab;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.par_det_fault_intr_enab;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.rmt_fault_intr_enab;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.jabber_intr_enab;
		             `endif
                          end	      
	      
               5'b10010 : begin
		             `ifdef DIG_GATES
  
		             `else
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_FEF_DISB;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_MII_LOOP_BACK_DISB;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_MDIX_DISB;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_MDIX_FORCE;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_JABBER_ENAB;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_LINK_TEST_DISB;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_POL_CORR_DISB;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_ALIGN_DISB;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SYMBOL_MODE;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_BYPASS_SCRAMBLER;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_TP_DISC;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_RXTX_TEST;	
		             `endif
                          end

               5'b10011 : begin
		             `ifdef DIG_GATES

		             `else
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_BYPASS10TX_FILTER;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_BYPASS10RX_FILTER;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SQUELCH_RANGE;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SQUELCH_DISB;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SQE_ENAB;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_RX10_PLL_MAX_ADJ_SHIFT;
		             `endif
                          end

               5'b10100 : begin
		             `ifdef DIG_GATES
			      `ifdef OLD_NL
		              `else

                              `endif

		             `else
			      `ifdef OLD_NL
		              `else
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.trim_reg_enab;
                              `endif
//                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_PHASE_ADJ;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.TX_AMPTRIM;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.TX_SLOPETRIM;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.TEST_MODE;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_SCRAMBLER_SEED;
		             `endif
                          end	      

               5'b10101 : begin
		             `ifdef DIG_GATES
 
		             `else
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.rsvd_21_15_5;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_PHY;
		             `endif
                          end

               5'b10111 : begin
		             `ifdef DIG_GATES

		             `else
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_ERR_THRESH;
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_ERR_TIMER;
		                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.MR_MSE_NORESET;
		             `endif
                          end	      
	      
	      
               (5'b11011 | 5'b11100 | 5'b11101)  : begin
		             `ifdef DIG_GATES
 
		             `else
                                release test.top.I0.I00.I0.i_top_digital.i_dig_regs.SM_DATA_WRITE;
		             `endif
                          end

               default :
                          $write("E: Register address %0d not valid\n", reg_addr); 
            endcase
         end

         @(negedge sim_clk25); 
	 in_use = 1'b0;
      end

   endtask // release_reg
 
endmodule



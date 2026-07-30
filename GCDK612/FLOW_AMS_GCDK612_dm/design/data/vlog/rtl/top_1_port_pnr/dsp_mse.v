// Created by ihdl
module dsp_mse(ERROR,CLK,RESET,MSE_GOOD_THRESH,MSE,MSE_GOOD);

   input          CLK;
   input          RESET;
   input  [10:0]  ERROR;            // Error from DFE
   input  [7:0]   MSE_GOOD_THRESH;  // Threshold to determine MSE_GOOD
   output [7:0]   MSE;              // error out <8,-1,t>
   output         MSE_GOOD;         // Error is acceptable

   reg [10:0]    abs_error;         // NOTE: MSb is always 0,
   reg [19:0]    acc;               // accumulated error
   reg [19:0]    acc_clip;          // cliped version of above
   reg [12:0]    sum;               // sum for err calculations
   reg           MSE_GOOD;          // Error < theshold

   wire [7:0]     fb;               // Error <8,-1,t>
   wire [20:0]    acc_preclip;      // accumulated value prior to cliping

   // abs val (w/clip)
   always @(ERROR)
      if (ERROR == 11'b10000000000)
         abs_error = 11'b01111111111;
      else
         abs_error = ERROR[10] ? -ERROR : ERROR;

   // LPF
   always @(posedge CLK or posedge RESET)
     if (RESET)
       sum <= 13'd0;
     else
       sum <= {abs_error[10],abs_error,1'b0} -
         {fb[7],fb[7],fb[7],fb[7],fb[7],fb};

   assign acc_preclip = {acc[19],acc} +
     {sum[12],sum[12],sum[12],sum[12],sum[12],sum[12],sum[12],sum[12],sum};

   always @(acc_preclip)
      case(acc_preclip[20:19])
         2'b01: acc_clip = 20'b01111111111111111111;  // overflow pos
         2'b10: acc_clip = 20'b00000000000000000000;  // overflow neg
         2'b00: acc_clip = acc_preclip[19:0];         // no overflow
         2'b11: acc_clip = 20'b00000000000000000000;  // overflow neg
      endcase

   always @(posedge CLK or posedge RESET)
   begin
  
      if (RESET)
         acc <= 20'b01111111111111111111;
      else
         acc <= acc_clip[19:0];
   end


//   assign MSE_GOOD = (fb < MSE_GOOD_THRESH);

   always @(posedge CLK or posedge RESET)
     begin : p_MSE_GOOD
     if (RESET)
       MSE_GOOD <= 1'd0;
     else if (fb < MSE_GOOD_THRESH)
       MSE_GOOD <= 1'd1;
     else
       MSE_GOOD <= 1'd0;
     end // p_MSE_GOOD       


   assign fb = acc[19:12];
   assign MSE = fb;

endmodule

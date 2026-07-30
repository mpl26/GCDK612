// Created by ihdl
module dig_slicer_mux (
                      //Inputs
                      DACDATA,
                      SLICER_OUT,
                      MR_POL_REVERSED,
                      POS_DETECT,
                      NEG_DETECT,
                      MR_DIG_LOOP_BACK_ENAB,

                      //Outputs
                      SLICER_MUX,
                      POS_DETECT_MUX,
                      NEG_DETECT_MUX
                      );

//
// I/O Declarations
//
input   [4:3]  DACDATA;                //
input          SLICER_OUT;             //
input          MR_POL_REVERSED;        //
input          POS_DETECT;             //
input          NEG_DETECT;             //
input          MR_DIG_LOOP_BACK_ENAB;  // Loopback enable

output         SLICER_MUX;             //
output         POS_DETECT_MUX;         //
output         NEG_DETECT_MUX;         //

//
// I/O Type Declarations
//
wire    [4:3]  DACDATA;              
wire           SLICER_OUT;           
wire           MR_POL_REVERSED;      
wire           POS_DETECT;           
wire           NEG_DETECT;           
wire           MR_DIG_LOOP_BACK_ENAB;

reg            SLICER_MUX;    
reg            POS_DETECT_MUX;
reg            NEG_DETECT_MUX;
//
// Internal Signal Declarations
//
// None

//
// Parameter Declarations
//
// none

//------------------------------------------------------------------------------
// MAIN UNIT CODE
//------------------------------------------------------------------------------
//
   always @ (MR_DIG_LOOP_BACK_ENAB or DACDATA or SLICER_OUT or 
             MR_POL_REVERSED or POS_DETECT or NEG_DETECT)
   begin : p_mux
   if (MR_DIG_LOOP_BACK_ENAB)
      begin
      SLICER_MUX     = (!DACDATA[4]);
      POS_DETECT_MUX = (DACDATA[4:3] == 2'b01);
      NEG_DETECT_MUX = (DACDATA[4:3] == 2'b10);
      end
   else
      begin
      SLICER_MUX     = (SLICER_OUT ^ MR_POL_REVERSED);
      POS_DETECT_MUX = POS_DETECT;
      NEG_DETECT_MUX = NEG_DETECT;
      end
   end

endmodule

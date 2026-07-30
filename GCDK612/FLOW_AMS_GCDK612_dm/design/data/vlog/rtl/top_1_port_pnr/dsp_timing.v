// Created by ihdl
module dsp_timing(   SLICE,UNSLICE,ADC_TIMING,TIMING_MODE,
                     CLK,RESET,TIMING_UP,TIMING_DN,
                     FORCE_TIMING_UP,TIMING_LPF_SHIFT,T_SEL);

input   [1:0]  SLICE;
input   [5:0]  UNSLICE;
input   [2:0]  ADC_TIMING;
input          TIMING_MODE;
input          CLK;
input          RESET;
output         TIMING_UP;
output         TIMING_DN;

//test
input          FORCE_TIMING_UP;
input [2:0]    TIMING_LPF_SHIFT;
input          T_SEL;

wire  [6:0]    t_err, sel_t_err;
wire  [11:0]   lpf_out;
wire  [1:0]     sd_out;

reg      force_timing_up_pulse;
reg      force_timing_up_ff;

// Timing Error calculation

dsp_timing_err i_dsp_timing_err (   .SLICE      (SLICE),
                                    .UNSLICE    (UNSLICE),
                                    .CLK        (CLK),
                                    .RESET      (RESET),
                                    .TIMING_ERR (t_err),
                                    .T_SEL      (T_SEL));

// Half-T Error calculation

dsp_timing_halft i_dsp_timing_halft (  .ADC_TIMING    (ADC_TIMING),
                                       .SLICE         (SLICE),
                                       .TIMING_ERR_1T (t_err),
                                       .TIMING_MODE   (TIMING_MODE),
                                       .CLK           (CLK),
                                       .RESET         (RESET),
                                       .TIMING_ERR    (sel_t_err) );

// Low pass filter

dsp_timing_lpf i_dsp_timing_lpf (   .LPF_IN           ({sel_t_err}),
                                    .CLK              (CLK),
                                    .RESET            (RESET),
                                    .LPF_OUT          (lpf_out),
                                    .TIMING_LPF_SHIFT (TIMING_LPF_SHIFT));

// Sigma Delta

dsp_timing_sd i_dsp_timing_sd (  .SD_IN   (lpf_out),
                                 .CLK     (CLK),
                                 .RESET   (RESET),
                                 .SD_OUT  (sd_out));

always @(posedge CLK or posedge RESET)
  if (RESET)
     force_timing_up_ff <= 1'b0;
  else
      force_timing_up_ff <= FORCE_TIMING_UP;

always @(posedge CLK or posedge RESET)
  if (RESET)
   force_timing_up_pulse <= 1'b0;
  else
   force_timing_up_pulse <= FORCE_TIMING_UP & (~force_timing_up_ff);

assign TIMING_UP = sd_out[0] | force_timing_up_pulse;
assign TIMING_DN = sd_out[1];
endmodule

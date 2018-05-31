// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Fri Sep 22 13:14:59 2017
// Host        : Mei-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               D:/AX7021/vivado_project/02_HDMI_output_test/HDMI_output_test.runs/video_pll_synth_1/video_pll_stub.v
// Design      : video_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module video_pll(clk_in1, clk_out1, clk_out2, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_out1,clk_out2,locked" */;
  input clk_in1;
  output clk_out1;
  output clk_out2;
  output locked;
endmodule

// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Mon Nov 06 14:12:56 2017
// Host        : Mei-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               z:/project/ax/ax7010/ax7010_cd/02_source/vivado_project_2/04_ov5640_single/repo/alinx/ov5640_ip/alinx_ov5640.srcs/sources_1/ip/cmos_in_buf/cmos_in_buf_stub.v
// Design      : cmos_in_buf
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_0_1,Vivado 2015.4" *)
module cmos_in_buf(rst, wr_clk, rd_clk, din, wr_en, rd_en, dout, full, overflow, empty, underflow)
/* synthesis syn_black_box black_box_pad_pin="rst,wr_clk,rd_clk,din[18:0],wr_en,rd_en,dout[18:0],full,overflow,empty,underflow" */;
  input rst;
  input wr_clk;
  input rd_clk;
  input [18:0]din;
  input wr_en;
  input rd_en;
  output [18:0]dout;
  output full;
  output overflow;
  output empty;
  output underflow;
endmodule

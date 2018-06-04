// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: www.alinx.com.cn:user:alinx_ov5640_yuv:2.1
// IP Revision: 14

(* X_CORE_INFO = "alinx_ov5640,Vivado 2015.4" *)
(* CHECK_LICENSE_TYPE = "system_alinx_ov5640_0_1,alinx_ov5640,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module system_alinx_ov5640_0_1 (
  cmos_xclk,
  cmos_scl,
  cmos_sda,
  cmos_vsync,
  cmos_href,
  cmos_pclk,
  cmos_d,
  cmos_reset,
  aclk,
  aclken,
  aresetn,
  m_axis_video_tdata,
  m_axis_video_tvalid,
  m_axis_video_tready,
  m_axis_video_tuser,
  m_axis_video_tlast,
  m_axis_video_tkeep,
  fid,
  axis_enable
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 cmos_xclk CLK" *)
input wire cmos_xclk;
inout wire cmos_scl;
inout wire cmos_sda;
input wire cmos_vsync;
input wire cmos_href;
input wire cmos_pclk;
input wire [9 : 0] cmos_d;
output wire cmos_reset;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
input wire aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 aclken CE" *)
input wire aclken;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *)
input wire aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TDATA" *)
output wire [15 : 0] m_axis_video_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TVALID" *)
output wire m_axis_video_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TREADY" *)
input wire m_axis_video_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TUSER" *)
output wire m_axis_video_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TLAST" *)
output wire m_axis_video_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis_video TKEEP" *)
output wire [1 : 0] m_axis_video_tkeep;
output wire fid;
input wire axis_enable;

  alinx_ov5640 #(
    .PIXELS_FORMAT("RGB565")
  ) inst (
    .cmos_xclk(cmos_xclk),
    .cmos_scl(cmos_scl),
    .cmos_sda(cmos_sda),
    .cmos_vsync(cmos_vsync),
    .cmos_href(cmos_href),
    .cmos_pclk(cmos_pclk),
    .cmos_d(cmos_d),
    .cmos_reset(cmos_reset),
    .aclk(aclk),
    .aclken(aclken),
    .aresetn(aresetn),
    .m_axis_video_tdata(m_axis_video_tdata),
    .m_axis_video_tvalid(m_axis_video_tvalid),
    .m_axis_video_tready(m_axis_video_tready),
    .m_axis_video_tuser(m_axis_video_tuser),
    .m_axis_video_tlast(m_axis_video_tlast),
    .m_axis_video_tkeep(m_axis_video_tkeep),
    .fid(fid),
    .axis_enable(axis_enable)
  );
endmodule

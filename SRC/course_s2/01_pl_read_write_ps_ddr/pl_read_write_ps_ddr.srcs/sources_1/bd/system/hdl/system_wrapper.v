//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
//Date        : Thu Nov 23 17:02:53 2017
//Host        : Mei-PC running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target system_wrapper.bd
//Design      : system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FCLK_CLK0,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    MM2S_AXI_araddr,
    MM2S_AXI_arburst,
    MM2S_AXI_arcache,
    MM2S_AXI_arid,
    MM2S_AXI_arlen,
    MM2S_AXI_arlock,
    MM2S_AXI_arprot,
    MM2S_AXI_arqos,
    MM2S_AXI_arready,
    MM2S_AXI_arregion,
    MM2S_AXI_arsize,
    MM2S_AXI_arvalid,
    MM2S_AXI_rdata,
    MM2S_AXI_rid,
    MM2S_AXI_rlast,
    MM2S_AXI_rready,
    MM2S_AXI_rresp,
    MM2S_AXI_rvalid,
    S2MM_AXI_awaddr,
    S2MM_AXI_awburst,
    S2MM_AXI_awcache,
    S2MM_AXI_awid,
    S2MM_AXI_awlen,
    S2MM_AXI_awlock,
    S2MM_AXI_awprot,
    S2MM_AXI_awqos,
    S2MM_AXI_awready,
    S2MM_AXI_awregion,
    S2MM_AXI_awsize,
    S2MM_AXI_awvalid,
    S2MM_AXI_bid,
    S2MM_AXI_bready,
    S2MM_AXI_bresp,
    S2MM_AXI_bvalid,
    S2MM_AXI_wdata,
    S2MM_AXI_wlast,
    S2MM_AXI_wready,
    S2MM_AXI_wstrb,
    S2MM_AXI_wvalid,
    axi_hp_clk);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  output FCLK_CLK0;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input [31:0]MM2S_AXI_araddr;
  input [1:0]MM2S_AXI_arburst;
  input [3:0]MM2S_AXI_arcache;
  input [5:0]MM2S_AXI_arid;
  input [7:0]MM2S_AXI_arlen;
  input [0:0]MM2S_AXI_arlock;
  input [2:0]MM2S_AXI_arprot;
  input [3:0]MM2S_AXI_arqos;
  output MM2S_AXI_arready;
  input [3:0]MM2S_AXI_arregion;
  input [2:0]MM2S_AXI_arsize;
  input MM2S_AXI_arvalid;
  output [63:0]MM2S_AXI_rdata;
  output [5:0]MM2S_AXI_rid;
  output MM2S_AXI_rlast;
  input MM2S_AXI_rready;
  output [1:0]MM2S_AXI_rresp;
  output MM2S_AXI_rvalid;
  input [31:0]S2MM_AXI_awaddr;
  input [1:0]S2MM_AXI_awburst;
  input [3:0]S2MM_AXI_awcache;
  input [5:0]S2MM_AXI_awid;
  input [7:0]S2MM_AXI_awlen;
  input [0:0]S2MM_AXI_awlock;
  input [2:0]S2MM_AXI_awprot;
  input [3:0]S2MM_AXI_awqos;
  output S2MM_AXI_awready;
  input [3:0]S2MM_AXI_awregion;
  input [2:0]S2MM_AXI_awsize;
  input S2MM_AXI_awvalid;
  output [5:0]S2MM_AXI_bid;
  input S2MM_AXI_bready;
  output [1:0]S2MM_AXI_bresp;
  output S2MM_AXI_bvalid;
  input [63:0]S2MM_AXI_wdata;
  input S2MM_AXI_wlast;
  output S2MM_AXI_wready;
  input [7:0]S2MM_AXI_wstrb;
  input S2MM_AXI_wvalid;
  input axi_hp_clk;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FCLK_CLK0;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [31:0]MM2S_AXI_araddr;
  wire [1:0]MM2S_AXI_arburst;
  wire [3:0]MM2S_AXI_arcache;
  wire [5:0]MM2S_AXI_arid;
  wire [7:0]MM2S_AXI_arlen;
  wire [0:0]MM2S_AXI_arlock;
  wire [2:0]MM2S_AXI_arprot;
  wire [3:0]MM2S_AXI_arqos;
  wire MM2S_AXI_arready;
  wire [3:0]MM2S_AXI_arregion;
  wire [2:0]MM2S_AXI_arsize;
  wire MM2S_AXI_arvalid;
  wire [63:0]MM2S_AXI_rdata;
  wire [5:0]MM2S_AXI_rid;
  wire MM2S_AXI_rlast;
  wire MM2S_AXI_rready;
  wire [1:0]MM2S_AXI_rresp;
  wire MM2S_AXI_rvalid;
  wire [31:0]S2MM_AXI_awaddr;
  wire [1:0]S2MM_AXI_awburst;
  wire [3:0]S2MM_AXI_awcache;
  wire [5:0]S2MM_AXI_awid;
  wire [7:0]S2MM_AXI_awlen;
  wire [0:0]S2MM_AXI_awlock;
  wire [2:0]S2MM_AXI_awprot;
  wire [3:0]S2MM_AXI_awqos;
  wire S2MM_AXI_awready;
  wire [3:0]S2MM_AXI_awregion;
  wire [2:0]S2MM_AXI_awsize;
  wire S2MM_AXI_awvalid;
  wire [5:0]S2MM_AXI_bid;
  wire S2MM_AXI_bready;
  wire [1:0]S2MM_AXI_bresp;
  wire S2MM_AXI_bvalid;
  wire [63:0]S2MM_AXI_wdata;
  wire S2MM_AXI_wlast;
  wire S2MM_AXI_wready;
  wire [7:0]S2MM_AXI_wstrb;
  wire S2MM_AXI_wvalid;
  wire axi_hp_clk;

  system system_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FCLK_CLK0(FCLK_CLK0),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .MM2S_AXI_araddr(MM2S_AXI_araddr),
        .MM2S_AXI_arburst(MM2S_AXI_arburst),
        .MM2S_AXI_arcache(MM2S_AXI_arcache),
        .MM2S_AXI_arid(MM2S_AXI_arid),
        .MM2S_AXI_arlen(MM2S_AXI_arlen),
        .MM2S_AXI_arlock(MM2S_AXI_arlock),
        .MM2S_AXI_arprot(MM2S_AXI_arprot),
        .MM2S_AXI_arqos(MM2S_AXI_arqos),
        .MM2S_AXI_arready(MM2S_AXI_arready),
        .MM2S_AXI_arregion(MM2S_AXI_arregion),
        .MM2S_AXI_arsize(MM2S_AXI_arsize),
        .MM2S_AXI_arvalid(MM2S_AXI_arvalid),
        .MM2S_AXI_rdata(MM2S_AXI_rdata),
        .MM2S_AXI_rid(MM2S_AXI_rid),
        .MM2S_AXI_rlast(MM2S_AXI_rlast),
        .MM2S_AXI_rready(MM2S_AXI_rready),
        .MM2S_AXI_rresp(MM2S_AXI_rresp),
        .MM2S_AXI_rvalid(MM2S_AXI_rvalid),
        .S2MM_AXI_awaddr(S2MM_AXI_awaddr),
        .S2MM_AXI_awburst(S2MM_AXI_awburst),
        .S2MM_AXI_awcache(S2MM_AXI_awcache),
        .S2MM_AXI_awid(S2MM_AXI_awid),
        .S2MM_AXI_awlen(S2MM_AXI_awlen),
        .S2MM_AXI_awlock(S2MM_AXI_awlock),
        .S2MM_AXI_awprot(S2MM_AXI_awprot),
        .S2MM_AXI_awqos(S2MM_AXI_awqos),
        .S2MM_AXI_awready(S2MM_AXI_awready),
        .S2MM_AXI_awregion(S2MM_AXI_awregion),
        .S2MM_AXI_awsize(S2MM_AXI_awsize),
        .S2MM_AXI_awvalid(S2MM_AXI_awvalid),
        .S2MM_AXI_bid(S2MM_AXI_bid),
        .S2MM_AXI_bready(S2MM_AXI_bready),
        .S2MM_AXI_bresp(S2MM_AXI_bresp),
        .S2MM_AXI_bvalid(S2MM_AXI_bvalid),
        .S2MM_AXI_wdata(S2MM_AXI_wdata),
        .S2MM_AXI_wlast(S2MM_AXI_wlast),
        .S2MM_AXI_wready(S2MM_AXI_wready),
        .S2MM_AXI_wstrb(S2MM_AXI_wstrb),
        .S2MM_AXI_wvalid(S2MM_AXI_wvalid),
        .axi_hp_clk(axi_hp_clk));
endmodule

//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
//Date        : Fri Nov 24 13:34:21 2017
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
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    btns_tri_i,
    lcd_bl_pwm,
    lcd_data,
    lcd_dclk,
    lcd_de,
    lcd_hsync,
    lcd_i2c_scl_io,
    lcd_i2c_sda_io,
    lcd_int,
    lcd_vsync,
    leds_tri_o);
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
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input [0:0]btns_tri_i;
  output [0:0]lcd_bl_pwm;
  output [23:0]lcd_data;
  output [0:0]lcd_dclk;
  output lcd_de;
  output lcd_hsync;
  inout lcd_i2c_scl_io;
  inout lcd_i2c_sda_io;
  input [0:0]lcd_int;
  output lcd_vsync;
  output [1:0]leds_tri_o;

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
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [0:0]btns_tri_i;
  wire [0:0]lcd_bl_pwm;
  wire [23:0]lcd_data;
  wire [0:0]lcd_dclk;
  wire lcd_de;
  wire lcd_hsync;
  wire lcd_i2c_scl_i;
  wire lcd_i2c_scl_io;
  wire lcd_i2c_scl_o;
  wire lcd_i2c_scl_t;
  wire lcd_i2c_sda_i;
  wire lcd_i2c_sda_io;
  wire lcd_i2c_sda_o;
  wire lcd_i2c_sda_t;
  wire [0:0]lcd_int;
  wire lcd_vsync;
  wire [1:0]leds_tri_o;

  IOBUF lcd_i2c_scl_iobuf
       (.I(lcd_i2c_scl_o),
        .IO(lcd_i2c_scl_io),
        .O(lcd_i2c_scl_i),
        .T(lcd_i2c_scl_t));
  IOBUF lcd_i2c_sda_iobuf
       (.I(lcd_i2c_sda_o),
        .IO(lcd_i2c_sda_io),
        .O(lcd_i2c_sda_i),
        .T(lcd_i2c_sda_t));
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
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .btns_tri_i(btns_tri_i),
        .lcd_bl_pwm(lcd_bl_pwm),
        .lcd_data(lcd_data),
        .lcd_dclk(lcd_dclk),
        .lcd_de(lcd_de),
        .lcd_hsync(lcd_hsync),
        .lcd_i2c_scl_i(lcd_i2c_scl_i),
        .lcd_i2c_scl_o(lcd_i2c_scl_o),
        .lcd_i2c_scl_t(lcd_i2c_scl_t),
        .lcd_i2c_sda_i(lcd_i2c_sda_i),
        .lcd_i2c_sda_o(lcd_i2c_sda_o),
        .lcd_i2c_sda_t(lcd_i2c_sda_t),
        .lcd_int(lcd_int),
        .lcd_vsync(lcd_vsync),
        .leds_tri_o(leds_tri_o));
endmodule

//use heijin AN9134 .on port J11
module top(
    input sys_clk,
    output hdmi_clk,
    output[23:0] hdmi_d,
    output hdmi_de,
    output hdmi_hs,
	output hdmi_vs,
    output hdmi_nreset,
    inout hdmi_scl,
    inout hdmi_sda   
);
wire video_clk;
wire clk_100mhz;
wire video_hs;
wire video_vs;
wire video_de;
wire[7:0] video_r;
wire[7:0] video_g;
wire[7:0] video_b;
wire pll_locked;
assign hdmi_clk = video_clk;
assign hdmi_d = {video_r,video_g,video_b};
assign hdmi_de = video_de;
assign hdmi_hs = video_hs;
assign hdmi_vs = video_vs;

color_bar hdmi_color_bar(
	.clk(video_clk),
	.rst(1'b0),
	.hs(video_hs),
	.vs(video_vs),
	.de(video_de),
	.rgb_r(video_r),
	.rgb_g(video_g),
	.rgb_b(video_b)
);

video_pll video_pll_m0
 (
 // Clock in ports
    .clk_in1(sys_clk),
  // Clock out ports
    .clk_out1(video_clk),
    .clk_out2(clk_100mhz),
  // Status and control signals
    .locked(pll_locked)
 );
 
i2c_config i2c_config_m0(
	.rst(~pll_locked),
	.clk(clk_100mhz),
	.error(),
	.done(),
	.rst_n(hdmi_nreset),
	.i2c_scl(hdmi_scl),
	.i2c_sda(hdmi_sda)
);
endmodule
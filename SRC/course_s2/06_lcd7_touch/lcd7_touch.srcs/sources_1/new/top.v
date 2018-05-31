`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/16 11:45:01
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
	inout [14:0]DDR_addr,
	inout [2:0]DDR_ba,
	inout DDR_cas_n,
	inout DDR_ck_n,
	inout DDR_ck_p,
	inout DDR_cke,
	inout DDR_cs_n,
	inout [3:0]DDR_dm,
	inout [31:0]DDR_dq,
	inout [3:0]DDR_dqs_n,
	inout [3:0]DDR_dqs_p,
	inout DDR_odt,
	inout DDR_ras_n,
	inout DDR_reset_n,
	inout DDR_we_n,
	inout FIXED_IO_ddr_vrn,
	inout FIXED_IO_ddr_vrp,
	inout [53:0]FIXED_IO_mio,
	inout FIXED_IO_ps_clk,
	inout FIXED_IO_ps_porb,
	inout FIXED_IO_ps_srstb,
	
	input sys_clk,
	output lcd_dclk,
	inout lcd_scl,
	inout lcd_sda,
	input lcd_int,
	output lcd_bl_pwm,
	output lcd_hsync,
	output lcd_vsync,
	output lcd_de,
	output[7:0] lcd_r,
	output[7:0] lcd_g,
	output[7:0] lcd_b

    );

wire       vid_io_out_clk;

wire[23:0] vid_io_out_data;
wire       vid_io_out_active_video;
wire       vid_io_out_hsync;
wire       vid_io_out_vsync;

reg[23:0] vid_io_out_data_d0;
reg       vid_io_out_active_video_d0;
reg       vid_io_out_hsync_d0;
reg       vid_io_out_vsync_d0;

assign lcd_dclk = ~vid_io_out_clk;
//assign lcd_bl_pwm = 1'b1;
assign lcd_hsync = vid_io_out_hsync_d0;
assign lcd_vsync = vid_io_out_vsync_d0;
assign lcd_de = vid_io_out_active_video_d0;
assign lcd_r = vid_io_out_data_d0[23:16];
assign lcd_g = vid_io_out_data_d0[15: 8];
assign lcd_b = vid_io_out_data_d0[ 7: 0];

always@(posedge vid_io_out_clk)
begin
	vid_io_out_data_d0 <= vid_io_out_data;
	vid_io_out_active_video_d0 <= vid_io_out_active_video;
	vid_io_out_hsync_d0 <= vid_io_out_hsync;
	vid_io_out_vsync_d0 <= vid_io_out_vsync;
end

pwm pwm_m0(
	.clk(sys_clk),
	.rst(1'b0),
	.period(16'd1),
	.duty(16'h8000),
	.pwm_out(lcd_bl_pwm)
    );
system_wrapper system_m0
(
	.DDR_addr                    ( DDR_addr                   ),
	.DDR_ba                      ( DDR_ba                     ),
	.DDR_cas_n                   ( DDR_cas_n                  ),
	.DDR_ck_n                    ( DDR_ck_n                   ),
	.DDR_ck_p                    ( DDR_ck_p                   ),
	.DDR_cke                     ( DDR_cke                    ),
	.DDR_cs_n                    ( DDR_cs_n                   ),
	.DDR_dm                      ( DDR_dm                     ),
	.DDR_dq                      ( DDR_dq                     ),
	.DDR_dqs_n                   ( DDR_dqs_n                  ),
	.DDR_dqs_p                   ( DDR_dqs_p                  ),
	.DDR_odt                     ( DDR_odt                    ),
	.DDR_ras_n                   ( DDR_ras_n                  ),
	.DDR_reset_n                 ( DDR_reset_n                ),
	.DDR_we_n                    ( DDR_we_n                   ),
	.FIXED_IO_ddr_vrn            ( FIXED_IO_ddr_vrn           ),
	.FIXED_IO_ddr_vrp            ( FIXED_IO_ddr_vrp           ),
	.FIXED_IO_mio                ( FIXED_IO_mio               ),
	.FIXED_IO_ps_clk             ( FIXED_IO_ps_clk            ),
	.FIXED_IO_ps_porb            ( FIXED_IO_ps_porb           ),
	.FIXED_IO_ps_srstb           ( FIXED_IO_ps_srstb          ),
	
	.lcd_iic_scl_io              (lcd_scl                     ),
	.lcd_iic_sda_io              (lcd_sda                     ),
	.lcd_int_tri_i               (lcd_int                     ),
	.vid_io_out_active_video     (vid_io_out_active_video     ),
	.vid_io_out_clk              (vid_io_out_clk              ),
	.vid_io_out_data             (vid_io_out_data             ),
	.vid_io_out_field            (                            ),
	.vid_io_out_hblank           (                            ),
	.vid_io_out_hsync            (vid_io_out_hsync            ),
	.vid_io_out_vblank           (                            ),
	.vid_io_out_vsync            (vid_io_out_vsync            )

);                            
endmodule

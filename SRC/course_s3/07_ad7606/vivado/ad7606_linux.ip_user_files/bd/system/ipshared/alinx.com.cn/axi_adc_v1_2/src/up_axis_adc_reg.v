`timescale 1ns/100ps

module up_axis_adc_reg (
	// adc interface
	input              axim_clk,
	input              axim_rst,
	
	output [31:0]      wr_addr_0,
	output [31:0]      wr_addr_1,
	output [31:0]      data_len,
	output             go,
	output             int_clr,
	input              int_in,
	input              fifo_overflow,
	input[3:0]         wr_buf_index,
	input              done,
	// bus interface
	input              up_rstn,
	input              up_clk,
	input              up_wreq,
	input   [13:0]     up_waddr,
	input   [31:0]     up_wdata,
	output reg         up_wack,
	input              up_rreq,
	input   [13:0]     up_raddr,
	output reg [31:0]  up_rdata,
	output reg         up_rack
 );

// parameters

localparam  PCORE_VERSION = 32'h00050063;
parameter   ID = 0;

// internal registers
reg             up_preset = 'd0;
reg     [31:0]  up_scratch = 'd0;
reg             up_resetn = 'd0;
reg[31:0]       wr_addr_0_r;
reg[31:0]       wr_addr_1_r;
reg[15:0]       len_r;
reg             go_r;
reg             int_clr_r;
// internal signals

wire            up_wreq_s;
wire            up_rreq_s;

wire            done_s;
wire            int_in_s;
wire            fifo_overflow_s;

// decode block select
assign up_wreq_s = (up_waddr[13:8] == 6'h00) ? up_wreq : 1'b0;
assign up_rreq_s = (up_waddr[13:8] == 6'h00) ? up_rreq : 1'b0;

//processor write interface
always @(negedge up_rstn or posedge up_clk) 
begin
	if (up_rstn == 0)
	begin
		up_preset <= 1'd1;
		up_wack <= 'd0;
		up_scratch <= 'd0;
		up_resetn <= 'd0;
		len_r <= 16'd0;
		go_r  <= 16'd0;
		wr_addr_0_r <= 32'd0;
	end 
	else 
	begin
		up_preset <= 1'd0;
		up_wack <= up_wreq_s;
		if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h02)) 
		begin
			up_scratch <= up_wdata;
		end
		
		if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h04)) 
		begin
			int_clr_r <= up_wdata[0];
		end
		
		if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h10))
		begin
			up_resetn <= up_wdata[0];
		end
		if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h11)) 
		begin
			len_r <= up_wdata[15:0];
		end
	  
		if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h12)) 
		begin
			go_r <= up_wdata[0];
		end
		if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h13)) 
		begin
			wr_addr_0_r <= up_wdata;
		end
		if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h14)) 
		begin
			wr_addr_1_r <= up_wdata;
		end		
	end
end

  // processor read interface

always @(negedge up_rstn or posedge up_clk) 
begin
	if (up_rstn == 0) 
	begin
		up_rack <= 'd0;
		up_rdata <= 'd0;
	end 
	else 
	begin
		up_rack <= up_rreq_s;
		if (up_rreq_s == 1'b1) 
		begin
			case (up_raddr[7:0])
				8'h00: up_rdata <= PCORE_VERSION;
				8'h01: up_rdata <= ID;
				8'h02: up_rdata <= up_scratch;
				8'h03: up_rdata <= {25'd0,wr_buf_index[3:0],int_in_s,fifo_overflow_s,done_s};
				8'h04: up_rdata <= {31'd0,int_clr_r};
				8'h10: up_rdata <= {31'd0,up_resetn};
				8'h11: up_rdata <= {16'd0,len_r};
				8'h12: up_rdata <= {31'd0,go_r};
				8'h13: up_rdata <= wr_addr_0_r;
				8'h14: up_rdata <= wr_addr_1_r;
				default: up_rdata <= 0;
			endcase
		end 
		else 
		begin
			up_rdata <= 32'd0;
		end
	end
end

up_xfer_cntrl #(.DATA_WIDTH(16)) up_xfer_cntrl_m0 (
	.up_rstn (up_rstn),
	.up_clk (up_clk),
	.up_data_cntrl (len_r),
	.d_rst (axim_rst),
	.d_clk (axim_clk),
	.d_data_cntrl (data_len)
);
up_xfer_cntrl #(.DATA_WIDTH(32)) up_xfer_cntrl_m1 (
	.up_rstn (up_rstn),
	.up_clk (up_clk),
	.up_data_cntrl (wr_addr_0_r),
	.d_rst (axim_rst),
	.d_clk (axim_clk),
	.d_data_cntrl (wr_addr_0)
);

up_xfer_cntrl #(.DATA_WIDTH(32)) up_xfer_cntrl_m2 (
	.up_rstn (up_rstn),
	.up_clk (up_clk),
	.up_data_cntrl (wr_addr_1_r),
	.d_rst (axim_rst),
	.d_clk (axim_clk),
	.d_data_cntrl (wr_addr_1)
);	

up_xfer_cntrl #(.DATA_WIDTH(2)) up_xfer_cntrl_m3 (
	.up_rstn (up_rstn),
	.up_clk (up_clk),
	.up_data_cntrl ({go_r,int_clr_r}),
	.d_rst (axim_rst),
	.d_clk (axim_clk),
	.d_data_cntrl ({go,int_clr})
);	

up_xfer_status #(.DATA_WIDTH(3)) up_xfer_status_m0 (
	.up_rstn (up_rstn),
	.up_clk (up_clk),
	.up_data_status ({int_in_s,fifo_overflow_s,done_s}),
	.d_rst (axim_rst),
	.d_clk (axim_clk),
	.d_data_status ({int_in,fifo_overflow,done})
); 	
 
endmodule

// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module up_axis_adc (

  // adc interface

	input              axim_clk,
	input              axim_rst,
	output [31:0]      wr_addr,
	output [15:0]      len,
	output             go,

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

  // adc interface



  // bus interface

  // internal registers
  reg             up_preset = 'd0;
  reg     [31:0]  up_scratch = 'd0;
  reg             up_resetn = 'd0;
  reg[31:0]       wr_addr_r;
  reg[15:0]        len_r;
  reg             go_r;
  // internal signals

  wire            up_wreq_s;
  wire            up_rreq_s;
  
  // decode block select

  assign up_wreq_s = (up_waddr[13:8] == 6'h00) ? up_wreq : 1'b0;
  assign up_rreq_s = (up_waddr[13:8] == 6'h00) ? up_rreq : 1'b0;
//  assign len = len_r;
    assign go = go_r;
//  assign wr_addr  = wr_addr_r;

  // processor write interface

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_preset <= 1'd1;
      up_wack <= 'd0;
      up_scratch <= 'd0;
      up_resetn <= 'd0;
	  len_r <= 16'd0;
	  go_r  <= 16'd0;
	  wr_addr_r <= 32'd0;
    end else begin
      up_preset <= 1'd0;
      up_wack <= up_wreq_s;
      if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h02)) begin
        up_scratch <= up_wdata;
      end
      if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h10)) begin
        up_resetn <= up_wdata[0];
      end
	  if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h11)) begin
        len_r <= up_wdata[15:0];
      end
	  
	  if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h12)) begin
        go_r <= up_wdata[0];
      end
	  
	  if ((up_wreq_s == 1'b1) && (up_waddr[7:0] == 8'h13)) begin
        wr_addr_r <= up_wdata;
      end
    end
  end

  // processor read interface

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_rack <= 'd0;
      up_rdata <= 'd0;
    end else begin
      up_rack <= up_rreq_s;
      if (up_rreq_s == 1'b1) begin
        case (up_raddr[7:0])
          8'h00: up_rdata <= PCORE_VERSION;
          8'h01: up_rdata <= ID;
          8'h02: up_rdata <= up_scratch;
          8'h10: up_rdata <= {31'd0, up_resetn};
		  8'h11: up_rdata <= {16'd0,len_r};
		  8'h12: up_rdata <= {31'd0,go_r};
		  8'h13: up_rdata <= wr_addr_r;
          default: up_rdata <= 0;
        endcase
      end else begin
        up_rdata <= 32'd0;
      end
    end
  end

  // resets

  
  up_xfer_cntrl #(.DATA_WIDTH(16)) up_xfer_cntrl_m0 (
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_data_cntrl (len_r),
    .d_rst (axim_rst),
    .d_clk (axim_clk),
    .d_data_cntrl (len)
	);
  up_xfer_cntrl #(.DATA_WIDTH(32)) up_xfer_cntrl_m1 (
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_data_cntrl (wr_addr_r),
    .d_rst (axim_rst),
    .d_clk (axim_clk),
    .d_data_cntrl (wr_addr)
	);	

  // dma control & status

/*   up_xfer_cntrl #(.DATA_WIDTH(34)) i_dma_xfer_cntrl (
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_data_cntrl ({ up_dma_start,
                      up_dma_stream,
                      up_dma_count}),
    .d_rst (dma_rst),
    .d_clk (dma_clk),
    .d_data_cntrl ({  dma_start_s,
                      dma_stream,
                      dma_count}));

  up_xfer_status #(.DATA_WIDTH(3)) i_dma_xfer_status (
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_data_status ({up_dma_ovf_s,
                      up_dma_unf_s,
                      up_dma_status_s}),
    .d_rst (dma_rst),
    .d_clk (dma_clk),
    .d_data_status ({ dma_ovf,
                      dma_unf,
                      dma_status})); */

  // start needs to be a pulse

endmodule

// ***************************************************************************
// ***************************************************************************

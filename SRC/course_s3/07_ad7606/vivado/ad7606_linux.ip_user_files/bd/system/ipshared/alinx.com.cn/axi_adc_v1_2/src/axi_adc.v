module axi_adc(
	input                       adc_clk,
	input[63:0]                 adc_data,
	input                       adc_data_valid,
	
	output                      irq,
	//AXI Master
	//Reset, Clock
	input                       ARESETN,
	input                       ACLK,
	// Master Write Address
	output [0:0]                M_AXI_AWID,
	output [31:0]               M_AXI_AWADDR,
	output [7:0]                M_AXI_AWLEN,    // Burst Length: 0-255
	output [2:0]                M_AXI_AWSIZE,   // Burst Size: Fixed 2'b011
	output [1:0]                M_AXI_AWBURST,  // Burst Type: Fixed 2'b01(Incremental Burst)
	output                      M_AXI_AWLOCK,   // Lock: Fixed 2'b00
	output [3:0]                M_AXI_AWCACHE,  // Cache: Fiex 2'b0011
	output [2:0]                M_AXI_AWPROT,   // Protect: Fixed 2'b000
	output [3:0]                M_AXI_AWQOS,    // QoS: Fixed 2'b0000
	output [0:0]                M_AXI_AWUSER,   // User: Fixed 32'd0
	output                      M_AXI_AWVALID,
	input                       M_AXI_AWREADY,
	//Master Write Data
	output [63:0]               M_AXI_WDATA,
	output [7:0]                M_AXI_WSTRB,
	output                      M_AXI_WLAST,
	output [0:0]                M_AXI_WUSER,
	output                      M_AXI_WVALID,
	input                       M_AXI_WREADY,
	//Master Write Response
	input [0:0]                 M_AXI_BID,
	input [1:0]                 M_AXI_BRESP,
	input [0:0]                 M_AXI_BUSER,
	input                       M_AXI_BVALID,
	output                      M_AXI_BREADY,
	//Master Read Address
	output [0:0]                M_AXI_ARID,
	output [31:0]               M_AXI_ARADDR,
	output [7:0]                M_AXI_ARLEN,
	output [2:0]                M_AXI_ARSIZE,
	output [1:0]                M_AXI_ARBURST,
	output [1:0]                M_AXI_ARLOCK,
	output [3:0]                M_AXI_ARCACHE,
	output [2:0]                M_AXI_ARPROT,
	output [3:0]                M_AXI_ARQOS,
	output [0:0]                M_AXI_ARUSER,
	output                      M_AXI_ARVALID,
	input                       M_AXI_ARREADY,
	//Master Read Data
	input [0:0]                 M_AXI_RID,
	input [63:0]                M_AXI_RDATA,
	input [1:0]                 M_AXI_RRESP,
	input                       M_AXI_RLAST,
	input [0:0]                 M_AXI_RUSER,
	input                       M_AXI_RVALID,
	output                      M_AXI_RREADY,
	//axi4 interface
	input                       s_axi_aclk,
	input                       s_axi_aresetn,
	input                       s_axi_awvalid,
	input   [31:0]              s_axi_awaddr,
	output                      s_axi_awready,
	input                       s_axi_wvalid,
	input   [31:0]              s_axi_wdata,
	input   [ 3:0]              s_axi_wstrb,
	output                      s_axi_wready,
	output                      s_axi_bvalid,
	output  [ 1:0]              s_axi_bresp,
	input                       s_axi_bready,
	input                       s_axi_arvalid,
	input   [31:0]              s_axi_araddr,
	output                      s_axi_arready,
	output                      s_axi_rvalid,
	output  [31:0]              s_axi_rdata,
	output  [ 1:0]              s_axi_rresp,
	input                       s_axi_rready
);
localparam WR_IDLE         =  0;
localparam WR_START        =  1;
localparam WR_BURST_BEGIN  =  2;
localparam WR_BURST_WAIT   =  3;
localparam WR_BURSTING     =  4;
localparam WR_BURST_END    =  5;
localparam WR_DONE         =  6;

localparam  WR_BURST_SIZE  =  128;

wire            up_rstn;
wire            up_clk;
//internal signals
wire            up_wreq_s;
wire    [13:0]  up_waddr_s;
wire    [31:0]  up_wdata_s;
wire            up_wack_s;
wire            up_rreq_s;
wire    [13:0]  up_raddr_s;
wire    [31:0]  up_rdata_s;
wire            up_rack_s;
//signal name changes
assign up_clk   = s_axi_aclk;
assign up_rstn  = s_axi_aresetn;

wire[31:0] wr_addr_0;
wire[31:0] wr_addr_1;
wire go;
wire init_clr;
wire [31:0] data_len;

reg fifo_overflow;
wire fifo_full;
reg fifo_full_sync;
reg done;
reg int_r;

reg[2:0] wr_state;
reg[15:0]burst_size;
reg[15:0] remain_data_len;
reg wr_buf_index;

reg[3:0] wr_buf_index_latch;

wire wr_burst_data_req;
wire[63:0]   wr_burst_data;
wire[10:0]   rd_data_count;
reg wr_burst_req;
wire wr_burst_finish;
reg[31:0] wr_burst_addr;
assign irq = int_r;
adc_buf adc_buf_m0
(
	.rst            (~go                 ),
	.wr_clk         (adc_clk             ),
	.rd_clk         (ACLK                ),
	.din            (adc_data            ),
	.wr_en          (adc_data_valid      ),
	.rd_en          (wr_burst_data_req   ),
	.dout           (wr_burst_data       ),
	.full           (fifo_full           ),
	.empty          (                    ),
	.rd_data_count  (rd_data_count       ),
	.wr_data_count  (                    )

);

always @(posedge ACLK or negedge ARESETN)
begin
	if(~ARESETN)
		fifo_full_sync <= 1'b0;
	else
		fifo_full_sync <= fifo_full;
end

always @(posedge ACLK or negedge ARESETN)
begin
	if(~ARESETN)
		done <= 1'b0;
	else if(init_clr == 1'b1 || go == 1'b0)
		done <= 1'b0;
	else if(wr_state == WR_DONE)
		done <= 1'b1;
end

always @(posedge ACLK or negedge ARESETN)
begin
	if(~ARESETN)
		fifo_overflow <= 1'b0;
	else if(init_clr == 1'b1 || go == 1'b0)
		fifo_overflow <= 1'b0;
	else if(fifo_full_sync == 1'b1)
		fifo_overflow <= 1'b1;
end

always @(posedge ACLK or negedge ARESETN)
begin
	if(~ARESETN)
		int_r <= 1'b0;
	else if(go == 1'b0 || init_clr == 1'b1)
		int_r <= 1'b0;
	else if(wr_state == WR_DONE || fifo_full_sync == 1'b1)
		int_r <= 1'b1;
end

always @(posedge ACLK or negedge ARESETN)
begin
	if(~ARESETN)
		wr_buf_index_latch <= 4'd0;
	else if(wr_state == WR_DONE && done == 1'b0)
		wr_buf_index_latch <= wr_buf_index;
end

always @(posedge ACLK or negedge ARESETN)
begin
	if(!ARESETN)
	begin
		wr_state <= WR_IDLE;
		wr_burst_req <= 1'b0;
		burst_size <= 16'd0;
		wr_burst_addr <= 32'd0;
		wr_buf_index <= 1'b0;
	end	
	else if(go == 1'b0)
	begin
		wr_state <= WR_IDLE;
		wr_burst_req <= 1'b0;
		wr_buf_index <= 1'b0;
	end
	else
	begin
		case(wr_state)
			WR_IDLE:
			begin
				wr_state <= WR_START;
			end
			WR_START:
			begin
				remain_data_len <= data_len[18:3];
				wr_burst_addr <= (wr_buf_index == 1'b0) ? wr_addr_0 : wr_addr_1;
			end
			WR_BURST_BEGIN:
			begin
				if(remain_data_len > WR_BURST_SIZE)
					burst_size <= WR_BURST_SIZE;
				else
					burst_size <= remain_data_len;
				wr_state <= WR_BURST_WAIT;
			end
			WR_BURST_WAIT:
			begin
				if(rd_data_count >= burst_size)
				begin
					wr_burst_req <= 1'b1;
					wr_state <= WR_BURSTING;
					
				end
			end
			WR_BURSTING:
			begin
				if(wr_burst_data_req == 1'b1)
					wr_burst_req <= 1'b0;
					
				if(wr_burst_finish == 1'b1)
				begin
					wr_state <= WR_BURST_END;
					remain_data_len <= remain_data_len - burst_size;
				end
			end
			WR_BURST_END:
			begin
				if(remain_data_len != 16'd0)
					wr_state <= WR_BURST_BEGIN;
				else
					wr_state <= WR_DONE;
				wr_burst_addr <= wr_burst_addr + {16'd0,burst_size};
			end
			
			WR_DONE:
			begin
				wr_state <= WR_START;
				wr_buf_index <= wr_buf_index + 1'b1;
			end
			default:
			begin
				wr_state <= WR_IDLE;
			end
		endcase
	end
end

up_axis_adc_reg up_axis_adc_reg_reg 
(
	.axim_clk             (ACLK),
	.axim_rst             (~ARESETN),
	.wr_addr_0            (wr_addr_0      ),
	.wr_addr_1            (wr_addr_1      ),
	.data_len             (data_len       ),
	.go                   (go             ),
	.int_clr              (int_clr        ),
	.int_in               (int_r          ),
	.fifo_overflow        (fifo_overflow  ),
	.wr_buf_index         (wr_buf_index_latch),
	.done                 (done           ),
	.up_rstn              (up_rstn),
	.up_clk               (up_clk),
	.up_wreq              (up_wreq_s),
	.up_waddr             (up_waddr_s),
	.up_wdata             (up_wdata_s),
	.up_wack              (up_wack_s),
	.up_rreq              (up_rreq_s),
	.up_raddr             (up_raddr_s),
	.up_rdata             (up_rdata_s),
	.up_rack              (up_rack_s)
);

aq_axi_master u_aq_axi_master
(
	.ARESETN            (ARESETN),
	.ACLK               (ACLK),
	.M_AXI_AWID         (M_AXI_AWID),
	.M_AXI_AWADDR       (M_AXI_AWADDR),
	.M_AXI_AWLEN        (M_AXI_AWLEN),
	.M_AXI_AWSIZE       (M_AXI_AWSIZE),
	.M_AXI_AWBURST      (M_AXI_AWBURST),
	.M_AXI_AWLOCK       (M_AXI_AWLOCK),
	.M_AXI_AWCACHE      (M_AXI_AWCACHE),
	.M_AXI_AWPROT       (M_AXI_AWPROT),
	.M_AXI_AWQOS        (M_AXI_AWQOS),
	.M_AXI_AWUSER       (M_AXI_AWUSER),
	.M_AXI_AWVALID      (M_AXI_AWVALID),
	.M_AXI_AWREADY      (M_AXI_AWREADY),
	.M_AXI_WDATA        (M_AXI_WDATA),
	.M_AXI_WSTRB        (M_AXI_WSTRB),
	.M_AXI_WLAST        (M_AXI_WLAST),
	.M_AXI_WUSER        (M_AXI_WUSER),
	.M_AXI_WVALID       (M_AXI_WVALID),
	.M_AXI_WREADY       (M_AXI_WREADY),
	.M_AXI_BID          (M_AXI_BID),
	.M_AXI_BRESP        (M_AXI_BRESP),
	.M_AXI_BUSER        (M_AXI_BUSER),
	.M_AXI_BVALID       (M_AXI_BVALID),
	.M_AXI_BREADY       (M_AXI_BREADY),
	.M_AXI_ARID         (M_AXI_ARID),
	.M_AXI_ARADDR       (M_AXI_ARADDR),
	.M_AXI_ARLEN        (M_AXI_ARLEN),
	.M_AXI_ARSIZE       (M_AXI_ARSIZE),
	.M_AXI_ARBURST      (M_AXI_ARBURST),
	.M_AXI_ARLOCK       (M_AXI_ARLOCK),
	.M_AXI_ARCACHE      (M_AXI_ARCACHE),
	.M_AXI_ARPROT       (M_AXI_ARPROT),
	.M_AXI_ARQOS        (M_AXI_ARQOS),
	.M_AXI_ARUSER       (M_AXI_ARUSER),
	.M_AXI_ARVALID      (M_AXI_ARVALID),
	.M_AXI_ARREADY      (M_AXI_ARREADY),
	.M_AXI_RID          (M_AXI_RID),
	.M_AXI_RDATA        (M_AXI_RDATA),
	.M_AXI_RRESP        (M_AXI_RRESP),
	.M_AXI_RLAST        (M_AXI_RLAST),
	.M_AXI_RUSER        (M_AXI_RUSER),
	.M_AXI_RVALID       (M_AXI_RVALID),
	.M_AXI_RREADY       (M_AXI_RREADY),
	.MASTER_RST         (1'b0),
	.WR_START           (wr_burst_req),
	.WR_ADRS            (wr_burst_addr),
	.WR_LEN             ({13'd0,burst_size,3'd0}),//byte
	.WR_READY           (),
	.WR_FIFO_RE         (wr_burst_data_req),
	.WR_FIFO_EMPTY      (1'b0),
	.WR_FIFO_AEMPTY     (1'b0),
	.WR_FIFO_DATA       (wr_burst_data),
	.WR_DONE            (wr_burst_finish),
	.RD_START           (1'b0),
	.RD_ADRS            (),
	.RD_LEN             (),
	.RD_READY           (),
	.RD_FIFO_WE         (),
	.RD_FIFO_FULL       (1'b0),
	.RD_FIFO_AFULL      (1'b0),
	.RD_FIFO_DATA       (),
	.RD_DONE            (),
	.DEBUG              ()
);
// up bus interface
up_axi i_up_axi(
	.up_rstn              (up_rstn),
	.up_clk               (up_clk),
	.up_axi_awvalid       (s_axi_awvalid),
	.up_axi_awaddr        (s_axi_awaddr),
	.up_axi_awready       (s_axi_awready),
	.up_axi_wvalid        (s_axi_wvalid),
	.up_axi_wdata         (s_axi_wdata),
	.up_axi_wstrb         (s_axi_wstrb),
	.up_axi_wready        (s_axi_wready),
	.up_axi_bvalid        (s_axi_bvalid),
	.up_axi_bresp         (s_axi_bresp),
	.up_axi_bready        (s_axi_bready),
	.up_axi_arvalid       (s_axi_arvalid),
	.up_axi_araddr        (s_axi_araddr),
	.up_axi_arready       (s_axi_arready),
	.up_axi_rvalid        (s_axi_rvalid),
	.up_axi_rresp         (s_axi_rresp),
	.up_axi_rdata         (s_axi_rdata),
	.up_axi_rready        (s_axi_rready),
	.up_wreq              (up_wreq_s),
	.up_waddr             (up_waddr_s),
	.up_wdata             (up_wdata_s),
	.up_wack              (up_wack_s),
	.up_rreq              (up_rreq_s),
	.up_raddr             (up_raddr_s),
	.up_rdata             (up_rdata_s),
	.up_rack              (up_rack_s)
);

endmodule

// ***************************************************************************
// ***************************************************************************

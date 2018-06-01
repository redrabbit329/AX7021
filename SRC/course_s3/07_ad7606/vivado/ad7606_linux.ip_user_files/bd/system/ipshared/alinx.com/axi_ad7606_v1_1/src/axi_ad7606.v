module axi_ad7606 (
	
	input           adc_clk,
	input [15:0] 	ad_data,        //ad7606 采样数据
	input        	ad_busy,        //ad7606 忙标志位 
    input        	first_data,     //ad7606 第一个数据标志位 	    
	output [2:0] 	ad_os,          //ad7606 过采样�?�率选择
	output          ad_cs,          //ad7606 AD cs
	output          ad_rd,          //ad7606 AD data read
	output          ad_reset,       //ad7606 AD reset
	output          ad_convstab,    //ad7606 AD convert start
	
	//AXI Master
	// Reset, Clock
	input           ARESETN,
	input           ACLK,
	
	// Master Write Address
	output [0:0]    M_AXI_AWID,
	output [31:0]   M_AXI_AWADDR,
	output [7:0]    M_AXI_AWLEN,    // Burst Length: 0-255
	output [2:0]    M_AXI_AWSIZE,   // Burst Size: Fixed 2'b011
	output [1:0]    M_AXI_AWBURST,  // Burst Type: Fixed 2'b01(Incremental Burst)
	output          M_AXI_AWLOCK,   // Lock: Fixed 2'b00
	output [3:0]    M_AXI_AWCACHE,  // Cache: Fiex 2'b0011
	output [2:0]    M_AXI_AWPROT,   // Protect: Fixed 2'b000
	output [3:0]    M_AXI_AWQOS,    // QoS: Fixed 2'b0000
	output [0:0]    M_AXI_AWUSER,   // User: Fixed 32'd0
	output          M_AXI_AWVALID,
	input           M_AXI_AWREADY,
	
	// Master Write Data
	output [63:0]   M_AXI_WDATA,
	output [7:0]    M_AXI_WSTRB,
	output          M_AXI_WLAST,
	output [0:0]    M_AXI_WUSER,
	output          M_AXI_WVALID,
	input           M_AXI_WREADY,
	
	// Master Write Response
	input [0:0]     M_AXI_BID,
	input [1:0]     M_AXI_BRESP,
	input [0:0]     M_AXI_BUSER,
	input           M_AXI_BVALID,
	output          M_AXI_BREADY,
	
	// Master Read Address
	output [0:0]    M_AXI_ARID,
	output [31:0]   M_AXI_ARADDR,
	output [7:0]    M_AXI_ARLEN,
	output [2:0]    M_AXI_ARSIZE,
	output [1:0]    M_AXI_ARBURST,
	output [1:0]    M_AXI_ARLOCK,
	output [3:0]    M_AXI_ARCACHE,
	output [2:0]    M_AXI_ARPROT,
	output [3:0]    M_AXI_ARQOS,
	output [0:0]    M_AXI_ARUSER,
	output          M_AXI_ARVALID,
	input           M_AXI_ARREADY,
	
	// Master Read Data 
	input [0:0]     M_AXI_RID,
	input [63:0]    M_AXI_RDATA,
	input [1:0]     M_AXI_RRESP,
	input           M_AXI_RLAST,
	input [0:0]     M_AXI_RUSER,
	input           M_AXI_RVALID,
	output          M_AXI_RREADY,
  
	// axi4 interface
	input           s_axi_aclk,
	input           s_axi_aresetn,
	input           s_axi_awvalid,
	input   [31:0]  s_axi_awaddr,
	output          s_axi_awready,
	input           s_axi_wvalid,
	input   [31:0]  s_axi_wdata,
	input   [ 3:0]  s_axi_wstrb,
	output          s_axi_wready,
	output          s_axi_bvalid,
	output  [ 1:0]  s_axi_bresp,
	input           s_axi_bready,
	input           s_axi_arvalid,
	input   [31:0]  s_axi_araddr,
	output          s_axi_arready,
	output          s_axi_rvalid,
	output  [31:0]  s_axi_rdata,
	output  [ 1:0]  s_axi_rresp,
	input           s_axi_rready
	);

  // parameters


  // reset and clocks

  wire            up_rstn;
  wire            up_clk;

  // internal signals

  
  
  wire            up_wreq_s;
  wire    [13:0]  up_waddr_s;
  wire    [31:0]  up_wdata_s;
  wire            up_wack_s;
  wire            up_rreq_s;
  wire    [13:0]  up_raddr_s;
  wire    [31:0]  up_rdata_s;
  wire            up_rack_s;
  
  
  
 

  // signal name changes

  assign up_clk = s_axi_aclk;
  assign up_rstn = s_axi_aresetn;
  
(*mark_debug = "true"*)wire [15:0] ad_ch1;
(*mark_debug = "true"*)wire [15:0] ad_ch2;
(*mark_debug = "true"*)wire [15:0] ad_ch3;
(*mark_debug = "true"*)wire [15:0] ad_ch4;
(*mark_debug = "true"*)wire [15:0] ad_ch5;
(*mark_debug = "true"*)wire [15:0] ad_ch6;
(*mark_debug = "true"*)wire [15:0] ad_ch7;
(*mark_debug = "true"*)wire [15:0] ad_ch8;
(*mark_debug = "true"*)wire ad_data_wr;

ad7606 ad7606_m0(
    .clk              (adc_clk),
    .rst_n            (1'b1),
    .ad_data          (ad_data),
    .ad_busy          (ad_busy),    
    .first_data       (first_data),    
    .ad_os            (ad_os),    
    .ad_cs            (ad_cs),
    .ad_rd            (ad_rd),    
    .ad_reset         (ad_reset),
    .ad_convstab      (ad_convstab),
	.ad_data_wr       (ad_data_wr),
    .ad_ch1           (ad_ch1),           //ch1 ad data 16bit
    .ad_ch2           (ad_ch2),           //ch2 ad data 16bit
    .ad_ch3           (ad_ch3),           //ch3 ad data 16bit
    .ad_ch4           (ad_ch4),           //ch4 ad data 16bit
    .ad_ch5           (ad_ch5),           //ch5 ad data 16bit
    .ad_ch6           (ad_ch6),           //ch6 ad data 16bit
    .ad_ch7           (ad_ch7),           //ch7 ad data 16bit
    .ad_ch8           (ad_ch8)            //ch8 ad data 16bit
);

wire [15:0] len;
wire go;
(*mark_debug = "true"*)wire[31:0] wr_addr;
reg go_d0;
(*mark_debug = "true"*)reg go_d1;

(*mark_debug = "true"*)wire wr_burst_data_req;
(*mark_debug = "true"*)wire[63:0]	wr_burst_data;
(*mark_debug = "true"*)wire[9:0] rd_data_count;

(*mark_debug = "true"*)reg wr_burst_req;
(*mark_debug = "true"*)wire wr_burst_finish;

reg[15:0] len_sync_d0;
reg[15:0] len_sync_d1;
(*mark_debug = "true"*)reg[15:0] rd_data_cnt;
reg wr_fifo_en;
(*mark_debug = "true"*)reg[2:0] rd_state;
localparam RD_IDLE =  'd0;
localparam RD_DATA =  'd1;
localparam RD_DONE =  'd2;

ad7606_buf ad7606_buf_m0
(
	.rst(1'b0),
	.wr_clk(adc_clk),
	.rd_clk(ACLK),
	.din({ad_ch1,ad_ch2,ad_ch3,ad_ch4,ad_ch5,ad_ch6,ad_ch7,ad_ch8}),
	.wr_en(ad_data_wr & wr_fifo_en),
	.rd_en(wr_burst_data_req),
	.dout(wr_burst_data),
	.full(),
	.empty(),
	.rd_data_count(rd_data_count),
	.wr_data_count()

);

always @(posedge adc_clk)
begin
	go_d0 <= go;
	go_d1 <= go_d0;
	len_sync_d0 <= len;
	len_sync_d1 <= len_sync_d0;
end
always @(posedge adc_clk)
begin
	case(rd_state)
		RD_IDLE:
		begin
			if(~go_d1 && go_d0)
			begin
				rd_state <= RD_DATA;
				wr_fifo_en <= 1'b1;
			end
			else
			begin
				wr_fifo_en <= 1'b0;
			end
		end
		RD_DATA:
		begin
			if(rd_data_cnt == (len_sync_d1[15:4] - 16'd1)  && ad_data_wr)
			begin
				rd_state <= RD_DONE;
				wr_fifo_en <= 1'b0;
				rd_data_cnt <= 16'd0;
			end
			else if(ad_data_wr)
			begin
				rd_data_cnt <= rd_data_cnt + 16'd1;
			end
		end
		RD_DONE:
		begin
			rd_state <= RD_IDLE;
			wr_fifo_en <= 1'b0;
		end
		default:
			rd_state <= RD_IDLE;
	endcase
end

(*mark_debug = "true"*)reg[2:0] wr_state;
localparam WR_IDLE =  'd0;
localparam WR_DATA =  'd1;
localparam WR_DONE =  'd2;

always @(posedge ACLK or negedge ARESETN)
begin
	if(!ARESETN)
	begin
		wr_state <= WR_IDLE;
		wr_burst_req <= 1'b0;
	end
	else
	begin
		case(wr_state)
			WR_IDLE:
			begin
				if(rd_data_count >= len[12:3])
				begin
					wr_burst_req <= 1'b1;
					wr_state <= WR_DATA;
				end
			end
			WR_DATA:
			begin
				if(wr_burst_finish)
				begin
					wr_burst_req <= 1'b0;
					wr_state <= WR_DONE;
				end
			end
			WR_DONE:
			begin
				wr_state <= WR_IDLE;
			end
			default:
			begin
				wr_state <= WR_IDLE;
			end
		endcase
	end
end

aq_axi_master u_aq_axi_master
    (
      .ARESETN(ARESETN),
      .ACLK(ACLK),
      
      .M_AXI_AWID(M_AXI_AWID),
      .M_AXI_AWADDR(M_AXI_AWADDR),     
	  .M_AXI_AWLEN(M_AXI_AWLEN),
      .M_AXI_AWSIZE(M_AXI_AWSIZE),
      .M_AXI_AWBURST(M_AXI_AWBURST),
      .M_AXI_AWLOCK(M_AXI_AWLOCK),
      .M_AXI_AWCACHE(M_AXI_AWCACHE),
      .M_AXI_AWPROT(M_AXI_AWPROT),
      .M_AXI_AWQOS(M_AXI_AWQOS),
      .M_AXI_AWUSER(M_AXI_AWUSER),
      .M_AXI_AWVALID(M_AXI_AWVALID),
      .M_AXI_AWREADY(M_AXI_AWREADY),
      
      .M_AXI_WDATA(M_AXI_WDATA),
      .M_AXI_WSTRB(M_AXI_WSTRB),
      .M_AXI_WLAST(M_AXI_WLAST),
      .M_AXI_WUSER(M_AXI_WUSER),
      .M_AXI_WVALID(M_AXI_WVALID),
      .M_AXI_WREADY(M_AXI_WREADY),
      
      .M_AXI_BID(M_AXI_BID),
      .M_AXI_BRESP(M_AXI_BRESP),
      .M_AXI_BUSER(M_AXI_BUSER),
      .M_AXI_BVALID(M_AXI_BVALID),
      .M_AXI_BREADY(M_AXI_BREADY),
      
      .M_AXI_ARID(M_AXI_ARID),
      .M_AXI_ARADDR(M_AXI_ARADDR),
      .M_AXI_ARLEN(M_AXI_ARLEN),
      .M_AXI_ARSIZE(M_AXI_ARSIZE),
      .M_AXI_ARBURST(M_AXI_ARBURST),
      .M_AXI_ARLOCK(M_AXI_ARLOCK),
      .M_AXI_ARCACHE(M_AXI_ARCACHE),
      .M_AXI_ARPROT(M_AXI_ARPROT),
      .M_AXI_ARQOS(M_AXI_ARQOS),
      .M_AXI_ARUSER(M_AXI_ARUSER),
      .M_AXI_ARVALID(M_AXI_ARVALID),
      .M_AXI_ARREADY(M_AXI_ARREADY),
      
      .M_AXI_RID(M_AXI_RID),
      .M_AXI_RDATA(M_AXI_RDATA),
      .M_AXI_RRESP(M_AXI_RRESP),
      .M_AXI_RLAST(M_AXI_RLAST),
      .M_AXI_RUSER(M_AXI_RUSER),
      .M_AXI_RVALID(M_AXI_RVALID),
      .M_AXI_RREADY(M_AXI_RREADY),
      
      .MASTER_RST(1'b0),
      
      .WR_START(wr_burst_req),
      .WR_ADRS(wr_addr),
      .WR_LEN({16'd0,len}), 
      .WR_READY(),
      .WR_FIFO_RE(wr_burst_data_req),
      .WR_FIFO_EMPTY(1'b0),
      .WR_FIFO_AEMPTY(1'b0),
      .WR_FIFO_DATA(wr_burst_data),
	  .WR_DONE(wr_burst_finish),
      
      .RD_START(1'b0),
      .RD_ADRS(),
      .RD_LEN(), 
      .RD_READY(),
      .RD_FIFO_WE(),
      .RD_FIFO_FULL(1'b0),
      .RD_FIFO_AFULL(1'b0),
      .RD_FIFO_DATA(),
      .RD_DONE(),
      .DEBUG()                                         
    );

// up bus interface

up_axi i_up_axi (
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_axi_awvalid (s_axi_awvalid),
    .up_axi_awaddr (s_axi_awaddr),
    .up_axi_awready (s_axi_awready),
    .up_axi_wvalid (s_axi_wvalid),
    .up_axi_wdata (s_axi_wdata),
    .up_axi_wstrb (s_axi_wstrb),
    .up_axi_wready (s_axi_wready),
    .up_axi_bvalid (s_axi_bvalid),
    .up_axi_bresp (s_axi_bresp),
    .up_axi_bready (s_axi_bready),
    .up_axi_arvalid (s_axi_arvalid),
    .up_axi_araddr (s_axi_araddr),
    .up_axi_arready (s_axi_arready),
    .up_axi_rvalid (s_axi_rvalid),
    .up_axi_rresp (s_axi_rresp),
    .up_axi_rdata (s_axi_rdata),
    .up_axi_rready (s_axi_rready),
    .up_wreq (up_wreq_s),
    .up_waddr (up_waddr_s),
    .up_wdata (up_wdata_s),
    .up_wack (up_wack_s),
    .up_rreq (up_rreq_s),
    .up_raddr (up_raddr_s),
    .up_rdata (up_rdata_s),
    .up_rack (up_rack_s));

  // processor interface

up_axis_adc up_axis_adc_m0 (
 	.axim_clk (ACLK),
 	.axim_rst(~ARESETN),
	.wr_addr  (wr_addr),
	.len      (len),
	.go       (go),
 
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_wreq (up_wreq_s),
    .up_waddr (up_waddr_s),
    .up_wdata (up_wdata_s),
    .up_wack (up_wack_s),
    .up_rreq (up_rreq_s),
    .up_raddr (up_raddr_s),
    .up_rdata (up_rdata_s),
    .up_rack (up_rack_s));



endmodule

// ***************************************************************************
// ***************************************************************************

module ad7606_data_resize(
	input           adc_clk,
	output[63:0]    adc_data,
	output reg      adc_data_valid,         
	input [15:0] 	ad_data,        
	input        	ad_busy,        
    input        	first_data,     
	output [2:0] 	ad_os,          
	output          ad_cs,          
	output          ad_rd,          
	output          ad_reset,       
	output          ad_convstab
	);
wire [15:0] ad_ch1;
wire [15:0] ad_ch2;
wire [15:0] ad_ch3;
wire [15:0] ad_ch4;
wire [15:0] ad_ch5;
wire [15:0] ad_ch6;
wire [15:0] ad_ch7;
wire [15:0] ad_ch8;
wire ad_data_wr;
wire empty;

always@(posedge adc_clk)
begin
	adc_data_valid <= ~empty;
end
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

ad7606_buf ad7606_buf_m0
(
	.clk(adc_clk),
	.din({ad_ch4,ad_ch3,ad_ch2,ad_ch1,ad_ch8,ad_ch7,ad_ch6,ad_ch5}),
	.wr_en(ad_data_wr),
	.rd_en(~empty),
	.dout(adc_data),
	.full(),
	.empty(empty)

);
endmodule

// ***************************************************************************
// ***************************************************************************

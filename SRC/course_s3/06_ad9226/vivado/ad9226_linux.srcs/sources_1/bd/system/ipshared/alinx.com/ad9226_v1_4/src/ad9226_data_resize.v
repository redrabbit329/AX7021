module ad9226_data_resize(
	input               adc_clk,
	input               adc_otr,
	output reg[63:0]    adc_data,
	output reg          adc_data_valid,         
	input [11:0] 	    ad9226_data
	);
reg[11:0] ad9226_data_d0;
reg[11:0] ad9226_data_d1;
reg[11:0] ad9226_data_d2;
reg[11:0] ad9226_data_d3;
reg[1:0] cnt;
wire ad_data_wr;
wire empty;

always@(posedge adc_clk)
begin
	ad9226_data_d0 <= {ad9226_data[0],ad9226_data[1],ad9226_data[2],ad9226_data[3],ad9226_data[4],
	                  ad9226_data[5],ad9226_data[6],ad9226_data[7],ad9226_data[8],ad9226_data[9],
					  ad9226_data[10],ad9226_data[11]};
	ad9226_data_d1 <= ad9226_data_d0;
	ad9226_data_d2 <= ad9226_data_d1;
	ad9226_data_d3 <= ad9226_data_d2;
end
always@(posedge adc_clk)
begin
	cnt <= cnt + 2'd1;
end
always@(posedge adc_clk)
begin
	adc_data <= { {4{ad9226_data_d0[11]}},ad9226_data_d0,{4{ad9226_data_d1[11]}},ad9226_data_d1,{4{ad9226_data_d2[11]}},ad9226_data_d2,{4{ad9226_data_d3[11]}},ad9226_data_d3};
	adc_data_valid <= (cnt == 2'd3) ? 1'b1 : 1'b0;
end

endmodule

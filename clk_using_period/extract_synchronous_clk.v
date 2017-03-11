module extract_synchronous_clk(
    input clk, 
	input [7:0]man_code,
    input manchester_code, 
	output man_sync, 
	output reg rx_sig,
	output reg ad_clk,
    output reg debug_clk
);

reg ad_clk_temp=0;
always@(posedge clk)begin
	ad_clk_temp<=~ad_clk_temp;
end

always @(posedge ad_clk_temp) begin
  ad_clk<=~ad_clk;
end

reg man_code_r;
always @(posedge clk) begin
    if(man_code < 8'd127 )
        man_code_r<=1;
    else
        man_code_r<=0;
end

reg [1:0] man_code_dly;
wire man_code_edge = ^man_code_dly;
always@(posedge clk) begin
    man_code_dly = {man_code_dly[0], man_code_r}; 
end

wire [15:0] prd/* synthesis keep="1" */;
max_period max_period_u1
(   
    .clk(clk),
    .code_edge(man_code_edge), 
    .period(prd)
);

reg [15:0] cnt=0;
always@(posedge clk) begin
    if(man_code_edge) begin
        if(cnt > (prd - (prd >> 2)) && cnt < (prd >> 2))
        cnt <= 1'b0;
    end
    else begin
        if(cnt < prd - 1'b1) 
            cnt <= cnt + 1'b1;
        else cnt <= 1'b0; 
    end 
end

// assign man_sync =( cnt > (prd >> 2)  && cnt< (prd>>1) ) ||( cnt> (prd- (prd>>2)) );
// assign man_sync = (cnt == (prd - (prd >> 2)) || cnt == (prd >> 2));
assign man_sync = ( cnt == (prd >> 2) );

always @(posedge man_sync) begin
    rx_sig<=man_code_r;
end

//1M debug_clk
reg [9:0]cnt_debug=0;
always @(posedge clk) begin
	 if(cnt_debug == 10'd49) begin 
        cnt_debug<=0;
		  debug_clk<=~debug_clk;
		end 
    else
        cnt_debug<=cnt_debug+1;
end


endmodule

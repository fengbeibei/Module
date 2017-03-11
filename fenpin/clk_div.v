module clk_div(
    input clk,
    input rst_n,
    output clk_1m
    );

//1m
reg [31:0]cnt_1m=0;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        cnt_1m<=0;
    end
    else if(cnt_1m == 32'd999)
        cnt_1m<=0;
    else
        cnt_1m<=cnt_1m+1;
end
assign clk_1m=(cnt_1m == 32'd999);

endmodule
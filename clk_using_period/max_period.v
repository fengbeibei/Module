`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/30 12:36:47
// Design Name: 
// Module Name: max_period
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


module max_period( 
	input clk, 
	input code_edge, 
	output reg [15:0] period
);

reg [15:0] cnt=0;
reg [15:0] p_temp=0; 
reg [23:0] cnt_for_100ms=0;
	
wire en_100ms = (cnt_for_100ms == 1'b0);
always@(posedge clk) begin
    if(cnt_for_100ms < 24'd9_999)
        cnt_for_100ms <= cnt_for_100ms + 1'b1;
    else 
        cnt_for_100ms <= 1'b0; 
end
	
always@(posedge clk) begin
    if(code_edge) 
        cnt <= 1'b0;
    else 
        cnt <= cnt + 1'b1; 
end

always@(posedge clk) begin
    if(en_100ms) begin
        p_temp <= 1'b0; 
        period <= p_temp; 
    end
    else if(code_edge) begin
        if(cnt > p_temp) 
            p_temp <= cnt; 
    end 
end

endmodule

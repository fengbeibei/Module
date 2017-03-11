`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/01/09 22:03:09
// Design Name: 
// Module Name: manchester
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


module man_encode(
	 input clk,
    input sig_in,
    output man_sig_out
    );

reg ck=0;
reg ck_r=0;
always @(posedge clk) begin
    ck<=ck_r;
    ck <= ~ ck;
end

assign man_sig_out = ck ^ sig_in;

endmodule

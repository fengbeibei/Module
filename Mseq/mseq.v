`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/01/10 15:03:22
// Design Name: 
// Module Name: mseq
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

module mseq
#(  
    // parameter W = 4'd8,
    // parameter POLY = 9'b100011101
    parameter W = 4'd4,
    parameter POLY = 5'b10011
)
(   
    input clk,
    input rst_n,
    output mseq_out
);

reg [W-1:0] sreg = 4'b1111;
assign mseq_out = sreg[0];

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) 
        sreg <= 1'b1;
    else begin
        if(mseq_out) 
            sreg <= (sreg >> 1) ^ (POLY >> 1);
        else 
            sreg <= sreg >> 1;
    end
end

endmodule

module rx_control_module(
	input clk,
	input [7:0]rx_data,
	input rx_done_sig,
	output reg [31:0]fre_word=32'd28633115
);

reg [31:0]fre_word_r=0;
reg [3:0]i_cnt=4'd0;
always @(posedge clk) begin
	case(i_cnt)
		4'd0:if(rx_data==8'h01 && rx_done_sig) begin i_cnt<=i_cnt+1; end
		4'd1:if(rx_done_sig) begin fre_word_r[31:24]<=rx_data; i_cnt<=i_cnt+1; end
		4'd2:if(rx_done_sig) begin fre_word_r[23:16]<=rx_data; i_cnt<=i_cnt+1; end
		4'd3:if(rx_done_sig) begin fre_word_r[15:8]<=rx_data; i_cnt<=i_cnt+1; end
		4'd4:if(rx_done_sig) begin fre_word_r[7:0]<=rx_data; i_cnt<=i_cnt+1; end
		4'd5:begin fre_word<=fre_word_r; i_cnt<=0; end
	endcase
end
	 
endmodule


module keyword_control(
  input clk,
  input [3:0]key,
  output reg [3:0]led=4'd0,
  output [15:0]fre_word,
  output [31:0]data
);

reg [15:0]fre_word_r=16'd10;
always @(posedge clk) begin
  if(key[0]) 
		begin led[0]<=~led[0]; fre_word_r<=fre_word_r+8'd100; end
  else if(key[1])
		begin led[1]<=~led[1]; fre_word_r<=fre_word_r-8'd100;  end
  else if(key[2])
		begin led[2]<=~led[2];fre_word_r<=fre_word_r+4'd10;   end
  else if(key[3])
		begin led[3]<=~led[3];fre_word_r<=fre_word_r-4'd10;   end
  else
    fre_word_r<=fre_word_r;
end 

assign fre_word=fre_word_r;
assign data=32'd2814749767;

endmodule // keyword_control
module detect_delay
#(
    parameter DELAY_TIME = 20'd999_999
)
(
    input clk,
    input key_in,
    output  key_out
    );

//initial
reg [10:0]cnt_ini=0;
reg isen=0;
always @(posedge clk) begin
  if(cnt_ini == 11'd4999) begin
    isen<=1;
  end
  else  
    cnt_ini<=cnt_ini+1;
end

//detect the fall_edge and rise_edge
reg [1:0]bus=2'b11;
wire fall_edge= bus[1] & (~ bus[0]);
wire rise_edge= (~ bus[1]) & bus[0];
always @(posedge clk) begin
    bus<= {bus[0], key_in} ;
end

reg[2:0]i_cnt=0;
reg cnt_begin=0;
reg key_out_r=0;
always @(posedge clk) begin
    case (i_cnt)
            3'd0:
                if(fall_edge && isen)
                    i_cnt<=3'd1;
                else if(rise_edge && isen)
                    i_cnt<=3'd2;
            3'd1:if(cnt_delay == DELAY_TIME) 
                    begin
                        key_out_r<=1;
                        cnt_begin<=0;
                        i_cnt<=3'd3;
                    end
                  else 
                        cnt_begin<=1;
            3'd2:if(cnt_delay == DELAY_TIME) 
                    begin
                        cnt_begin<=0;
                        i_cnt<=3'd0;
                    end
                  else 
                        cnt_begin<=1;
            3'd3:
                begin   
                    i_cnt<=0;
                    key_out_r<=0;
                end
        endcase
end 

assign key_out=key_out_r;

reg [19:0]cnt_delay=0;
always @(posedge clk) begin
    if(cnt_delay == DELAY_TIME) begin
        cnt_delay<=0;
    end
    else if(cnt_begin) begin
        cnt_delay<=cnt_delay+1;
    end
    else
        cnt_delay<=0;
end

endmodule

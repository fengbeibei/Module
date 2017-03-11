module uart_rx
#(
    parameter BPS = 10'd434
)
(
    input clk,
    input rst_n,
    input rx,
    output reg [7:0]rx_data,
    output reg rx_dong_sig
    );

wire rst;
assign rst = ~ rst_n;


//detect the fall_edge
reg [1:0]bus=2'b11;
wire fall_edge= ^bus;
always @(posedge clk) begin
    bus<= {bus[0], rx} ;
end

//set the 115200 bps 50M
reg [9:0]cnt_bps=0;
reg cnt_begin=0;
always @(posedge clk) begin
    if(rst) 
        cnt_bps<=0;
    else if(cnt_bps == BPS) 
        cnt_bps<=0;
    else if(cnt_begin)
        cnt_bps<=cnt_bps+1;
    else
        cnt_bps<=0;
end

wire bps_clk=cnt_begin ? (cnt_bps == (BPS>>1)) : 0;

reg [3:0]cnt_tx_step=0;
reg [7:0]rx_data_r=0;
always @(posedge clk) begin
    if(rst) begin
        cnt_tx_step<=0;
        rx_dong_sig<=0;
        cnt_begin<=0;
    end
    else
        case (cnt_tx_step) 
            4'd0:
                if(fall_edge) begin//检测首位
                    cnt_tx_step<=cnt_tx_step+1;
                    cnt_begin<=1;
                end
            4'd1:
                if(bps_clk) begin//忽略第一位
                    cnt_tx_step<=cnt_tx_step+1;
                end
            4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9 :
                if(bps_clk) begin//数据位
                    cnt_tx_step<=cnt_tx_step+1;
                    rx_data_r[cnt_tx_step-2]<=rx;
                end
            4'd10:
                if(bps_clk) begin//一帧数据接收结束标志
                    rx_data<=rx_data_r;//register the data before the dong_sig
                    cnt_tx_step<=cnt_tx_step+1;
                    rx_dong_sig<=1;
                    cnt_begin<=0;
                end
            4'd11: begin
                    cnt_tx_step<=0;
                    rx_dong_sig<=0;
                end
        endcase
end

endmodule

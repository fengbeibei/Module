module tube_decode(
    input clk,
    input rst_n,
    input [7:0]data_tube,
    output reg [7:0]duan_scan,
    output reg [3:0]wei_scan
    );

wire rst_p;
assign rst_p= ~ rst_n;

reg [7:0]baiwei=0;
reg [7:0]baiwei_r=0;
reg [7:0]shiwei=0;
reg [7:0]gewei=0;

always @(posedge clk) begin
    baiwei<=data_tube/100;
    baiwei_r<=data_tube%100;
    shiwei<=baiwei_r/10;
    gewei<=baiwei_r%10;
end


//浣嶆壂鎻忚鏁板櫒
reg [15:0]cnt_scan=0;
always @(posedge clk ) begin
    if(rst_p) 
        cnt_scan<=0;
    else
        cnt_scan<=cnt_scan+1;
end

//浣嶆壂鎻 
always @(posedge clk ) begin
    if(rst_p)
        wei_scan<= 4'b1110;
    else        
        case(cnt_scan[15:14])
            2'b00:wei_scan<=4'b1110;
            2'b01:wei_scan<=4'b1101;
            2'b10:wei_scan<=4'b1011;
            2'b11:wei_scan<=4'b0111;
        endcase
end

reg [3:0]dataout;
always @(posedge clk) begin
    if(rst_p) 
        dataout<=0;
    else 
        case(cnt_scan[15:14])
            2'b00:dataout<=0;
            2'b01:dataout<=baiwei;
            2'b10:dataout<=shiwei;
            2'b11:dataout<=gewei;
        endcase
end


//鍔犵爜,鍏遍槼鏁扮爜绠 
always @(posedge clk) begin
    if(rst_p)
        duan_scan<=8'b1100_0000;
    else
        case(dataout)
            4'b0000:
			    duan_scan=8'b1100_0000;//0
            4'b0001:
                duan_scan=8'b1111_1001;
            4'b0010:
                duan_scan=8'b1010_0100;
            4'b0011:
                duan_scan=8'b1011_0000;
            4'b0100:
                duan_scan=8'b1001_1001;
            4'b0101:
                duan_scan=8'b1001_0010;
            4'b0110:
                duan_scan=8'b1000_0010;
            4'b0111:
                duan_scan=8'b1111_1000;
            4'b1000:
                duan_scan=8'b1000_0000;
            4'b1001:
                duan_scan=8'b1001_1000;
            4'b1010:
                duan_scan=8'b1000_1000;
            4'b1011:
                duan_scan=8'b1000_0011;
            4'b1100:
                duan_scan=8'b1100_0110;
            4'b1101:
                duan_scan=8'b1010_0001;
            4'b1110:
                duan_scan=8'b1000_0110;
            4'b1111:
                duan_scan=8'b1000_1110;//f
        endcase
end

endmodule


reg [14:0]abs_bpf1=0;
reg [14:0]abs_bpf2=0;
always @(posedge clk_100m) begin
    if(bpf1_data[31])
        abs_bpf1<=-bpf1_data[30:16];
    else
        abs_bpf1<=bpf1_data[30:16];
    if(bpf2_data[39])
        abs_bpf2<=-bpf2_data[32:18];
    else
        abs_bpf2<=bpf2_data[32:18];
end
module key_inerface(
    input clk,
    input [3:0]key_in,
    output [3:0]key_out
);


detect_delay detect_delay_u1(
    .clk(clk),    
    .key_in(key_in[0]),
    .key_out(key_out[0])
);

detect_delay detect_delay_u2(
    .clk(clk),    
    .key_in(key_in[1]),
    .key_out(key_out[1])
);

detect_delay detect_delay_u3(
    .clk(clk),    
    .key_in(key_in[2]),
    .key_out(key_out[2])
);

detect_delay detect_delay_u4(
    .clk(clk),    
    .key_in(key_in[3]),
    .key_out(key_out[3])
);

endmodule
module rom (
    input [1:0] addr,
    output [3:0] data
);
    wire D0, D1, D2, D3;
    wire [3:0] mem0 = 4'b1100; // Password
    wire [3:0] mem1 = 4'b1010; // Particle Limit
    wire [3:0] mem2 = 4'b1000; // Temperature Limit
    wire [3:0] mem3 = 4'b0110; // Room Cool Limit

    // Decoder logic
    assign D0 = ~addr[1] & ~addr[0];
    assign D1 = ~addr[1] & addr[0];
    assign D2 = addr[1] & ~addr[0];
    assign D3 = addr[1] & addr[0];

    // Output logic
    assign data[0] = (D0 & mem0[0]) | (D1 & mem1[0]) | (D2 & mem2[0]) | (D3 & mem3[0]);
    assign data[1] = (D0 & mem0[1]) | (D1 & mem1[1]) | (D2 & mem2[1]) | (D3 & mem3[1]);
    assign data[2] = (D0 & mem0[2]) | (D1 & mem1[2]) | (D2 & mem2[2]) | (D3 & mem3[2]);
    assign data[3] = (D0 & mem0[3]) | (D1 & mem1[3]) | (D2 & mem2[3]) | (D3 & mem3[3]);

endmodule

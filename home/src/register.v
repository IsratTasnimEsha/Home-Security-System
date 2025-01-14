module register (
    input [3:0] D,     // Data input
    input clk,         // Clock signal
    input rst,         // Reset signal (active high)
    input en,          // Enable signal
    output [3:0] Q     // Data output
);
    // Instantiate four D flip-flops for the 4-bit register
    d_flip_flop ff0 (.D(D[0]), .clk(clk), .rst(rst), .en(en), .Q(Q[0]));
    d_flip_flop ff1 (.D(D[1]), .clk(clk), .rst(rst), .en(en), .Q(Q[1]));
    d_flip_flop ff2 (.D(D[2]), .clk(clk), .rst(rst), .en(en), .Q(Q[2]));
    d_flip_flop ff3 (.D(D[3]), .clk(clk), .rst(rst), .en(en), .Q(Q[3]));
endmodule
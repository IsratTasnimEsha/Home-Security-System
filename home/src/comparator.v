module comparator (
    input [3:0] A,          
    input [3:0] B,          
    input clk,              
    input rst,              
    input en,               
    output A_greater_B,     
    output A_equal_B,       
    output A_less_B         
);
    wire [3:0] reg_A, reg_B; 

    register reg1 (.D(A), .clk(clk), .rst(rst), .en(en), .Q(reg_A));
    register reg2 (.D(B), .clk(clk), .rst(rst), .en(en), .Q(reg_B));

    assign A_greater_B = (reg_A > reg_B);
    assign A_equal_B = (reg_A == reg_B);
    assign A_less_B = (reg_A < reg_B);

endmodule

module d_flip_flop (
    input D,      
    input clk,    
    input rst,    
    input en,     
    output reg Q  
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 1'b0;       
        else if (en)
            Q <= D;          
    end
endmodule
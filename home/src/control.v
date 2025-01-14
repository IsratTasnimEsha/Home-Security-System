module control (
    input clk, reset, load,  
    input p, f, d, pm, ptl, dtl, tl, pt, pp, rh,
    output reg t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13
);
    wire [3:0] state;  
    wire D3, D2, D1, D0; 

    assign D3 = (load && (t0&f | t0&d | t8&~pt | t8&pt | t10&~pp | t10&~tl | t10&tl&pp | t11 | t12&~rh | t12&rh));
    assign D2 = (load && (t2&pm | t3 | t5 | t6&~dtl | t6&dtl | t7 | t9 | t11 | t12&~rh | t12&rh | t13));
    assign D1 = (load && (t0&d | t1 | t2&~pm&~ptl | t2&ptl | t5 | t6&~dtl | t6&dtl | t10&~pp | t10&~tl | t10&tl&pp));
    assign D0 = (load && (t0&p | t2&ptl | t2&pm | t6&dtl | t8&pt | t10&tl&pp | t12&rh));

    register reg_state (
        .D({D3, D2, D1, D0}),  
        .clk(clk),             
        .rst(reset),           
        .en(1'b1),             
        .Q(state)              
    );

    always @(*) begin
       
        {t13, t12, t11, t10, t9, t8, t7, t6, t5, t4, t3, t2, t1, t0} = 13'b0;
        case (state)  
            4'b0000: t0 = 1;    
            4'b0001: t1 = 1;    
            4'b0010: t2 = 1;    
            4'b0011: t3 = 1;    
            4'b0100: t4 = 1;    
            4'b0101: t5 = 1;    
            4'b0110: t6 = 1;    
            4'b0111: t7 = 1;    
            4'b1000: t8 = 1;    
            4'b1001: t9 = 1;    
            4'b1010: t10 = 1;   
            4'b1011: t11 = 1;   
            4'b1100: t12 = 1;   
			4'b1101: t13 = 1;   
            default: ;          
        endcase
    end
endmodule

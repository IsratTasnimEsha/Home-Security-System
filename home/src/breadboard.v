module breadboard;

    reg clk, reset, load;
    reg p, f, d, pm, ptl, dtl, tl, pt, pp, rh;
    wire t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13;	 

    reg [3:0] b;         
    reg s0, s1, cin;     
    wire [3:0] a;        
    wire [3:0] s;        
    wire cout; 	 
	
	reg [3:0] A;
    reg [3:0] B;  
	reg [3:0] _a;
    reg [3:0] _b;
	reg [3:0] _A;
    reg [3:0] _B;
	
    reg en;

    reg [3:0] b_ar [2:0];  

    reg [1:0] rom_addr_0; 
	reg [1:0] rom_addr_1;
	reg [1:0] rom_addr_2;
	reg [1:0] rom_addr_3;

    reg [1:0] count;

	reg load_pass;
	reg load_fire;
	reg load_ac;
	
	reg pass_correct;
	reg pass_incorrect;	
	
	wire A_greater_B;
    wire A_equal_B;
    wire A_less_B;	
	wire _a_greater_b;
    wire _a_equal_b;
    wire _a_less_b;
	wire _A_greater_B;
    wire _A_equal_B;
    wire _A_less_B;

    rom rom_instance0 (
        .addr(rom_addr_0),
        .data(a)
    );
	
	rom rom_instance1 (
        .addr(rom_addr_1),
        .data(A)
    );
	
	rom rom_instance2 (
        .addr(rom_addr_2),
        .data(_a)
    );	  
	
	rom rom_instance3 (
        .addr(rom_addr_3),
        .data(_A)
    );
	
    parallel_adder adder (
        .a(a), 
        .b(b), 
        .s0(s0), 
        .s1(s1), 
        .cin(cin), 
        .s(s), 
        .cout(cout)
    );

    control uut (
        .clk(clk), .reset(reset), .load(load),
        .p(p), .f(f), .d(d), .pm(pm), .ptl(ptl), .dtl(dtl), .tl(tl), .pt(pt), .pp(pp), .rh(rh),
        .t0(t0), .t1(t1), .t2(t2), .t3(t3), .t4(t4), .t5(t5), .t6(t6), .t7(t7),
        .t8(t8), .t9(t9), .t10(t10), .t11(t11), .t12(t12), .t13(t13)
    );
	
	comparator comp0 (
        .A(A),
        .B(B),
        .clk(clk),
        .rst(rst),
        .en(en),
        .A_greater_B(A_greater_B),
        .A_equal_B(A_equal_B),
        .A_less_B(A_less_B)
    ); 
	
	comparator comp1 (
        .A(_a),
        .B(_b),
        .clk(clk),
        .rst(rst),
        .en(en),
        .A_greater_B(_a_greater_b),
        .A_equal_B(_a_equal_b),
        .A_less_B(_a_less_b)
    );
	
	comparator comp2 (
        .A(_A),
        .B(_B),
        .clk(clk),
        .rst(rst),
        .en(en),
        .A_greater_B(_A_greater_B),
        .A_equal_B(_A_equal_B),
        .A_less_B(_A_less_B)
    );
	
    initial begin
		
		// ********************************************** input change **********************************************
		
		b_ar[0] = 4'b1110; 
        b_ar[1] = 4'b1010; 
        b_ar[2] = 4'b1100;	// 4'b1100 
		B = 4'b1111;		// 4'b1010 
		_b = 4'b1100;  		// 4'b1000 
		_B = 4'b0100;		// 4'b0110 
		
		// ***********************************************************************************************************
							   
        rom_addr_0 = 2'b00;    
		rom_addr_1 = 2'b01;	   
		rom_addr_2 = 2'b10;	   
		rom_addr_3 = 2'b11;
		
        s0 = 0;           
        s1 = 1;           
        cin = 1;   

        reset = 1;	
		en = 0;
        count = 0;
        p = 0; f = 0; d = 0; pm = 0; ptl = 0; dtl = 0; tl = 0; pt = 0; pp = 0; rh = 0;
 
        #10 reset = 0;
        en = 1;
		load = 0; 	
		
		// ********************************************** input change **********************************************
		
		load_pass = 1; 
		load_fire = 0;	 
		load_ac = 0;   
		
		// ***********************************************************************************************************
		
		// ********************************************** password **********************************************
		
		pass_correct = 1;
		pass_incorrect = 1;	 
		
		load = load_pass;
        
		#10 clk = load;
        #10 p = 1 & load;  // t0 -> t1
        
		#10 clk = 0; 
        #10 clk = load; 
		#10  // t1 -> t2
		
        $display("Password: a=%b, b=%b, Result=%b", a, b, s);
		if (load) begin
	        for (int i = 0; i < 3; i = i + 1) begin    
	            b = b_ar[i];
	
	            rom_addr_0 = 2'b00; 
	            #10;
	
	            $display("Password: a=%b, b=%b, Result=%b", a, b, s);
	
	            b = ~b;
	
	            if (s == 4'b0000) begin
	                break;
	            end else begin
	                count = count + 1;
	            end
			end	  
	   	end
		 
		   
		// ------------ pass correct ------------
		
		load = load_pass & pass_correct & (count < 3); 
		
		#10 clk = 0; 
        #10 clk = 1;
		#10 pm = 1 & load;  // t2 -> t5
        
		#10 clk = 0;  
        #10 clk = load;  
		#10  // t5 -> t6 
		
		#10 clk = 0; 
        #10 clk = load;
		#10000		   
		
		#10000 clk = 0;
        #10000 clk = load;
        #10 dtl = 1 & load; // t6 -> t7
        
		#10 clk = 0;
        #10 clk = load;
        #10;  // t7 -> t4
		
		#10 clk = 0;
        #10 clk = load;
		#10;  // t4 -> t0  
		
		#10 clk = 0;
        #10 clk = load; 
		#10;
		
		
		// ------------ pass incorrect ------------
		
		load = load_pass & pass_incorrect & (count >= 3);
        
		#10 clk = 0; 
        #10 clk = load;		
		#10 ptl = 1 & load;  // t2 -> t3
        
		#10 clk = 0; 
        #10 clk = load;   	
        #10;  // t3 -> t4 
		
		#10 clk = 0;
        #10 clk = load;	
		#10;  // t4 -> t0 
		
		#10 clk = 0;
        #10 clk = load; 
		#10;
		
		#10 clk = 0;
        #10 clk = load; 
		#10;
		
		
		// ********************************************** fire **********************************************
		
		load = load_fire;
		
		#10 clk = 0;
		#10 clk = load;
        #10 f = 1 & load;  // t0 -> t8
		
		#10 clk = 0;
		#10 clk = load;
        #10	
		
		// ------------ load fire ------------
		
		load = load_fire & A_less_B;
		
		#10 clk = 0;
		#10 clk = load;
        #10	pt = 1 & load;  // t8 -> t9
		
		#10 clk = 0;
		#10 clk = load;
        #10	 // t9 -> t4	
		
		#10 clk = 0;
		#10 clk = load;
        #10	 // t4 -> t0	   
		
		#10 clk = 0;
		#10 clk = load;
        #10			 
		
		
		// ********************************************** ac **********************************************
		
		load = load_ac;
		
		#10 clk = 0;
		#10 clk = load;
        #10 d = 1 & load;  // t0 -> t10
		
		#10 clk = 0;
		#10 clk = load;
        #10	
		
		// ------------ on ac ------------
		
		load = load_ac & _a_less_b;
		
		#10 clk = 0;
		#10 clk = load;
        #10	pp = 1 & load; tl = 1 & load;  // t10 -> t11
		
		#10 clk = 0;
		#10 clk = load;
        #10	 // t11 -> t12 
		
		#10 clk = 0;
		#10 clk = load;
        #10
		
		// ------------ off ac ------------
		
		load = load_ac & _a_less_b && _A_greater_B;
		
		#10 clk = 0;
		#10 clk = load;
        #10 rh = 1 & load;  // t12 -> t13
		
		#10 clk = 0;
		#10 clk = load;
        #10;  // t13 -> t4
		
		#10 clk = 0;
		#10 clk = load;
        #10;  // t4 -> t0
		
		#10 clk = 0;
		#10 clk = load;
        #10;
		
		
		#10 $stop;
    end

    initial begin
        $monitor(
            "Time=%0t count=%d | p=%b f=%b d=%b pm=%b ptl=%b dtl=%b tl=%b pt=%b pp=%b rh=%b | State: t0=%b t1=%b t2=%b t3=%b t4=%b t5=%b t6=%b t7=%b t8=%b t9=%b t10=%b t11=%b t12=%b t13=%b",
            $time, load, p, f, d, pm, ptl, dtl, tl, pt, pp, rh, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13
        );
		
		// $monitor("Time=%0t | A=%b, B=%b | A_greater_B=%b, A_equal_B=%b, A_less_B=%b",
        //    $time, _A, _B, _A_greater_B, _A_equal_B, _A_less_B);
    end

endmodule

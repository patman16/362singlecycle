module testbench;
    reg signed [31:0] A;
    reg signed [31:0] B;
    reg [3:0] OP;
	wire signed [31:0] RESULT;
	wire ZERO;

    alu alu(.a(A), .b(B), .op(OP), .result(RESULT), .zero(ZERO));

    initial begin
        $monitor("A=%d B=%d OP=%b RESULT=%d ZERO=%b", A, B, OP, RESULT, ZERO);
		// FFFF0000 & 0000FFFF = 00000000
		#0 A = 32'hFFFF0000; B = 32'h0000FFFF; OP = 0;
		// FFFF0000 | 0000FFFF = FFFFFFFF
		#1 OP = 1;
		// FFFF0000 ^ 0000FFFF = FFFFFFFF
		#1 OP = 2;
		// 1+5 = 6
    	#1 A = 1; B = 6; OP = 3; 
		// 100-100 = 0
		#1 A = 100; B = 100; OP = 4;
		// 25 * 520843 = 13021075
		#1 A = 25; B = 520843; OP = 5;
		// 520843 == 520843
		#1 A = 520843; OP = 6;
		// -3348 != 520843
		#1 A = -3348; OP = 7;
		// 10000 >= 10000
		#1 A = 10000; B = 10000; OP = 8;
		// 10000 > 2000
		#1 B = 2000; OP = 9;
		// 2000 < 10000
		#1 A = 2000; B = 10000; OP = 10;
		// 2000 <= 2000
		#1 B = 2000; OP = 11;
		// 10 << 5 = 320
		#1 A = 10; B = 5; OP = 12;
		// 320 >> 5 = 320
		#1 A = 320; B = 5; OP = 13;
		// 10010111 >> 1 = 11001011
		#1 A = -105; B = 1; OP = 14;
    end
endmodule // testbench

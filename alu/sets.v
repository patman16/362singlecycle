module constant(a,b,x);
        input a, b;
        output x;

        assign x = (a&b) | ((~a)&(~b));
endmodule

module equal(a,b,eq);
        parameter N = 32;
        input [N-1:0] a, b;
        output eq;
        wire [N-1:0] x;

        generate
        genvar i;
        for(i = 0; i < N; i = i+1)
                begin : uF
                constant GENERATE_X(a[i], b[i], x[i]);
        end
        endgenerate
		
		assign eq = &x;
endmodule

module aNotb(a,b, test);
        input a, b;
        output test;

        assign test = a & ~b;
endmodule

module greaterThan(a,b,eq);
        parameter N = 32;
        input signed [N-1:0]  a, b;
        output eq;
        wire [N-1:0] x;
        wire  [N-1:0] anotbvector;
	wire [N-2:0] ineqvector;
	wire mageq;

        generate
        genvar i;
        for(i=0; i<(N); i = i+1)
                begin : uF
                constant GENERATE(a[i], b[i], x[i]);
                aNotb AB(a[i],b[i],anotbvector[i]);
        end
	for (i=N-2; i >= 0; i = i-1) begin: ineq
		assign ineqvector[i] = &x[N-1:((N-1)-(N-2-i))] & anotbvector[i]; 	
	end
        endgenerate

	assign mageq = anotbvector[N-1] | |ineqvector;
	assign eq = ((a[N-1] == 1'b0 && b[N-1] == 1'b1) || (a[N-1] == 1'b1 && b[N-1] == 1'b0)) ? ~mageq : mageq;
endmodule

module greaterOrEqual(a,b,eq);
	parameter N = 32;
	input [N-1:0] a, b;
	output eq;
	wire [N-1:0] x;
	wire  test1, test2;
	
	greaterThan GREATER(a,b,test1);
	equal EQ(a,b,test2);

	assign eq = test1 | test2;

endmodule

module Notab(a,b, test);
        input a, b;
        output test;

        assign test = ~a & b;
endmodule

module lessThan(a,b,eq);
	parameter N = 32;
    input signed [N-1:0]  a, b;
    output eq;
    wire [N-1:0] x;
    wire  [N-1:0] notabvector;
	wire [N-2:0] ineqvector;
	wire mageq;

        generate
        genvar i;
        for(i=0; i<(N); i = i+1)
                begin : uF
                constant GENERATE(a[i], b[i], x[i]);
                Notab AB(a[i],b[i],notabvector[i]);
        end
	for (i=N-2; i >= 0; i = i-1) begin: ineq
		assign ineqvector[i] = &x[N-1:((N-1)-(N-2-i))] & notabvector[i]; 	
	end
        endgenerate

	assign mageq = notabvector[N-1] | |ineqvector;
	assign eq = ((a[N-1] == 1'b0 && b[N-1] == 1'b1) || (a[N-1] == 1'b1 && b[N-1] == 1'b0)) ? ~mageq : mageq;
endmodule

module lessOrEqual(a,b,eq);
        parameter N = 32;
        input [N-1:0] a, b;
        output eq;
        wire  test1, test2;

      	lessThan LESS(a,b,test1);
  	equal EQ(a,b,test2);

        assign eq = test1 | test2;
endmodule

module extender(a, z);
    parameter inN = 16;
    parameter outN = 32;
    input [inN-1:0] a;
    output [outN-1:0] z;
	
    assign z[outN-1:0] = { {inN{a[inN-1]}}, a[inN-1:0] };
endmodule	

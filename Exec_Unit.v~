module alu(a, b, op, result, zero);
	input [31:0] a, b;
	input [3:0] op;
	output [31:0] result;
	output zero;
	
	wire [31:0] addsub, multiply, shiftleft, shiftright, rightarith;
	wire seq, sge, sgt, sle;
	reg [31:0] res;
	reg sel;
	
	add_sub_32 adder(.a(a),.b(b),.sel(sel),.sum(addsub));
	mult multiplier(a,b,multiply);
	equal equal(a,b,seq);
	greaterOrEqual ge(a,b,sge);
	greaterThan greater(a,b,sgt);
	lessOrEqual le(a,b,sle);
	sll left(a,b,shiftleft);
	srl right(a,b,shiftright);
	sra ra(a,b,rightarith);
	
	assign result = res;
	assign zero = (res == 1'b0) ? 1'b1 : 1'b0;

	always @* 
	case (op)
		0 : res <= a & b;
		1 : res <= a | b;
		2 : res <= a ^ b;
		3 : begin
				sel <= 1'b0;
				res <= addsub;
			end
		4 : begin
				sel <= 1'b1;
				res <= addsub;
			end
		5 : res <= multiply;
		6 : res <= {{31{1'b0}}, seq};
		7 : res <= {{31{1'b0}}, ~seq};
		8 : res <= {{31{1'b0}}, sge};
		9 : res <= {{31{1'b0}}, sgt};
		10 : res <= {{31{1'b0}}, ~sgt};
		11 : res <= {{31{1'b0}}, sle};
		12 : res <= shiftleft;
		13 : res <= shiftright;
		14 : res <= rightarith;
		default : res <= 32'd0;
	endcase
endmodule

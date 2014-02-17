module register(clk, reset, d, ce, q);
	input clk, reset, d, ce;
	output q;
	reg q;
	
	always @(posedge clk, reset)
	if (reset == 1'b1)
	  q <= 1'b0;
	else if (clk)
	  q <= d;
endmodule 

module registers(clk, write, regdst, fpoint, rd, rs, rt, busW, busA, busB);
	input clk, write, regdst;
	input [1:0] fpoint;
	input [4:0] rd, rs, rt;
	input [31:0] busW;
	output [31:0] busA, busB;
	
	reg [31:0] intregs [31:0];
	reg [31:0] fpregs [31:0];
	reg [4:0] rw;
	
	assign busA = fpoint == 1 ? fpregs[rs] : intregs[rs];
	assign busB = fpoint == 1 ? fpregs[rt] : intregs[rt];

	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin: intinitial
		initial begin
			intregs[i] <= 0;
		end
		end
		for (i = 0; i < 32; i = i + 1) begin: fpinitial
		initial begin
			fpregs[i] <= 0;
		end
		end	
	endgenerate
	
	always @(posedge clk)
	begin
	rw = (regdst == 1'b0) ? rt : rd;
	if (write)
		case (fpoint)
		0 : intregs[rw] <= busW;
		1 : fpregs[rw] <= intregs[rs];
		2 : intregs[rw] <= fpregs[rs];
		3 : fpregs[rw] <= busW;
		endcase
	end
endmodule

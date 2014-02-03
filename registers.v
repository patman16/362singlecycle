module registers(clk, write, regdst, fpoint, rd, rs, rt, busW, busA, busB);
	input clk, write, regdst, fpoint;
	input [4:0] rd, rs, rt;
	input [31:0] busW;
	output [31:0] busA, busB;
	
	integer rw, ra, rb;
	reg [31:0] A, B;
	reg [31:0] intregs [31:0];
	reg [31:0] fpregs [31:0];
	
	assign busA = A;
	assign busB = B;

	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin: intinitial
		initial begin
			intregs[i] = 0;
		end
		end
		for (i = 0; i < 32; i = i + 1) begin: fpinitial
		initial begin
			fpregs[i] = 0;
		end
		end	
	endgenerate
	
	always @(posedge clk)
	begin
		rw = (regdst == 1'b0) ? rt : rd;
		ra = rs;
		rb = rt;
		if (write)
			if (fpoint)
				fpregs[rw] = busW;
			else
				intregs[rw] = busW;
		if (fpoint)
			begin
				A = fpregs[ra];
				B = fpregs[rb];
			end
		else
			begin
				A = intregs[ra];
				B = intregs[rb];
			end
	end	
endmodule

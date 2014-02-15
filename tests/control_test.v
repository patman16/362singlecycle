module testbench;
	reg [31:0] instruction;
	wire regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, extop, loadext;
	wire [1:0] fpoint, dsize;
	wire [3:0] aluctrl;
	wire [4:0] rd, rs1, rs2;
	
	control control(instruction, regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, aluctrl, extop, fpoint, rd, rs1, rs2, dsize, loadext);

	initial 
	begin
		$monitor("rd = %b, rs1 = %b, rs2 = %b, regdst = %b alusrc = %b mem2reg = %b regwrite = %b memwrite = %b branch = %b jump = %b aluctrl = %b extop = %b fpoint = %b dsize = %b loadext = %b", rd, rs1, rs2, regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, aluctrl, extop, fpoint, dsize, loadext);
		//and
		#0 instruction = 32'h00620820;
		//movi2fp
		#2 instruction = 32'h00620835;
		//mult
		#2 instruction = 32'h0462080E;
		//nop
		#2 instruction = 32'h00620815;
		//j
		#2 instruction = 32'h08000000;
		//addui
		#2 instruction = 32'h24410000;
		//bnez
		#2 instruction = 32'h14410000;
		//lhi
		#2 instruction = 32'h3C410000;
		//sgti
		#2 instruction = 32'h6C410000;
		//sh
		#2 instruction = 32'hA4410000;
		//xori
		#2 instruction = 32'h38410000;
	end
endmodule	
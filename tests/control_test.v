module testbench;
	reg [31:0] instruction;
	wire regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, extop;
	wire [1:0] fpoint;
	wire [3:0] aluctrl;
	wire [4:0] rd, rs1, rs2;
	
	control control(instruction, regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, aluctrl, extop, fpoint, rd, rs1, rs2);

	initial 
	begin
		$monitor("rd = %b, rs1 = %b, rs2 = %b, regdst = %b alusrc = %b mem2reg = %b regwrite = %b memwrite = %b branch = %b jump = %b aluctrl = %b extop = %b fpoint = %b", rd, rs1, rs2, regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, aluctrl, extop, fpoint);
		//and
		#0 instruction = 32'h;
		//movi2fp
		#2 instruction = 32'h;
		//mult
		#2 instruction = 32'h;
		//nop
		#2 instruction = 32'h;
		//j
		#2 instruction = 32'h;
		//addui
		#2 instruction = 32'h;
		//bnez
		#2 instruction = 32'h;
		//lhi
		#2 instruction = 32'h;
		//sgti
		#2 instruction = 32'h;
		//sh
		#2 instruction = 32'h;
		//xori
		#2 instruction = 32'h;
	end
endmodule	
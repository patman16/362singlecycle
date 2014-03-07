module exec_unit(clock, reset, RegDst, ALUSrc, MemToReg, RegWrite, MemWr, Branch, Jump, AluCtrl, Extop, FPoint, Dsize, Loadext, Jal, Jar, Loadext, Imm16, BusA, BusB, Extop_out, ALUSrc_out, RegDst-out, MemWr_out, Branch_out, MemtoReg_out, RegWr_out, Dsize_out, Zero_out);
	
	input RegDst, ALUSrc, MemToReg, RegWrite, MemWr, Branch, Jump, Extop, Loadext, Jal, Jar, Loadext, clock, reset;
	input [15:0] Imm16;
	input [31:0] BusA, BusB;
	input [3:0] AluCtrl;
	input [1:0] FPoint, Dsize;
	output Extop_out, ALUSrc_out, RegDst_out, MemWr_out, Branch_out, MemtoReg_out, RegWr_out, Zero_out;
	output [1:0] Dsize_out;
	
	wire [31:0] ext_out, mux0_out; //Output of extender, output of mux 	
	wire [9:0] reg_in, reg_out; //Bits going into and out of register
	wire zero; //Zero output from ALU

	//Execution part of the single cycle
	extender EXT0 (Imm16,Extop, ext_out);
    	mux_2to1_n #(.n(32)) MUX0(BusB, ext_out, ALUSrc, mux0_out);
	alu ALU(BusA, mux0_out, ALUCtrl, alu_out, zero);
	
	//Register at the end	
	assign reg_in = {Extop, ALUSrc, RegDst, MemWr, Branch, MemtoReg, RegWr, Dsize, Zero}
	assign reg_out = {Extop_out, ALUSrc_out, RegDst_out, MemWr_out, Branch_out, MemtoReg_out, RegWr_out, Dsize_out, Zero_out};
	PCReg #(.width(10)) PC (reg_out, reg_in, clock, reset);


endmodule

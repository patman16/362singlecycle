module control(instruction, regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, aluctrl, extop, fpoint, rd, rs1, rs2);
	input [31:0] instruction;
	output regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, extop;
	output [1:0] fpoint;
	output [3:0] aluctrl;
	output [4:0] rd, rs1, rs2;
	reg rdst, alusc, memreg, regwr, memwr, br, jmp, exop;
	reg [1:0] fpnt;
	reg [3:0] aluctl;
	reg [4:0] regd, regs, regt;
	
	assign regdst = rdst;
	assign alusrc = alusc;
	assign mem2reg = memreg;
	assign regwrite = regwr;
	assign memwrite = memwr;
	assign branch = br;
	assign jump = jmp;
	assign aluctrl = aluctl;
	assign extop = exop;
	assign fpoint = fpnt;
	assign rd = regd;
	assign rs1 = regs;
	assign rs2 = regt;
	
	always @*
		if (instruction[31:26] == 6'd0 || instruction[31:26] == 6'd1)
		begin
			rdst <= 1'b1;
			alusc <= 1'b0;
			memreg <= 1'b0;
			regwr <= 1'b1;
			memwr <= 1'b0;
			br <= 1'b0;
			jmp <= 1'b0;
			exop <= 1'b0;
			fpnt <= 2'b00;
			regd <= instruction[15:11];
			regs <= instruction[20:16];
			regt <= instruction[25:21];
			case (instruction[10:0])
				//add
				32 : aluctl <= 4'b0011;
				//addu
				33 : aluctl <= 4'b0011;
				//and
				36 : aluctl <= 4'b0000;
				//movfp2i
				52 : begin aluctl <= 4'b0000; fpnt <= 2'b01; end
				//movi2fp
				53 : begin aluctl <= 4'b0000; fpnt <= 2'b10; end
				//mult
				14 : begin aluctl <= 4'b0101; fpnt <= 2'b11; end
				//multu
				22 : begin aluctl <= 4'b0101; fpnt <= 2'b11; end
				//nop
				21 : begin regwr <= 1'b0; aluctl <= 4'b0000; end 
				//or
				37 : aluctl <= 4'b0001;
				//seq
				40 : aluctl <= 4'b0110;
				//sge
				45 : aluctl <= 4'b1000;
				//sgt
				43 : aluctl <= 4'b1001;
				//sle
				44 : aluctl <= 4'b1011;
				//sll
				4 : aluctl <= 4'b1100;
				//slt
				42 : aluctl <= 4'b1010;
				//sne
				41 : aluctl <= 4'b0111;
				//sra
				7 : aluctl <= 4'b1110;
				//srl
				6 : aluctl <= 4'b1101;
				//sub
				34 : aluctl <= 4'b0100;
				//subu
				35 : aluctl <= 4'b0100;
				//xor
				38 : aluctl <= 4'b0010;
				default : aluctl <= 4'b0000;
			endcase
		end
		//j and jal
		else if (instruction[31:26] == 6'd2 || instruction[31:26] == 6'd3)
		begin
			rdst <= 1'b0; alusc <= 1'b0; memreg <= 1'b0; regwr <= 1'b0;
			memwr <= 1'b0; br <= 1'b0; jmp <= 1'b1; exop <= 1'b0; aluctl <= 4'b0000; fpnt <= 2'b00;
			regd <= 5'b00000;
			regs <= 5'b00000;
			regt <= 5'b00000;
		end
		else
		begin
			alusc <= 1'b1; memreg <= 1'b0; regwr <= 1'b1; memwr <= 1'b0; 
			br <= 1'b0; jmp <= 1'b0; exop <= 1'b1; fpnt <= 2'b00;
			regd <= instruction[20:16];
			regs <= instruction[25:21];
			regt <= 5'b00000;
			case (instruction[31:26])
				//addi
				8: begin rdst <= 1'b1; aluctl <= 4'b0011; end
				//addui
				9: begin rdst <= 1'b1; aluctl <= 4'b0011; exop <= 1'b0; end
				//andi
				12: begin rdst <= 1'b1; aluctl <= 4'b0000; exop <= 1'b0; end
				//beqz
				4: begin rdst <= 1'b0; alusc <= 1'b0; regwr <= 1'b0; br <= 1'b1; aluctl <= 4'b0100; exop <= 1'b0; end
				//bnez
				5: begin rdst <= 1'b0; alusc <= 1'b0; regwr <= 1'b0; br <= 1'b1; aluctl <= 4'b0100; exop <= 1'b0; end
				//jalr
				13: begin rdst <= 1'b0; regwr <= 1'b0; jmp <= 1'b1; aluctl <= 4'b0000; exop <= 1'b0; end
				//jr
				12: begin rdst <= 1'b0; regwr <= 1'b0; jmp <= 1'b1; aluctl <= 4'b0000; exop <= 1'b0; end
				//lb
				32: begin rdst <= 1'b0; memreg <= 1'b1; aluctl <= 4'b0000; end
				//lbu
				36: begin rdst <= 1'b0; memreg <= 1'b1; aluctl <= 4'b0000; end
				//lh
				33: begin rdst <= 1'b0; memreg <= 1'b1; aluctl <= 4'b0000; end
				//lhi
				15: begin rdst <= 1'b0; memreg <= 1'b1; aluctl <= 4'b0000; exop <= 1'b0; end
				//lhu
				37: begin rdst <= 1'b0; memreg <= 1'b1; aluctl <= 4'b0000; end
				//lw
				35: begin rdst <= 1'b0; memreg <= 1'b1; aluctl <= 4'b0000; end
				//ori
				14: begin rdst <= 1'b1; aluctl <= 4'b0001; exop <= 1'b0; end
				//sb
				40: begin rdst <= 1'b0; regwr <= 1'b0; memwr <= 1'b1; aluctl <= 4'b0000; end
				//seqi
				24: begin rdst <= 1'b1; aluctl <= 4'b0110; end
				//sgei
				29: begin rdst <= 1'b1; aluctl <= 4'b1000; end
				//sgti
				27: begin rdst <= 1'b1; aluctl <= 4'b1001; end
				//sh
				41: begin rdst <= 1'b0; regwr <= 1'b0; memwr <= 1'b1; aluctl <= 4'b0000; end
				//slei
				28: begin rdst <= 1'b1; aluctl <= 4'b1011; end
				//slli
				20: begin rdst <= 1'b1; aluctl <= 4'b1100; end
				//slti
				26: begin rdst <= 1'b1; aluctl <= 4'b1010; end
				//snei
				25: begin rdst <= 1'b1; aluctl <= 4'b0111; end
				//srai
				23: begin rdst <= 1'b1; aluctl <= 4'b1110; end
				//srli
				22: begin rdst <= 1'b1; aluctl <= 4'b1101; end
				//subi
				10: begin rdst <= 1'b1; aluctl <= 4'b0100; end
				//subui
				11: begin rdst <= 1'b1; aluctl <= 4'b0100; exop <= 1'b0; end
				//sw
				43: begin rdst <= 1'b0; regwr <= 1'b0; memwr <= 1'b1; aluctl <= 4'b0000; end
				//xori
				14: begin rdst <= 1'b1; aluctl <= 4'b0010; exop <= 1'b0; end
			endcase
		end
endmodule
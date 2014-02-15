module mux_4to1_n(src0, src1, src2, src3, sel, z);
	parameter n = 1;
	input [(n-1):0] src0, src1, src2, src3;
	input [1:0] sel;
	output [(n-1):0] z;
	reg [(n-1):0] z_reg;
	//assign z = (sel == 1'b0) ? src0 : src1;
	assign z = z_reg;
	always @(src0, src1, src2, src3, sel[0], sel[1])
	   begin
		case ({sel[1], sel[0]})
		2'b00 : z_reg <= src0;
		2'b01 : z_reg <= src1;
		2'b10 : z_reg <= src2;
		2'b11 : z_reg <= src3;
		//default : z = n'bx;
		endcase
	   end
endmodule


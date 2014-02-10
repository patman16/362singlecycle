module mux_2to1_n(src0, src1, sel, z);
	parameter n = 1;
	input [(n-1):0] src0, src1;
	input sel;
	output [(n-1):0] z;
	
	assign z = (sel == 1'b0) ? src0 : src1;
endmodule

module srl(a, b, result);
	input [31:0] a, b;
	output [31:0] result;
	
	wire [31:0] row2;
	wire [31:0] row3;
	wire [31:0] row4;
	wire [31:0] row5;
	wire zero;
	assign zero = 1'b0;
	
	genvar i;
	generate
		for (i = 0; i < 31; i = i + 1) begin: row1begin
			mux_2to1_n mux_2to1_n(.src0(a[i]), .src1(a[i+1]), .sel(b[0]), .z(row2[i]));
		end
	endgenerate
	mux_2to1_n mux_2to1_n(.src0(a[31]), .src1(zero), .sel(b[0]), .z(row2[31]));
	generate
		for (i = 0; i < 30; i = i + 1) begin: row2begin
			mux_2to1_n mux_2to1_n(.src0(row2[i]), .src1(row2[i+2]), .sel(b[1]), .z(row3[i]));
		end
	endgenerate
	generate
		for (i = 30; i < 32; i = i + 1) begin: row2end
			mux_2to1_n mux_2to1_n(.src0(row2[i]), .src1(zero), .sel(b[1]), .z(row3[i]));
		end
	endgenerate
	generate
		for (i = 0; i < 28; i = i + 1) begin: row3begin
			mux_2to1_n mux_2to1_n(.src0(row3[i]), .src1(row3[i+4]), .sel(b[2]), .z(row4[i]));
		end
	endgenerate
	generate
		for (i = 28; i < 32; i = i + 1) begin: row3end
			mux_2to1_n mux_2to1_n(.src0(row3[i]), .src1(zero), .sel(b[2]), .z(row4[i]));
		end
	endgenerate
	generate
		for (i = 0; i < 24; i = i + 1) begin: row4begin
			mux_2to1_n mux_2to1_n(.src0(row4[i]), .src1(row4[i+8]), .sel(b[3]), .z(row5[i]));
		end
	endgenerate
	generate
		for (i = 24; i < 32; i = i + 1) begin: row4end
			mux_2to1_n mux_2to1_n(.src0(row4[i]), .src1(zero), .sel(b[3]), .z(row5[i]));
		end
	endgenerate
	generate
		for (i = 0; i < 16; i = i + 1) begin: row5begin
			mux_2to1_n mux_2to1_n(.src0(row5[i]), .src1(row5[i+16]), .sel(b[4]), .z(result[i]));
		end
	endgenerate
	generate
		for (i = 16; i < 32; i = i + 1) begin: row5end
			mux_2to1_n mux_2to1_n(.src0(row5[i]), .src1(zero), .sel(b[4]), .z(result[i]));
		end
	endgenerate
endmodule

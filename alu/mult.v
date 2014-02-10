module mult(a, b, result);
	input [31:0] a, b;
	output [31:0] result;
	
	wire [29:0] carryvector [0:29];
	wire [30:0] resultvector [0:30];
	
	genvar i, j, k;
	assign result[0] = a[0] & b[0];
	generate
		for (k = 0; k < 31; k = k + 1) begin: row1
			assign resultvector[0][k] = a[k+1] & b[0];
		end
		for (j = 0; j < 30; j = j + 1) begin: rows
			fulladder first(.a(a[0] & b[j+1]), .b(resultvector[j][0]), .cin(1'b0), .z(result[j+1]), .cout(carryvector[j][0]));
			for (i = 0; i < (30-j)-1; i = i + 1) begin: rowX
				fulladder middle(.a(a[i+1] & b[j+1]), .b(resultvector[j][i+1]), .cin(carryvector[j][i]), .z(resultvector[j+1][i]), .cout(carryvector[j][i+1]));
			end
			fulladder last(.a(a[30-j] & b[j+1]), .b(resultvector[j][30-j]), .cin(carryvector[j][(30-j)-1]), .z(resultvector[j+1][(30-j)-1]));
		end
	endgenerate
	fulladder finalbit(.a(a[0] & b[31]), .b(resultvector[30][0]), .cin(1'b0), .z(result[31]));
endmodule

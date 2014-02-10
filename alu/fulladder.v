module fulladder(a, b, cin, z, cout);
	input a, b, cin;
	output z, cout;
	
	assign z = a ^ b ^ cin;
	assign cout = (a & b) ^ (cin & (a ^ b));
endmodule

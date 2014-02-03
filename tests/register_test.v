module testbench;
        reg clk, write, regdst, fpoint;
	reg [4:0] rd, rs, rt;
	reg [31:0] busW;
	wire [31:0] busA, busB;
		
	registers regs(clk, write, regdst, fpoint, rd, rs, rt, busW, busA, busB);

	always #1 clk = ~clk;

        initial	begin
		clk = 1;
		write = 1;
		regdst = 1;	
		fpoint = 0;

		//write 1 to integer register 1
		rd = 1;
		rs = 0;
		rt = 0;
		busW = 1;
	end
		
	initial begin
		$monitor("write = %b fpoint = %b busA = %d busB = %d", write, fpoint, busA, busB);
		//read integer register 1 on both buses
		#2 write = 0; rs = 1; rt = 1;
		//write 2 to integer register 2
		#2 write = 1; rd = 2; busW = 2;
		//read integer register 2 on bus B, register 1 on bus A
		#2 write = 0; rt = 2;
		$finish;
        end
endmodule

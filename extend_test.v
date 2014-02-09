module testbench;
        reg [15:0] A;
        reg SELECT;
        wire [31:0] OUT;


        extender EXTEND(.a(A), .sel(SELECT), .out(OUT));

        initial begin
        $monitor("A = %b SELECT = %b OUT = %b", A, SELECT, OUT);
        #0 A = 16'b0000000000000001; SELECT = 1'b1;
        #1 A = 16'b1111111111111111; SELECT = 1'b1;
        #1 A = 16'b0000000000000001; SELECT = 1'b0;
        #1 A = 16'b1111111111111111; SELECT = 1'b0;
        #1 A = 16'b1010101010101010; SELECT = 1'b1;
        #1 A = 16'b1010101010101010; SELECT = 1'b0;
        #1 A = 16'b0111100011010110; SELECT = 1'b0;
        #1 A = 16'b0111100011010110; SELECT = 1'b1;
        end
endmodule
~           
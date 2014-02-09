module testbench;
        reg [15:0] A;
        wire [31:0] OUT;


        extender EXTEND(.a(A), .z(OUT));

        initial begin
        $monitor("A = %b OUT = %b", A, OUT);
        #0 A = 16'b0000000000000001;
        #1 A = 16'b1111111111111111;
        #1 A = 16'b0000000000000001;
        #1 A = 16'b1111111111111111;
        #1 A = 16'b1010101010101010;
        #1 A = 16'b1010101010101010;
        #1 A = 16'b0111100011010110;
        #1 A = 16'b0111100011010110;
        end
endmodule    

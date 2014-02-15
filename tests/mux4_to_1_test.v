module mux4to1test();
      parameter N = 32;
      reg[1:0] SEL;
      reg[N-1:0] A, B, C, D;
      wire[N-1:0] OUT;
      
      mux_4to1_n #(.n(32)) TEST(.src0(A), .src1(B), .src2(C), .src3(D), .sel(SEL), .z(OUT));

 
       initial begin
	  $monitor("A = %x B = %x C = %x D = %x SEL = %b OUT=%x", A, B, C, D, SEL, OUT);
	  #0 A = 32'h1234; B = 32'h4567; C = 32'h98785; D = 32'h1111; SEL = 2'b00; 
	  #1 A = 32'h1234; B = 32'h4567; C = 32'h98785; D = 32'h1111; SEL = 2'b01; 
	  #1 A = 32'h1234; B = 32'h4567; C = 32'h98785; D = 32'h1111; SEL = 2'b10; 
	  #1 A = 32'h1234; B = 32'h4567; C = 32'h98785; D = 32'h1111; SEL = 2'b11; 
	end
      

endmodule
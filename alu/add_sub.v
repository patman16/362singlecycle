module adder_32(a, b, cin, sum, cout);
   parameter N = 32;
   input cin;
   input [N-1:0] a, b;
   output [N-1:0] sum;
   output cout;
   wire [N:0] carry;
   
   assign carry[0] = cin;
   assign cout = carry[N]; 
   generate
   genvar i;
   for (i = 0; i < N; i = i+1)
       begin : uF
       fulladder FULL_ADDER (a[i], b[i], carry[i], sum[i], carry[i+1]);
   end
   endgenerate

endmodule

module add_sub_32(a, b, sel, cin, sum, cout);
  parameter N = 32;
  input [N-1:0] a, b;
  input cin, sel;
  output [N-1:0] sum;
  output cout;
  wire [N-1:0] input_b;

  generate
  genvar i;
  for (i = 0; i < N; i = i+1)
      begin : uF
      xor (input_b[i],b[i],sel); 
  end
  endgenerate

  adder_32 THE_ADDER (a, input_b, sel, sum, cout);
  
endmodule


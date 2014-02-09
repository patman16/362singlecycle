module fa_IFU(a, b, cin, sum, cout);
   input a, b, cin;
   output sum, cout;

   assign sum = a ^ b ^ cin;
   assign cout = (a&b)^(cin&(a^b));
endmodule

module adder_IFU(a, b, cin, sum, cout);
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
       fa_IFU FULL_ADDER (a[i], b[i], carry[i], sum[i], carry[i+1]);
   end
   endgenerate

endmodule

module PCReg(out, in, clk, rst); 
   parameter width = 32, init = 0;
   output [0:width-1] out;
   reg [0:width-1]    out;
   input [0:width-1]  in;
   input 	      clk, rst;

   always @ (posedge clk or negedge rst)
     if (~rst)
       out <= init;
     else
       out <= in;
   
endmodule // PipeReg

module mux_2to1_n(src0, src1, sel, z);
parameter n = 1;
input [(n-1):0] src0, src1;
input sel;
output [(n-1):0] z;

assign z = (sel == 1'b0) ? src0 : src1;
endmodule

module ifu(branch, zero, jump, clock, start, instruction);

    input branch, zero, jump, clock, start;	
    output [31:0] instruction;
    reg [31:0] four;
    wire mux0control, open1, open2;
    wire [31:0] adder0, adder1, mux0, mux1, jumpmux, pcout, extend, address, test; 
    

    adder_IFU #(.N(32)) adder0_map (pcout, four, 1'b0, adder0, open1);
    adder_IFU #(.N(32)) adder1_map (adder0, extend, 1'b0, adder1, open2);
    and (mux0control, branch, zero); 
    mux_2to1_n #(.n(32)) mux0_map (adder0, adder1, mux0control, mux0);
    mux_2to1_n #(.n(32)) mux1_map (mux0, jumpmux, jump, mux1);
    PCReg #(.width(32)) PC (pcout, mux1, clock, start);
    imem #(.SIZE(1024), .IMEMFILE("instr.hex")) INSTR_MEM (pcout, test);
    extender EXT (test[15:0], extend);
    

    assign jumpmux[31:26] = pcout[31:26];
    assign jumpmux[25:0] = test[25:0];
    
    assign instruction = test;


    initial begin
	four = 32'h00000004;
    end

endmodule



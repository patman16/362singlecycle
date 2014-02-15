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
   output [width-1:0] out;
   reg [width-1:0]    out;
   input [width-1:0]  in;
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
    output [31:0] address, test, instruction;
    reg [29:0] one;
    wire mux0control, open1, open2, zero_ctrl;
    wire [29:0] adder0, adder1, mux0, mux1, jumpmux, pcout, extend; 
   
    adder_IFU #(.N(30)) adder0_map (pcout, one, 1'b0, adder0, open1);
    adder_IFU #(.N(30)) adder1_map (adder0, extend, 1'b0, adder1, open2);
    and (mux0control, branch, zero_ctrl); 
    mux_2to1_n #(.n(30)) mux0_map (adder0, adder1, mux0control, mux0);
    mux_2to1_n #(.n(30)) mux1_map (mux0, jumpmux, jump, mux1);
    PCReg #(.width(30)) PC (pcout, mux1, clock, start);
    imem #(.SIZE(1024)) IMEM (address, test);
    extender #(.inN(16), .outN(30) ) EXT (test[15:0], 1'b1, extend);
    
    mux_2to1_n #(.n(1)) branch_ctrl (zero,~zero, instruction[26], zero_ctrl);

    assign address[31:2] = pcout;
    assign address[1:0] = 2'b00;
    assign jumpmux[29:26] = pcout[29:26];
    assign jumpmux[25:0] = test[25:0];
    assign instruction = test;


    initial begin
	one = 30'b000000000000000000000000000001;
    end

endmodule

//Try:
//PC Register
//Does extender do it correct way?

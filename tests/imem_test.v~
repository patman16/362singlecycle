module itest();
    reg [0:31] iaddr;
    wire [0:31] instr;

     imem #(.SIZE(1024), .IMEMFILE("instr.hex")) IMEM(.addr(iaddr), .instr(instr));

     // Read out some values. Note clock ticks between setting values
     // & reading values in tests.
     // - First two instructions
    
initial begin
    iaddr = 32'h0;
        #1
        $display("Instr [%x] = %x", iaddr, instr);
        iaddr = 32'h4;
        #1
        $display("Instr [%x] = %x", iaddr, instr);
end

endmodule
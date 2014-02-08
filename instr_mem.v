module imem(addr, instr);
    parameter SIZE=4096;
    parameter OFFSET=0;
    parameter IMEMFILE = "instr.hex";

    input [0:31] addr;
    output [0:31] instr;
    reg [0:7] mem[0:(SIZE-1)];
    reg [8*80-1:0] filename;

    wire [0:31] phys_addr;

    assign phys_addr = addr - OFFSET;
    assign instr = {mem[phys_addr],mem[phys_addr+1],mem[phys_addr+2],mem[phys_addr+3]};

    //USED TO LOAD INSTRUCTION FILE
    initial begin
    
        // Load IMEM from file
        if (!$value$plusargs("instrfile=%s", filename)) begin
            filename = IMEMFILE;
        end
        $readmemh(filename, IMEM.mem);
        
      end

endmodule // imem
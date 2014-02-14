// Test module. Loads data files
module mem_testbench();
    parameter IMEMFILE = "instr.hex";
    parameter DMEMFILE = "data.hex";
    reg [8*80-1:0] filename;
    reg [0:31] iaddr, daddr, dwdata;
    wire [0:31] instr, drdata;
    reg dwrite;
    reg [0:1] dsize;
    reg clk;

    integer dfileobj, dmaddr, r, k, i;

    imem #(.SIZE(1024)) IMEM(.addr(iaddr), .instr(instr));
    dmem #(.SIZE(16384)) DMEM(.addr(daddr), .rData(drdata), .wData(dwdata), .writeEnable(dwrite), .dsize(dsize), .clk(clk));

    initial begin
        // Clear DMEM
        for (i = 0; i < DMEM.SIZE; i = i+1)
            DMEM.mem[i] = 8'h0;

        // Load IMEM from file
        if (!$value$plusargs("instrfile=%s", filename)) begin
            filename = IMEMFILE;
        end
        $readmemh(filename, IMEM.mem);
        // Load DMEM from file
        if (!$value$plusargs("datafile=%s", filename)) begin
            filename = DMEMFILE;
        end
        $readmemh(filename, DMEM.mem);

        //// Debug: dump memory
        //$writememh("imem", IMEM.mem);
        //$writememh("dmem", DMEM.mem);

        // Read out some values. Note clock ticks between setting values
        // & reading values in tests.
        // - First two instructions
        iaddr = 32'h0;
        #1
        $display("Instr [%x] = %x", iaddr, instr);
        iaddr = 32'h4;
        #1
        $display("Instr [%x] = %x", iaddr, instr);
        // - Some Data values
        // 'monitor' follows signals automatically as they change
        $monitor("addr= %x data = %x", daddr, drdata);
        daddr = 32'h2000;
        #1
        daddr = 32'h2001;
    end // initial
endmodule

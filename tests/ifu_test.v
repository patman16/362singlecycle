module IFU_test();
    parameter IMEMFILE = "instr.hex";
    parameter DMEMFILE = "data.hex";
    reg [8*80-1:0] filename;

    reg CLK, START, BRANCH, ZERO, JUMP;
    wire[31:0] INSTRUCTION;
  
    ifu IFU (.branch(BRANCH), .zero(ZERO), .jump(JUMP), .clock(CLK), .start(START), .instruction(INSTRUCTION) );

  initial begin

        // Load IMEM from file
        if (!$value$plusargs("instrfile=%s", filename)) begin
            filename = IMEMFILE;
        end
        $readmemh(filename, IFU.IMEM.mem);
       
    //Set control Signals
    #1
    START = 1'b0; //Initial reset
    #1
    START = 1'b1;
    BRANCH = 1'b0;
    ZERO = 1'b0;
    JUMP = 1'b0;
    CLK = 1'b0;
    #1
    $display("Instr [%x] = %x", IFU.address, INSTRUCTION);
    #1
    CLK = 1'b1;
    #1
    CLK = 1'b0;
    #1
    $display("Instr [%x] = %x", IFU.address, INSTRUCTION);
    #1
    CLK = 1'b1;
    #1
    CLK = 1'b0;
    #1
    $display("Instr [%x] = %x", IFU.address, INSTRUCTION);
    #1
    CLK = 1'b1;
    #1
    CLK = 1'b0;
    #1
    $display("Instr [%x] = %x", IFU.address, INSTRUCTION);
    #1
    CLK = 1'b1;
    #1
    CLK = 1'b0;
    
    
    
   
    
  end
    
endmodule


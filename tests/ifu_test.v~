module IFU_test();
    reg CLK, START, BRANCH, ZERO, JUMP;
    wire[31:0] INSTRUCTION;
  
    ifu IFU (.branch(BRANCH), .zero(ZERO), .jump(JUMP), .clock(CLK), .start(START), .instruction(INSTRUCTION) );

  initial begin
    BRANCH = 1'b0;
    ZERO = 1'b0;
    JUMP = 1'b0;

    $monitor("CLK = %d INSTRUCTION =%x", CLK, INSTRUCTION);
    #0 CLK = 1'b1;
    #1 CLK = 1'b0;
    #1 CLK = 1'b1;
    #1 CLK = 1'b0;
  end
    


endmodule


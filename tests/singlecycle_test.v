//  Testbench for the very top... the whole dang thing

module single_cycle_tb;
reg clock;
reg reset;
reg [8*80-1:0] filename;
wire [0:31] PC;

singlecycle top (.clock(clock),.reset(reset));

//assign PC = {top.IFU.PCReg.out,2'b00};

always begin
   #1 clock = ~clock;
end

integer i;
initial begin
  // Clear DMEM
   for (i = 0; i < top.DMEM.SIZE; i = i+1)
      top.DMEM.mem[i] = 8'h0;

  //Load IMEM from file
   if (!$value$plusargs("instrfile=%s", filename)) begin
      filename = "instr_unsignedsum.hex";
   end
   $readmemh(filename, top.IFU.IMEM.mem);
  // Load DMEM from file
  if (!$value$plusargs("datafile=%s", filename)) begin
      filename = "data_unsignedsum.hex";
  end
  $readmemh(filename, top.DMEM.mem);

   //$monitor("Instruction = %h  PC = %h\n\tIFU\n\t\tTarget = %h\n\t\ttakeBranch = %b\n\t\tjType = %b\n\t\treset = %b\n\t\tregJump = %b\n\t\tlinkTarget = %h\n\tDECODER\n\t\trs1 = %d\n\t\trs2 = %d\n\t\trd = %d\n\t\timmediate = %h\n\t\talu_signals = %b\n\t\tmem_size = %b\n\t\tmem_write = %b\n\t\tmem_ext = %b\n\t\treg_write = %b\n\t\tbranch_instr = %b\n\t\tjump_instr = %b\n\t\treg_data = %b\n\t\tI_type = %b\n\t\tbne = %b\n\t\tbeq = %b\n\t\tlink = %b\n\tREGISTERS\n\t\treg_data_in = %h\n\t\twrite_en = %b\n\t\taddr1 = %d\n\t\taddr2 = %d\n\t\twraddr = %d\n\t\tregA = %h\n\t\tregB = %h\n\tALU\n\t\tA = (HEX)%h   (DEC)%d\n\t\tB = (HEX)%h    (DEC)%d\n\t\talu_controls = %b\n\t\tzero = %b\n\t\talu_out = (HEX)%h    (DEC)%d\n\tDATA_MEMORY\n\t\taddr = %h\n\t\twData = %h\n\t\twriteEnable = %b\n\t\tdsize = %b\n\t\tmem_ext = %b\n\t\tdata_mem_out = %h\n\n",top.instr,PC,top.regA[0:29],top.takeBranch,top.jType,top.reset,top.regJump,top.linkTarget,top.rs1,top.rs2,top.rd,top.immediate,top.alu_signals,top.mem_size,top.mem_write,top.mem_ext,top.xreg_write,top.branch_instr,top.jump_instr,top.reg_data,top.I_type,top.bne,top.beq,top.link,top.reg_data_in,top.reg_write,top.rs1,top.rs2,top.rd,top.regA,top.regB,top.regA,top.regA,top.b_input,top.b_input,top.alu_signals,top.zero,top.alu_out,top.alu_out,top.alu_out,top.regB,top.mem_write,top.mem_size,top.mem_ext,top.data_mem_out);
   $monitor("Instruction = %h PC =  %h Target = %h Branch = %d Jump = %d\n\tRegb = %d ALUa = %d ALUb = %d ALUctrl = %b ALUout = %d busW = %d Rd = %d Rs1 = %d Rs2 = %d\n\tregdst = %b alusrc = %b mem2reg = %b regwrite = %b memwrite = %d extop = %b loadext = %b fpoint = %b dsize = %b jal = %b jar = %b", top.instruction, top.IFU.pcout, top.IFU.mux1, top.branch, top.jump, top.busB, top.busA, top.mux0_out,top.aluctrl, top.alu_out, top.busW, top.rd, top.rs1, top.rs2,top.regdst, top.alusrc, top.mem2reg, top.regwrite, top.memwrite, top.extop, top.loadext, top.fpoint, top.dsize, top.jal, top.jar);  

   #0 clock=1; reset=0;
   #2 reset=1;

   #50000
   $finish;
end

always @(top.instruction) begin
   //This checks for a trap 0x300 (signifying the end of the file)
   if (top.instruction == 32'h44000300)
   begin
   for (i = 8192; i < 8232; i = i + 4)
   $display("Mem[%d] = %d", i, {top.DMEM.mem[i], top.DMEM.mem[i+1], top.DMEM.mem[i+2], top.DMEM.mem[i+3]});
   $finish;
   end
end
endmodule

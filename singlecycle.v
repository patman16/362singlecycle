module singlecycle (clock, reset);

    input clock, reset;
    
    wire[31:0] instruction, busW, busA, busB, ext_out, mux0_out, mux1_out, alu_out, datamem_muxout, datamem_muxin, mux2_in0, mux2_in1, mux3_in0, mux3_in1, rData;
    wire[29:0] delayslot2;
    wire regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, extop, zero, loadext, jal, jar;
    wire [1:0] fpoint, dsize;
    wire [3:0] aluctrl;
    wire [4:0] rd, rs1, rs2;
    
    control CTRL (instruction, regdst, alusrc, mem2reg, regwrite, memwrite, branch, jump, aluctrl, extop, fpoint, rd, rs1, rs2, dsize, loadext, jal, jar);

    //branch, zero, jump signals defined by control logic unit
    ifu IFU (branch, zero, jump, clock, reset, jar, busA[31:2], instruction, delayslot2);
    extender EXT0 (instruction[15:0],extop, ext_out);
    mux_2to1_n #(.n(32)) MUX0(busB, ext_out, alusrc, mux0_out);
    registers REGFILE(clock, regwrite, regdst, fpoint, rd, rs1, rs2, busW, busA, busB);
    alu ALU(busA, mux0_out, aluctrl, alu_out, zero);
    mux_2to1_n #(.n(32)) MUX1(alu_out, datamem_muxout, mem2reg, mux1_out);
    mux_2to1_n #(.n(32)) MUX4(mux1_out, {delayslot2, 2'b00}, jal, busW);

    //Need control signals for dmem
    dmem #(.SIZE(16384)) DMEM(alu_out, rData, datamem_muxin, memwrite, dsize, clock);

    extender #(.inN(16), .outN(32)) EXT1(rData[15:0],loadext,mux2_in1);
    extender #(.inN(8), .outN(32)) EXT2(rData[7:0],loadext,mux2_in0); 
    mux_4to1_n #(.n(32)) MUX2(mux2_in0, mux2_in1, 32'd0, rData, dsize, datamem_muxout);
     
//Before Data 
    extender #(.inN(16), .outN(32)) EXT3(busB[15:0],1'b0, mux3_in1);
    extender #(.inN(8), .outN(32)) EXT4(busB [7:0],1'b0, mux3_in0); 
    mux_4to1_n #(.n(32)) MUX3(mux3_in0, mux3_in1, 32'd0, busB, dsize, datamem_muxin);

endmodule

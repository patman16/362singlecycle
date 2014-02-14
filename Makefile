IVERILOG = /vol/eecs362/iverilog/bin/iverilog

register_test: ; ${IVERILOG} registers.v tests/register_test.v -o tests/register_test
extender_test: ; ${IVERILOG} extender.v tests/extender_test.v -o tests/extender_test
mem_test: ;  ${IVERILOG} instr_mem.v data_mem.v tests/mem_test.v -o tests/mem_test
ifu_test: ;  ${IVERILOG} instr_mem.v extender.v ifu.v tests/ifu_test.v -o tests/ifu_test
alu_test: ; ${IVERILOG} alu/2to1_mux_n.v alu/fulladder.v alu/add_sub.v alu/mult.v alu/sets.v alu/sll.v alu/srl.v alu/sra.v alu.v tests/alu_test.v -o tests/alu_test

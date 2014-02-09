IVERILOG = /vol/eecs362/iverilog/bin/iverilog

register_test: ; ${IVERILOG} registers.v tests/register_test.v -o tests/register_test
extender_test: ; ${IVERILOG} extender.v tests/extender_test.v -o tests/extender_test
imem_test: ;  ${IVERILOG} instr_mem.v tests/imem_test.v -o tests/imem_test
dmem_test: ;  ${IVERILOG} data_mem.v tests/dmem_test.v -o tests/dmem_test
ifu_test: ;  ${IVERILOG} ifu.v tests/ifu_test.v -o tests/ifu_test
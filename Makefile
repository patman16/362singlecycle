IVERILOG = /vol/eecs362/iverilog/bin/iverilog

register_test: ; ${IVERILOG} registers.v tests/register_test.v -o tests/register_test
imem_test: ;  ${IVERILOG} instr_mem.v tests/imem_test.v -o tests/imem_test
dmem_test: ;  ${IVERILOG} data_mem.v tests/dmem_test.v -o tests/dmem_test

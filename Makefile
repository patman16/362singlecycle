IVERILOG = /vol/eecs362/iverilog/bin/iverilog

register_test: ; ${IVERILOG} registers.v tests/register_test.v -o tests/register_test

# Cocotb examples

[Cocotb](https://github.com/potentialventures/cocotb) is a Python based cosimulation testbench environment for verifying VHDL/Verilog that uses GHDL/iverilog as backends.

- install cocotb and set COCOTB environmental variable
- run `make` from `cocotb/` directory
- all models are under `cocotb/model/` directory
- all tests are under `cocotb/tests/` directory

additionally

- `make COCOTB_REDUCED_LOG_FMT=1` for reduced log lines
- `make TOPLEVEL=full_adder MODULE=test_full_adder` for changing tests


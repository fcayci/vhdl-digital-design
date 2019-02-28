# vhdl-digital-design
VHDL examples for a digital design course.

- install *ghdl* and *gtkwave* and add them
to the *PATH*.
- run `make` to syntax check and analyze all the designs
- run `make simulate ARCHNAME=tbname` to run the given testbench where `tbname` is any of the testbench names inside the [sim](sim/) directory
- run `make waveform ARCHNAME=tbname` to display the given testbench run waveform using *gtkwave*

# vhdl-digital-design

VHDL circuit examples for digital design course.

## Folders

```
rtl/  - circuits
tb/   - testbenches for some of the circuits
test/ - cocotb support for simulation
```

## Usage

- All the files under `rtl/` and `tb/` can be imported in your synthesis tool (e.g Vivado).
- Optionally, you can use [GHDL](http://ghdl.free.fr) which is a cross-platform open-source simulator for VHDL language.
- Simulated results can be seen using [GTKWave](http://gtkwave.sourceforge.net/) which is an open source waveform viewer.
- Install *GHDL* and *GTKWave* and add them to your `PATH`
- run `make` on the root folder to check syntax and analyze all designs

example:

```bash
$ make
>>> check syntax on all designs...
>>> analyzing designs...
>>> completed...
```

- run `make simulate ARCHNAME=tbname` to run the given testbench and display waveform using *GTKWave* where `tbname` is any of the testbench names inside the [tb](tb/) directory.

example:

```bash
$ make simulate ARCHNAME=tb_counter
>>> cleaning design...
>>> done...
>>> analyzing designs...
>>> simulating design: tb/tb_counter.vhd
tb/tb_counter.vhd:43:9:@510ns:(assertion note): completed
>>> showing waveform for: tb/tb_counter.vhd

GTKWave Analyzer v3.3.94 (w)1999-2018 BSI
...
```

- `100us` stop time is given for simulation by default. Optional `STOPTIME=` arg can be passed to makefile to change this value.

example:

```bash
make simulate ARCHNAME=tb_counter STOPTIME=1ms
```

## Cocotb Support

- [Cocotb](https://github.com/cocotb/cocotb) is a *co-simulation library* for writing VHDL and Verilog testbenches in Python.
- Github page gives information about installation.
- `test/` directory has a couple models and examples along with a *makefile* to run tests. Although you might need to play with the *makefile* to get it working, especially cocotb installation location.

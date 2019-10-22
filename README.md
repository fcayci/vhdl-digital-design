# vhdl-digital-design
---

VHDL circuit examples for digital design course.

- [GHDL](http://ghdl.free.fr) can be used for simulation
- [GTKWave](http://gtkwave.sourceforge.net/) for displaying the waveforms

## Folders
```
rtl/  - circuits
tb/   - testbenches for some of the circuits
test/ - (optional) cocotb support for simulation
```

- install *GHDL* and *GTKWave* and add both to `PATH` 
- run `make` to syntax check and analyze all the designs

```bash
$ make
>>> check syntax on all designs...
>>> analyzing designs...
>>> completed...
```

- run `make simulate ARCHNAME=tbname` to run the given testbench, and display waveform where `tbname` is any of the testbench names inside the [tb](tb/) directory

```bash
$ make simulate ARCHNAME=tb_counter
>>> cleaning design...
>>> done...
>>> analyzing designs...
>>> simulating design: tb/tb_counter.vhd
tb/tb_counter.vhd:43:9:@510ns:(assertion note): completed
showing the waveform for: tb/tb_counter.vhd

GTKWave Analyzer v3.3.94 (w)1999-2018 BSI

[0] start time.
[510000000] end time.
```


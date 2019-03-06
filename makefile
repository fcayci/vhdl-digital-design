# author: Furkan Cayci, 2019
# description:
#   add ghdl to your PATH for simulation
#   add gtkwave to your PATH for displayin the waveform

CC = ghdl
SIM = gtkwave
ARCHNAME?=tb_half_adder
STOPTIME = 100ms

#SRCS = $(wildcard rtl/*.vhd)
#SRCS += $(wildcard impl/*.vhd)

# added one at a time for keeping the compile order
VHDL_SOURCES += rtl/half_adder.vhd
VHDL_SOURCES += rtl/full_adder.vhd
VHDL_SOURCES += rtl/adder4.vhd
VHDL_SOURCES += rtl/addsub4.vhd
VHDL_SOURCES += rtl/counter.vhd
VHDL_SOURCES += rtl/fifo_async.vhd
VHDL_SOURCES += rtl/fifo_sync.vhd
VHDL_SOURCES += rtl/fsm.vhd
VHDL_SOURCES += rtl/hamming.vhd
VHDL_SOURCES += rtl/rgb2grey.vhd

TBS = $(wildcard tb/tb_*.vhd)
TB = tb/$(ARCHNAME).vhd
WORKDIR = debug

CFLAGS += --std=08 # enable ieee 2008 standard

.PHONY: all
all: check analyze
	@echo "completed..."

.PHONY: check
check:
	@echo "syntax check on all designs..."
	@$(CC) -s $(CFLAGS) $(VHDL_SOURCES) $(TBS)

.PHONY: analyze
analyze:
	@echo "analyzing designs..."
	@mkdir -p $(WORKDIR)
	@$(CC) -a $(CFLAGS) --workdir=$(WORKDIR) $(VHDL_SOURCES) $(TBS)

.PHONY: simulate
simulate: clean analyze
	@echo "simulating design:" $(TB)
	@$(CC) --elab-run $(CFLAGS) --workdir=$(WORKDIR) -o $(WORKDIR)/$(ARCHNAME).bin $(ARCHNAME) --vcd=$(WORKDIR)/$(ARCHNAME).vcd --stop-time=$(STOPTIME)

.PHONY: waveform
waveform: simulate
	@echo "showing the waveform for:" $(TB)
	@$(SIM) $(WORKDIR)/$(ARCHNAME).vcd

.PHONY: clean
clean:
	@echo "cleaning design..."
	@ghdl --remove --workdir=$(WORKDIR)
	@rm -f $(WORKDIR)/*
	@rm -rf $(WORKDIR)

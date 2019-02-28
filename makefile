# author: Furkan Cayci, 2019
# description:
#   add ghdl to your PATH for simulation
#   add gtkwave to your PATH for displayin the waveform

CC = ghdl
SIM = gtkwave
ARCHNAME?=tb_half_adder
STOPTIME = 100ms

SRCS = $(wildcard rtl/*.vhd)
#SRCS += $(wildcard impl/*.vhd)
TBS = $(wildcard sim/tb_*.vhd)
TB = sim/$(ARCHNAME).vhd
WORKDIR = debug

OBJS = $(patsubst sim/%.vhd, %.bin, $(TBS))

.PHONY: all
all: check analyze
	@echo "completed..."

.PHONY: check
check:
	@echo "syntax check on all designs..."
	@$(CC) -s $(SRCS) $(TBS)

.PHONY: analyze
analyze:
	@echo "analyzing designs..."
	@mkdir -p $(WORKDIR)
	@$(CC) -a --workdir=$(WORKDIR) $(SRCS) $(TBS)

.PHONY: simulate
simulate: clean analyze
	@echo "simulating design:" $(TB)
	@$(CC) --elab-run --workdir=$(WORKDIR) -o $(WORKDIR)/$(ARCHNAME).bin $(ARCHNAME) --vcd=$(WORKDIR)/$(ARCHNAME).vcd --stop-time=$(STOPTIME)

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

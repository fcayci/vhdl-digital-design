TOPLEVEL_LANG = vhdl
SIM = ghdl

TOPLEVEL := addsub4
MODULE   := test_addsub4

# add sources here. order is important
VHDL_SOURCES += $(WPWD)/../rtl/half_adder.vhd
VHDL_SOURCES += $(WPWD)/../rtl/full_adder.vhd
VHDL_SOURCES += $(WPWD)/../rtl/adder4.vhd
VHDL_SOURCES += $(WPWD)/../rtl/addsub4.vhd

PWD=$(shell pwd)
COCOTB=../../tools/cocotb

ifeq ($(OS),Msys)
WPWD=$(shell sh -c 'pwd -W')
PYTHONPATH := $(WPWD)/model;$(PYTHONPATH)
else
WPWD=$(shell pwd)
PYTHONPATH := $(WPWD)/model:$(PYTHONPATH)
endif

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim

clean::
	@rm -f *.pyc
	@rm -f model/*.pyc

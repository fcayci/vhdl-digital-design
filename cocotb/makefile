# install cocotb and set COCOTB environmental variable
# eg. COCOTB=../../tools/cocotb
#
TOPLEVEL_LANG = vhdl
SIM = ghdl

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim

ifeq ($(OS),Msys)
  export USER_DIR:=$(shell sh -c 'pwd -W')
  WPWD=$(shell sh -c 'pwd -W')
  PYTHONPATH := $(WPWD)/model;$(WPWD)/tests;$(PYTHONPATH)
else
  export USER_DIR:=$(shell pwd)
  WPWD=$(shell pwd)
  PYTHONPATH := $(WPWD)/model:$(WPWD)/tests:$(PYTHONPATH)
endif

# add sources here. order is important
VHDL_SOURCES += $(WPWD)/../rtl/half_adder.vhd
VHDL_SOURCES += $(WPWD)/../rtl/full_adder.vhd
VHDL_SOURCES += $(WPWD)/../rtl/adder4.vhd
VHDL_SOURCES += $(WPWD)/../rtl/addsub4.vhd

TOPLEVEL := addsub4
MODULE   := test_addsub4


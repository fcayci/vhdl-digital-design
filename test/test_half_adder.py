# Test for half adder module
import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure
from adders import half_adder_model
import random

@cocotb.test()
def half_adder_simple(dut):
	"""
	half adder simple test
	calculates 1 + 0
	"""
	yield Timer(2)
	x = 1
	y = 0
	dut.x = x
	dut.y = y
	yield Timer(2)

	# run model and get the results
	s, c = half_adder_model(x, y)

	if dut.s != s:
		x = "incorrect result for sum: {} != {}".format(dut.s, int(s))
		raise TestFailure(x)
	elif dut.c != c:
		x = "incorrect result for carry: {} != {}".format(dut.c, int(c))
		raise TestFailure(x)
	else:
		dut._log.info("passed!")


@cocotb.test()
def half_adder_randomized(dut):
	"""
	half adder randomized test
	test for 10 random inputs for x/y
	"""
	yield Timer(2)

	for i in range(10):
		x = random.randint(0, 1)
		y = random.randint(0, 1)
		dut.x = x
		dut.y = y
		yield Timer(2)

		# run model and get the results
		s, c = half_adder_model(x, y)

		if dut.s != s:
			x = "incorrect result for sum: {} != {}".format(dut.s, int(s))
			raise TestFailure(x)
		elif dut.c != c:
			x = "incorrect result for carry: {} != {}".format(dut.c, int(c))
			raise TestFailure(x)
		else:
			dut._log.info("passed!")

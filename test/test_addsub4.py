# Test for addsub4 module
import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure
from adders import addsub4_model
import random

@cocotb.test()
def addsub4_simple(dut):
    """
    addsub4 simple test
    calculates 13 - 4
    """
    yield Timer(2)
    a = 13
    b = 4
    m = 1
    dut.a = a
    dut.b = b
    dut.m = m
    yield Timer(2)

    # run model and get the results
    s, cout, v = addsub4_model(a, b, m)

    if dut.s != s:
        x = "incorrect result for sum: {} != {}".format(dut.s, int(s))
        raise TestFailure(x)
    elif dut.cout != cout:
        x = "incorrect result for carry: {} != {}".format(dut.cout, int(cout))
        raise TestFailure(x)
    else:
        dut._log.info("passed!")


@cocotb.test()
def addsub4_randomized(dut):
    """
    addsub4 randomized test
    test for 100 random inputs for a/b/m
    """
    yield Timer(2)

    for _ in range(100):
        a = random.randint(0, 15)
        b = random.randint(0, 15)
        m = random.randint(0, 1)
        dut.a = a
        dut.b = b
        dut.m = m
        yield Timer(2)

        # run model and get the results
        s, cout, v = addsub4_model(a, b, m)

        if dut.s != s:
            x = "incorrect result for sum: {} != {}, a = {}, b = {}, m = {}".format(dut.s, int(s), a, b, m)
            raise TestFailure(x)
        elif dut.cout != cout:
            x = "incorrect result for carry: {} != {}, a = {}, b = {}, m = {}".format(dut.cout, int(cout), a, b, m)
            raise TestFailure(x)
        else:
            dut._log.info("passed!")

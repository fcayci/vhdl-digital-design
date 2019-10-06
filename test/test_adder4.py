# Test for adder4 module
import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure
from adders import adder4_model
import random

@cocotb.test()
def adder4_simple(dut):
    """
    adder4 simple test
    calculates 13 + 4 + 1
    """
    yield Timer(2)
    a = 13
    b = 4
    cin = 1
    dut.a = a
    dut.b = b
    dut.cin = cin
    yield Timer(2)

    # run model and get the results
    s, cout, v = adder4_model(a, b, cin)

    if dut.s != s:
        x = "incorrect result for sum: {} != {}".format(dut.s, int(s))
        raise TestFailure(x)
    elif dut.v != v:
        x = "incorrect result for overflow: {} != {}".format(dut.v, int(v))
        raise TestFailure(x)
    elif dut.cout != cout:
        x = "incorrect result for carry: {} != {}".format(dut.cout, int(cout))
        raise TestFailure(x)
    else:
        dut._log.info("passed!")


@cocotb.test()
def adder4_randomized(dut):
    """
    adder4 randomized test
    test for 100 random inputs for a/b/cin
    """
    yield Timer(2)

    for _ in range(100):
        a = random.randint(0, 15)
        b = random.randint(0, 15)
        cin = random.randint(0, 1)
        dut.a = a
        dut.b = b
        dut.cin = cin
        yield Timer(2)

        # run model and get the results
        s, cout, v = adder4_model(a, b, cin)

        if dut.s != s:
            x = "incorrect result for sum: {} != {}".format(dut.s, int(s))
            raise TestFailure(x)
        elif dut.v != v:
            x = "incorrect result for overflow: {} != {}".format(dut.v, int(v))
            raise TestFailure(x)
        elif dut.cout != cout:
            x = "incorrect result for carry: {} != {}".format(dut.cout, int(cout))
            raise TestFailure(x)
        else:
            dut._log.info("passed!")

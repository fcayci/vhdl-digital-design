# Test for full adder module
import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure
from adders import full_adder_model
import random

@cocotb.test()
def full_adder_simple(dut):
    """
    full adder simple test
    calculates 1 + 0 + 1
    """
    yield Timer(2)
    a = 1
    b = 0
    cin = 1
    dut.a = a
    dut.b = b
    dut.cin = cin
    yield Timer(2)

    # run model and get the results
    s, cout = full_adder_model(a, b, cin)

    if dut.s != s:
        x = "incorrect result for sum: {} != {}".format(dut.s, int(s))
        raise TestFailure(x)
    elif dut.cout != cout:
        x = "incorrect result for carry: {} != {}".format(dut.cout, int(cout))
        raise TestFailure(x)
    else:
        dut._log.info("passed!")


@cocotb.test()
def full_adder_randomized(dut):
    """
    full adder randomized test
    test for 10 random inputs for x/y
    """
    yield Timer(2)

    for _ in range(10):
        a = random.randint(0, 1)
        b = random.randint(0, 1)
        cin = random.randint(0, 1)
        dut.a = a
        dut.b = b
        dut.cin = cin
        yield Timer(2)

        # run model and get the results
        s, cout = full_adder_model(a, b, cin)

        if dut.s != s:
            x = "incorrect result for sum: {} != {}".format(dut.s, int(s))
            raise TestFailure(x)
        elif dut.cout != cout:
            x = "incorrect result for carry: {} != {}".format(dut.cout, int(cout))
            raise TestFailure(x)
        else:
            dut._log.info("passed!")

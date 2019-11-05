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

    a = 13
    b = 4
    cin = 1
    dut.a = a
    dut.b = b
    dut.cin = cin
    yield Timer(1, units='ns')

    # run model and get the results
    s, cout, v = adder4_model(a, b, cin)

    if dut.s != s:
        x = 'SUM ERROR!\n'
        x += 'added 0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, s)
        x += 'rtl resulted in s: 0x{:x}'.format(int(dut.s))
        raise TestFailure(x)
    elif dut.cout != cout:
        x = 'CARRY ERROR!\n'
        x += 'added 0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, s)
        x += 'carry flag should be : 0b{:b}\n'.format(cout)
        x += 'rtl resulted in c: 0b{:b}'.format(int(dut.cout))
        raise TestFailure(x)
    elif dut.v != v:
        x = 'OVERFLOW ERROR!\n'
        x += 'added 0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, s)
        x+= 'overflow flag should be : 0b{:b}\n'.format(v)
        x += 'rtl resulted in v: 0b{:b}'.format(int(dut.v))
        #raise TestFailure(x)

    else:
        dut._log.info("passed!")


@cocotb.test()
def adder4_randomized(dut):
    """
    adder4 randomized test
    test for 100 random inputs for a/b/cin
    """

    for _ in range(100):
        a = random.randint(0, 15)
        b = random.randint(0, 15)
        cin = random.randint(0, 1)
        dut.a = a
        dut.b = b
        dut.cin = cin
        yield Timer(1, units='ns')

        # run model and get the results
        s, cout, v = adder4_model(a, b, cin)

        if dut.s != s:
            x = 'SUM ERROR!\n'
            x += 'added 0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, s)
            x += 'rtl resulted in s: 0x{:x}'.format(int(dut.s))
            raise TestFailure(x)
        elif dut.cout != cout:
            x = 'CARRY ERROR!\n'
            x += 'added 0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, s)
            x += 'carry flag should be : 0b{:b}\n'.format(cout)
            x += 'rtl resulted in c: 0b{:b}'.format(int(dut.cout))
            raise TestFailure(x)
        elif dut.v != v:
            x = 'OVERFLOW ERROR!\n'
            x += 'added 0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, s)
            x+= 'overflow flag should be : 0b{:b}\n'.format(v)
            x += 'rtl resulted in v: 0b{:b}'.format(int(dut.v))
            raise TestFailure(x)


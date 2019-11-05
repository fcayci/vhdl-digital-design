# Test for addsub4 module
import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure
from adders import addsub4_model

@cocotb.test()
def addsub4_simple(dut):
    '''
    addsub4 simple subtract test
    calculates 13 - 4 = 9
    '''

    dut._log.info("OVERFLOW CHECK IS NOT IMPLEMENTED!")

    a = 13
    b = 4
    m = 1
    dut.a = a
    dut.b = b
    dut.m = m
    yield Timer(1, units='ns')

    # run model and get the results
    s, cout, v = addsub4_model(a, b, m)

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
def addsub4_randomized(dut):
    """
    addsub4 randomized test
    test for 100 random inputs for a/b/m
    """
    import random

    dut._log.info("OVERFLOW CHECK IS NOT IMPLEMENTED!")

    for _ in range(100):
        a = random.randint(0, 15)
        b = random.randint(0, 15)
        m = random.randint(0, 1)
        dut.a = a
        dut.b = b
        dut.m = m
        yield Timer(1, units='ns')

        # run model and get the results
        s, cout, v = addsub4_model(a, b, m)

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

    dut._log.info("all tests passed!")


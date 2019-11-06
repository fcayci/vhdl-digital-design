# tests for alu_nzvc unit

# 0 a + b
# 1 a - b
# 2 a and b
# 3 a or b
# 4 a nor b
# 5 a xor b
# 6 a < b
# 7 not a

import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure
from alu_nzvc import *

@cocotb.test()
def alu_add_single(dut):
    '''
    alu ADD tests:
    - simple and operation:
    13 add 1 = 14
    '''

    a = 13
    b = 1
    op = 0
    dut.a = a
    dut.b = b
    dut.opcode = op
    yield Timer(1, units='ns')

    # run model and get the results
    r, n, z, v, c = alu_add_model(a, b, op)

    if dut.r != r:
        x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
        x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
        raise TestFailure(x)
    elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
        x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
        x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
        x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
        raise TestFailure(x)
    else:
        dut._log.info("all passed!")


@cocotb.test()
def alu_add_random(dut):
    '''
    alu ADD tests:
    - random numbers
    '''
    from random import randrange

    op = 0

    for _ in range(1000):
        a = randrange(0, 2**32)
        b = randrange(0, 2**32)
        dut.a = a
        dut.b = b
        dut.opcode = op
        yield Timer(1, units='ns')

        # run model and get the results
        r, n, z, v, c = alu_add_model(a, b, op)

        if dut.r != r:
            x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
            x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
            raise TestFailure(x)
        elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
            x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
            x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
            x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
            raise TestFailure(x)

    dut._log.info("all passed!")


@cocotb.test()
def alu_sub_single(dut):
    '''
    alu SUB tests:
    - simple subtraction operation:
    1 - 13
    '''

    a = 1
    b = 13
    op = 1
    dut.a = a
    dut.b = b
    dut.opcode = op
    yield Timer(1, units='ns')

    # run model and get the results
    r, n, z, v, c = alu_sub_model(a, b, op)

    if dut.r != r:
        x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
        x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
        raise TestFailure(x)
    elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
        x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
        x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
        x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
        raise TestFailure(x)
    else:
        dut._log.info("all passed!")


@cocotb.test()
def alu_sub_random(dut):
    '''
    alu SUB tests:
    - random numbers
    '''
    from random import randrange

    op = 1

    for _ in range(1000):
        a = randrange(0, 2**32)
        b = randrange(0, 2**32)
        dut.a = a
        dut.b = b
        dut.opcode = op
        yield Timer(1, units='ns')

        # run model and get the results
        r, n, z, v, c = alu_sub_model(a, b, op)

        if dut.r != r:
            x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
            x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
            raise TestFailure(x)
        elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
            x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
            x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
            x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
            raise TestFailure(x)

    dut._log.info("all passed!")


@cocotb.test()
def alu_and_single(dut):
    '''
    alu AND tests:
    - simple and operation:
    13 and 1 = 1
    '''

    a = 13
    b = 1
    op = 2
    dut.a = a
    dut.b = b
    dut.opcode = op
    yield Timer(1, units='ns')

    # run model and get the results
    r, n, z, v, c = alu_and_model(a, b, op)

    if dut.r != r:
        x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
        x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
        raise TestFailure(x)
    elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
        x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
        x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
        x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
        raise TestFailure(x)
    else:
        dut._log.info("all passed!")


@cocotb.test()
def alu_and_random(dut):
    '''
    alu AND tests:
    - random numbers
    '''
    from random import randrange

    op = 2

    for _ in range(1000):
        a = randrange(0, 2**32)
        b = randrange(0, 2**32)
        dut.a = a
        dut.b = b
        dut.opcode = op
        yield Timer(1, units='ns')

        # run model and get the results
        r, n, z, v, c = alu_and_model(a, b, op)

        if dut.r != r:
            x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
            x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
            raise TestFailure(x)
        elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
            x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
            x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
            x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
            raise TestFailure(x)

    dut._log.info("all passed!")


@cocotb.test()
def alu_or_single(dut):
    '''
    alu OR tests:
    - simple or operation:
    12 or 1 = 13
    '''

    a = 12
    b = 1
    op = 3
    dut.a = a
    dut.b = b
    dut.opcode = op
    yield Timer(1, units='ns')

    # run model and get the results
    r, n, z, v, c = alu_or_model(a, b, op)

    if dut.r != r:
        x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
        x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
        raise TestFailure(x)
    elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
        x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
        x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
        x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
        raise TestFailure(x)
    else:
        dut._log.info("all passed!")


@cocotb.test()
def alu_or_random(dut):
    '''
    alu OR tests:
    - random numbers
    '''
    from random import randrange

    op = 3

    for _ in range(1000):
        a = randrange(0, 2**32)
        b = randrange(0, 2**32)
        dut.a = a
        dut.b = b
        dut.opcode = op
        yield Timer(1, units='ns')

        # run model and get the results
        r, n, z, v, c = alu_or_model(a, b, op)

        if dut.r != r:
            x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
            x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
            raise TestFailure(x)
        elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
            x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
            x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
            x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
            raise TestFailure(x)

    dut._log.info("all passed!")


@cocotb.test()
def alu_nor_single(dut):
    '''
    alu NOR tests:
    - simple NOR operation:
    12 nor 1
    '''

    a = 12
    b = 1
    op = 4
    dut.a = a
    dut.b = b
    dut.opcode = op
    yield Timer(1, units='ns')

    # run model and get the results
    r, n, z, v, c = alu_nor_model(a, b, op)

    if dut.r != r:
        x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
        x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
        raise TestFailure(x)
    elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
        x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
        x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
        x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
        raise TestFailure(x)
    else:
        dut._log.info("all passed!")


@cocotb.test()
def alu_nor_random(dut):
    '''
    alu NOR tests:
    - random numbers
    '''
    from random import randrange

    op = 4

    for _ in range(1000):
        a = randrange(0, 2**32)
        b = randrange(0, 2**32)
        dut.a = a
        dut.b = b
        dut.opcode = op
        yield Timer(1, units='ns')

        # run model and get the results
        r, n, z, v, c = alu_nor_model(a, b, op)

        if dut.r != r:
            x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
            x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
            raise TestFailure(x)
        elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
            x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
            x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
            x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
            raise TestFailure(x)

    dut._log.info("all passed!")


@cocotb.test()
def alu_xor_single(dut):
    '''
    alu XOR tests:
    - simple Xor operation:
    12 xor 1 = 13
    '''

    a = 12
    b = 1
    op = 5
    dut.a = a
    dut.b = b
    dut.opcode = op
    yield Timer(1, units='ns')

    # run model and get the results
    r, n, z, v, c = alu_xor_model(a, b, op)

    if dut.r != r:
        x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
        x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
        raise TestFailure(x)
    elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
        x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
        x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
        x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
        raise TestFailure(x)
    else:
        dut._log.info("all passed!")


@cocotb.test()
def alu_xor_random(dut):
    '''
    alu XOR tests:
    - random numbers
    '''
    from random import randrange

    op = 5

    for _ in range(1000):
        a = randrange(0, 2**32)
        b = randrange(0, 2**32)
        dut.a = a
        dut.b = b
        dut.opcode = op
        yield Timer(1, units='ns')

        # run model and get the results
        r, n, z, v, c = alu_xor_model(a, b, op)

        if dut.r != r:
            x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
            x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
            raise TestFailure(x)
        elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
            x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
            x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
            x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
            raise TestFailure(x)

    dut._log.info("all passed!")


@cocotb.test()
def alu_slt_single(dut):
    '''
    alu SLT tests:
    - simple set less than operation:
    12 slt 1 = 0
    '''

    a = 12
    b = 1
    op = 6
    dut.a = a
    dut.b = b
    dut.opcode = op
    yield Timer(1, units='ns')

    # run model and get the results
    r, n, z, v, c = alu_slt_model(a, b, op)

    if dut.r != r:
        x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
        x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
        raise TestFailure(x)
    elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
        x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
        x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
        x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
        raise TestFailure(x)
    else:
        dut._log.info("all passed!")


@cocotb.test()
def alu_slt_random(dut):
    '''
    alu SLT tests:
    - random numbers
    '''
    from random import randrange

    op = 6

    for _ in range(1000):
        a = randrange(0, 2**32)
        b = randrange(0, 2**32)
        dut.a = a
        dut.b = b
        dut.opcode = op
        yield Timer(1, units='ns')

        # run model and get the results
        r, n, z, v, c = alu_slt_model(a, b, op)

        if dut.r != r:
            x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
            x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
            raise TestFailure(x)
        elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
            x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
            x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
            x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
            raise TestFailure(x)

    dut._log.info("all passed!")



@cocotb.test()
def alu_not_single(dut):
    '''
    alu NOT tests:
    - simple NOT operation:
    not 12
    '''

    a = 12
    b = 1
    op = 7
    dut.a = a
    dut.b = b
    dut.opcode = op
    yield Timer(1, units='ns')

    # run model and get the results
    r, n, z, v, c = alu_not_model(a, b, op)

    if dut.r != r:
        x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
        x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
        raise TestFailure(x)
    elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
        x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
        x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
        x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
        raise TestFailure(x)
    else:
        dut._log.info("all passed!")


@cocotb.test()
def alu_not_random(dut):
    '''
    alu NOT tests:
    - random numbers
    '''
    from random import randrange

    op = 7

    for _ in range(1000):
        a = randrange(0, 2**32)
        b = randrange(0, 2**32)
        dut.a = a
        dut.b = b
        dut.opcode = op
        yield Timer(1, units='ns')

        # run model and get the results
        r, n, z, v, c = alu_not_model(a, b, op)

        if dut.r != r:
            x = '0x{:x} and 0x{:x}, result is: 0x{:x}\n'.format(a, b, r)
            x += 'rtl resulted in r             : 0x{:x}'.format(int(dut.r))
            raise TestFailure(x)
        elif dut.n != n or dut.z != z or dut.v != v or dut.c != c:
            x = '0x{:x} and 0x{:x}, result is 0x{:x}\n'.format(a, b, r)
            x += 'flags should be      : n:{} z:{} v:{} c:{}\n'.format(n, z, v, c)
            x += 'rtl result in o_flags: n:{} z:{} v:{} c:{}'.format(dut.n, dut.z, dut.v, dut.c)
            raise TestFailure(x)

    dut._log.info("all passed!")


# alu_nzvc model

# 0 a + b
# 1 a - b
# 2 a and b
# 3 a or b
# 4 a nor b
# 5 a xor b
# 6 a < b
# 7 not a

# constants
INT_MAX  =  2**31-1
INT_MIN  = -2**31
UINT_MAX =  2**32-1

def xor(a, b):
    return (a & (~b)) | ((~a) & b)


def alu_add_model(a, b, op):
    '''alu ADD model'''

    # opcode for ADD is 0
    assert(0 == op)

    # sum a and b
    r = a + b

    # check if r is bigger than 32 bits, if so trim it
    # and set carry flag
    if r > UINT_MAX:
        r = r % (UINT_MAX + 1)
        c = 1
    else:
        c = 0

    # check for overflow, + + > - or - - > +
    if a <= INT_MAX and b <= INT_MAX:
        if r > INT_MAX:
            v = 1
        else:
            v = 0
    elif a > INT_MAX and b > INT_MAX:
        if r <= INT_MAX:
            v = 1
        else:
            v = 0
    else:
        v = 0

    # zero flag
    z = 1 if r == 0 else 0

    # negative flag
    n = 1 if r > INT_MAX else 0

    return r, n, z, v, c


def alu_sub_model(a, b, op):
    '''alu SUB model'''

    # opcode for SUB is 1
    assert(1 == op)

    # a - b
    r = a - b

    # check if r is smaller than 0, if so trim it
    # and set carry flag
    if r < 0:
        r = int(format(r % (1 << 32), '032b'), base=2)
        c = 0
    else:
        c = 1

    # check for overflow, + + > - or - - > +
    if a <= INT_MAX and b <= INT_MAX:
        if r > INT_MAX:
            v = 1
        else:
            v = 0
    elif a > INT_MAX and b > INT_MAX:
        if r <= INT_MAX:
            v = 1
        else:
            v = 0
    else:
        v = 0

    # zero flag
    z = 1 if r == 0 else 0

    # negative flag
    n = 1 if r > INT_MAX else 0

    return r, n, z, v, c



def alu_and_model(a, b, op):
    '''alu AND model'''

    # opcode for AND is 2
    assert(2 == op)

    # and a and b
    r = a & b

    # carry flag : should always be zero
    c = 0

    # check for overflow, + + > - or - - > +
    if a <= INT_MAX and b <= INT_MAX:
        if r > INT_MAX:
            v = 1
        else:
            v = 0
    elif a > INT_MAX and b > INT_MAX:
        if r <= INT_MAX:
            v = 1
        else:
            v = 0
    else:
        v = 0

    # zero flag
    z = 1 if r == 0 else 0

    # negative flag
    n = 1 if r > INT_MAX else 0

    return r, n, z, v, c


def alu_or_model(a, b, op):
    '''alu OR model'''

    # opcode for OR is 3
    assert(3 == op)

    # a or b
    r = a | b

    # carry flag : should always be zero
    c = 0

    # check for overflow, + + > - or - - > +
    if a <= INT_MAX and b <= INT_MAX:
        if r > INT_MAX:
            v = 1
        else:
            v = 0
    elif a > INT_MAX and b > INT_MAX:
        if r <= INT_MAX:
            v = 1
        else:
            v = 0
    else:
        v = 0

    # zero flag
    z = 1 if r == 0 else 0

    # negative flag
    n = 1 if r > INT_MAX else 0

    return r, n, z, v, c


def alu_nor_model(a, b, op):
    '''alu NOR model'''

    # opcode for NOR is 3
    assert(4 == op)

    # not (a or b)
    r = UINT_MAX - (a | b)
    #r = int(format(r % (1 << 32), '032b'), base=2)

    # carry flag : should always be zero
    c = 0

    # check for overflow, + + > - or - - > +
    if a <= INT_MAX and b <= INT_MAX:
        if r > INT_MAX:
            v = 1
        else:
            v = 0
    elif a > INT_MAX and b > INT_MAX:
        if r <= INT_MAX:
            v = 1
        else:
            v = 0
    else:
        v = 0

    # zero flag
    z = 1 if r == 0 else 0

    # negative flag
    n = 1 if r > INT_MAX else 0

    return r, n, z, v, c


def alu_xor_model(a, b, op):
    '''alu XOR model'''

    # opcode for XOR is 5
    assert(5 == op)

    # a xor b
    r = xor(a, b)

    # carry flag : should always be zero
    c = 0

    # check for overflow, + + > - or - - > +
    if a <= INT_MAX and b <= INT_MAX:
        if r > INT_MAX:
            v = 1
        else:
            v = 0
    elif a > INT_MAX and b > INT_MAX:
        if r <= INT_MAX:
            v = 1
        else:
            v = 0
    else:
        v = 0

    # zero flag
    z = 1 if r == 0 else 0

    # negative flag
    n = 1 if r > INT_MAX else 0

    return r, n, z, v, c


def alu_slt_model(a, b, op):
    '''alu SLT model'''

    # opcode for SLT is 6
    assert(6 == op)

    # a < b
    r = 1 if a < b else 0

    # carry flag : should always be zero
    c = 0

    # check for overflow, + + > - or - - > +
    if a <= INT_MAX and b <= INT_MAX:
        if r > INT_MAX:
            v = 1
        else:
            v = 0
    elif a > INT_MAX and b > INT_MAX:
        if r <= INT_MAX:
            v = 1
        else:
            v = 0
    else:
        v = 0

    # zero flag
    z = 1 if r == 0 else 0

    # negative flag
    n = 0

    return r, n, z, v, c


def alu_not_model(a, b, op):
    '''alu NOT model'''

    # opcode for NOT is 7
    assert(7 == op)

    r = ~a
    r = int(format(r % (1 << 32), '032b'), base=2)

    # carry flag : should always be zero
    c = 0

    # check for overflow, + + > - or - - > +
    if a <= INT_MAX and b <= INT_MAX:
        if r > INT_MAX:
            v = 1
        else:
            v = 0
    elif a > INT_MAX and b > INT_MAX:
        if r <= INT_MAX:
            v = 1
        else:
            v = 0
    else:
        v = 0

    # zero flag
    z = 1 if r == 0 else 0

    # negative flag
    n = 1 if r > INT_MAX else 0

    return r, n, z, v, c


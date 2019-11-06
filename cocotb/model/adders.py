# all the adder models

def xor(a, b):
    return (a & (~b)) | ((~a) & b)

def half_adder_model(a, b):
    """
    half adder model
    """
    s = xor(a, b)
    c = a and b
    return s, c


def full_adder_model(a, b, cin):
    """
    full adder model
    """

    m = xor(a, b)
    s = xor(m, cin)
    cout = (a and b) or (cin and m)

    return s, cout


def adder4_model(a, b, cin):
    """
    4-bit adder model
    """

    s = a + b + cin
    if s > 15:
        cout = 1
        s = s % 16
    else:
        cout = 0

    # overflow calculation
    # two negatives give positive or
    # two positives give negative
    if a > 7 and b > 7 and s < 8:
        v = 1
    elif a < 8 and b < 8 and s > 7:
        v = 1
    else:
        v = 0

    return s, cout, v


def addsub4_model(a, b, m):
    """
    4-bit adder/subtractor model
    """

    # add
    if m == 0:
        s = a + b + m
        if s > 15:
            cout = 1
            s = s % 16
        else:
            cout = 0

    # sub
    elif m == 1:
        s = a - b
        if s < 0:
            cout = 0
            s = 16 + s
        else:
            cout = 1

    # overflow calculation
    # two negatives give positive or
    # two positives give negative
    if a > 7 and b > 7 and s < 8:
        v = 1
    elif a < 8 and b < 8 and s > 7:
        v = 1
    else:
        v = 0

    return s, cout, v

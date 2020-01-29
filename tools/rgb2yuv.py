def rgb2yuv(r, g, b):
    y =  0.299 * r + 0.587 * g + 0.114 * b
    u = -0.147 * r - 0.289 * g + 0.436 * b
    v =  0.615 * r - 0.515 * g - 0.100 * b

    return hex(int(y)), hex(int(u)), hex(int(v))

print(rgb2yuv(int("00", 16), int("00", 16), int("00", 16)))
print(rgb2yuv(int("A0", 16), int("A0", 16), int("A0", 16)))
print(rgb2yuv(int("39", 16), int("49", 16), int("1A", 16)))
print(rgb2yuv(int("30", 16), int("00", 16), int("00", 16)))
print(rgb2yuv(int("12", 16), int("3D", 16), int("EF", 16)))

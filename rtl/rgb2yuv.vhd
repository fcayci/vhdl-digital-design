-- rgb2yuv converter
-- y =  0.299 R + 0.587 G + 0.114 B
-- u = -0.147 R - 0.289 G + 0.436 B
-- v =  0.615 R - 0.515 G - 0.100 B

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rgb2yuv is
port(
    i_rgb : in  std_logic_vector(23 downto 0);
    o_yuv : out std_logic_vector(23 downto 0)
);
end rgb2yuv;

architecture rtl of rgb2yuv is
    -- create yuv so that it will hold the multiplication of
    -- at least 587 and g value. 587 needs at least 11
    -- bits to represent as positive integer. g is 9 bits
    -- total which brings to 20 bits total. we give one
    -- extra bit from summation overflow to be on the save
    -- side
    signal y, u, v : signed(20 downto 0) := (others=>'0');
    signal r, g, b : signed(8 downto 0) := (others=>'0');
begin

    -- convert rgb to signed, but append 0 first so that
    --   they don't get treated as negative
    r <= signed('0' & i_rgb(23 downto 16));
    g <= signed('0' & i_rgb(15 downto  8));
    b <= signed('0' & i_rgb( 7 downto  0));

    y <= (to_signed(299, 12)*r + to_signed(587,12)*g + to_signed(114, 12)*b)/1000;
    u <= (to_signed(-147, 12)*r - to_signed(289,12)*g + to_signed(436, 12)*b)/1000;
    v <= (to_signed(615, 12)*r - to_signed(515,12)*g - to_signed(100, 12)*b)/1000;

    o_yuv <= std_logic_vector(y(7 downto 0) & u(7 downto 0) & v(7 downto 0));

end rtl;

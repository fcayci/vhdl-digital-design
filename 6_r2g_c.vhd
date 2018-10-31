-- rgb to greyscale conversion
-- grey = 0.3r + 0.59g + 0.11b
-- approximate and most efficient way using
--   grey = 0.25r + 0.50g + 0.25b instead

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity r2g_c is
port (
    rgb_i : in std_logic_vector(23 downto 0);
    grey_o : out std_logic_vector(7 downto 0)
);
end r2g_c;

architecture rtl of r2g_c is
    signal r, g, b, t : unsigned(7 downto 0) := (others => '0');
begin

    r <= unsigned(rgb_i(23 downto 16));
    g <= unsigned(rgb_i(15 downto 8));
    b <= unsigned(rgb_i(7 downto 0));

    -- divide to 2 means shift right by 1
    -- divide by 4 means shift right by 2
    t <= (r srl 2) + (g srl 1) + (b srl 2);

    grey_o <= std_logic_vector(t);

end rtl;
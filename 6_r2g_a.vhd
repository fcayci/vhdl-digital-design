-- rgb to greyscale conversion
-- grey = 0.3r + 0.59g + 0.11b

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity r2g_a is
port (
    rgb_i : in std_logic_vector(23 downto 0);
    grey_o : out std_logic_vector(7 downto 0)
);
end r2g_a;

architecture rtl of r2g_a is
    signal r, g, b : unsigned(7 downto 0) := (others => '0');
    signal t : unsigned(15 downto 0) := (others => '0');
begin

    r <= unsigned(rgb_i(23 downto 16));
    g <= unsigned(rgb_i(15 downto 8));
    b <= unsigned(rgb_i(7 downto 0));

    t <= ((r * 3) / 10) + ((g * 59) / 100) + ((b * 11) / 100);

    grey_o <= std_logic_vector(t(7 downto 0));

end rtl;
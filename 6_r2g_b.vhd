-- rgb to greyscale conversion
-- grey = 0.3r + 0.59g + 0.11b
-- in order to get it working:
--   add fixed_pkg_2018.vhd to the project (under scripts/rt/data/ folder in vivado installation)
--   when adding use ieee for the library (compile fixed_pkg_2018 for ieee library)
-- tested on vivado design suite 2018.2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- use the following for synthesis
use ieee.fixed_pkg.all;

-- use the following for simulation
--library ieee_proposed;
--use ieee_proposed.fixed_pkg.all;

entity r2g_b is
port (
    rgb_i : in std_logic_vector(23 downto 0);
    grey_o : out std_logic_vector(7 downto 0)
);
end r2g_b;

architecture rtl of r2g_b is
    -- ufixed (and sfixed) is a special type that comes with fixed_pkg.
    --   max downto 0 represents the integer part
    --   -1 downto min represents the fraction part
    --   both gets combined into single max downto min representation
    signal r, g, b: ufixed(7 downto -2) := (others => '0');
    signal t : ufixed(10 downto -10) := (others => '0');
begin

    r <= ufixed(rgb_i(23 downto 16) & "00");
    g <= ufixed(rgb_i(15 downto 8) & "00");
    b <= ufixed(rgb_i(7 downto 0) & "00");

    -- in order to determine the size of t
    --   all the multiplications will bring 9 (8 + 1) integer and 10 (2 + 8) float bits
    --   the sum of three ufixed numbers will bring 11 (9 + 1 + 1) integer and 10 ( max(10, 10, 10)) float bits
    --   so t should be (10 downto 0) + (-1 downto -10) -> (10 downto -10)
    t <= r * to_ufixed(0.3, 0, -8) + g * to_ufixed(0.59, 0, -8) + b * to_ufixed(0.11, 0, -8);
    --t(8 downto -10) <= r * to_ufixed(0.59, 0, -8);

    grey_o <= std_logic_vector(to_unsigned(t, 8));

end rtl;
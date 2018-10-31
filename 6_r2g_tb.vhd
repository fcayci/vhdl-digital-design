-- rgb to greyscale conversion testbench
-- test all implementations of r2g

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity r2g_tb is
end r2g_tb;

architecture behav of r2g_tb is

    component r2g_a is
    port (
        rgb_i : in std_logic_vector(23 downto 0);
        grey_o : out std_logic_vector(7 downto 0)
    );
    end component;

    component r2g_b is
    port (
        rgb_i : in std_logic_vector(23 downto 0);
        grey_o : out std_logic_vector(7 downto 0)
    );
    end component;

    component r2g_c is
    port (
        rgb_i : in std_logic_vector(23 downto 0);
        grey_o : out std_logic_vector(7 downto 0)
    );
    end component;

    signal rgb_i : std_logic_vector(23 downto 0);
    signal ga, gb, gc: std_logic_vector(7 downto 0);
begin

    ra : r2g_a port map( rgb_i => rgb_i, grey_o => ga);
    rb : r2g_b port map( rgb_i => rgb_i, grey_o => gb);
    rc : r2g_c port map( rgb_i => rgb_i, grey_o => gc);

    process
    begin
        wait for 10 ns;
        rgb_i <= x"000000";
        wait for 10 ns;
        rgb_i <= x"A0A0A0";
        wait for 10 ns;
        rgb_i <= x"39491A";
        wait for 10 ns;
        rgb_i <= x"300000";
        wait for 10 ns;
        rgb_i <= x"123DEF";
        wait for 10 ns;
        wait;
    end process;

end behav;

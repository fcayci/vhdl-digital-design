-- hamming distance finder testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_hamming is
end tb_hamming;

architecture bhv of tb_hamming is

    constant M : integer := 16;
    signal a, b : std_logic_vector(15 downto 0) := (others => '0');
    signal d    : std_logic_vector(7 downto 0);

begin

    -- careful with positional mapping. not adviced
    -- use proper port mapping instead
    h0 : entity work.hamming(rtl)
      generic map (M => M)
      port map (i_a => a, i_b => b, o_dist => d);

    -- stimulus
    process
    begin
        wait for 10 ns;
        a <= x"AAAA";
        b <= x"0000";
        wait for 10 ns;
        a <= x"FFFF";
        b <= x"FFFE";
        wait for 10 ns;
        a <= x"1100";
        b <= x"0011";
        wait for 10 ns;
        a <= x"0000";
        b <= x"FFFF";
        wait for 10 ns;
        wait;
    end process;
end bhv;
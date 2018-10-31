-- 16-bit hamming distance finder testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hamming_tb is
end hamming_tb;

architecture behavioral of hamming_tb is
    component hamming is
    port ( a_i, b_i : in std_logic_vector(15 downto 0);
           dist1_o, dist2_o, dist3_o, dist4_o  : out std_logic_vector(7 downto 0)
    );
    end component;

    signal a_i, b_i : std_logic_vector(15 downto 0) := (others => '0');
    signal en : std_logic := '0';
    signal d1, d2, d3, d4 :  std_logic_vector(7 downto 0);

begin

    -- careful with positional mapping. not adviced
    -- use proper port mapping instead
    h0 : hamming port map (
        a_i => a_i, b_i => b_i, dist1_o => d1, dist2_o => d2, dist3_o => d3, dist4_o => d4);

    -- stimulus
    process
    begin
        wait for 100 ns;
        en <= '1';
        a_i <= x"AAAA";
        b_i <= x"0000";
        wait for 10 ns;
        a_i <= x"FFFF";
        b_i <= x"FFFE";
        wait for 10 ns;
        a_i <= x"1100";
        b_i <= x"0011";
        wait for 10 ns;
        a_i <= x"0000";
        b_i <= x"FFFF";
        wait for 10 ns;
        wait;
    end process;
end behavioral;
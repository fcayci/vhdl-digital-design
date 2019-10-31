-- parity calculation testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_parity is
end tb_parity;

architecture bhv of tb_parity is
    signal a : std_logic_vector(7 downto 0) := (others => '0');
    signal t, p : std_logic;
begin

    uut : entity work.parity(rtl)
      port map( a => a, t => t, p => p);

    process
    begin
        -- testing for even parity
        t <= '0';
        a <= (others => '0');
        wait for 10 ns;
        a <= "01000000";
        wait for 10 ns;
        a <= "00000001";
        wait for 10 ns;
        a <= "01000100";
        wait for 10 ns;
        a <= "01010010";
        wait for 10 ns;
        a <= "01010011";
        wait for 10 ns;
        a <= "11111111";
        wait for 30 ns;
        -- testing for odd parity
        t <= '1';
        a <= (others => '0');
        wait for 10 ns;
        a <= "01000000";
        wait for 10 ns;
        a <= "00000001";
        wait for 10 ns;
        a <= "01000100";
        wait for 10 ns;
        a <= "01010010";
        wait for 10 ns;
        a <= "01010011";
        wait for 10 ns;
        a <= "11111111";
        wait for 10 ns;
        wait;
    end process;

end bhv;

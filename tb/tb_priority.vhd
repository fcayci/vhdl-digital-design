-- priority encoder testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_priority is
end tb_priority;

architecture bhv of tb_priority is
    signal a : std_logic_vector(31 downto 0) := (others => '0');
    signal b : std_logic_vector(4 downto 0);
begin

    uut : entity work.priority(rtl)
      port map( a=>a, b=>b);

    process
    begin
        a <= (0=>'1', others=>'0');
        wait for 10 ns;
        a <= (4=>'1', others=>'0');
        wait for 10 ns;
        a <= (7=>'1', others=>'0');
        wait for 10 ns;
        a <= (12=>'1', others=>'0');
        wait for 10 ns;
        a <= (15=>'1', others=>'0');
        wait for 10 ns;
        a <= (25=>'1', others=>'0');
        wait for 10 ns;
        a <= (30=>'1', others=>'0');
        wait for 10 ns;
        a <= (31=>'1', others=>'0');
        wait for 30 ns;
        a <= x"0100AF00";
        wait for 10 ns;
        a <= x"F0AC0301";
        wait for 10 ns;
        a <= x"002F0001";
        wait for 10 ns;
        a <= x"FFFFFFFF";
        wait for 10 ns;
        wait;
    end process;

end bhv;

-- 4-bit counter testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_counter is
end tb_counter;

architecture bhv of tb_counter is

    signal en, clk : std_logic := '0';
    signal couta, coutb : std_logic_vector(3 downto 0);
    signal pulse_o : std_logic := '0';

    signal clk_period : time := 10 ns;

begin

    c0: entity work.counter(bhv)
      port map (en => en, clk => clk, cout => couta );
    c1: entity work.counter(rtl)
      port map (en => en, clk => clk, cout => coutb );

    -- generate clock signal
    clk_process : process
    begin
        for i in 0 to 100 loop
            clk <= not clk;
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- stimulus
    process
    begin
        wait for clk_period;
        en <= '1';
        wait for clk_period * 50;
        -- assert if cout != 50 % 12
        assert couta = coutb
          report "count values don't match" severity error;
        assert false
          report "completed" severity note;

        wait;
    end process;
end bhv;
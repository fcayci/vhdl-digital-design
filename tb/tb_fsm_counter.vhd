-- tb_fsm_counter.vhd
library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm_counter is
end tb_fsm_counter;

architecture rtl of tb_fsm_counter is

    signal clk  : std_logic := '0';
    signal o1, o2 : std_logic;

    constant wait_time : time := 10 ns;

begin

    fsm2a : entity work.fsm_counter(rtla)
    port map(clk=>clk, o=>o1);
    fsm2b : entity work.fsm_counter(rtlb)
    port map(clk=>clk, o=>o2);

    process
    begin
          wait for wait_time;
          clk <= '1';
          wait for wait_time;
          clk <= '0';
    end process;

    -- no need to do anything extra. it is an automatic counter

end rtl;
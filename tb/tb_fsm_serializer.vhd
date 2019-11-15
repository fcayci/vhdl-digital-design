-- testbench for fsm_serializer
library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm_serializer is
end tb_fsm_serializer;

architecture rtl of tb_fsm_serializer is

    constant D : integer := 8;

    signal clk  : std_logic := '0';
    signal rst  : std_logic := '1';
    signal i_data : std_logic_vector(D-1 downto 0) := (others=>'0');
    signal i_start : std_logic := '0';
    signal o_tx, o_tx_done : std_logic := '0';

    constant CLK_PERIOD : time := 10 ns;

begin

    uut : entity work.fsm_serializer(rtl)
      port map(clk=>clk, rst=>rst,
               i_start=>i_start, i_data=>i_data,
               o_tx=>o_tx, o_tx_done=>o_tx_done);

    -- generate clock
    clk <= not clk after CLK_PERIOD/2;

    process
    begin
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;
        -- first byte
        i_data <= x"A7";
        i_start <= '1';
        wait for CLK_PERIOD;
        -- intentionally zero out both data and start
        -- to see if data and start is properly latched
        i_start <= '0';
        i_data <= x"00";
        wait until o_tx_done = '1';
        -- second byte
        wait for 4*CLK_PERIOD;
        i_data <= x"4C";
        i_start <= '1';
        wait for CLK_PERIOD;
        i_start <= '0';
        i_data <= x"00";
        wait until o_tx_done = '1';
        wait;
    end process;
end rtl;
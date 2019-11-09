library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm is
end tb_fsm;

architecture rtl of tb_fsm is

    signal clk  : std_logic := '0';
    signal a, b : std_logic := '0';
    signal moore_a, mealy_a : std_logic;
    signal moore_b, mealy_b : std_logic;
    signal moore_c, mealy_c : std_logic;

    constant wait_time : time := 10 ns;

begin

    fsma : entity work.fsm(rtla)
      port map(clk=>clk, a=>a, b=>b, moore=>moore_a, mealy=>mealy_a);
    fsmb : entity work.fsm(rtlb)
      port map(clk=>clk, a=>a, b=>b, moore=>moore_b, mealy=>mealy_b);
    fsmc : entity work.fsm(rtlc)
      port map(clk=>clk, a=>a, b=>b, moore=>moore_c, mealy=>mealy_c);

    process
    begin
        for i in 0 to 15 loop
            wait for wait_time;
            clk <= '1';
            wait for wait_time;
            clk <= '0';
        end loop;
        wait;
    end process;

    process
    begin
        a <= '0';
        b <= '0';
        wait for 25 ns;
        a <= '1';
        wait for 52 ns;
        a <= '0';
        wait for 30 ns;
        a <= '1';
        b <= '1';
        wait for 50 ns;
        b <= '0';
        wait for 50 ns;
        a <= '0';
        wait for 20 ns;
        a <= '1';
        b <= '1';
        wait for 30 ns;
        a <= '0';
        wait;
    end process;
end rtl;
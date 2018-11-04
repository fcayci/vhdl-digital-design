library ieee;
use ieee.std_logic_1164.all;

entity fsm_tb is
end fsm_tb;

architecture rtl of fsm_tb is
    component fsma is
    port(
        clk, rst : in std_logic;
        a, b : in std_logic;
        mealy, moore : out std_logic
    );
    end component;

    component fsmb is
    port(
        clk, rst : in std_logic;
        a, b : in std_logic;
        mealy, moore : out std_logic
    );
    end component;

    component fsmc is
    port(
        clk, rst : in std_logic;
        a, b : in std_logic;
        mealy, moore : out std_logic
    );
    end component;

    signal clk, rst : std_logic := '0';
    signal a, b : std_logic := '0';
    signal moore_a, mealy_a : std_logic;
    signal moore_b, mealy_b : std_logic;
    signal moore_c, mealy_c : std_logic;

    constant wait_time : time := 10 ns;

begin

    fsm0 : fsma port map(clk=>clk, rst=>rst, a=>a, b=>b, moore=>moore_a, mealy=>mealy_a);
    fsm1 : fsmb port map(clk=>clk, rst=>rst, a=>a, b=>b, moore=>moore_b, mealy=>mealy_b);
    fsm2 : fsmc port map(clk=>clk, rst=>rst, a=>a, b=>b, moore=>moore_c, mealy=>mealy_c);

    process
    begin
        for i in 0 to 20 loop
            wait for wait_time;
            clk <= '1';
            wait for wait_time;
            clk <= '0';
        end loop;
        wait;
    end process;

    process
    begin
        rst <= '1';
        a <= '0';
        b <= '0';
        wait for 50 ns;
        rst <= '0';
        wait for 30 ns;
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
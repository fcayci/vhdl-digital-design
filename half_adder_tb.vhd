-- half adder testbench
-- A testbench has no ports
library ieee;
use ieee.std_logic_1164.all;

entity half_adder_tb is
end half_adder_tb;

architecture behavioral of half_adder_tb is
    -- declare half_adder circut as a component
    component half_adder is
        port ( x : in std_logic; y : in std_logic; s : out std_logic; c : out std_logic );
    end component;
    -- declare internal signals
    signal x, y, s, c : std_logic;
begin
    --  instantiate half_adder component.
    h0: half_adder port map (x => x, y => y, s => s, c => c);

    process
    begin
        -- initial state wait
        wait for 10 ns;
        -- apply first set of patterns to the inputs
        x <= '0';
        y <= '0';
        -- hold this state for 10 ns
        wait for 10 ns;
        -- apply second set
        x <= '0';
        y <= '1';
        wait for 10 ns;
        -- apply third set
        x <= '1';
        y <= '0';
        wait for 10 ns;
        -- apply forth set
        x <= '1';
        y <= '1';
        --  wait forever; this will finish the simulation
        wait;
    end process;
end behavioral;
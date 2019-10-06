-- half adder testbench
--  essentially this is a wrapper around the
--  circuit that we want to test;
--  declares and connects the circuit under test
--  generates signals for the inputs
--  watches the ouputs
library ieee;
use ieee.std_logic_1164.all;

-- testbench has no ports
entity tb_half_adder is
end tb_half_adder;

architecture bhv of tb_half_adder is
    -- declare half_adder circut as a component
    component half_adder is
    port (
        x : in std_logic;
        y : in std_logic;
        s : out std_logic;
        c : out std_logic
    );
    end component;

    -- declare internal signals
    signal x, y, s, c : std_logic;

begin
    --  instantiate half_adder component.
    h0: half_adder
      port map (x => x, y => y, s => s, c => c);

    -- stimuli
    process
    begin
        -- initial state wait
        wait for 10 ns;
        -- apply first set of patterns to the inputs
        x <= '0';
        y <= '0';
        -- hold this state for 10 ns
        wait for 10 ns;
        -- assert if sum or carry are not correcty
        assert s = '0'
        report "bad sum value" severity error;
        assert c = '0'
        report "bad carry value" severity error;
        -- apply second set
        x <= '0';
        y <= '1';
        wait for 10 ns;
        assert s = '1'
        report "bad sum value" severity error;
        assert c = '0'
        report "bad carry value" severity error;
        -- apply third set
        x <= '1';
        y <= '0';
        wait for 10 ns;
        assert s = '1'
        report "bad sum value" severity error;
        assert c = '0'
        report "bad carry value" severity error;
        -- apply forth set
        x <= '1';
        y <= '1';
        wait for 10 ns;
        assert s = '0'
        report "bad sum value" severity error;
        assert c = '1'
        report "bad carry value" severity error;

        assert false
        report "completed" severity note;

        --  wait forever; this will finish the simulation
        wait;
    end process;

end bhv;
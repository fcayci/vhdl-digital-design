-- 4-bit adder subtractor testbench
-- A testbench has no ports
library ieee;
use ieee.std_logic_1164.all;

entity addsub4_tb is
end addsub4_tb;

architecture behavioral of addsub4_tb is
    -- declare addsub4 circut as a component
    component addsub4 is
        port ( a, b : in std_logic_vector(3 downto 0); m : in std_logic; s : out std_logic_vector(3 downto 0); v, cout : out std_logic );
    end component;
    --  Specifies which entity is bound with the component
    for a0: addsub4 use entity work.addsub4;

    signal a, b : std_logic_vector(3 downto 0);
    signal m : std_logic;
    signal s : std_logic_vector(3 downto 0);
    signal v, cout : std_logic;
begin
    --  instantiate addsub4 component.
    a0: addsub4 port map (a => a, b => b, m => m, s => s, v => v, cout => cout);

    process
    begin
        wait for 1 ns;
        --  check each pattern.
        for i in 0 to 16 loop
            for j in 0 to 16 loop
                a <= std_logic_vector(i, 4);
                b <= std_logic_vector(j, 4);
                wait for 1 ns;
                assert s = a + b mod 16;
                report "bad sum value" severity error;
                -- assert cout = 1 ? a + b >= 16
                -- report "bad carray out value" severity error;
            end loop;
        end loop;
        assert false report "end of test" severity note;
        --  wait forever; this will finish the simulation.
        wait;
    end process;
end behavioral;
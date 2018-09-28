-- 4-bit adder subtractor testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
    -- simple 1-bit vector trick to convert integer to std_logic
    signal m : std_logic_vector(0 downto 0);
    signal s : std_logic_vector(3 downto 0);
    signal v, cout : std_logic;
begin
    --  instantiate addsub4 component.
    a0: addsub4 port map (a => a, b => b, m => m(0), s => s, v => v, cout => cout);

    process
    begin
        wait for 1 ns;
        for sel in 0 to 1 loop
            m <= std_logic_vector(to_unsigned(sel, 1));
            for i in 0 to 16 loop
                for j in 0 to 16 loop
                    a <= std_logic_vector(to_unsigned(i, 4));
                    b <= std_logic_vector(to_unsigned(j, 4));
                    wait for 1 ns;
                end loop;
            end loop;
            wait for 10ns;
        end loop;
        wait;
    end process;
end behavioral;
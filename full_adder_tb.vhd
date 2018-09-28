-- 1-bit full adder testbench
--   modified from ghdl adder testbench example
-- A testbench has no ports
library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end full_adder_tb;

architecture behavioral of full_adder_tb is
    -- declare full_adder circut as a component
    component full_adder is
        port ( x, y, cin : in std_logic; s, cout : out std_logic );
    end component;
    --  Specifies which entity is bound with the component
    for f0: full_adder use entity work.full_adder;
    signal x, y, cin, s, cout : std_logic;
begin
    --  instantiate full_adder component.
    f0: full_adder port map (x => x, y => y, cin => cin, s => s, cout => cout);

    process
        type pattern_type is record
            --  inputs of the adder.
            x, y, cin : std_logic;
            --  expected outputs of the adder.
            s, cout : std_logic;
        end record;
        --  patterns to apply.
        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns : pattern_array :=
           (('0', '0', '0', '0', '0'),
            ('0', '0', '1', '1', '0'),
            ('0', '1', '0', '1', '0'),
            ('0', '1', '1', '0', '1'),
            ('1', '0', '0', '1', '0'),
            ('1', '0', '1', '0', '1'),
            ('1', '1', '0', '0', '1'),
            ('1', '1', '1', '1', '1'));
    begin
        --  check each pattern.
        for i in patterns'range loop
            --  Set the inputs.
            x <= patterns(i).x;
            y <= patterns(i).y;
            cin <= patterns(i).cin;
            --  wait for the results.
            wait for 1 ns;
            --  check the outputs.
            assert s = patterns(i).s
            report "bad sum value" severity error;
            assert cout = patterns(i).cout
            report "bad carray out value" severity error;
        end loop;
        assert false report "end of test" severity note;
        --  wait forever; this will finish the simulation.
        wait;
    end process;
end behavioral;
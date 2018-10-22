-- 1-bit full adder
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    -- x, y, cin are inputs of the adder
    -- s (sum), cout (carry) are outputs of the adder
    port ( x, y : in  std_logic; cin : in std_logic; s : out std_logic; cout : out std_logic );
end full_adder;

architecture rtl of full_adder is
    -- declare half_adder circut as a component
    component half_adder is
        port ( x : in  std_logic; y : in  std_logic; s : out std_logic; c : out std_logic );
    end component;
    -- intermediate signals
    signal s0, c0, c1 : std_logic := '0';
begin
    -- instantiate half_adder component two times
    h0 : half_adder port map ( x => x, y => y, s => s0, c => c0 );
    h1 : half_adder port map ( x => s0, y => cin, s => s, c => c1 );
    cout <= c0 or c1;
end rtl;
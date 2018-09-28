-- 4-bit adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder4 is
    -- a, b are 4-bit inputs of the adder4
    -- cin is the carry-in input
    -- s is the 4-bit sum output,
    -- cout (carry-out) is the output of the adder4
    port (
        a, b : in  STD_LOGIC_VECTOR(3 downto 0);
        cin  : in  STD_LOGIC;
        s    : out STD_LOGIC_VECTOR(3 downto 0);
        cout : out STD_LOGIC );
end adder4;

architecture rtl of adder4 is
    -- declare full_adder circut as a component
    component full_adder IS
        port ( x, y, cin : in STD_LOGIC; s, cout : out STD_LOGIC );
    end component;
    -- intermediate signals
    -- set each bit to 0 initially
    signal c : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
begin
    f0 : full_adder port map ( x => a(0), y => b(0), cin => '0',  s => s(0), cout => c(0) );
    f1 : full_adder port map ( x => a(1), y => b(1), cin => c(0), s => s(1), cout => c(1) );
    f2 : full_adder port map ( x => a(2), y => b(2), cin => c(1), s => s(2), cout => c(2) );
    f3 : full_adder port map ( x => a(3), y => b(3), cin => c(2), s => s(3), cout => cout );
end rtl;
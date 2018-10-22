-- 4-bit adder
library ieee;
use ieee.std_logic_1164.all;

entity adder4 is
    -- a, b are 4-bit inputs of the adder4
    -- cin is the carry-in input
    -- s is the 4-bit sum output,
    -- cout (carry-out) is the output of the adder4
    port (
        a, b : in  std_logic_vector(3 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector(3 downto 0);
        cout : out std_logic );
end adder4;

architecture rtl of adder4 is
    -- declare full_adder circut as a component
    component full_adder is
        port (
            a, b    : in  std_logic_vector(3 downto 0);
            m       : in  std_logic;
            sum     : out std_logic_vector(3 downto 0);
            v, cout : out std_logic );
    end component;
    -- intermediate signals
    -- set each bit to 0 initially
    signal c : std_logic_vector(2 downto 0) := (others => '0');
begin

    f0 : full_adder port map ( x => a(0), y => b(0), cin => '0',  s => s(0), cout => c(0) );
    f1 : full_adder port map ( x => a(1), y => b(1), cin => c(0), s => s(1), cout => c(1) );
    f2 : full_adder port map ( x => a(2), y => b(2), cin => c(1), s => s(2), cout => c(2) );
    f3 : full_adder port map ( x => a(3), y => b(3), cin => c(2), s => s(3), cout => cout );

end rtl;
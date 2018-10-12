-- 4-bit adder / subtractor
-- subtractor calculates a - b
library ieee;
use ieee.std_logic_1164.all;

entity addsub4 is
    -- a, b are 4-bit inputs of the addsub4
    -- m is the adder / subtractor selector input ('0' - adder, '1' - subtractor)
    -- sum is the 4-bit sum output,
    -- cout (carry-out) is the output of the addsub4
    -- v is the overflow detector output
    port (
        a, b    : in  std_logic_vector(3 downto 0);
        m       : in  std_logic;
        sum     : out std_logic_vector(3 downto 0);
        v, cout : out std_logic );
end addsub4;

architecture rtl of addsub4 is
    -- declare full_adder circut as a component
    component full_adder is
        port ( x, y, cin : in std_logic; s, cout : out std_logic );
    end component;
    -- intermediate signals
    -- set each bit to 0 initially
    signal c : std_logic_vector(3 downto 0) := (others => '0');
    signal bin : std_logic_vector(3 downto 0) := (others => '0');
begin
    -- xor each b input with the value of m to use it as is or take 1's complement
    bin(0) <= b(0) xor m;
    bin(1) <= b(1) xor m;
    bin(2) <= b(2) xor m;
    bin(3) <= b(3) xor m;

    f0 : full_adder port map ( x => a(0), y => bin(0), cin => m,    s => sum(0), cout => c(0) );
    f1 : full_adder port map ( x => a(1), y => bin(1), cin => c(0), s => sum(1), cout => c(1) );
    f2 : full_adder port map ( x => a(2), y => bin(2), cin => c(1), s => sum(2), cout => c(2) );
    f3 : full_adder port map ( x => a(3), y => bin(3), cin => c(2), s => sum(3), cout => c(3) );

    cout <= c(3);
    -- calculate overflow
    v <= c(2) xor c(3);
end rtl;
-- 4-bit adder / subtractor
-- subtractor calculates a - b
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity addsub4 is
    -- a, b are 4-bit inputs of the addsub4
    -- m is the adder / subtractor selector input ('0' - adder, '1' - subtractor)
    -- s is the 4-bit sum output,
    -- cout (carry-out) is the output of the addsub4
    -- v is the overflow detector output
    port (
        a, b : in  std_logic_vector(3 downto 0);
        m    : in  std_logic;
        s    : out std_logic_vector(3 downto 0);
        v    : out std_logic;
        cout : out std_logic );
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
    bin <= b xor std_logic_vector(resize(unsigned(m), bin'length));

    f0 : full_adder port map ( x => a(0), y => bin(0), cin => m,    s => s(0), cout => c(0) );
    f1 : full_adder port map ( x => a(1), y => bin(1), cin => c(0), s => s(1), cout => c(1) );
    f2 : full_adder port map ( x => a(2), y => bin(2), cin => c(1), s => s(2), cout => c(2) );
    f3 : full_adder port map ( x => a(3), y => bin(3), cin => c(2), s => s(3), cout => c(3) );

    cout <= c(3);
    -- calculate overflow
    v <= c(2) xor c(3);
end rtl;
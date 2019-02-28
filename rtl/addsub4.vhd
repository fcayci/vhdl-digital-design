-- 4-bit adder / subtractor
--   subtractor calculates a - b
library ieee;
use ieee.std_logic_1164.all;

entity addsub4 is
-- a, b are 4-bit inputs of the addsub4
-- m is the adder / subtractor selector input
--   ('0' - adder, '1' - subtractor)
-- sum is the 4-bit sum output,
-- cout is the carry out
-- v is the overflow
port (
	a, b    : in  std_logic_vector(3 downto 0);
	m       : in  std_logic;
	sum     : out std_logic_vector(3 downto 0);
	v, cout : out std_logic
);
end addsub4;

architecture rtl of addsub4 is
	-- declare full_adder circut as a component
	component full_adder is
	port (
		a, b : in  std_logic;
		cin  : in  std_logic;
		sum  : out std_logic;
		cout : out std_logic
	);
	end component;
	-- intermediate signals
	signal c : std_logic_vector(3 downto 0) := (others => '0');
	signal bt : std_logic_vector(3 downto 0) := (others => '0');
begin
	-- xor each b input with the value of m to use it as is
	--   or take 1's complement
	bt(0) <= b(0) xor m;
	bt(1) <= b(1) xor m;
	bt(2) <= b(2) xor m;
	bt(3) <= b(3) xor m;

	f0 : full_adder port map ( a => a(0), b => bt(0), cin => m,    sum => sum(0), cout => c(0) );
	f1 : full_adder port map ( a => a(1), b => bt(1), cin => c(0), sum => sum(1), cout => c(1) );
	f2 : full_adder port map ( a => a(2), b => bt(2), cin => c(1), sum => sum(2), cout => c(2) );
	f3 : full_adder port map ( a => a(3), b => bt(3), cin => c(2), sum => sum(3), cout => c(3) );

	-- carry out
	cout <= c(3);
	-- overflow
	v <= c(2) xor c(3);
end rtl;
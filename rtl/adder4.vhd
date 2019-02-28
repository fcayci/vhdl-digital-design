-- 4-bit ripple-carry adder (RCA)
library ieee;
use ieee.std_logic_1164.all;

entity adder4 is
-- a, b are 4-bit inputs of the adder4
-- cin is the carry-in input
-- s is the 4-bit sum output,
-- cout is the carry out
-- v is the overflow output
port (
	a, b    : in  std_logic_vector(3 downto 0);
	cin     : in  std_logic;
	s       : out std_logic_vector(3 downto 0);
	v, cout : out std_logic
);
end adder4;

architecture rtl of adder4 is
	-- declare full_adder component
	component full_adder
	port (
		a, b : in  std_logic;
		cin  : in  std_logic;
		sum  : out std_logic;
		cout : out std_logic
	);
	end component;

	-- intermediate signals
	-- set each bit to 0 initially
	signal c : std_logic_vector(3 downto 0) := (others => '0');
begin

	f0 : full_adder port map ( a => a(0), b => b(0), cin => cin,  sum => s(0), cout => c(0) );
	f1 : full_adder port map ( a => a(1), b => b(1), cin => c(0), sum => s(1), cout => c(1) );
	f2 : full_adder port map ( a => a(2), b => b(2), cin => c(1), sum => s(2), cout => c(2) );
	f3 : full_adder port map ( a => a(3), b => b(3), cin => c(2), sum => s(3), cout => c(3) );

	-- carry out
	cout <= c(3);
	-- overflow
	v <= c(2) xor c(3);

end rtl;
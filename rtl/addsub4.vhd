-- 4-bit adder / subtractor
--   subtractor calculates a - b
library ieee;
use ieee.std_logic_1164.all;

entity addsub4 is
-- a, b are 4-bit inputs of the addsub4
-- m is the adder / subtractor selector input
--   ('0' - adder, '1' - subtractor)
-- s is the 4-bit sum output,
-- cout is the carry out
-- v is the overflow
port (
	a, b    : in  std_logic_vector(3 downto 0);
	m       : in  std_logic;
	s       : out std_logic_vector(3 downto 0);
	v, cout : out std_logic
);
end addsub4;

architecture rtl of addsub4 is
	-- intermediate signals
	signal bt : std_logic_vector(3 downto 0) := (others => '0');
begin
	-- xor each b input with the value of m to use it as is
	--   or take 1's complement
	sub: for i in 0 to 3 generate
	begin
		bt(i) <= b(i) xor m;
	end generate;

	a4 : entity work.adder4(rtl)
	  port map ( a => a, b => bt, cin => m, s => s, v => v, cout => cout );

end rtl;
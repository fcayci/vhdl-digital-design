-- 1-bit full adder
--   two implementations are given
--   behavioral
--   structural using half_adder design
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
-- a, b, cin are inputs of the adder
-- s, cout (carry out) are outputs of the adder
port (
	a, b : in  std_logic;
	cin  : in  std_logic;
	s    : out std_logic;
	cout : out std_logic
);
end full_adder;

-- behavioral description
architecture bhv of full_adder is
	-- intermediate signals
	signal m : std_logic := '0';
begin

	-- concurrent assignments
	--   order does not matter
	m <= a xor b;
	s <= m xor cin;
	cout <= (a and b) or (cin and m);

end bhv;

-- structural description
architecture str of full_adder is
	-- declare half_adder circut as a component
	component half_adder is
	port (
		x : in  std_logic;
		y : in  std_logic;
		s : out std_logic;
		c : out std_logic
	);
	end component;
	-- intermediate signals
	signal s0, c0, c1 : std_logic := '0';
begin

	-- instantiate half_adder component two times
	h0 : half_adder port map ( x => a, y => b, s => s0, c => c0 );
	h1 : half_adder port map ( x => s0, y => cin, s => s, c => c1 );
	cout <= c0 or c1;

end str;
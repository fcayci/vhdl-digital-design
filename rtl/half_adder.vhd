-- half adder
-- import std logic library for
--   std_logic and std_logic_vector data types
library ieee;
use ieee.std_logic_1164.all;

-- entity of the design
--   defines the input / output ports
entity half_adder is
-- x, y are inputs of the adder
-- s (sum), c (carry) are outputs of the adder
port (
	x : in  std_logic;
	y : in  std_logic;
	s : out std_logic;
	c : out std_logic
);
end half_adder;

-- architecture of the design
--   describes how the circuit works
architecture bhv of half_adder is

begin
	-- two concurrent assignments
	--  happens at the same time
	--  order does not matter
	s <= x xor y;
	c <= x and y;

end bhv;
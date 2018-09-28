-- half adder
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    -- x, y are inputs of the adder
    -- s (sum), c (carry) are outputs of the adder
    port ( x : in  std_logic; y : in  std_logic; s : out std_logic; c : out std_logic );
end half_adder;

architecture bhv of half_adder is
begin
    -- two concurrent assignments
    s <= x xor y;
    c <= x and y;
end bhv;
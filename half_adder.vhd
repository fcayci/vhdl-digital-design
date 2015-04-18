-- Half Adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    Port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           s : out STD_LOGIC;
           c : out STD_LOGIC);
end half_adder;

architecture Behavioral of half_adder is

begin

    s <= x xor y;
    c <= x and y;

end Behavioral;
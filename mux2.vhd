-- 2-to-1 MUX circuit
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port ( I : in  STD_LOGIC_VECTOR (1 downto 0);
           S : in  STD_LOGIC;
           Y : out STD_LOGIC);
end mux2;

architecture Behavioral of mux2 is

begin
  
  with S select
    Y <= I(0) when '0',
         I(1) when '1';

end Behavioral;
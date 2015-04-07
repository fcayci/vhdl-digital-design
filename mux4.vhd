-- 4-to-1 MUX circuit
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4 is
    Port ( I : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           Y : out STD_LOGIC);
end mux4;

architecture Behavioral of mux4 is

begin

  with S select 
    Y <= I(0) when "00",
         I(1) when "01",
         I(2) when "10",
         I(3) when "11";

end Behavioral;
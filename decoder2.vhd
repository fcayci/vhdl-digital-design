-- 2-to-4 Decoder circuit
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity decoder2 is
    Port ( A : in  STD_LOGIC_VECTOR (1 downto 0);
           B : out  STD_LOGIC_VECTOR (3 downto 0));
end decoder2;

architecture Behavioral of decoder2 is

begin

  with A select 
    B <= "0001" when "00",
         "0010" when "01",
         "0100" when "10",
         "1000" when "11";

end Behavioral;
-- 1-to-4 Demux circuit
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux4 is
    Port ( A : in  STD_LOGIC;
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end demux4;

architecture Behavioral of demux4 is

  SIGNAL AS : STD_LOGIC_VECTOR (2 downto 0);

begin

  -- AS(1 downto 0) is Select inputs
  -- AS(2) is A input
  AS <= A & S; -- & is Concatenation Operator

  with AS select 
    Y <= "1000" when "100",
         "0100" when "101",
         "0010" when "110",
         "0001" when "111",
         "0000" when others;
         
end Behavioral;
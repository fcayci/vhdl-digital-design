-- 1-to-2 Demux circuit
-- Define an intermediate signal and concatenate
--    the input signals.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux2_3 is
    Port ( A : in  STD_LOGIC;
           S : in  STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (1 downto 0));
end demux2_3;

architecture Behavioral of demux2_3 is

  SIGNAL AS : STD_LOGIC_VECTOR (1 downto 0);

begin

  -- AS(0) is Select input
  -- AS(1) is A input
  AS <= A & S; -- & is Concatenation Operator

  with AS select 
    Y <= "10" when "10",
         "01" when "11",
         "00" when others;
         
end Behavioral;
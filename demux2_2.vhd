-- 1-to-2 Demux circuit
-- Might not always possible to change the input
--   signals since it might be a part of a bigger
--   design and the signal names need to stay the 
--   same.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux2_2 is
    Port ( AS : in  STD_LOGIC_VECTOR (1 downto 0);
           Y  : out STD_LOGIC_VECTOR (1 downto 0));
end demux2_2;

architecture Behavioral of demux2_2 is

begin

  -- AS(0) is Select input
  -- AS(1) is A input
  with AS select 
    Y <= "10" when "10",
         "01" when "11",
         "00" when others;


end Behavioral;
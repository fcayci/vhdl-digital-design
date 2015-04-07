-- 1-to-2 Demux circuit
-- Not really practical since having more outputs
--   mean having more with .. select statements.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux2_1 is
    Port ( A : in  STD_LOGIC;
           S : in  STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (1 downto 0));
end demux2_1;

architecture Behavioral of demux2_1 is

begin
  
  with S select 
    Y(0) <=  A  when '0',
            '0' when '1';

  with S select 
    Y(1) <= '0' when '0',
             A  when '1';

end Behavioral;
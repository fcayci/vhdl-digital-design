-- 2-bit line decoder (2 to 4)
library ieee;
use ieee.std_logic_1164.all;

entity decoder2 is
    port ( a : in  std_logic_vector(1 downto 0);
           b : out std_logic_vector(3 downto 0)
          );
end decoder2;

architecture rtl of decoder2 is
begin
    with a select
        b <= "0001" when "00",
             "0010" when "01",
             "0100" when "10",
             "1000" when "11";
end rtl;
-- 4-to-1 mux
library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
    port ( a   : in  std_logic_vector(3 downto 0);
           sel : in  std_logic_vector(1 downto 0);
           y   : out std_logic
          );
end mux4;

architecture rtl of mux4 is
begin

    with sel select
        y <= a(0) when "00",
             a(1) when "01",
             a(2) when "10",
             a(3) when others;

end rtl;
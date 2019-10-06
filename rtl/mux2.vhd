-- 2-to-1 mux
library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
port (
    x   : in  std_logic_vector(1 downto 0);
    sel : in  std_logic;
    y   : out std_logic
);
end mux2;

architecture rtl of mux2 is
begin

    with sel select
    y <= x(0) when '0',
         x(1) when others;

end rtl;
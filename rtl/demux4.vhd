-- 1-to-4 demux
library ieee;
use ieee.std_logic_1164.all;

entity demux4 is
port (
    a   : in  std_logic;
    sel : in  std_logic_vector(1 downto 0);
    y   : out std_logic_vector(3 downto 0)
);
end demux4;

architecture rtl of demux4 is
    -- signal to hold sel + a values
    signal s_sela : std_logic_vector(2 downto 0);
begin

    -- concatenate two values together
    --   & is concatenation operation
    s_sela <= sel & a;

    with s_sela select
    y <= "0001" when "001",
         "0010" when "011",
         "0100" when "101",
         "1000" when "111",
         "0000" when others;
end rtl;
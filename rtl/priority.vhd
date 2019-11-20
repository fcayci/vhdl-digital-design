-- 32-5 priority encoder
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority is
port (
    a : in std_logic_vector(31 downto 0);
    b : out std_logic_vector(4 downto 0)
);
end priority;

architecture rtl of priority is
begin

    process(a) is
    begin
        -- default state if no assignment is made
        b <= (others => '0');
        -- go through each bit and assign the last one only
        for i in 0 to 31 loop
            if a(i) = '1' then
                b <= std_logic_vector(to_unsigned(i, 5));
            end if;
        end loop;
    end process;
end rtl;

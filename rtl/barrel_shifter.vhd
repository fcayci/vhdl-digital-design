-- 32-bit barrel shifter
--  not yet tested
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity barrel_shifter is
port (
    a : in std_logic_vector(31 downto 0);
    sel : in std_logic_vector(4 downto 0);
    ori : in std_logic;
    b : out std_logic_vector(31 downto 0)
);
end barrel_shifter;

architecture rtl of barrel_shifter is
begin

    process(a, sel, ori) is
        variable s : integer range 0 to 31 := 0;
    begin
        s := to_integer(unsigned(sel));
        if s /= 0 then
            if ori = '1' then
                -- right rotate
                --b <= a ror s;
                b <= a(s-1 downto 0) & a(31 downto s);
            else
                -- left rotate
                --b <= a rol s;
                b <= a(31-s downto 0) & a(31 downto 31-s+1);
            end if;
        else
            b <= a;
        end if;
    end process;

end rtl;

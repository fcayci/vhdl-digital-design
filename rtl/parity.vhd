-- 8-bit parity generator
--   t = 0 for even parity
--   t = 1 for  odd parity
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parity is
port (
    a : in std_logic_vector(7 downto 0);
    t : in std_logic;
    p : out std_logic
);
end parity;

architecture rtl of parity is
begin

    process(a, t) is
        variable x: std_logic := '0';
    begin
        -- 0 out x in the beginning of process
        x := '0';
        for i in a'range loop
            x := x xor a(i);
        end loop;

        p <= x xor t;
    end process;

end rtl;

-- 1-bit d latch
library ieee;
use ieee.std_logic_1164.all;

entity dlatch is
port (
    d       : in  std_logic;
    en      : in  std_logic;
    q1, q2  : out std_logic
);
end dlatch;

architecture rtl of dlatch is
    signal d_next : std_logic := '0';
begin

    -- 1st way with / select method

    -- implement 1-bit latch
    with en select
    d_next <=
        d when '1',
        d_next when others;

    -- Assign the output
    q1 <= d_next;

    -- 2nd way: if method
    -- en and d input signals are placed
    --   inside the sensitivity list
    process(en, d) is
    begin
        if en = '1' then
            q2 <= d;
        end if;
    end process;

end rtl;

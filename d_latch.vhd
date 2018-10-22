-- d latch
library ieee;
use ieee.std_logic_1164.all;

entity d_latch is
    port (
        d  : in  std_logic;
        en : in  std_logic;
        q1, q2  : out std_logic
    );
end d_latch;

architecture behavioral of d_latch is
    signal d_next : std_logic := '0';
begin

    -- 1st way with / select method

    -- implement 1-bit latch
    with en select
        d_next <= d when '1',
                  d_next when others;

    -- Assign the output
    q1 <= d_next;


    -- 2nd way: if method

    process(en, d) is
    begin
        if en = '1' then
            q2 <= d;
        end if;
    end process;

end behavioral;

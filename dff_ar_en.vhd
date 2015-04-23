-- 1-bit D-Flip Flop with Asynchronous Reset and Clock Enable
--   It is important not to add to if statement for CE
--   an else condition. That will make a MUX instead.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_ar_en is
    Port ( 
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        CE  : in  STD_LOGIC;
        D   : in  STD_LOGIC;
        Q   : out STD_LOGIC
        );
end dff_ar_en;

architecture Behavioral of dff_ar_en is

begin

    -- Sensitivity list includes reset as well since
    --   reset is independent of the clock
    --   but not CE since it depends on clock
    PROCESS(CLK, RST)
    BEGIN
        IF RST = '1' then
            Q <= '0';
        ELSIF CLK'event and CLK = '1' then
            IF CE = '1' then
                Q <= D;
            END IF;
        END IF;
    END PROCESS;

end Behavioral;
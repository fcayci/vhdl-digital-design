-- 1-bit D-Flip Flop with Asynchronous Reset
--   Reset input is checked regardless of 
--   clock edge, thus 'Asynchronous Reset'
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_ar is
    Port ( 
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        D   : in  STD_LOGIC;
        Q   : out STD_LOGIC
        );
end dff_ar;

architecture Behavioral of dff_ar is

begin

    -- Sensitivity list includes reset as well since
    --   reset is independent of the clock
    PROCESS(CLK, RST)
    BEGIN
        IF RST = '1' then
            Q <= '0';
        ELSIF CLK'event and CLK = '1' then
            Q <= D;
        END IF;
    END PROCESS;

end Behavioral;
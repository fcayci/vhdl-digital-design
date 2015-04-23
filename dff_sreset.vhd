-- 1-bit D-Flip Flop with Synchronous Reset
--   Reset input is checked when clock edge 
--   happens, thus 'Synchronous Reset'
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_sr is
    Port ( 
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        D   : in  STD_LOGIC;
        Q   : out STD_LOGIC
        );
end dff_sr;

architecture Behavioral of dff_sr is

begin

    -- Sensitivity list does not need reset since
    --   reset depends on the clock
    PROCESS(CLK)
    BEGIN
        IF CLK'event and CLK = '1' then
            IF RST = '1' then
                Q <= '0';
            ELSE
                Q <= D;
            END IF;
        END IF;
    END PROCESS;

end Behavioral;
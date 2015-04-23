-- 1-bit D-Flip Flop (positive-edge triggered)
--   For negative edge change CLK = '0'
--   It is important not to add else
--   condition for CLK'event.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
    Port ( 
        CLK : in  STD_LOGIC;
        D   : in  STD_LOGIC;
        Q   : out STD_LOGIC
        );
end dff;

architecture Behavioral of dff is

begin

    -- Sensitivity list only includes clock
    PROCESS(CLK)
    BEGIN
        IF CLK'event and CLK = '1' then
            Q <= D;
        END IF;
    END PROCESS;

end Behavioral;
-- 1-bit T-Flip Flop (positive-edge triggered)
--   This will generate an XOR gate attached
--   to a D Flip Flop with a loopback from output.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tff is
    Port ( 
        CLK : in  STD_LOGIC;
        T   : in  STD_LOGIC;
        Q   : out STD_LOGIC
        );
end tff;

architecture Behavioral of tff is

    SIGNAL Q_temp : STD_LOGIC := '0';

begin

    -- Sensitivity list only includes clock
    PROCESS(CLK)
    BEGIN
        IF CLK'event and CLK = '1' then
            Q_temp <= T XOR Q_temp;
        END IF;
    END PROCESS;

    Q <= Q_temp;

end Behavioral;
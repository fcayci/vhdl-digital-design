-- 1-bit D Latch
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment for + - operations with STD_LOGIC / STD_LOGIC_VECTORS
-- use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity d_latch is
    Port ( 
        D  : in  STD_LOGIC;
        En : in  STD_LOGIC;
        Q  : out STD_LOGIC
    );
end d_latch;

architecture Behavioral of d_latch is

    SIGNAL D_next : STD_LOGIC;

begin

    -- Implement 1-bit latch
    with En select
        D_next <= D when '1',
                  D_next when others;

    -- Assign the output
    Q <= D_next;

end Behavioral;
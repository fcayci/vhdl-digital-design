-- Full Adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( 
        x : in  STD_LOGIC; -- In1
        y : in  STD_LOGIC; -- In2
        z : in  STD_LOGIC; -- Carry In
        s : out STD_LOGIC; -- Sum
        c : out STD_LOGIC  -- Carry Out
    );
end full_adder;

architecture structural of full_adder is

    COMPONENT half_adder IS
        PORT (
            x : in  STD_LOGIC;
            y : in  STD_LOGIC;
            s : out  STD_LOGIC;
            c : out  STD_LOGIC
        );
    END COMPONENT;

    SIGNAL s0, c0, c1 : STD_LOGIC := '0';

begin

    h0 : half_adder PORT MAP (
        x => x,
        y => y,
        s => s0,
        c => c0
    );

    h1 : half_adder PORT MAP (
        x => s0,
        y => z,
        s => s,
        c => c1
    );

    c <= c0 or c1;

end structural;


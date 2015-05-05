library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter3 is
    Port ( EN    : in  STD_LOGIC;
           CLK   : in  STD_LOGIC;
           RST   : in  STD_LOGIC;
           A_out : out STD_LOGIC;
           B_out : out STD_LOGIC;
           C_out : out STD_LOGIC);
end counter3;

architecture Behavioral of counter3 is

    SIGNAL A, B, C : STD_LOGIC := '0';
    
begin

    process(CLK, RST) is
    begin
        if RST = '1' then
            A <= '0';
            B <= '0';
            C <= '0';
        elsif CLK'event and CLK = '1' then
            if EN = '1' then
                A <= A xor '1';
                B <= B xor A;
                C <= C xor (A and B);
            end if;
        end if;
    end process;

    A_out <= A;
    B_out <= B;
    C_out <= C;

end Behavioral;
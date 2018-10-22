-- 4-bit (mod16) counter using d flip flops
--   connected as t flip flops
library ieee;
use ieee.std_logic_1164.all;

entity counter4_a is
    port ( en, clk, rst  : in  std_logic;
           count_o : out std_logic_vector(3 downto 0)
        );
end counter4_a;

architecture rtl of counter4_a is

    signal a, b, c, d : std_logic := '0';

begin

    process(clk, rst) is
    begin
        -- reset all the flip flop outputs to 0
        if rst = '1' then
            a <= '0';
            b <= '0';
            c <= '0';
            d <= '0';
        -- each rising edge, update the flip flops
        elsif rising_edge(clk) then
            if en = '1' then
                a <= a xor '1';
                b <= b xor a;
                c <= c xor (a and b);
                d <= d xor (a and b and c);
            end if;
        end if;
    end process;

    -- assign the outputs outside of process
    count_o <= d & c & b & a;

end rtl;
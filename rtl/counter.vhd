-- 4-bit (mod16) counter using d flip flops
--   connected as t flip flops
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port (
    en, clk : in  std_logic;
    cout    : out std_logic_vector(3 downto 0)
);
end counter;

architecture bhv of counter is
    signal a, b, c, d : std_logic := '0';
begin

    process(clk) is
    begin
        if rising_edge(clk) then
            -- each rising edge, update the flip flops
            if en = '1' then
                -- reset when counter hits 12
                if a = '0' and b = '0' and c = '1' and d = '1' then
                    a <= '0';
                    b <= '0';
                    c <= '0';
                    d <= '0';
                else
                    a <= a xor '1';
                    b <= b xor a;
                    c <= c xor (a and b);
                    d <= d xor (a and b and c);
                end if;
            end if;
        end if;
    end process;

    -- assign the outputs outside of process
    cout <= d & c & b & a;

end bhv;


architecture rtl of counter is
    -- initialize counter signal to all 0s
    signal cnt : unsigned(3 downto 0) := (others => '0');
begin

    process(clk) is
    begin
        -- Check for rising edge on the registers.
        if rising_edge(clk) then
            if en = '1' then
                -- reset when counter hits 12
                if cnt = 12 then
                    cnt <= (others => '0');
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;

    -- Assign the output outside of process.
    cout <= std_logic_vector(cnt);

end rtl;

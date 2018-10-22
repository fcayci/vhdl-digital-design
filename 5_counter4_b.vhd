-- 4-bit counter practical
-- reset after counter hits 12

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter4_b is
    port ( en, clk, rst : in std_logic;
           count_o : out std_logic_vector(3 downto 0)
    );
end counter4_b;

architecture rtl of counter4_b is
    signal counter : unsigned(3 downto 0) := (others => '0');
begin

    process(clk, rst) is
    begin
        -- reset flip-flop outputs (all counter bits) to 0 when
        --  rst signal is activated
        if rst = '1' then
            counter <= (others => '0');
        -- Increment the flip-flop outputs if enabled and rising edge hits.
        elsif rising_edge(clk) then
        --elsif clk'event and clk = '1' then
            if en = '1' then
                -- reset when counter hits 12
                if counter = "1100" then
                    counter <= "0000";
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    -- Assign the output outside of process.
    count_o <= std_logic_vector(counter);

end rtl;
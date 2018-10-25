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

    process(clk) is
    begin
        -- Check for rising edge on the registers.
        if rising_edge(clk) then
            -- reset flip-flop outputs (all counter bits) to 0 if
            --    rst signal is active
            if rst = '1' then
                counter <= (others => '0');
            elsif en = '1' then
                -- reset when counter hits 12
                if counter = "1100" then
                    counter <= (others => '0');
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    -- Assign the output outside of process.
    count_o <= std_logic_vector(counter);

end rtl;
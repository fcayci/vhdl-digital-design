-- Pulse generator
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pulse_generator is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ce  : in  STD_LOGIC;
           pulse_out : out  STD_LOGIC);
end pulse_generator;

architecture Behavioral of pulse_generator is

    -- Create an intermediate signal for counting and initialize it to 0s.
    -- It hould be a big number since 50 MHz is roughly around 50 x 2^20 ~= 2^26
    SIGNAL count : STD_LOGIC_VECTOR(24 downto 0) := (others => '0');

begin

    process (clk, rst) is
    begin
        -- First check for reset pin
        if rst = '1' then
            count <= (others => '0');
        -- Second and last check for clock event.
        elsif clk'event and clk = '1' then
            -- If the circuit is not enabled don't do anything. (Chip Enable)
            if ce = '1' then
                -- Increment the counter every clock cycle. This will go back to zero
                --   once overflows. So no need to reset it ourselves.
                count <= count + 1;
                -- Whenever it goes back to all 0's create a pulse for one clock cycle.
                --   The frequency of this new pulse (or clock) depend on the number of bits
                --   count has. If you want an exact frequency, reset the count back to zero
                --   when it reaches to that specific value.
                if count = "0000000000000000000000000" then
                    pulse_out <= '1';
                else
                    pulse_out <= '0';
                end if;
            end if;
        end if;
    end process;
        
end Behavioral;
-- pulse generator
-- use counter_tb.vhd for testbench
-- generates a one-clock cycle pulse after every 99 clocks;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_generator is
    port ( en, clk, rst : in std_logic;
           pulse_o : out std_logic
    );
end pulse_generator;

architecture rtl of pulse_generator is
    signal counter : natural range 0 to 100 := 0;
begin

    process(clk, rst) is
    begin
        if rst = '1' then
            counter <= 0;
        elsif rising_edge(clk) then
            if en = '1' then
                pulse_o <= '0'; -- assign default value for pulse_o. next values will overwrite this
                if counter = 99 then
                    pulse_o <= '1';
                    counter <= 0;
                else
                    counter <= counter + 1;
                    -- pulse_o <= '0'; -- alternative place for default value.
                end if;
            end if;
        end if;
    end process;

end rtl;

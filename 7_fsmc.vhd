-- finite state machine implementation
-- everything is merged into one process
-- mealy output is delayed by one clock cycle to avoid glitches
-- moore output is delayed by one clock cycle
--   but, can be treated like mealy to set earlier

library ieee;
use ieee.std_logic_1164.all;

entity fsmc is
    port(
        clk, rst : in std_logic;
        a, b : in std_logic;
        mealy, moore : out std_logic
    );
end fsmc;

architecture rtl of fsmc is
    -- define custom type for states
    -- next-state logic is merged into one state
    type state_type is (s0, s1, s2);
    signal state : state_type := s0;
begin

    process(clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= s0;
                moore <= '0';
                mealy <= '0';
            else
                -- default values for all the outputs
                -- used to avoid any accidental unintentional memory generation
                state <= s0;
                moore <= '0';
                mealy <= '0';

                case state is
                    when s0 =>
                        if a = '1' then
                            if b = '1' then
                                state <= s2;
                                mealy <= '1';
                            else
                                state <= s1;
                                -- can be added to set moore output earlier
                                --moore <= '1';
                            end if;
                        end if;
                    when s1 =>
                        moore <= '1';
                        if a = '1' then
                            state <= s0;
                            -- can be added to reset moore output earlier
                            --moore <= '0';
                        else
                            state <= s1;
                        end if;
                    when s2 =>
                        state <= s0;
                end case;
            end if;
        end if;
    end process;

end rtl;
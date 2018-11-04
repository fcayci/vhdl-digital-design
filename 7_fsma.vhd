-- finite state machine implementation
-- separate next-state logic
-- separate outputs for both mealy and moore

library ieee;
use ieee.std_logic_1164.all;

entity fsma is
    port(
        clk, rst : in std_logic;
        a, b : in std_logic;
        mealy, moore : out std_logic
    );
end fsma;

architecture rtl of fsma is
    -- define custom type for states
    type state_type is (s0, s1, s2);
    signal state, state_next : state_type := s0;
begin

    -- state registers
    process(clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= s0;
            else
                state <= state_next;
            end if;
        end if;
    end process;

    -- next-state logic
    process(state, a, b) is
    begin
        case state is
            when s0 =>
                if a = '1' then
                    if b = '1' then
                        state_next <= s2;
                    else
                        state_next <= s1;
                    end if;
                else
                    state_next <= s0;
                end if;
            when s1 =>
                if a = '1' then
                    state_next <= s0;
                else
                    state_next <= s1;
                end if;
            when s2 =>
                state_next <= s0;
        end case;
    end process;

    -- output logic (moore)
    process(state) is
    begin
        case state is
            when s0 | s2 =>
                moore <= '0';
            when s1 =>
                moore <= '1';
        end case;
    end process;


    -- output logic (mealy)
    -- susceptible to short input changes
    -- might create glitches
    -- can be put behind a register
    process(state, a, b) is
    begin
        case state is
            when s0 =>
                if a = '1' and b = '1' then
                    mealy <= '1';
                else
                    mealy <= '0';
                end if;
            when s1 | s2 =>
                mealy <= '0';
        end case;
    end process;

end rtl;
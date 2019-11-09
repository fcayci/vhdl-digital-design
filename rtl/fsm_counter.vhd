-- finite state machine implementations
--   showing when using a counter on a simple pwm example
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_counter is
port(
    clk  : in std_logic;
    o    : out std_logic
);
end fsm_counter;

-- implementation #1
-- next-state and output logic are merged
-- separate registes
architecture rtla of fsm_counter is
    type state_type is (s1, s2);
    signal state, state_next : state_type := s1;

    signal cnt, cnt_next : integer range 0 to 15 := 0;
    signal trgt, trgt_next : integer range 0 to 15 := 0;

begin

    -- state registers
    process(clk) is
    begin
        if rising_edge(clk) then
            state <= state_next;
            cnt <= cnt_next;
            trgt <= trgt_next;
        end if;
    end process;


    process(state, cnt, trgt) is
    begin
        -- defaults for latch avoidance
        -- read from regs and write to _next
        state_next <= state;
        cnt_next <= cnt;
        trgt_next <= trgt;

        case state is
        when s1 =>
            o <= '1';
            if cnt = trgt then
                state_next <= s2;
                if trgt = 15 then
                    trgt_next <= 0;
                else
                    trgt_next <= trgt + 1;
                end if;
            else
                cnt_next <= cnt + 1;
            end if;
        when s2 =>
            o <= '0';
            if cnt = 15 then
                cnt_next <= 0;
                state_next <= s1;
            else
                cnt_next <= cnt + 1;
            end if;
        end case;
    end process;

end rtla;

-- implementation #2
-- registers, next-state and output logic are merged
architecture rtlb of fsm_counter is
    type state_type is (s1, s2);
    signal state : state_type := s1;

    signal cnt : integer range 0 to 15 := 0;
    signal trgt : integer range 0 to 15 := 0;
begin

    process(clk) is
    begin
        if rising_edge(clk) then
            case state is
            when s1 =>
                o <= '1';
                if cnt = trgt then
                    state <= s2;
                    if trgt = 15 then
                        trgt <= 0;
                    else
                        trgt <= trgt + 1;
                    end if;
                else
                    cnt <= cnt + 1;
                end if;
            when s2 =>
                o <= '0';
                if cnt = 15 then
                    cnt <= 0;
                    state <= s1;
                else
                    cnt <= cnt + 1;
                end if;
            end case;
        end if;
    end process;

end rtlb;

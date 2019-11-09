-- finite state machine implementations
library ieee;
use ieee.std_logic_1164.all;

entity fsm is
port(
    clk  : in std_logic;
    a, b : in std_logic;
    mealy, moore : out std_logic
);
end fsm;

-- implementation #1
-- separate next-state logic
-- separate outputs for both mealy and moore
architecture rtla of fsm is
    -- define custom type for states
    type state_type is (s0, s1, s2);
    signal state, state_next : state_type := s0;
begin

    -- state registers
    process(clk) is
    begin
        if rising_edge(clk) then
            state <= state_next;
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
        when others =>
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
    --   susceptible to short input changes
    --   might create glitches
    --   can be put behind a register
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
end rtla;

-- implementation #2
-- next-state logic and outputs are
-- merged into one process
architecture rtlb of fsm is
    -- define custom type for states
    type state_type is (s0, s1, s2);
    signal state, state_next : state_type := s0;
begin

    -- state registers
    process(clk) is
    begin
        if rising_edge(clk) then
            state <= state_next;
        end if;
    end process;

    -- next-state and output logic
    --   susceptible to short input changes
    --   for mealy outputs
    process(state, a, b) is
    begin
        -- default values for all the outputs
        -- used to avoid any accidental unintentional memory generation
        state_next <= state;
        mealy <= '0';
        moore <= '0';

        case state is
        when s0 =>
            if a = '1' then
                if b = '1' then
                    state_next <= s2;
                    mealy <= '1';
                else
                    state_next <= s1;
                end if;
            else
                state_next <= s0;
            end if;
        when s1 =>
            moore <= '1';
            if a = '1' then
                state_next <= s0;
            else
                state_next <= s1;
            end if;
        when s2 =>
            state_next <= s0;
        when others =>
            state_next <= s0;
        end case;
    end process;
end rtlb;

-- implementation #3
-- everything is merged into one process
-- state is made a variable just to give a different example
architecture rtlc of fsm is
begin

    process(clk) is
        type state_type is (s0, s1, s2);
        variable state : state_type := s0;
    begin
        if rising_edge(clk) then
            -- default values for outputs
            moore <= '0';
            mealy <= '0';

            case state is
            when s0 =>
                if a = '1' then
                    if b = '1' then
                        state := s2;
                        -- will overwrite default mealy value
                        mealy <= '1';
                    else
                        state := s1;
                    end if;
                end if;
            when s1 =>
                -- will overwrite default moore value
                moore <= '1';
                if a = '1' then
                    state := s0;
                else
                    state := s1;
                end if;
            when s2 =>
                state := s0;
            end case;
        end if;
    end process;
end rtlc;

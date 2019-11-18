-- finite state machine implementation: serializer multi cycle
--  whenever i_start is high for one clock cycle
--  it will buffer the input data, and start transmission
--  each transmission will last for M cycles
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_serializer_mc is
generic (
    M : integer := 100; -- timer duration
    D : integer := 8 -- data bits
);
port (
    clk, rst  : in std_logic;
    i_start   : in std_logic;
    i_data    : in std_logic_vector(D-1 downto 0);
    o_tx      : out std_logic;
    o_tx_done : out std_logic
);
end fsm_serializer_mc;

architecture rtl of fsm_serializer_mc is
    type state_type is (idle, ones, payload, zeros);
    signal state, state_next : state_type := idle;
    signal cnt, cnt_next : integer range 0 to 15 := 0;
    signal data, data_next : std_logic_vector(D-1 downto 0) := (others =>'0');

    signal tmrst, tmrtick : std_logic := '0';
    signal tmr : integer := 0;
begin

    -- this is the timer part
    -- can be instantiated as a module and port mapped
    -- i.e. port map(clk=>clk, rst=>tmrst, done=>tmrtick);
    process(clk) is
    begin
        if rising_edge(clk) then
            if tmrst = '1' then
                tmr <= 0;
                tmrtick <= '0';
            else
                if tmr = M-1 then
                    tmr <= 0;
                    tmrtick <= '1';
                else
                    tmr <= tmr + 1;
                    tmrtick <= '0';
                end if;
            end if;
        end if;
    end process;

    -- state registers
    process(clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= idle;
                cnt <= 0;
                data <= (others=>'0');
            else
                state <= state_next;
                cnt <= cnt_next;
                data <= data_next;
            end if;
        end if;
    end process;

    -- next-state / output logic
    process(state, cnt, data, i_start, i_data, tmrtick) is
    begin
        -- defaults for latch avoidance
        -- read from regs and write to _next
        state_next <= state;
        cnt_next <= cnt;
        data_next <= data;
        -- since outputs are driven from here
        -- we need to pass defaults as well
        o_tx <= '0';
        o_tx_done <= '0';

        -- keep timer running by default
        tmrst <= '0';

        case state is
        when idle =>
            if i_start = '1' then
                -- latch data so that if it changes
                -- our tx does not mess up
                data_next <= i_data;
                state_next <= ones;
                cnt_next <= 0;
            else
                -- reset timer when in idle and start is not here
                tmrst <= '1';
            end if;
        when ones =>
            -- output when in ones state
            o_tx <= '1';

            if tmrtick = '1' then
                if cnt = 3 then
                    state_next <= payload;
                    cnt_next <= 0;
                else
                    cnt_next <= cnt + 1;
                end if;
            end if;
        when payload =>
            -- output when in payload state
            -- shift lsb out
            o_tx <= data(0);

            if tmrtick = '1' then
                if cnt = D-1 then
                    state_next <= zeros;
                    cnt_next <= 0;
                else
                    -- shift data to right
                    data_next <= '0' & data(D-1 downto 1);
                    cnt_next <= cnt + 1;
                end if;
            end if;
        when zeros =>
            -- output when in zeros state
            o_tx <= '0';

            if tmrtick = '1' then
                if cnt = 3 then
                    -- send tx_done for only one cycle
                    -- can create another state if multi cycle done
                    -- signal is needed
                    o_tx_done <= '1';
                    state_next <= idle;
                    cnt_next <= 0;
                else
                    cnt_next <= cnt + 1;
                end if;
            end if;
        end case;
    end process;

end rtl;
-- finite state machine implementation: serializer
--  whenever i_start is high for one clock cycle
--  it will buffer the input data, and start transmission
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_serializer is
generic (
    D : integer := 8 -- data bits
);
port (
    clk, rst  : in std_logic;
    i_start   : in std_logic;
    i_data    : in std_logic_vector(D-1 downto 0);
    o_tx      : out std_logic;
    o_tx_done : out std_logic
);
end fsm_serializer;

architecture rtl of fsm_serializer is
    type state_type is (idle, ones, payload, zeros);
    signal state, state_next : state_type := idle;
    signal cnt, cnt_next : integer range 0 to 15 := 0;
    signal data, data_next : std_logic_vector(D-1 downto 0) := (others =>'0');
begin

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
    process(state, cnt, data, i_start, i_data) is
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

        case state is
        when idle =>
            if i_start = '1' then
                -- latch data so that if it changes
                -- our tx does not mess up
                data_next <= i_data;
                state_next <= ones;
                cnt_next <= 0;
            end if;
        when ones =>
            -- output when in ones state
            o_tx <= '1';

            if cnt = 3 then
                state_next <= payload;
                cnt_next <= 0;
            else
                cnt_next <= cnt + 1;
            end if;
        when payload =>
            -- output when in payload state
            -- shift lsb out
            o_tx <= data(0);

            if cnt = D-1 then
                state_next <= zeros;
                cnt_next <= 0;
            else
                -- shift data to right
                data_next <= '0' & data(D-1 downto 1);
                cnt_next <= cnt + 1;
            end if;
        when zeros =>
            -- output when in zeros state
            o_tx <= '0';

            if cnt = 3 then
                -- this will send done on the last bit of zeros
                -- we could delay it one more cycle if needed
                o_tx_done <= '1';
                state_next <= idle;
                cnt_next <= 0;
            else
                cnt_next <= cnt + 1;
            end if;
        end case;
    end process;

end rtl;
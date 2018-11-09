-- asyncronous fifo example with empty / full flags
--   separate read / write clock
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_async is
    generic(
        M : integer := 10; -- depth 2**M
        N : integer := 18  -- width N-bits
    );
    port(
        rst_i : in std_logic;
        -- write interface
        clk_wr_i : in std_logic;
        wr_en_i  : in std_logic;
        din_i    : in std_logic_vector(N -1 downto 0);
        -- read interface
        clk_rd_i : in std_logic;
        rd_en_i  : in std_logic;
        dout_o   : out  std_logic_vector(N - 1 downto 0);
        -- flow control
        empty_o, full_o : out std_logic
    );
end fifo_async;

architecture rtl of fifo_async is
    type fifo_type is array(0 to 2**M - 1) of std_logic_vector(N - 1 downto 0);
    signal FIFO : fifo_type;

    signal wr_ptr, rd_ptr : integer range 0 to 2**M - 1 := 0;
    signal empty, full : std_logic := '0';

    -- do not optimize away empty / full signals
    attribute keep : string;
    attribute keep of empty : signal is "true";
    attribute keep of full : signal is "true";
begin

    write: process(clk_wr_i) is
    begin
        if rising_edge(clk_wr_i) then
            if rst_i = '1' then
                wr_ptr <= 0;
            elsif wr_en_i = '1' then
                if full = '0' then
                    FIFO(wr_ptr) <= din_i;
                    if wr_ptr = 2**M - 1 then
                        wr_ptr <= 0;
                    else
                        wr_ptr <= wr_ptr + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    read: process(clk_rd_i) is
    begin
        if rising_edge(clk_rd_i) then
            if rst_i = '1' then
                rd_ptr <= 0;
            elsif rd_en_i = '1' then
                if empty = '0' then
                    if rd_ptr = 2**M - 1 then
                        rd_ptr <= 0;
                    else
                        rd_ptr <= rd_ptr + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    empty <= '1' when wr_ptr - rd_ptr = 0 else '0';
    full  <= '1' when rd_ptr - wr_ptr = 1 or (rd_ptr = 0 and wr_ptr = 2**M - 1) else '0';

    empty_o <= empty;
    full_o <= full;

    dout_o <= FIFO(rd_ptr);
end rtl;
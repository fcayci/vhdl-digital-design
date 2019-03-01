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
	i_rst : in std_logic;
	-- write interface
	i_clk_wr : in std_logic;
	i_wr_en  : in std_logic;
	i_din    : in std_logic_vector(N -1 downto 0);
	-- read interface
	i_clk_rd : in std_logic;
	i_rd_en  : in std_logic;
	o_dout   : out  std_logic_vector(N - 1 downto 0);
	-- flow control
	o_empty, o_full : out std_logic
);
end fifo_async;

architecture rtl of fifo_async is
	type fifo_type is array(0 to 2**M - 1) of std_logic_vector(N - 1 downto 0);
	signal FIFO : fifo_type := (others => (others => '0'));

	signal wr_ptr, rd_ptr : integer range 0 to 2**M - 1 := 0;
	signal empty, full : std_logic := '0';

	-- do not optimize away empty / full signals
	attribute keep : string;
	attribute keep of empty : signal is "true";
	attribute keep of full : signal is "true";
begin

	write: process(i_clk_wr) is
	begin
		if rising_edge(i_clk_wr) then
			if i_rst = '1' then
				wr_ptr <= 0;
			elsif i_wr_en = '1' then
				if full = '0' then
					FIFO(wr_ptr) <= i_din;
					if wr_ptr = 2**M - 1 then
						wr_ptr <= 0;
					else
						wr_ptr <= wr_ptr + 1;
					end if;
				end if;
			end if;
		end if;
	end process;

	read: process(i_clk_rd) is
	begin
		if rising_edge(i_clk_rd) then
			if i_rst = '1' then
				rd_ptr <= 0;
			elsif i_rd_en = '1' then
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

	o_empty <= empty;
	o_full <= full;

	o_dout <= FIFO(rd_ptr);
end rtl;
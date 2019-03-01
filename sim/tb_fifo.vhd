-- fifo testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fifo is
end tb_fifo;

architecture rtl of tb_fifo is

	constant M : integer := 4;
	constant N : integer := 8;
	signal rst, clk_wr, wr_en, clk_rd, rd_en : std_logic := '0';
	signal din : std_logic_vector(N - 1 downto 0) := (others => '0');

	signal empty_async, full_async : std_logic;
	signal empty_sync, full_sync : std_logic;
	signal dout_async : std_logic_vector(N - 1 downto 0) := (others => '0');
	signal dout_sync  : std_logic_vector(N - 1 downto 0) := (others => '0');

	constant clk_wr_time : time := 20 ns;
	constant clk_rd_time : time := 10 ns;

begin
	f0: entity work.fifo_sync(rtl)
		generic map ( M=>M, N=>N )
		port map (
			i_rst=>rst, i_clk=>clk_rd, i_wr_en=>wr_en,
			i_din=>din, i_rd_en=>rd_en,
			o_dout=>dout_sync, o_empty=>empty_sync, o_full=>full_sync
		);

	f2: entity work.fifo_async(rtl)
		generic map ( M=>M, N=>N )
		port map (
			i_rst=>rst, i_clk_wr=>clk_wr, i_wr_en=>wr_en,
			i_din=>din, i_clk_rd=>clk_rd, i_rd_en=>rd_en,
			o_dout=>dout_async, o_empty=>empty_async, o_full=>full_async
		);

	-- write clock
	gen_wr_clk: process
	begin
		for i in 0 to 100 loop
	   		wait for clk_wr_time/2;
			clk_wr <= '1';
			wait for clk_wr_time/2;
			clk_wr <= '0';
		end loop;
		wait;
	end process;

	-- read clock
	gen_rd_clk: process
	begin
		for i in 0 to 200 loop
			wait for clk_rd_time/2;
			clk_rd <= '1';
			wait for clk_rd_time/2;
			clk_rd <= '0';
		end loop;
		wait;
	end process;

	-- stimulus
	stimulus: process
	begin
		rst <= '1';
		wait for 20 * clk_rd_time;
		rst <= '0';

		for i in 1 to 20 loop
			din <= std_logic_vector(to_unsigned(i, N));
			wait for clk_wr_time;
			wr_en <= '1';
			wait for clk_wr_time;
			wr_en <= '0';
		end loop;

		wait until clk_rd = '0';
		rd_en <= '1';
		wait for 3 * clk_rd_time;
		rd_en <= '0';

		for i in 1 to 5 loop
			din <= std_logic_vector(to_unsigned(i, N));
			wait for clk_wr_time;
			wr_en <= '1';
			wait for clk_wr_time;
			wr_en <= '0';
		end loop;

		wait until clk_rd = '0';

		for i in 1 to 20 loop
			rd_en <= '1';
			wait for clk_rd_time;
		end loop;


		wait;
	end process;

end rtl;

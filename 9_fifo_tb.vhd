-- fifo testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_tb is
end fifo_tb;

architecture rtl of fifo_tb is

    component fifo_sync is
    generic(
        M : integer := 10; -- depth 2**M
        N : integer := 18  -- width N-bits
    );
    port(
        rst_i : in std_logic;
        clk_i : in std_logic;
        -- write interface
        wr_en_i  : in std_logic;
        din_i    : in std_logic_vector(N -1 downto 0);
        -- read interface
        rd_en_i  : in std_logic;
        dout_o   : out  std_logic_vector(N - 1 downto 0);
        -- flow control
        empty_o, full_o : out std_logic
    );
    end component;

    component fifo_async is
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
    end component;

    constant M : integer := 4;
    constant N : integer := 8;
    signal rst_i, clk_wr_i, wr_en_i, clk_rd_i, rd_en_i : std_logic := '0';
    signal din_i : std_logic_vector(N - 1 downto 0) := (others => '0');

    signal empty_o_async, full_o_async : std_logic;
    signal empty_o_sync, full_o_sync : std_logic;
    signal dout_o_async : std_logic_vector(N - 1 downto 0) := (others => '0');
    signal dout_o_sync  : std_logic_vector(N - 1 downto 0) := (others => '0');

    constant clk_wr_time : time := 20 ns;
    constant clk_rd_time : time := 10 ns;

begin
    f0: fifo_sync
        generic map ( M=>M, N=>N )
        port map (
            rst_i=>rst_i, clk_i=>clk_rd_i, wr_en_i=>wr_en_i,
            din_i=>din_i, rd_en_i=>rd_en_i,
            dout_o=>dout_o_sync, empty_o=>empty_o_sync, full_o=>full_o_sync
        );

    f2: fifo_async
        generic map ( M=>M, N=>N )
        port map (
            rst_i=>rst_i, clk_wr_i=>clk_wr_i, wr_en_i=>wr_en_i,
            din_i=>din_i, clk_rd_i=>clk_rd_i, rd_en_i=>rd_en_i,
            dout_o=>dout_o_async, empty_o=>empty_o_async, full_o=>full_o_async
        );

    -- write clock
    gen_wr_clk: process
    begin
		for i in 0 to 100 loop
       		wait for clk_wr_time/2;
        	clk_wr_i <= '1';
        	wait for clk_wr_time/2;
        	clk_wr_i <= '0';
		end loop;
		wait;
    end process;

    -- read clock
    gen_rd_clk: process
    begin
		for i in 0 to 200 loop
        	wait for clk_rd_time/2;
        	clk_rd_i <= '1';
        	wait for clk_rd_time/2;
        	clk_rd_i <= '0';
		end loop;
		wait;
    end process;

    -- stimulus
    stimulus: process
    begin
        rst_i <= '1';
        wait for 20 * clk_rd_time;
        rst_i <= '0';

        for i in 1 to 20 loop
            din_i <= std_logic_vector(to_unsigned(i, N));
            wait for clk_wr_time;
            wr_en_i <= '1';
            wait for clk_wr_time;
            wr_en_i <= '0';
        end loop;

        wait until clk_rd_i = '0';
        rd_en_i <= '1';
        wait for 3 * clk_rd_time;
        rd_en_i <= '0';

        for i in 1 to 5 loop
            din_i <= std_logic_vector(to_unsigned(i, N));
            wait for clk_wr_time;
            wr_en_i <= '1';
            wait for clk_wr_time;
            wr_en_i <= '0';
        end loop;

        wait until clk_rd_i = '0';

        for i in 1 to 20 loop
          rd_en_i <= '1';
          wait for clk_rd_time;
        end loop;


        wait;
    end process;

end rtl;

-- 1-bit d flip-flop examples
library ieee;
use ieee.std_logic_1164.all;

entity dff is
port (
	d   : in std_logic;
	clk : in std_logic;
	en  : in std_logic;
	set : in std_logic;
	rst : in std_logic;
	q1, q2, q3, q4 : out std_logic;
	q5, q6, q7, q8 : out std_logic
);
end dff;

architecture rtl of dff is
begin

	-- rising-edge triggered dff
	process(clk) is
	begin
		if rising_edge(clk) then
			q1 <= d;
		end if;
	end process;

	-- falling-edge triggered dff
	process(clk) is
	begin
		--if falling_edge(clk) then
		if clk'event and clk = '0' then
			q2 <= d;
		end if;
	end process;

	-- dff with async reset (clear)
	process(rst, clk) is
	begin
		if rst = '1' then
			q3 <= '0';
		elsif rising_edge(clk) then
			q3 <= d;
		end if;
	end process;

	-- dff with sync reset
	process(rst, clk) is
	begin
		if rising_edge(clk) then
			if  rst = '1' then
				q4 <= '0';
			else
				q4 <= d;
			end if;
		end if;
	end process;

	-- dff with async reset and enable
	process(rst, clk) is
	begin
		if rst = '1' then
			q5 <= '0';
		elsif rising_edge(clk) then
			if en = '1' then
				q5 <= d;
			end if;
		end if;
	end process;


	-- dff with sync reset and enable
	process(clk) is
	begin
		if rising_edge(clk) then
			if rst = '1' then
				q6 <= '0';
			elsif en = '1' then
				q6 <= d;
			end if;
		end if;
	end process;

	-- dff with async set (preset) and enable
	process(set, clk) is
	begin
		if set = '1' then
			q7 <= '1';
		elsif rising_edge(clk) then
			if en = '1' then
				q7 <= d;
			end if;
		end if;
	end process;


	-- dff with sync set and enable
	process(clk) is
	begin
		if rising_edge(clk) then
			if set = '1' then
				q8 <= '1';
			elsif en = '1' then
				q8 <= d;
			end if;
		end if;
	end process;

end rtl;
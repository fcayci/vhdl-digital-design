-- N-bit shift register
--   a. using concatenation
--   b. using for-loop
library ieee;
use ieee.std_logic_1164.all;

entity shreg is
	generic(
		N : integer := 32
	);
	port(
		clk : in std_logic;
		si  : in std_logic;
		so  : out std_logic
	);
end shreg;

architecture rtla of shreg is
	signal sreg : std_logic_vector(N - 1 downto 0);
begin

	-- a. concatenation way
	process(clk) is
	begin
		if rising_edge(clk) then
			sreg <= sreg(N - 2 downto 0) & si;
		end if;
	end process;

	so <= sreg(N - 1);

end rtla;

architecture rtlb of shreg is
	signal sreg : std_logic_vector(N - 1 downto 0);
begin

	-- b. for loop way
	process(clk) is
	begin
		if rising_edge(clk) then
			for i in 0 to N - 2 loop
				sreg(i+1) <= sreg(i);
			end loop;
			sreg(0) <= si;
		end if;
	end process;

	so <= sreg(N - 1);

end rtlb;
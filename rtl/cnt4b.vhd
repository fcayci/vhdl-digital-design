-- 4-bit counter practical
-- reset after counter hits 12

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cnt4b is
port (
	en, clk : in  std_logic;
	cout    : out std_logic_vector(3 downto 0)
);
end cnt4b;

architecture rtl of cnt4b is
	-- initialize counter signal to all 0s
	signal counter : unsigned(3 downto 0) := (others => '0');
begin

	process(clk) is
	begin
		-- Check for rising edge on the registers.
		if rising_edge(clk) then
			if en = '1' then
				-- reset when counter hits 12
				if counter = 12 then
					counter <= (others => '0');
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;

	-- Assign the output outside of process.
	cout <= std_logic_vector(counter);

end rtl;
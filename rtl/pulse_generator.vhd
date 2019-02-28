-- pulse generator
--   generates a one-clock cycle pulse after every 99 clocks;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_generator is
port (
	en, clk : in  std_logic;
	o_pulse : out std_logic
);
end pulse_generator;

architecture rtl of pulse_generator is
	signal counter : natural range 0 to 100 := 0;
begin

	process(clk) is
	begin
		if rising_edge(clk) then
			if en = '1' then
				-- default output
				o_pulse <= '0';
				if counter = 99 then
					-- overwritten output
					o_pulse <= '1';
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
			end if;
		end if;
	end process;

end rtl;

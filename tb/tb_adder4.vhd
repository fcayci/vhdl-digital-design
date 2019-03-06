-- 4-bit adder subtractor testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_adder4 is
end tb_adder4;

architecture bhv of tb_adder4 is
	-- declare addsub4 circut as a component
	component adder4 is
	port (
		a, b    : in  std_logic_vector(3 downto 0);
		cin     : in  std_logic;
		s       : out std_logic_vector(3 downto 0);
		v, cout : out std_logic
	);
	end component;

	signal a, b : std_logic_vector(3 downto 0);
	signal s : std_logic_vector(3 downto 0);
	signal cin, cout : std_logic;
begin
	--  instantiate addsub4 component.
	a0: adder4
	  port map (a => a, b => b, cin => cin, s => s, cout => cout);

	process
	begin
		wait for 100 ns;
		for i in 0 to 15 loop
			for j in 0 to 15 loop
				a <= std_logic_vector(to_unsigned(i, 4));
				b <= std_logic_vector(to_unsigned(j, 4));
				wait for 1 ns;
				cin <= '1';
				wait for 1 ns;
				cin <= '0';
			end loop;
		end loop;
		wait for 10 ns;
		wait;
	end process;

end bhv;
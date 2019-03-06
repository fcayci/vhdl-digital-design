-- 1-bit full adder testbench
--   modified from ghdl adder testbench example
-- A testbench has no ports
library ieee;
use ieee.std_logic_1164.all;

entity tb_full_adder is
end tb_full_adder;

architecture bhv of tb_full_adder is
	-- with '93, component does not
	--  need to be declared anymore
	signal a, b, cin : std_logic;
	signal s0, s1, cout0, cout1 : std_logic;
begin
	-- instantiate full_adder component
	--   syntax: entity work.entity_name(arch_name)
	f0: entity work.full_adder(bhv)
	  port map (a => a, b => b, cin => cin, s => s0, cout => cout0);

	f1: entity work.full_adder(str)
	  port map (a => a, b => b, cin => cin, s => s1, cout => cout1);

	process
		type pattern_type is record
			--  inputs of the adder.
			a, b, cin : std_logic;
			--  expected outputs of the adder.
			s, cout : std_logic;
		end record;
		--  patterns to apply.
		type pattern_array is array (natural range <>) of pattern_type;
		constant patterns : pattern_array :=
			(('0', '0', '0', '0', '0'),
			('0', '0', '1', '1', '0'),
			('0', '1', '0', '1', '0'),
			('0', '1', '1', '0', '1'),
			('1', '0', '0', '1', '0'),
			('1', '0', '1', '0', '1'),
			('1', '1', '0', '0', '1'),
			('1', '1', '1', '1', '1'));
	begin
		--  check each pattern.
		for i in patterns'range loop
			--  Set the inputs.
			a <= patterns(i).a;
			b <= patterns(i).b;
			cin <= patterns(i).cin;
			--  wait for the results.
			wait for 1 ns;
			--  check the outputs.
			assert s0 = patterns(i).s
			  report "bad sum value" severity error;
			assert s1 = patterns(i).s
			  report "bad sum value" severity error;
			assert cout0 = patterns(i).cout
			  report "bad carray out value" severity error;
			assert cout1 = patterns(i).cout
			  report "bad carray out value" severity error;
		end loop;
		assert false report "end of test" severity note;
		--  wait forever; this will finish the simulation.
		wait;
	end process;
end bhv;
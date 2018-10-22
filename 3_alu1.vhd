-- 1-bit alu circuit
library ieee;
use ieee.std_logic_1164.all;

-- functions implemented
-- opcode       function
-- 000          a + b
-- 001          a - b
-- 010          a xor b
-- 011          a and b
-- 100          shift left a
-- 101          not a
-- 110          increment a
-- 111          clear

entity alu1 is
    port (
        a, b   : in  std_logic;  -- operands
        cin    : in  std_logic;  -- carry in
        opcode : in std_logic_vector(1 downto 0); -- opcode (select)
        s      : out std_logic;  -- result
        cout   : out std_logic   -- carry out
    );
end alu1;


architecture rtl of alu1 is
begin

    -- calculate result output
    with opcode select
        s <= a xor B xor z          when "000",  -- a + b
             a xor b xor z          when "001",  -- a - b
             a xor b                when "010",  -- a xor b
             a and b                when "011",  -- a and b
             cin                    when "100",  -- shift left a
             not a                  when "101",  -- not a
             a xor cin              when "110",  -- increment a
             '0'                    when others; -- clear

    -- calculate carry output
    with opcode select
     cout <= (a and b) or (cin and (a xor b))        when "000", -- a + b
             ((not a) and b) or (cin and (a xnor b)) when "001", -- a - b
             '0'                                     when "010", -- a xor b
             '0'                                     when "011", -- a and b
             a                                       when "100", -- shift left a
             '0'                                     when "101", -- not a
             a and cin                               when "110", -- increment a
             '0'                                     when others;

end rtl;
-- 1-bit ALU circuit
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Functions implemented
-- OPCODE       FUNCTION
-- 000          A + B
-- 001          A - B
-- 010          A XOR B
-- 011          A AND B
-- 100          SHIFT LEFT A
-- 101          NOT A
-- 110          INCREMENT A
-- 111          CLEAR

entity alu1 is
    Port ( A      : in  STD_LOGIC;  -- Operand 1
           B      : in  STD_LOGIC;  -- Operand 2
           OPCODE : in  STD_LOGIC_VECTOR(2 downto 0);  -- Opcode (Select)
           Z      : in  STD_LOGIC;  -- Carry In
           F      : out STD_LOGIC;  -- Result
           C      : out STD_LOGIC   -- Carry Out
    );
end alu1;

architecture Behavioral of alu1 is

begin

    -- Calculate output
    with OPCODE select
        F <= (A XOR B) XOR Z        when "000",  -- A + B
             (A XOR B) XOR Z        when "001",  -- A - B
             A XOR B                when "010",  -- A XOR B
             A AND B                when "011",  -- A AND B
             Z                      when "100",  -- SHIFT LEFT A
             NOT A                  when "101",  -- NOT A
             A XOR Z                when "110",  -- INCREMENT A
             '0'                    when others; -- CLEAR

    -- Calculate carry
    with OPCODE select
        C <= (A AND B) OR (Z AND (A XOR B))             when "000", -- A + B
             ((NOT A) AND B) OR (Z AND (NOT (A XOR B))) when "001", -- A - B
             '0'        when "010",        -- A XOR B
             '0'        when "011",        -- A AND B
             A          when "100",        -- SHIFT LEFT A
             '0'        when "101",        -- NOT A
             A AND Z    when "110",        -- INCREMENT A
             '0'        when others;       -- CLEAR

end Behavioral;
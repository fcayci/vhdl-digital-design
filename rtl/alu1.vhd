-- 1-bit alu circuit
library ieee;
use ieee.std_logic_1164.all;

-- functions implemented
-- opcode       function
-- 0000          a + b
-- 0001          a - b
-- 0010          a xor b
-- 0011          a and b
-- 0100          shift left a
-- 0101          not a
-- 0110          increment a
-- 0111          clear

entity alu1 is
port (
    op1, op2 : in  std_logic;
    cin      : in  std_logic;
    opcode   : in  std_logic_vector(3 downto 0);
    res      : out std_logic;
    cout     : out std_logic
);
end alu1;

architecture rtl of alu1 is
begin

    -- calculate result output
    with opcode select res <=
        op1 xor op2 xor cin    when "0000",  -- a + b
        op1 xor op2 xor cin    when "0001",  -- a - b
        op1 xor op2            when "0010",  -- a xor b
        op1 and op2            when "0011",  -- a and b
        cin                    when "0100",  -- shift left a
        not op1                when "0101",  -- not a
        op1 xor cin            when "0110",  -- increment a
        '0'                    when others;  -- clear

    -- calculate carry output
    with opcode select cout <=
        (op1 and op2) or (cin and (op1 xor op2))        when "0000", -- a + b
        ((not op1) and op2) or (cin and (op1 xnor op2)) when "0001", -- a - b
        op1                                             when "0100", -- shift left a
        op1 and cin                                     when "0110", -- increment a
        '0'                                             when others;

end rtl;

-- 1-bit alu circuit (with process)
-- functions implemented
--   opcode  function
--   000     a + b
--   001     a - b
--   010     a and b
--   011     a or b
--   100     a nor b
--   101     a xor b
--   110     a < b
--   111     not a

library ieee;
use ieee.std_logic_1164.all;

entity alu1 is
port (
    a, b   : in std_logic;
    ci     : in std_logic;
    opcode : in std_logic_vector(2 downto 0);
    r      : out std_logic;
    co     : out std_logic
);
end alu1;

architecture rtl of alu1 is
begin

    process(a, b, ci, opcode) is
    begin
        co <= '0';
        case opcode is
            when "000" =>
                r <= a xor b xor ci;
                co <= (a and b) or (a and ci) or (b and ci);
            when "001" =>
                r <= a xor b xor ci;
                co <= ((not a) and b) or ((not (a xor b)) and ci);
            when "010" =>
                r <= a and b;
            when "011" =>
                r <= a or b;
            when "100" =>
                r <= a nor b;
            when "101" =>
                r <= a xor b;
            when "110" =>
                if a = '0' and b = '1' then
                    r <= '1';
                else
                    r <= '0';
                end if;
            when "111" =>
                r <= not a;
            when others =>
                r <= '0';
        end case;
    end process;

end rtl;

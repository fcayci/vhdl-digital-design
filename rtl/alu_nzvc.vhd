-- generic alu unit supporting nzvc flags
--   not yet tested, expect bugs
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_nzvc is
generic ( M :integer := 32);
port (
    a, b    : in std_logic_vector(M-1 downto 0);
    opcode  : in std_logic_vector(2 downto 0);
    r       : out std_logic_vector(M-1 downto 0);
    n,z,v,c : out std_logic
);
end alu_nzvc;

architecture rtl of alu_nzvc is
    signal a_u, b_u, r_u : unsigned(M downto 0) := (others=>'0');
    signal c_sub : std_logic := '0';
begin

    -- make type castings for easy operations
    a_u <= unsigned('0' & a);
    b_u <= unsigned('0' & b);
    r <= std_logic_vector(r_u(M-1 downto 0));

    -- alu, can also be tied to clock
    process(a_u, b_u, opcode) is
    begin
        c_sub <= '0';

        case opcode is
            when "000" => -- add
                r_u <= a_u + b_u;
            when "001" => -- sub
                r_u <= a_u - b_u;
                c_sub <= '1';
            when "010" => -- and
                r_u <= a_u and b_u;
            when "011" => -- or
                r_u <= a_u or b_u;
            when "100" => -- nor
                -- don't update carry bit
                r_u <= '0' & (a_u(M-1 downto 0) nor b_u(M-1 downto 0));
            when "101" => -- xor
                r_u <= a_u xor b_u;
            when "110" => -- a < b unsigned
                if a_u < b_u then
                    r_u <= (0=>'1', others=>'0');
                else
                    r_u <= (others=>'0');
                end if;
            when "111" => -- not a
                -- don't update carry bit
                r_u <= '0' & (not a_u(M-1 downto 0));
            when others =>
                r_u <= (others=>'0');
        end case;
    end process;

    -- carry flag
    c <= r_u(M) when c_sub = '0' else not r_u(M);

    -- negative flag
    n <= r_u(M-1);

    -- zero flag
    z <= '1' when r_u(M-1 downto 0) = 0 else '0';

    -- overflow flag
    v <= '1' when (a_u(M-1) = '1' and b_u(M-1) = '1' and r_u(M-1) = '0') or
                  (a_u(M-1) = '0' and b_u(M-1) = '0' and r_u(M-1) = '1') else
         '0';

end rtl;

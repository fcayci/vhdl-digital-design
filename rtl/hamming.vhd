-- 16-bit hamming distance finder
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hamming is
port (
    a, b : in  std_logic_vector(15 downto 0);
    dist : out std_logic_vector(7 downto 0)
);
end hamming;

architecture rtl of hamming is
    signal diff : std_logic_vector(15 downto 0) := (others => '0');

    -- a function example that sums all the given bits of a std_logic_array
    --   and returns an integer
    function sum_bits ( s: std_logic_vector ) return natural is
        variable sum : integer range 0 to s'length := 0;
    begin
        for i in s'range loop
            if s(i) = '1' then
                sum := sum + 1;
            else
                sum := sum;
            end if;
        end loop;

        return sum;
    end function;

begin

    -- we can write a function to sum the bits of a given vector
    -- that function returns an integer so we cast it back to std_logic_vector
    diff <= a xor b;
    dist <= std_logic_vector( to_unsigned( sum_bits(diff), 8 ) );

end rtl;

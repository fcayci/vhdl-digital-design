-- 16-bit hamming distance finder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hamming is
    port ( a_i, b_i : in std_logic_vector(15 downto 0);
           dist1_o, dist2_o, dist3_o, dist4_o  : out std_logic_vector(7 downto 0)
    );
end hamming;

architecture rtl of hamming is
    signal a, b : unsigned(15 downto 0) := (others => '0');
    signal diff : std_logic_vector(15 downto 0) := (others => '0');

    -- a function example to convert std_logic type to integer
    function std_logic_to_integer ( s: std_logic ) return natural is
    begin
        if s = '1' then
            return 1;
        else
            return 0;
        end if;
    end function;

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

    -- for loop / if else way
    a <= unsigned(a_i);
    b <= unsigned(b_i);

    process(a, b) is
        variable counter : integer := 0;
    begin
        counter := 0;
        for i in a'range loop
            if a(i) /= b(i) then
                counter := counter + 1;
            end if;
        end loop;

        dist1_o <= std_logic_vector(to_unsigned(counter,8));
    end process;

    -- the tricky way
    -- since unsigned casting requires a vector input
    --   we give use a trick to make the inputs 1-bit vector
    --   then cast them to integers to sum them
    --   finally cast them back to std_logic_vector
    diff <= a_i xor b_i;

    dist2_o <=  std_logic_vector( to_unsigned(
                    to_integer(unsigned(diff(15 downto 15))) +
                    to_integer(unsigned(diff(14 downto 14))) +
                    to_integer(unsigned(diff(13 downto 13))) +
                    to_integer(unsigned(diff(12 downto 12))) +
                    to_integer(unsigned(diff(11 downto 11))) +
                    to_integer(unsigned(diff(10 downto 10))) +
                    to_integer(unsigned(diff(9  downto  9))) +
                    to_integer(unsigned(diff(8  downto  8))) +
                    to_integer(unsigned(diff(7  downto  7))) +
                    to_integer(unsigned(diff(6  downto  6))) +
                    to_integer(unsigned(diff(5  downto  5))) +
                    to_integer(unsigned(diff(4  downto  4))) +
                    to_integer(unsigned(diff(3  downto  3))) +
                    to_integer(unsigned(diff(2  downto  2))) +
                    to_integer(unsigned(diff(1  downto  1))) +
                    to_integer(unsigned(diff(0  downto  0)))
                ,8));


    -- the function way 1
    -- we can write a function to covert a std_logic to an integer
    -- still need to sum all inputs though.
    dist3_o <=  std_logic_vector( to_unsigned(
                    std_logic_to_integer(diff(15)) +
                    std_logic_to_integer(diff(14)) +
                    std_logic_to_integer(diff(13)) +
                    std_logic_to_integer(diff(12)) +
                    std_logic_to_integer(diff(11)) +
                    std_logic_to_integer(diff(10)) +
                    std_logic_to_integer(diff( 9)) +
                    std_logic_to_integer(diff( 8)) +
                    std_logic_to_integer(diff( 7)) +
                    std_logic_to_integer(diff( 6)) +
                    std_logic_to_integer(diff( 5)) +
                    std_logic_to_integer(diff( 4)) +
                    std_logic_to_integer(diff( 3)) +
                    std_logic_to_integer(diff( 2)) +
                    std_logic_to_integer(diff( 1)) +
                    std_logic_to_integer(diff( 0))
                ,8));

    -- the function way 2
    -- we can write a function to sum the bits of a given vector
    -- that function returns an integer so we cast it back to std_logic_vector
    dist4_o <= std_logic_vector( to_unsigned( sum_bits(diff), 8 ) );

end rtl;

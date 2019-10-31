-- carry lookahead adder
-- though synthesis will create like a ripple carry
library ieee;
use ieee.std_logic_1164.all;

entity cla is
generic (M : integer := 32);
port (
    a, b : in  std_logic_vector(M-1 downto 0);
    cin  : in  std_logic;
    s    : out std_logic_vector(M-1 downto 0);
    cout : out std_logic
);
end cla;

architecture rtl of cla is
    signal c : std_logic_vector(M downto 0) := (others =>'0');
    signal p, g : std_logic_vector(M-1 downto 0) := (others =>'0');
begin

    -- common assignments for all routes
    p <= a xor b;
    g <= a and b;
    s <= p xor c(M-1 downto 0);
    cout <= c(M);

    -- 1. using for generate
    c(0) <= cin;
    gen: for i in 0 to M-1 generate
        c(i+1) <= g(i) or (p(i) and c(i));
    end generate;

    -- 2. using for loop
    -- process(g, p, c) is
    -- begin
    --     c(0) <= cin;
    --     for i in 0 to M-1 loop
    --         c(i+1) <= g(i) or (p(i) and c(i));
    --     end loop;
    -- end process;

    -- 3. manually assigning each signal
    -- c(0) <= cin;
    -- c(1) <= g(0) or ( p(0) and ( c(0) ));
    -- c(2) <= g(1) or ( p(1) and ( g(0) or ( p(0) and ( c(0) )) ));
    -- c(3) <= g(2) or ( p(2) and ( g(1) or ( p(1) and ( g(0) or ( p(0) and ( c(0) )) )) ));
    -- c(4) <= g(3) or ( p(3) and ( g(2) or ( p(2) and ( g(1) or ( p(1) and ( g(0) or ( p(0) and ( c(0) )) )) )) ));
    -- c(5) <= g(4) or ( p(4) and ( g(3) or ( p(3) and ( g(2) or ( p(2) and ( g(1) or ( p(1) and ( g(0) or ( p(0) and ( c(0) )) )) )) )) ));
    -- c(6) <= g(5) or ( p(5) and ( g(4) or ( p(4) and ( g(3) or ( p(3) and ( g(2) or ( p(2) and ( g(1) or ( p(1) and ( g(0) or ( p(0) and ( c(0) )) )) )) )) )) ));
    -- c(7) <= g(6) or ( p(6) and ( g(5) or ( p(5) and ( g(4) or ( p(4) and ( g(3) or ( p(3) and ( g(2) or ( p(2) and ( g(1) or ( p(1) and ( g(0) or ( p(0) and ( c(0) )) )) )) )) )) )) ));
    -- c(8) <= g(7) or ( p(7) and ( g(6) or ( p(6) and ( g(5) or ( p(5) and ( g(4) or ( p(4) and ( g(3) or ( p(3) and ( g(2) or ( p(2) and ( g(1) or ( p(1) and ( g(0) or ( p(0) and ( c(0) )) )) )) )) )) )) )) ));

end rtl;

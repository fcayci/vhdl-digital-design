-- ripple carry adder
library ieee;
use ieee.std_logic_1164.all;

entity rca is
generic (M : integer := 32);
port (
    a, b : in  std_logic_vector(M-1 downto 0);
    cin  : in  std_logic;
    s    : out std_logic_vector(M-1 downto 0);
    cout : out std_logic
);
end rca;

architecture rtl of rca is
    component full_adder
    port (
        a, b, cin : in  std_logic;
        s, cout   : out std_logic
    );
    end component;

    -- create intermediate signal that will hold c values
    signal c : std_logic_vector(M downto 0) := (others =>'0');
begin

    c(0) <= cin;
    cout <= c(M);

    gfa: for i in 0 to M-1 generate
        fa: full_adder
            port map (a=>a(i), b=>b(i), cin=>c(i), s=>s(i), cout=>c(i+1) );
    end generate;

end rtl;

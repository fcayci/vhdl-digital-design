-- This is a demonstration of a pipeline design
--   showing different implementations of the same design
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
port (
    clk : in std_logic;
    a : in  std_logic_vector(7 downto 0);
    b : in  std_logic_vector(7 downto 0);
    c : in  std_logic_vector(7 downto 0);
    d : in  std_logic_vector(7 downto 0);
    x : out std_logic_vector(23 downto 0)
);
end pipeline;

-- combinational logic
architecture rtla of pipeline is
    signal as, bs, cs, ds : signed(7 downto 0) := (others => '0');
    signal xs : signed(23 downto 0) := (others => '0');
begin

    -- type castings
    x <= std_logic_vector(xs);
    as <= signed(a);
    bs <= signed(b);
    cs <= signed(c);
    ds <= signed(d);

    -- logic equation: a*b*c + d
    xs <= (as * bs * cs) + ds;

end rtla;

-- clk bound operation
architecture rtlb of pipeline is
    signal as, bs, cs, ds : signed(7 downto 0) := (others => '0');
    signal xs : signed(23 downto 0) := (others => '0');
begin

    -- type castings
    x <= std_logic_vector(xs);
    as <= signed(a);
    bs <= signed(b);
    cs <= signed(c);
    ds <= signed(d);

    process(clk) is
    begin
        if rising_edge(clk) then
            xs <= (as * bs * cs) + ds;
        end if;
    end process;

end rtlb;


-- two clock cycle delayed output using register buffers
architecture rtlc of pipeline is
    signal as, bs, cs, ds : signed(7 downto 0) := (others => '0');
    signal xs1, xs2, xs3 : signed(23 downto 0) := (others => '0');
begin

    -- type castings
    x <= std_logic_vector(xs3);
    as <= signed(a);
    bs <= signed(b);
    cs <= signed(c);
    ds <= signed(d);

    process(clk) is
    begin
        if rising_edge(clk) then
            xs1 <= (as * bs * cs) + ds;
            -- two clk delay
            xs2 <= xs1;
            xs3 <= xs2;
        end if;
    end process;

end rtlc;

-- pipeline two multiplies and add in three stages
architecture rtld of pipeline is
    signal as, bs, cs, ds, cbuf, dbuf1, dbuf2 : signed(7 downto 0) := (others => '0');
    signal xs1 : signed(15 downto 0) := (others => '0');
    signal xs2, xs3 : signed(23 downto 0) := (others => '0');
begin

    -- type castings
    x <= std_logic_vector(xs3);
    as <= signed(a);
    bs <= signed(b);
    cs <= signed(c);
    ds <= signed(d);

    process(clk) is
    begin
        if rising_edge(clk) then
            -- first stage: multiply two signals, buffer rest
            xs1 <= as * bs;
            cbuf <= cs;
            dbuf1 <= ds;
            -- second stage: multiply remaining signals, buffer rest
            xs2 <= xs1 * cbuf;
            dbuf2 <= dbuf1;
            -- third stage: do the final addition
            xs3 <= xs2 + dbuf2;
        end if;
    end process;

end rtld;

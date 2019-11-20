library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pipeline is
end tb_pipeline;

architecture rtl of tb_pipeline is

    signal clk  : std_logic := '0';
    signal a, b, c, d : std_logic_vector(7 downto 0);
    signal xa, xb, xc, xd : std_logic_vector(23 downto 0);

    constant CLK_PERIOD : time := 40 ns;

begin

    p0_comblogic : entity work.pipeline(rtla)
      port map(clk=>clk, a=>a, b=>b, c=>c, d=>d, x=>xa);
    p1_clkbound : entity work.pipeline(rtlb)
      port map(clk=>clk, a=>a, b=>b, c=>c, d=>d, x=>xb);
    p2_clkdelay : entity work.pipeline(rtlc)
      port map(clk=>clk, a=>a, b=>b, c=>c, d=>d, x=>xc);
    p2_pipeline : entity work.pipeline(rtld)
      port map(clk=>clk, a=>a, b=>b, c=>c, d=>d, x=>xd);

    -- generate clock
    clk <= not clk after CLK_PERIOD/2;

    process
        variable as, bs, cs, ds : signed(7 downto 0) := (others=>'0');
    begin
        wait for 130 ns; -- wait for some time
        for i in 0 to 15 loop
            -- send data in every new clkc cycle
            --wait until clk = '1';
            as := to_signed( 100, 8);
            bs := to_signed(   i, 8);
            cs := to_signed( i*i, 8);
            ds := to_signed(60-i, 8);
            -- x =   a * b *   c +    d
            -- x = 100 * i * i*i + 60-i
            a <= std_logic_vector(as);
            b <= std_logic_vector(bs);
            c <= std_logic_vector(cs);
            d <= std_logic_vector(ds);
            wait for 40 ns;
        end loop;

        wait; -- do not repeat
    end process;
end rtl;
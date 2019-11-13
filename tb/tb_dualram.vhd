-- dualram testbench
-- this testbench is for post-synthesis simulations
-- or fixed M/N value pair behavioral simulations
--   for M=5 and N=32
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_dualram is
end tb_dualram;

architecture bhv of tb_dualram is
    component dualram is
    port(
        clka, clkb   : in  std_logic;
        ena, enb     : in  std_logic;
        wea          : in  std_logic;
        addra, addrb : in  std_logic_vector(4 downto 0);
        dina         : in  std_logic_vector(31 downto 0);
        doutb        : out std_logic_vector(31 downto 0)
    );
    end component;

    constant CLKA_PERIOD : time := 8 ns;
    constant CLKB_PERIOD : time := 8 ns;

    signal clka, clkb : std_logic := '0';
    signal ena, enb, wea : std_logic := '0';
    signal addra, addrb : std_logic_vector(4 downto 0) := (others=>'0');
    signal dina, doutb : std_logic_vector(31 downto 0) := (others=>'0');

begin

    uut0 : dualram
      port map (clka=>clka, clkb=>clkb, ena=>ena, enb=>enb, wea=>wea,
      addra=>addra, addrb=>addrb, dina=>dina, doutb=>doutb);

    process
    begin
        clka <= not clka;
        wait for CLKA_PERIOD/2;
    end process;

    process
    begin
        clkb <= not clkb;
        wait for CLKB_PERIOD/2;
    end process;

    -- stimulus
    process
    begin
        wait for 10 ns;
        ena <= '0';
        enb <= '1';
        wea <= '0';
        for i in 0 to 2**5 - 1 loop
            addrb <= std_logic_vector(to_unsigned(i, 5));
            wait for CLKA_PERIOD;
        end loop;
        wait;
    end process;
end bhv;
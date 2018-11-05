-- N-bit shift register
--   a. using concatenation
--   b. using for-loop
library ieee;
use ieee.std_logic_1164.all;

entity shreg is
    generic(
        N : integer := 32
    );
    port(
        clk, rst : in std_logic;
        si : in std_logic;
        soa, sob : out std_logic
    );
end shreg;

architecture rtl of shreg is
    signal srega : std_logic_vector(N - 1 downto 0);
    signal sregb : std_logic_vector(N - 1 downto 0);
begin

    -- a. concatenation way
    process(clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                srega <= (others => '0');
            else
                srega <= srega(N - 2 downto 0) & si;
            end if;
        end if;
    end process;

    soa <= srega(N - 1);

    -- b. for - loop way
    process(clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                sregb <= (others => '0');
            else
                for i in 0 to N - 2 loop
                    sregb(i+1) <= sregb(i);
                end loop;

                sregb(0) <= si;
            end if;
        end if;
    end process;

    sob <= sregb(N - 1);

end rtl;
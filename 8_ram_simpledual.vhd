-- simple dual-clock dual-port M-bit x N-bit RAM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
    generic(
        M : integer := 10;
        N : integer := 32
    );
    port(
        clka, clkb  : in  std_logic;
        ena, enb : in std_logic;
        wea  : in std_logic;
        addra, addrb : in  std_logic_vector(M - 1 downto 0);
        dina  : in  std_logic_vector(N - 1 downto 0);
        doutb : out std_logic_vector(N - 1 downto 0)
    );
end ram;

architecture rtl of ram is
    type ram_type is array(0 to 2**M - 1) of std_logic_vector(N - 1 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
begin

    -- a port process - write only
    process(clka) is
    begin
        if rising_edge(clka) then
            if ena = '1' then
                if wea = '1' then
                    RAM(to_integer(unsigned(addra))) <= dina;
                end if;
            end if;
        end if;
    end process;

    -- b port process - read only
    process(clkb) is
    begin
        if rising_edge(clkb) then
            if enb = '1' then
                doutb <= RAM(to_integer(unsigned(addrb)));
            end if;
        end if;
    end process;

end rtl;
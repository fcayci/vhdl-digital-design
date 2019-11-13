-- simple dual-clock dual-port M-bit x N-bit RAM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity dualram is
generic(
    RAMFILENAME: string := "../impl/ram_content.data";
    M : integer := 5;
    N : integer := 32
);
port(
    clka, clkb   : in  std_logic;
    ena, enb     : in  std_logic;
    wea          : in  std_logic;
    addra, addrb : in  std_logic_vector(M - 1 downto 0);
    dina         : in  std_logic_vector(N - 1 downto 0);
    doutb        : out std_logic_vector(N - 1 downto 0)
);
end dualram;

architecture rtl of dualram is
    type ram_type is array(0 to 2**M - 1) of std_logic_vector(N - 1 downto 0);

    impure function init_ram_from_file (fname : in string) return ram_type is
        file f : text is fname;
        variable fline : line;
        variable ramm : ram_type;
        variable rl : bit_vector(N-1 downto 0);
    begin
        for i in ram_type'range loop
            readline (f, fline);
            read (fline, rl);
            ramm(i) := to_stdlogicvector(rl);
        end loop;
        return ramm;
    end function;

    signal RAM : ram_type := init_ram_from_file(RAMFILENAME);

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
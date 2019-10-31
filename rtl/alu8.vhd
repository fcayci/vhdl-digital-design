-- 8-bit alu using 1-bit alus
-- smaller than options needs rework to fix the result
-- not yet tested, expect bugs
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu8 is
port (
    a, b   : in std_logic_vector(7 downto 0);
    cin    : in std_logic;
    opcode : in std_logic_vector(2 downto 0);
    r      : out std_logic_vector(7 downto 0);
    cout   : out std_logic
);
end alu8;

architecture rtl of alu8 is
    component alu1 is
    port (
        a, b   : in std_logic;
        ci     : in std_logic;
        opcode : in std_logic_vector(2 downto 0);
        r      : out std_logic;
        co     : out std_logic
    );
    end component;

    signal c : std_logic_vector(8 downto 0) := (others=>'0');
    signal rtmp : std_logic_vector(7 downto 0) := (others=>'0');
begin

    c(0) <= cin;
    gen: for i in 0 to 7 generate
        alu_g: alu1 port map ( a=>a(i), b=>b(i), ci=>c(i), opcode=>opcode, r=>rtmp(i), co=>c(i+1));
    end generate;
    cout <= c(8);

    -- only for a < b stage
    process(a, b, opcode, rtmp) is
        begin
            case opcode is
                when "110" =>
                    if a < b then
                        r <= x"01";
                    else
                        r <= x"00";
                    end if;
                when others =>
                    r <= rtmp;
            end case;
        end process;
end rtl;

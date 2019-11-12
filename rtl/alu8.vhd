-- M-bit alu using 1-bit alus
-- smaller than options needs rework to get correct result
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu8 is
generic(M: integer := 32);
port (
    a, b   : in std_logic_vector(M-1 downto 0);
    cin    : in std_logic;
    opcode : in std_logic_vector(2 downto 0);
    r      : out std_logic_vector(M-1 downto 0);
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

    signal c : std_logic_vector(M downto 0) := (others=>'0');
    signal rtmp : std_logic_vector(M-1 downto 0) := (others=>'0');
begin

    c(0) <= cin;
    gen: for i in 0 to M-1 generate
        alu_g: alu1 port map ( a=>a(i), b=>b(i), ci=>c(i), opcode=>opcode, r=>rtmp(i), co=>c(i+1));
    end generate;
    -- subtract is inverted cout
    cout <= not c(M) when opcode = "001" else c(M);

    -- only for a < b stage
    -- get correct result
    process(a, b, opcode, rtmp) is
        begin
            case opcode is
                when "110" =>
                    if a < b then
                        r <= (0=>'1', others=>'0');
                    else
                        r <= (others=>'0');
                    end if;
                when others =>
                    r <= rtmp;
            end case;
        end process;
end rtl;

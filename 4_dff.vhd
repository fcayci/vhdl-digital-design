-- d flip-flop examples
library ieee;
use ieee.std_logic_1164.all;

entity dff is
    port (
        d   : in std_logic;
        clk : in std_logic;
        en  : in std_logic;
        rst : in std_logic;
        q1, q2, q3, q4, q5  : out std_logic
    );
end dff;

architecture behavioral of dff is
begin

    -- positive-edge triggered dff
    process(clk) is
    begin
        if rising_edge(clk) then
            q1 <= d;
        end if;
    end process;

    -- negative-edge triggered dff
    process(clk) is
    begin
        --if falling_edge(clk) then
        if clk'event and clk = '0' then
            q2 <= d;
        end if;
    end process;

    -- dff with async reset
    process(rst, clk) is
    begin
        if rst = '1' then
            q3 <= '0';
        elsif rising_edge(clk) then
            q3 <= d;
        end if;
    end process;

    -- dff with sync reset
    process(rst, clk) is
    begin
        if rising_edge(clk) then
            if  rst = '1' then
                q4 <= '0';
            else
                q4 <= d;
            end if;
        end if;
    end process;

    -- dff with async reset and enable
    process(rst, en, clk) is
    begin
        if rst = '1' then
            q5 <= '0';
        elsif en = '1' then
            if rising_edge(clk) then
                q5 <= d;
            end if;
        end if;
    end process;

end behavioral;
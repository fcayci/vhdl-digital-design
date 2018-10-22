-- 4-bit counter testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter4_tb is
end counter4_tb;

architecture behavioral of counter4_tb is
    component counter4_a is
        port ( en, clk, rst  : in  std_logic;
               count_o : out std_logic_vector(3 downto 0)
            );
    end component;

    component counter4_b is
        port ( en, clk, rst  : in  std_logic;
               count_o : out std_logic_vector(3 downto 0)
            );
    end component;

    component pulse_generator is
        port ( en, clk, rst : in std_logic;
               pulse_o : out std_logic
        );
    end component;

    signal en, clk, rst : std_logic := '0';
    signal count_a, count_b : std_logic_vector(3 downto 0);
    signal pulse_o : std_logic := '0';

    signal clk_period : time := 10 ns;

begin

    c4a: counter4_a port map (en => en, clk => clk, rst => rst, count_o => count_a );
    c4b: counter4_b port map (en => en, clk => clk, rst => rst, count_o => count_b );
    p0 : pulse_generator port map (en => en, clk => clk, rst => rst, pulse_o => pulse_o );

    -- generate clock signal
    clk_process : process
    begin
        clk <= not clk;
        wait for clk_period/2;
    end process;

    -- stimulus
    process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        en <= '1';
        wait for clk_period*50;
        wait;
    end process;
end behavioral;
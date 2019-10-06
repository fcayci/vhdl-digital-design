-- rgb to greyscale conversion testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rgb2grey is
end tb_rgb2grey;

architecture bhv of tb_rgb2grey is
    signal rgb  : std_logic_vector(23 downto 0);
    signal grey : std_logic_vector(7 downto 0);
begin

    uut : entity work.rgb2grey(rtl)
      port map( rgb => rgb, grey => grey);

    process
    begin
        wait for 10 ns;
        rgb <= x"000000";
        wait for 10 ns;
        rgb <= x"A0A0A0";
        wait for 10 ns;
        rgb <= x"39491A";
        wait for 10 ns;
        rgb <= x"300000";
        wait for 10 ns;
        rgb <= x"123DEF";
        wait for 10 ns;
        wait;
    end process;

end bhv;

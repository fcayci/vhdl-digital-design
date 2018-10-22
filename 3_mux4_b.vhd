-- 4-to-1 mux structural
library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
    port ( a   : in  std_logic_vector(3 downto 0);
           sel : in  std_logic_vector(1 downto 0);
           y   : out std_logic
          );
end mux4;

architecture str of mux4_struct is

    -- instantiate mux2 circuit (mux2.vhd)
    component mux2 is
    port ( a   : in  std_logic_vector(1 downto 0);
           sel : in  std_logic;
           y   : out std_logic
         );
    end component;

    -- signal to hold the first stage mux outputs
    signal stage1 : std_logic_vector(1 downto 0) := "00";

begin

  -- first stage mux
  m1a: mux2 port map (
   	 a => a(3 downto 2),
   	 s => s(0),
   	 y => stage1(0)
  );

  -- sirst stage mux
  m1b: mux2 port map (
   	 a => a(1 downto 0),
   	 s => s(0),
   	 y => stage1(1)
  );

  -- second stage mux
  m2: mux2 port map (
   	 a => stage1,
   	 s => s(1),
   	 y => y
  );

end str;
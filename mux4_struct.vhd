-- 1-to-4 MUX structural circuit using 3 x 1-to-2 MUX circuits
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4_struct is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           Z : out  STD_LOGIC);
end mux4_struct;

architecture Structural of mux4_struct is

  -- Instantiate mux2 circuit (mux2.vhd)
  COMPONENT mux2
    PORT ( 
      I : in  STD_LOGIC_VECTOR (1 downto 0);
      S : in  STD_LOGIC;
      Y : out STD_LOGIC
    );
  END COMPONENT;

  SIGNAL MUXOUT : STD_LOGIC_VECTOR(1 downto 0) := "00";

begin

  -- First stage mux
  m1: mux2 PORT MAP (
   	 I => A(3 downto 2),
   	 S => S(0),
   	 Y => MUXOUT(0)
  );
  
  -- First stage mux
  m2: mux2 PORT MAP (
   	 I => A(1 downto 0),
   	 S => S(0),
   	 Y => MUXOUT(1)
  );
  
  -- Second stage mux
  m3: mux2 PORT MAP (
   	 I => MUXOUT,
   	 S => S(1),
   	 Y => Z
  );

end Structural;
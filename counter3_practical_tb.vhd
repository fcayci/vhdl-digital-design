-- 3-bit (MOD-8) counter practical testbench
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY counter3_practical_tb IS
END counter3_practical_tb;
 
ARCHITECTURE behavior OF counter3_practical_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter3_practical
    PORT(
         CLK : IN  std_logic;
         EN : IN  std_logic;
         RST : IN  std_logic;
         COUNT : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal EN : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal COUNT : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter3_practical PORT MAP (
          CLK => CLK,
          EN => EN,
          RST => RST,
          COUNT => COUNT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 90 ns.
      RST <= '1';
      wait for 90 ns;	
      RST <= '0';
      EN <= '1';
      wait for CLK_period*20;
      wait;
   end process;
   
END;
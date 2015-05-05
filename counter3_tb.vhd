-- 3-bit (MOD-8) counter testbench
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY counter3_tb IS
END counter3_tb;
 
ARCHITECTURE behavior OF counter3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter3
    PORT(
         EN : IN  std_logic;
         CLK : IN  std_logic;
         RST : IN  std_logic;
         A_out : OUT  std_logic;
         B_out : OUT  std_logic;
         C_out : OUT  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal EN : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal A_out : std_logic;
   signal B_out : std_logic;
   signal C_out : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter3 PORT MAP (
          EN => EN,
          CLK => CLK,
          RST => RST,
          A_out => A_out,
          B_out => B_out,
          C_out => C_out
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
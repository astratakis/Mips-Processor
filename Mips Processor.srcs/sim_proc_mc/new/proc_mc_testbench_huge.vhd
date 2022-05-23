library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity proc_mc_testbench_huge is
end proc_mc_testbench_huge;

architecture Behavioral of proc_mc_testbench_huge is

component proc_mc is
    Port (
        clock: in std_logic;
        reset: in std_logic
    );
end component;

signal clock: std_logic := '0';
signal reset: std_logic := '1';

begin

    clock <= not clock after clock_period/2;
    
    uut: proc_mc port map(
        clock => clock,
        reset => reset
    );
    
    stim_proc: process begin
    
        wait for 5*clock_period;
        
        reset <= '0';
        
        wait;
    
    end process;

end Behavioral;
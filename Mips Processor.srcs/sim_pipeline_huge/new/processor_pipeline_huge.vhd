library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity processor_pipeline_huge is
end processor_pipeline_huge;

architecture Behavioral of processor_pipeline_huge is

component processor_pipeline is
    Port (
        clock: in std_logic;
        reset: in std_logic
    );
end component;

signal clock: std_logic := '0';
signal reset: std_logic := '1';

begin

    clock <= not clock after clock_period/2;

    uut: processor_pipeline port map(
        clock => clock,
        reset => reset
    );
    
    stim_proc: process begin
    
        wait for 5 * clock_period;
        
        reset <= '0';
    
        wait;
    end process;

end Behavioral;
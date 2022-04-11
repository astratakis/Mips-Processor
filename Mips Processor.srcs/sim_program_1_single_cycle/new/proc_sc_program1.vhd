----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	proc_sc_program1 - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the single cycle processor.
--
-- Instructions: addi, ori, sw, lw, lb, nand, b
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity proc_sc_program1 is
end proc_sc_program1;

architecture Behavioral of proc_sc_program1 is

component proc_sc is
    Port (
        clock: in std_logic;
        reset: in std_logic
    );
end component;

signal clock: std_logic := '0';
signal reset: std_logic := '1';
signal active_clock: std_logic := '1';

begin

    clock <= not clock after clock_period/2 when active_clock = '1' else '0';

    uut: proc_sc port map(
        clock => clock,
        reset => reset
    );
    
    stim_proc: process begin
        
        wait for 5 * clock_period;
        
        reset <= '0';
        
        wait;
    
    end process;

end Behavioral;
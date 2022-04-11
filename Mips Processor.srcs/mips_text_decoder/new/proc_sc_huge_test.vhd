----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2022 01:55:47 PM
-- Design Name: 
-- Module Name: processor_sc_testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity proc_sc_huge_test is
end proc_sc_huge_test;

architecture Behavioral of proc_sc_huge_test is

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
    
        wait for 47710 * clock_period;
        
        active_clock <= '0';
        
        wait for 5 * clock_period;
        
        reset <= '1';
        wait;
    
    end process;

end Behavioral;
----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	ifstage - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the Instruction Fetch stage.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity ifstage_testbench is
end ifstage_testbench;

architecture Behavioral of ifstage_testbench is

component ifstage is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        
        pc_lden: in std_logic;
        pc_sel: in std_logic;
        
        pc_immed: in std_logic_vector(31 downto 0);
        pc: out std_logic_vector(31 downto 0)
    );
end component;

signal clock: std_logic := '0';
signal reset: std_logic := '1';
signal pc_lden: std_logic := '-';
signal pc_sel: std_logic := '-';
signal pc_immed: std_logic_vector(31 downto 0);
signal pc: std_logic_vector(31 downto 0);

begin

    clock <= not clock after clock_period/2;

    uut: ifstage port map(
        clock => clock,
        reset => reset,
        pc_lden => pc_lden,
        pc_sel => pc_sel,
        pc_immed => pc_immed,
        pc => pc
    );
    
    stim_proc: process begin
    
        wait for clock_period;
        
        reset <= '0';
        pc_lden <= '1';
        pc_sel <= '0';
        
        wait for 5*clock_period;
        
        pc_lden <= '0';
        
        wait for clock_period;
        
        pc_lden <= '1';
        pc_sel <= '1';
        pc_immed <= x"0000000f";
        
        wait for 2*clock_period;
        
        reset <= '1';
        
        wait;
    
    end process;

end Behavioral;
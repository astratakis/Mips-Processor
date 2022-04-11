----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	control_testbench - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the control of the processor.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_testbench is
end control_testbench;

architecture Behavioral of control_testbench is

component control is
    Port (
        instruction: in std_logic_vector(31 downto 0);
        alu_zero: in std_logic;
        
        pc_sel: out std_logic;
        pc_lden: out std_logic
    );
end component;

signal instruction: std_logic_vector(31 downto 0);
signal alu_zero: std_logic;

signal pc_sel: std_logic;
signal pc_lden: std_logic;

begin

    uut: control port map(
        instruction => instruction,
        alu_zero => alu_zero,
        
        pc_sel => pc_sel,
        pc_lden => pc_lden
    );
    
    stim_proc: process begin
    
        -- li $2, 15
        instruction <= "111000-----000100000000000001111";
        alu_zero <= '0';
        wait for 100 ns;
        
        -- lui $7 1
        instruction <= "111001-----001110000000000000001";
        wait for 100 ns;
        
        -- add $5 $2 $7
        instruction <= "100000000100010100111-----110000";
        
        wait;
    
    end process;

end Behavioral;
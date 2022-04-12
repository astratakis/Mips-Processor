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
        pc_lden: out std_logic;
        
        alu_bin_sel: out std_logic;
        alu_func: out std_logic_vector(3 downto 0);
        
        rf_wrdata_sel: out std_logic;
        rf_b_sel: out std_logic;
        rf_wren: out std_logic;
        immed_ext: out std_logic_vector(1 downto 0);
        
        byte_op: out std_logic;
        mem_wren: out std_logic
    );
end component;

signal instruction: std_logic_vector(31 downto 0);
signal alu_zero: std_logic;

signal pc_sel: std_logic;
signal pc_lden: std_logic;

signal alu_bin_sel: std_logic;
signal alu_func: std_logic_vector(3 downto 0);

signal rf_wrdata_sel: std_logic;
signal rf_b_sel: std_logic;
signal rf_wren: std_logic;
signal immed_ext: std_logic_vector(1 downto 0);

signal byte_op: std_logic;
signal mem_wren: std_logic;

begin

    uut: control port map(
        instruction => instruction,
        alu_zero => alu_zero,
        
        pc_sel => pc_sel,
        pc_lden => pc_lden,
        
        alu_bin_sel => alu_bin_sel,
        alu_func => alu_func,
        rf_wrdata_sel => rf_wrdata_sel,
        rf_b_sel => rf_b_sel,
        rf_wren => rf_wren,
        immed_ext => immed_ext,
        byte_op => byte_op,
        mem_wren => mem_wren
    );
    
    stim_proc: process begin
    
        -- li $2, 15
        instruction <= "11000000000001010000000000001000";
        alu_zero <= '0';
        wait for 100 ns;
        
        -- lui $7 1
        instruction <= "11001100000000111010101111001101";
        wait for 100 ns;
        
        -- add $5 $2 $7
        instruction <= "01111100000000110000000000000100";
        wait for 100 ns;
        
        instruction <= "00111100101010101111111111111100";
        wait for 100 ns;
        
        instruction <= "00001100000100000000000000000100";
        wait for 100 ns;
        
        instruction <= "10000001010001001000000000110101";
        wait for 100 ns;
        
        instruction <= "111111----------1111111111111111";
        wait for 100 ns;
        
        instruction <= "00000100101001010000000000001000";
        wait for 100 ns;
        
        instruction <= "11111100000000001111111111111110";
        wait for 100 ns;
        
        instruction <= "11000000000000010000000000000001";
        wait for 100 ns;
        
        wait;
    
    end process;

end Behavioral;
----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	exstage_testbench - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the exstage.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity exstage_testbench is
end exstage_testbench;

architecture Behavioral of exstage_testbench is

component exstage is
    Port (
        rf_a: in std_logic_vector(31 downto 0);
        rf_b: in std_logic_vector(31 downto 0);
        immed: in std_logic_vector(31 downto 0);
        
        alu_bin_sel: in std_logic;
        
        alu_func: in std_logic_vector(3 downto 0);
        alu_out: out std_logic_vector(31 downto 0);
        alu_zero: out std_logic
    );
end component;

signal rf_a: std_logic_vector(31 downto 0);
signal rf_b: std_logic_vector(31 downto 0);
signal immed: std_logic_vector(31 downto 0);
signal alu_bin_sel: std_logic;
signal alu_func: std_logic_vector(3 downto 0);
signal alu_out: std_logic_vector(31 downto 0);
signal alu_zero: std_logic;

begin

    uut: exstage port map(
        rf_a => rf_a,
        rf_b => rf_b,
        immed => immed,
        alu_bin_sel => alu_bin_sel,
        alu_func => alu_func,
        alu_out => alu_out,
        alu_zero => alu_zero
    );
    
    stim_proc: process begin
    
        rf_a <= x"00001000";
        rf_b <= x"00000021";
        immed <= x"00001021";
        
        alu_bin_sel <= '0';
        alu_func <= x"0";
        
        wait for 100 ns;
        
        alu_bin_sel <= '1';
        
        wait for 100 ns;
        
        rf_b <= x"00001000";
        alu_func <= x"1";
        alu_bin_sel <= '0';
        
        wait;
        
    end process;

end Behavioral;
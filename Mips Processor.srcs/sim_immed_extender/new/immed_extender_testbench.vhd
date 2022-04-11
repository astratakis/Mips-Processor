----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	immed_extender_testbench - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the immed extender.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity immed_extender_testbench is
end immed_extender_testbench;

architecture Behavioral of immed_extender_testbench is

component immed_extender is
    Port (
        input_immed: in std_logic_vector(15 downto 0);
        operation: in std_logic_vector(1 downto 0);
        
        extended_immed: out std_logic_vector(31 downto 0)
    );
end component;

signal immed: std_logic_vector(15 downto 0);
signal sel: std_logic_vector(1 downto 0);
signal immed_extended: std_logic_vector(31 downto 0);

begin

    uut: immed_extender port map(
        input_immed => immed,
        operation => sel,
        extended_immed => immed_extended
    );
    
    stim_proc: process begin
        
        immed <= x"800f";
        sel <= "00";
        
        wait for 100 ns;
        
        sel <= "01";
        
        wait for 100 ns;
        
        sel <= "10";
        
        wait for 100 ns;
        
        sel <= "11";
        
        wait for 100 ns;
        
        immed <= x"000f";
        sel <= "01";
        
        wait;
        
    end process;

end Behavioral;

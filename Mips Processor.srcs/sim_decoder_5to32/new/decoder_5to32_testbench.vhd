----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	decoder_5to32_testbench - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the 5:32 decoder.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_5to32_testbench is
end decoder_5to32_testbench;

architecture Behavioral of decoder_5to32_testbench is

component decoder_5to32 is
    Port (
        input: in std_logic_vector(4 downto 0);
        output: out std_logic_vector(31 downto 0)
    );
end component;

signal input: std_logic_vector(4 downto 0);
signal output: std_logic_vector(31 downto 0);

begin

    uut: decoder_5to32 port map(
        input => input,
        output => output
    );
    
    stim_proc: process begin
    
        input <= "00000";
        wait for 100 ns;
        
        input <= "00001";
        wait for 100 ns;
        
        input <= "00011";
        wait for 100 ns;
        
        input <= "11111";
        wait;
    
    end process;

end Behavioral;

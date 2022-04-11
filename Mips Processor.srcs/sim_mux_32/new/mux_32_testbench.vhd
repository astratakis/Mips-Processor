----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	mux_32 - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the 32x32:1 multiplexer.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.vector_array.all;

entity mux_32_testbench is
end mux_32_testbench;

architecture Behavioral of mux_32_testbench is

component mux_32 is
    Port (
        input: in bus_array(31 downto 0);
        sel: in std_logic_vector(4 downto 0);
        output: out std_logic_vector(31 downto 0)
    );
end component;

signal input: bus_array(31 downto 0);
signal sel: std_logic_vector(4 downto 0);
signal output: std_logic_vector(31 downto 0);

begin
    
    uut: mux_32 port map(
        input => input,
        sel => sel,
        output => output
    );
    
    stim_proc: process begin
    
        input(3) <= x"dada1122";
        input(16) <= x"fefe5566";
        input(0) <= x"10002000";
        
        sel <= "00000";
        wait for 100 ns;
        
        sel <= "00001";
        wait for 100 ns;
        
        sel <= "00011";
        wait for 100 ns;
        
        sel <= "10000";
        wait;
    
    end process;

end Behavioral;

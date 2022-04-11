----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	mux_2 - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the 2:1 multiplexer.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_testbench is
end mux_2_testbench;

architecture Behavioral of mux_2_testbench is

component mux_2 is
    Port (
        A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        sel: in std_logic;
        output: out std_logic_vector(31 downto 0)
    );
end component;

signal A: std_logic_vector(31 downto 0);
signal B: std_logic_vector(31 downto 0);
signal sel: std_logic;
signal output: std_logic_vector(31 downto 0);

begin

    uut: mux_2 port map(
        A => A,
        B => B,
        sel => sel,
        output => output
    );
    
    stim_proc: process begin
    
        A <= x"ffff1111";
        B <= x"eeee2222";
        sel <= '0';
        
        wait for 100 ns;
        
        sel <= '1';
        
        wait;
    
    end process;

end Behavioral;
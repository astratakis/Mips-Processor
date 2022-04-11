----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	byte_parser_testbench - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This selects a signle byte from a 32 bit word.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity byte_parser_testbench is
end byte_parser_testbench;

architecture Behavioral of byte_parser_testbench is

component byte_parser is
    Port (
        word: in std_logic_vector(31 downto 0);
        sel: in std_logic_vector(1 downto 0);
        
        byte: out std_logic_vector(31 downto 0)
    );
end component;

signal word: std_logic_vector(31 downto 0);
signal sel: std_logic_vector(1 downto 0);
signal byte: std_logic_vector(31 downto 0);

begin

    uut: byte_parser port map(
        word => word,
        sel => sel,
        byte => byte
    );
    
    process begin
    
        word <= x"12345678";
        
        sel <= "00";
        wait for 100 ns;
    
        sel <= "01";
        wait for 100 ns;
        
        sel <= "10";
        wait for 100 ns;
        
        sel <= "11";
        wait for 100 ns;
        
        wait;
    end process;

end Behavioral;

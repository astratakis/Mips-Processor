----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2022 02:36:51 PM
-- Design Name: 
-- Module Name: interrupt_comparator - Behavioral
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

entity interrupt_comparator is
    Port (
        rs: in std_logic_vector(4 downto 0);
        rt: in std_logic_vector(4 downto 0);
        
        rd_prime: in std_logic_vector(4 downto 0);
        
        rf_wrdata_sel: in std_logic;
        rf_wren: in std_logic;
        
        halt: out std_logic
    );
end interrupt_comparator;

architecture Behavioral of interrupt_comparator is

begin
    
    halt <= '1' when ((rd_prime = rs) or (rd_prime = rt)) and rf_wrdata_sel = '1' and rf_wren = '1' else '0';

end Behavioral;

----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	immed_extender - Structural
-- Project Name: 	Mips Processor
--
-- Description: 
-- Given a 16 bit immediate and an operation select signal perform 1 of 4 operations
-- and convert the 16 bit immediate to 32 bits.
--
-- 1. Zero Fill
-- 2. Sign Extend
-- 3. immed << 16
-- 4 (Sign Extend) * 4
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity immed_extender is
    Port (
        input_immed: in std_logic_vector(15 downto 0);
        operation: in std_logic_vector(1 downto 0);
        
        extended_immed: out std_logic_vector(31 downto 0)
    );
end immed_extender;

architecture Structural of immed_extender is

signal zero_fill: std_logic_vector(31 downto 0);
signal sign_extend: std_logic_vector(31 downto 0);

begin

    zero_fill <= std_logic_vector(resize(unsigned(input_immed), 32));
    sign_extend <= std_logic_vector(resize(signed(input_immed), 32));
    
    extended_immed <= zero_fill when operation = "00"
                      else sign_extend when operation = "01"
                      else zero_fill(15 downto 0) & x"0000" when operation = "10"
                      else sign_extend(29 downto 0) & "00";
    

end Structural;
----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	decoder_5to32 - Structural
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a 5 to 32 bit decoder. The decimal value of the input
-- corresponds to output = 1 << input.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;
use IEEE.NUMERIC_STD.ALL;

entity decoder_5to32 is
    Port (
        input: in std_logic_vector(4 downto 0);
        output: out std_logic_vector(31 downto 0)
    );
end decoder_5to32;

architecture Structural of decoder_5to32 is

-- One in binary (used for slide left logical operation)
constant one: std_logic_vector(31 downto 0) := x"00000001";

begin

    -- Output = 1 << decimal(input).
    output <= std_logic_vector(unsigned(one) sll to_integer(unsigned(input))) after latency;

end Structural;

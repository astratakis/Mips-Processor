----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	mux_32 - Structural
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a 32:1 multiplexer. Each input is 32 bits. 
-- The sel signal is log2(32) = 5 bits.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.constants.all;
use work.vector_array.all;

entity mux_32 is
    Port (
        input: in bus_array(31 downto 0);
        sel: in std_logic_vector(4 downto 0);
        output: out std_logic_vector(31 downto 0)
    );
end mux_32;

architecture Structural of mux_32 is
    
begin

    -- Select the decimal value of the sel signal in the array...
    output <= input(to_integer(unsigned(sel))) after latency;

end Structural;

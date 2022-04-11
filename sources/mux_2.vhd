----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	mux_2 - Structural
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a multiplexer 2:1. Inputs are 32 bit signals and the sel signal is 1 bit.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2 is
    Port (
        A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        sel: in std_logic;
        output: out std_logic_vector(31 downto 0)
    );
end mux_2;

architecture Structural of mux_2 is

begin

    -- Obviously...
    output <= A when sel = '1' else B;

end Structural;

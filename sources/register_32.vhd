----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	register_32 - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a 32-bit synchronous register. The reset signal initializes the
-- output to 0x0000. The write enable signal enables writing to the register.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity register_32 is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        write_enable: in std_logic;
        
        datain: in std_logic_vector(31 downto 0);
        dataout: out std_logic_vector(31 downto 0)
    );
end register_32;

architecture Behavioral of register_32 is

signal write_data: std_logic_vector(31 downto 0);

begin

    process begin
        
        -- Wait for rising edge of the clock...
        wait until clock'event and clock = '1';
        
        -- Reset signal is the highest priority (ignores write enable).
        if reset = '1' then
            write_data <= x"00000000" after latency;
        else
            if write_enable = '1' then
                write_data <= datain after latency;
            end if;
        end if;
        
    end process;
    
    dataout <= write_data;

end Behavioral;

----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	register_32_testbench - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is the test for the 32-bit register.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity register_32_testbench is
end register_32_testbench;

architecture Behavioral of register_32_testbench is

component register_32 is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        write_enable: in std_logic;
        
        datain: in std_logic_vector(31 downto 0);
        dataout: out std_logic_vector(31 downto 0)
    );
end component;

signal clock: std_logic := '0';
signal reset: std_logic := '1';
signal write_enable: std_logic := '-';
signal datain: std_logic_vector(31 downto 0);
signal dataout: std_logic_vector(31 downto 0);

begin

    clock <= not clock after clock_period/2;
    
    uut: register_32 port map(
        clock => clock,
        reset => reset,
        write_enable => write_enable,
        datain => datain,
        dataout => dataout
    );
    
    stim_proc: process begin
    
        wait for 4*clock_period;
        
        reset <= '0';
        write_enable <= '1';
        datain <= x"ffffee11";
        
        wait for 2*clock_period;
        
        datain <= x"12345678";
        wait for clock_period;
        
        datain <= x"dddd1122";
        write_enable <= '0';
        
        wait for clock_period;
        
        reset <= '1';
        write_enable <= '-';
        
        wait;
    
    end process;

end Behavioral;

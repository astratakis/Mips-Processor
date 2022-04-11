----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	register_file - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the register file
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;
use ieee.numeric_std.all;

entity register_file_testbench is
end register_file_testbench;

architecture Behavioral of register_file_testbench is

component register_file is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        write_enable: in std_logic;
        
        ard1: in std_logic_vector(4 downto 0);
        ard2: in std_logic_vector(4 downto 0);
        awr: in std_logic_vector(4 downto 0);
        
        din: in std_logic_vector(31 downto 0);
        dout1: out std_logic_vector(31 downto 0);
        dout2: out std_logic_vector(31 downto 0)
    );
end component;

signal clock: std_logic := '0';
signal reset: std_logic := '1';
signal write_enable: std_logic := '-';

signal ard1: std_logic_vector(4 downto 0);
signal ard2: std_logic_vector(4 downto 0);
signal awr: std_logic_vector(4 downto 0);

signal din: std_logic_vector(31 downto 0);
signal dout1: std_logic_vector(31 downto 0);
signal dout2: std_logic_vector(31 downto 0);

begin
    
    clock <= not clock after clock_period/2;

    uut: register_file port map(
        clock => clock,
        reset => reset,
        write_enable => write_enable,
        
        ard1 => ard1,
        ard2 => ard2,
        awr => awr,
        
        din => din,
        dout1 => dout1,
        dout2 => dout2
    );

    stim_proc: process begin
    
        wait for clock_period;
        
        reset <= '0';
        write_enable <= '1';
        
        -- Attempt to write to resiter 0
        awr <= '0' & x"0";
        din <= x"fac10000";
        
        wait for clock_period;
        
        ard1 <= '0' & x"0";
        
        wait for clock_period;
        
        for i in 1 to 4 loop
            
            din <= std_logic_vector(to_unsigned(i, 32));
            awr <= std_logic_vector(to_unsigned(i, 5));
            
            wait for clock_period;
        
        end loop;
        
        write_enable <= '0';
        
        ard1 <= '0' & x"1";
        
        for i in 1 to 4 loop
        
            ard2 <= std_logic_vector(to_unsigned(i, 5));
            
            wait for clock_period;
        
        end loop;
		
		wait;
    
    end process;

end Behavioral;

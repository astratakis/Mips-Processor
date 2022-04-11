----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	memstage_testbench - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the memstage of the datapath.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memstage_testbench is
end memstage_testbench;

architecture Behavioral of memstage_testbench is

component memstage is
    Port ( 
        byte_op: in std_logic;
        mem_wren: in std_logic;
        
        alu_mem_addr: in std_logic_vector(31 downto 0);
        
        mem_datain: in std_logic_vector(31 downto 0);
        mem_dataout: out std_logic_vector(31 downto 0);
        
        mm_wren: out std_logic;
        mm_addr: out std_logic_vector(10 downto 0);
        
        mm_wrdata: out std_logic_vector(31 downto 0);
        mm_rddata: in std_logic_vector(31 downto 0)
    );
end component;

signal mem_wren: std_logic;
signal mem_datain: std_logic_vector(31 downto 0);
signal mem_dataout: std_logic_vector(31 downto 0);
signal alu_mem_addr: std_logic_vector(31 downto 0);
signal byte_op: std_logic;

signal ram_addr: std_logic_vector(10 downto 0);
signal ram_wren: std_logic;
signal ram_wrdata: std_logic_vector(31 downto 0);
signal ram_rddata: std_logic_vector(31 downto 0);

begin

    uut: memstage port map(
        mem_wren => mem_wren,
        mem_datain => mem_datain,
        mem_dataout => mem_dataout,
        alu_mem_addr => alu_mem_addr,
        byte_op => byte_op,
        
        mm_addr => ram_addr,
        mm_wren => ram_wren,
        mm_wrdata => ram_wrdata,
        mm_rddata => ram_rddata
    );
    
    stim_proc: process begin
        
        byte_op <= '0';
        mem_wren <= '0';
        mem_datain <= x"12345678";
        ram_rddata <= x"edca9592";
        
        alu_mem_addr <= x"17283645";
        
        wait for 100 ns;
        byte_op <= '1';
        
        wait for 100 ns;
        
        alu_mem_addr <= x"17283646";
        wait for 100 ns;
        
        alu_mem_addr <= x"17283647";
        wait for 100 ns;
        
        alu_mem_addr <= x"17283648";
        
        wait;
    
    end process;

end Behavioral;
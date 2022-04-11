----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2022 09:44:45 PM
-- Design Name: 
-- Module Name: datapath_testbench - Behavioral
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

entity datapath_testbench is
end datapath_testbench;

architecture Behavioral of datapath_testbench is

component datapath is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        
        alu_bin_sel: in std_logic;
        alu_func: in std_logic_vector(3 downto 0);
        alu_zero: out std_logic;
        
        pc_lden: in std_logic;
        pc_sel: in std_logic;
        pc: out std_logic_vector(31 downto 0);
        
        instruction: in std_logic_vector(31 downto 0);
        rf_wrdata_sel: in std_logic;
        rf_b_sel: in std_logic;
        rf_wren: in std_logic;
        immed_ext: in std_logic_vector(1 downto 0);
        
        mem_wren: in std_logic;
        byte_op: in std_logic;
        ram_rddata: in std_logic_vector(31 downto 0);
        ram_wren: out std_logic;
        ram_wrdata: out std_logic_vector(31 downto 0);
        ram_addr: out std_logic_vector(10 downto 0)
    );
end component;

signal clock: std_logic := '0';
signal reset: std_logic := '1';

signal alu_bin_sel: std_logic;
signal alu_func: std_logic_vector(3 downto 0);
signal alu_zero: std_logic;

signal pc_lden: std_logic;
signal pc_sel: std_logic;
signal pc: std_logic_vector(31 downto 0);

signal instruction: std_logic_vector(31 downto 0);
signal rf_wrdata_sel: std_logic;
signal rf_b_sel: std_logic;
signal rf_wren: std_logic;
signal immed_ext: std_logic_vector(1 downto 0);

begin

end Behavioral;
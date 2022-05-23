----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2022 11:57:07 PM
-- Design Name: 
-- Module Name: proc_mc - Behavioral
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
use work.constants.all;

entity proc_mc is
    Port (
        clock: in std_logic;
        reset: in std_logic
    );
end proc_mc;

architecture Behavioral of proc_mc is

component control_mc is
    Port (
        clock: in std_logic;
        reset: in std_logic;
    
        instruction: in std_logic_vector(31 downto 0);
        alu_zero: in std_logic;
        
        pc_sel: out std_logic;
        pc_lden: out std_logic;
        
        alu_bin_sel: out std_logic;
        alu_func: out std_logic_vector(3 downto 0);
        
        immed_sel: out std_logic;
        reg_we: out std_logic_vector(5 downto 0);
        
        rf_wrdata_sel: out std_logic;
        rf_b_sel: out std_logic;
        rf_wren: out std_logic;
        immed_ext: out std_logic_vector(1 downto 0);
        
        byte_op: out std_logic;
        mem_wren: out std_logic
    );
end component;

component datapath_mc is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        
        alu_bin_sel: in std_logic;
        alu_func: in std_logic_vector(3 downto 0);
        alu_zero: out std_logic;
        
        pc_lden: in std_logic;
        pc_sel: in std_logic;
        pc: out std_logic_vector(31 downto 0);
        
        immed_sel: in std_logic;
        reg_we: in std_logic_vector(5 downto 0);
        
        instruction: in std_logic_vector(31 downto 0);
        ctrl_instr: out std_logic_vector(31 downto 0);
        rf_wrdata_sel: in std_logic;
        rf_b_sel: in std_logic;
        rf_wren: in std_logic;
        immed_ext: in std_logic_vector(1 downto 0);
        
        mem_wren: in std_logic;
        byte_op: in std_logic;
        mm_rddata: in std_logic_vector(31 downto 0);
        mm_wren: out std_logic;
        mm_wrdata: out std_logic_vector(31 downto 0);
        mm_addr: out std_logic_vector(10 downto 0)
    );
end component;

component ram is
    port (
        clk : in std_logic;
        inst_addr : in std_logic_vector(10 downto 0);
        inst_dout : out std_logic_vector(31 downto 0);
        data_we : in std_logic;
        data_addr : in std_logic_vector(10 downto 0);
        data_din : in std_logic_vector(31 downto 0);
        data_dout : out std_logic_vector(31 downto 0)
    );
end component;

signal immed_sel: std_logic;
signal reg_we: std_logic_vector(5 downto 0);

signal alu_bin_sel_signal: std_logic;
signal alu_func_signal: std_logic_vector(3 downto 0);
signal alu_zero_signal: std_logic;

signal pc_lden_signal: std_logic;
signal pc_sel_signal: std_logic;
signal pc_signal: std_logic_vector(31 downto 0);

signal instr_signal: std_logic_vector(31 downto 0);
signal ctrl_instr_signal: std_logic_vector(31 downto 0);

signal rf_wrdata_sel_signal: std_logic;
signal rf_b_sel_signal: std_logic;
signal rf_wren_signal: std_logic;
signal immed_ext_signal: std_logic_vector(1 downto 0);

signal mem_wren_signal: std_logic;
signal byte_op_signal: std_logic;
signal ram_rddata_signal: std_logic_vector(31 downto 0);
signal ram_wren_signal: std_logic;
signal ram_wrdata_signal: std_logic_vector(31 downto 0);
signal ram_addr_signal: std_logic_vector(10 downto 0);

begin

    datapath_component: datapath_mc port map(
        clock => clock,
        reset => reset,
        alu_bin_sel => alu_bin_sel_signal,
        alu_func => alu_func_signal,
        alu_zero => alu_zero_signal,
        pc_lden => pc_lden_signal,
        pc_sel => pc_sel_signal,
        pc => pc_signal,
        instruction => instr_signal,
        ctrl_instr => ctrl_instr_signal,
        rf_wrdata_sel => rf_wrdata_sel_signal,
        rf_b_sel => rf_b_sel_signal,
        rf_wren => rf_wren_signal,
        immed_ext => immed_ext_signal,
        
        immed_sel => immed_sel,
        reg_we => reg_we,
        
        mem_wren => mem_wren_signal,
        byte_op => byte_op_signal,
        mm_rddata => ram_rddata_signal,
        mm_wren => ram_wren_signal,
        mm_wrdata => ram_wrdata_signal,
        mm_addr => ram_addr_signal
    );
    
    random_access_memory: ram port map(
        clk => clock,
        inst_addr => pc_signal(12 downto 2),
        inst_dout => instr_signal,
        data_we => ram_wren_signal,
        data_addr => ram_addr_signal,
        data_din => ram_wrdata_signal,
        data_dout => ram_rddata_signal
    );
    
    control_component: control_mc port map(
        clock => clock,
        reset => reset,
    
        instruction => ctrl_instr_signal,
        alu_zero => alu_zero_signal,
        
        pc_sel => pc_sel_signal,
        pc_lden => pc_lden_signal,
        
        alu_bin_sel => alu_bin_sel_signal,
        alu_func => alu_func_signal,
        
        reg_we => reg_we,
        immed_sel => immed_sel,
        
        rf_wrdata_sel => rf_wrdata_sel_signal,
        rf_b_sel => rf_b_sel_signal,
        rf_wren => rf_wren_signal,
        immed_ext => immed_ext_signal,
        
        byte_op => byte_op_signal,
        mem_wren => mem_wren_signal
    );

end Behavioral;

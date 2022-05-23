----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2022 11:48:30 PM
-- Design Name: 
-- Module Name: datapath_mc - Behavioral
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
use ieee.numeric_std.all;

entity datapath_mc is
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
end datapath_mc;

architecture Structural of datapath_mc is

component ifstage is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        
        pc_lden: in std_logic;
        pc_sel: in std_logic;
        
        pc_immed: in std_logic_vector(31 downto 0);
        pc: out std_logic_vector(31 downto 0)
    );
end component;

component decstage is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        
        instr: in std_logic_vector(31 downto 0);
        rf_wren: in std_logic;
        alu_out: in std_logic_vector(31 downto 0);
        mem_out: in std_logic_vector(31 downto 0);
        rf_wrdata_sel: in std_logic;
        rf_b_sel: in std_logic;
        
        imm_ext: in std_logic_vector(1 downto 0);
        
        immed: out std_logic_vector(31 downto 0);
        rf_a: out std_logic_vector(31 downto 0);
        rf_b: out std_logic_vector(31 downto 0)
    );
end component;

component exstage is
    Port (
        rf_a: in std_logic_vector(31 downto 0);
        rf_b: in std_logic_vector(31 downto 0);
        immed: in std_logic_vector(31 downto 0);
        
        alu_bin_sel: in std_logic;
        
        alu_func: in std_logic_vector(3 downto 0);
        alu_out: out std_logic_vector(31 downto 0);
        alu_zero: out std_logic
    );
end component;

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

component register_32 is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        write_enable: in std_logic;
        
        datain: in std_logic_vector(31 downto 0);
        dataout: out std_logic_vector(31 downto 0)
    );
end component;

component mux_2 is
    Port (
        A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        sel: in std_logic;
        output: out std_logic_vector(31 downto 0)
    );
end component;

signal selected_immed: std_logic_vector(31 downto 0);
signal pc_immed: std_logic_vector(31 downto 0);

signal extended_immed: std_logic_vector(31 downto 0);
signal rf_a_signal: std_logic_vector(31 downto 0);
signal rf_b_signal: std_logic_vector(31 downto 0);

signal alu_out_signal: std_logic_vector(31 downto 0);
signal mem_out_signal: std_logic_vector(31 downto 0);

-- REGISTER OUTPUT SIGNALS
signal instruction_register_out: std_logic_vector(31 downto 0);
signal alu_register_out: std_logic_vector(31 downto 0);
signal mem_register_out: std_logic_vector(31 downto 0);
signal immed_register_out: std_logic_vector(31 downto 0);
signal a_register_out: std_logic_vector(31 downto 0);
signal b_register_out: std_logic_vector(31 downto 0);

begin

    -- Decrement pc immediate by 4
    pc_immed <= std_logic_vector(unsigned(selected_immed) - x"4");
    ctrl_instr <= instruction_register_out;
    alu_zero <= '1' when alu_register_out = x"00000000" else '0';

    ifstage_component: ifstage port map(
        clock => clock,
        reset => reset,
        
        pc_lden => pc_lden,
        pc_sel => pc_sel,
        pc_immed => pc_immed,
        pc => pc
    );
    
    instruction_register: register_32 port map(
        clock => clock,
        reset => reset,
        write_enable => reg_we(0),
        
        datain => instruction,
        dataout => instruction_register_out
    );
    
    decstage_component: decstage port map(
        clock => clock,
        reset => reset,
        instr => instruction_register_out,
        
        rf_wren => rf_wren,
        rf_b_sel => rf_b_sel,
        rf_wrdata_sel => rf_wrdata_sel,
        
        alu_out => alu_register_out,
        mem_out => mem_register_out,
        
        imm_ext => immed_ext,
        immed => extended_immed,
        
        rf_a => rf_a_signal,
        rf_b => rf_b_signal
    );
    
    immediate_register: register_32 port map(
        clock => clock,
        reset => reset,
        write_enable => reg_we(1),
        
        datain => extended_immed,
        dataout => immed_register_out
    );
    
    A_register: register_32 port map(
        clock => clock,
        reset => reset,
        write_enable => reg_we(2),
        
        datain => rf_a_signal,
        dataout => a_register_out
    );
    
    B_register: register_32 port map(
        clock => clock,
        reset => reset,
        write_enable => reg_we(3),
        
        datain => rf_b_signal,
        dataout => b_register_out
    );
    
    immed_selector: mux_2 port map(
        A => immed_register_out,
        B => extended_immed,
        sel => immed_sel,
        
        output => selected_immed
    );
    
    exstage_component: exstage port map(
        rf_a => a_register_out,
        rf_b => b_register_out,
        immed => immed_register_out,
        
        alu_bin_sel => alu_bin_sel,
        alu_func => alu_func,
        alu_zero => open,
        alu_out => alu_out_signal
    );
    
    alu_register: register_32 port map(
        clock => clock,
        reset => reset,
        write_enable => reg_we(4),
        
        datain => alu_out_signal,
        dataout => alu_register_out
    );
    
    memstage_component: memstage port map(
        byte_op => byte_op,
        mem_wren => mem_wren,
        
        alu_mem_addr => alu_register_out,
        
        mem_datain => b_register_out,
        mem_dataout => mem_out_signal,
        
        mm_wren => mm_wren,
        mm_addr => mm_addr,
        
        mm_rddata => mm_rddata,
        mm_wrdata => mm_wrdata
    );
    
    mem_register: register_32 port map(
        clock => clock,
        reset => reset,
        write_enable => reg_we(5),
        
        datain => mem_out_signal,
        dataout => mem_register_out
    );

end Structural;

----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	datapath - Structural
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is the final datapath of the processor.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath is
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
end datapath;

architecture Structural of datapath is

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

component memstage is
    Port (
        mem_wren: in std_logic;
        mem_datain: in std_logic_vector(31 downto 0);
        mem_dataout: out std_logic_vector(31 downto 0);
        alu_mem_addr: in std_logic_vector(31 downto 0);
        byte_op: in std_logic;
        
        mm_addr: out std_logic_vector(10 downto 0);
        mm_wren: out std_logic;
        mm_wrdata: out std_logic_vector(31 downto 0);
        mm_rddata: in std_logic_vector(31 downto 0)
    );
end component;

signal extended_immed: std_logic_vector(31 downto 0);
signal rf_a_signal: std_logic_vector(31 downto 0);
signal rf_b_signal: std_logic_vector(31 downto 0);

signal alu_out_signal: std_logic_vector(31 downto 0);
signal mem_out_signal: std_logic_vector(31 downto 0);

begin

    fetch_stage: ifstage port map(
        clock => clock,
        reset => reset,
        pc_lden => pc_lden,
        pc_sel => pc_sel,
        pc => pc,
        pc_immed => extended_immed
    );
    
    decoding_stage: decstage port map(
        clock => clock,
        reset => reset,
        instr => instruction,
        
        rf_wren => rf_wren,
        alu_out => alu_out_signal,
        mem_out => mem_out_signal,
        rf_wrdata_sel => rf_wrdata_sel,
        rf_b_sel => rf_b_sel,
        imm_ext => immed_ext,
        
        immed => extended_immed,
        rf_a => rf_a_signal,
        rf_b => rf_b_signal
    );

    execution_stage: exstage port map(
        rf_a => rf_a_signal,
        rf_b => rf_b_signal,
        immed => extended_immed,
        alu_bin_sel => alu_bin_sel,
        alu_func => alu_func,
        alu_out => alu_out_signal,
        alu_zero => alu_zero
    );
    
    memory_stage: memstage port map(
        mem_wren => mem_wren,
        mem_datain => rf_b_signal,
        mem_dataout => mem_out_signal,
        alu_mem_addr => alu_out_signal,
        byte_op => byte_op,
        
        mm_addr => ram_addr,
        mm_wren => ram_wren,
        mm_wrdata => ram_wrdata,
        mm_rddata => ram_rddata
    );

end Structural;
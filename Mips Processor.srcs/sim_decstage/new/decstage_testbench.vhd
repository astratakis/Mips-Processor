----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	decstage_testbench - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the decstage.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity decstage_testbench is
end decstage_testbench;

architecture Behavioral of decstage_testbench is

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

signal clock: std_logic := '0';
signal reset: std_logic := '1';
signal rf_wren: std_logic := '-';
signal rf_b_sel: std_logic := '-';
signal rf_wrdata_sel: std_logic := '-';

signal instr: std_logic_vector(31 downto 0);

signal imm_ext: std_logic_vector(1 downto 0);
signal alu_out: std_logic_vector(31 downto 0);
signal mem_out: std_logic_vector(31 downto 0);

signal immed: std_logic_vector(31 downto 0);
signal rf_a: std_logic_vector(31 downto 0);
signal rf_b: std_logic_vector(31 downto 0);

begin

    clock <= not clock after clock_period/2;

    uut: decstage port map(
        clock => clock,
        reset => reset,
        rf_wren => rf_wren,
        rf_b_sel => rf_b_sel,
        rf_wrdata_sel => rf_wrdata_sel,
        instr => instr,
        imm_ext => imm_ext,
        alu_out => alu_out,
        mem_out => mem_out,
        immed => immed,
        rf_a => rf_a,
        rf_b => rf_b
    );
    
    stim_proc: process begin
    
        -- Reset Register File
        reset <= '1';
        instr <= "--------------------------------";
        wait for 200 ns;
        
        reset <= '0';
        
        instr	<= b"000000_00000_00000_00000_00000_011111"; 
        rf_wren <= '0';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '0';
        rf_b_sel	<= '0';
        imm_ext <= "00";
        wait for 200 ns;
        
        -- Zero-fill and shift
        instr	<= b"000000_00000_00000_00000_00000_011111"; 
        rf_wren <= '0';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '0';
        rf_b_sel	<= '0';
        imm_ext <= "10";
        wait for 200 ns;
        
        -- Sign-extend
        instr	<= b"000000_00000_00000_11111_11111_100000"; 
        rf_wren <= '0';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '0';
        rf_b_sel	<= '0';
        imm_ext <= "01";
        wait for 200 ns;
        
        -- Sign-extend and shift
        instr	<= b"000000_00000_00000_11111_11111_100000"; 
        rf_wren <= '0';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '0';
        rf_b_sel	<= '0';
        imm_ext <= "11";
        wait for 200 ns;
        
        -- Try to write R0 which isn't possible
        instr	<= b"000000_00000_00000_00000_00000_000000"; 
        rf_wren <= '1';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '0';
        rf_b_sel	<= '1';
        imm_ext <= "00";
        wait for 200 ns;
        
        -- Write from alu_out in R2 and reading 
        instr	<= b"000000_00010_00010_00000_00000_000000"; 
        rf_wren <= '1';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '0';
        rf_b_sel	<= '1';
        imm_ext <= "00";
        wait for 200 ns;			
        
        -- Don't write from mem_out in R2 and read
        instr	<= b"000000_00010_00010_00000_00000_000000"; 
        rf_wren <= '0';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '1';
        rf_b_sel	<= '1';
        imm_ext <= "00";
        wait for 200 ns;

        -- Write and read from mem_out in R3
        instr	<= b"000000_00010_00011_00000_00000_000000"; 
        rf_wren <= '1';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '1';
        rf_b_sel	<= '1';
        imm_ext <= "00";
        wait for 200 ns;
        
        -- Write R4 from alu_out and read R2 and R3
        instr	<= b"000000_00010_00100_00011_00000_000000"; 
        rf_wren <= '1';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '0';
        rf_b_sel	<= '0';
        imm_ext <= "00";
        wait for 200 ns;
        
        -- Write R4 from alu_out and read R2 and R3
        instr	<= b"000000_00010_00100_00011_00000_000000"; 
        rf_wren <= '1';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '0';
        rf_b_sel	<= '0';
        imm_ext <= "00";
        wait for 200 ns;
        
        -- Read R3 and R4
        instr	<= b"000000_00011_00100_00100_00000_000000"; 
        rf_wren <= '0';
        alu_out <= x"0000_abcd";
        mem_out <= x"0000_dcba";
        rf_wrdata_sel <= '0';
        rf_b_sel	<= '0';
        imm_ext <= "00";
        wait for 200 ns;
        
        wait;
    
    end process;

end Behavioral;

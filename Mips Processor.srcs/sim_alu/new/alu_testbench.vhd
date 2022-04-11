----------------------------------------------------------------------------------
-- Institution: 	Technical University of Crete
-- Engineer: 		Andreas Stratakis
-- 
-- Create Date: 	03/10/2022 08:40:32 PM
-- Design Name: 
-- Module Name: 	alu_testbench - Behavioral
-- Project Name: 	Mips Processor
--
-- Description: 
-- This is a test for the ALU
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_testbench is
end alu_testbench;

architecture Behavioral of alu_testbench is

component alu is
    Port (
        A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        op: in std_logic_vector(3 downto 0);
        
        output: out std_logic_vector(31 downto 0);
        zero: out std_logic;
        cout: out std_logic;
        ovf: out std_logic
    );
end component;

signal A: std_logic_vector(31 downto 0);
signal B: std_logic_vector(31 downto 0);
signal op: std_logic_vector(3 downto 0);

signal output: std_logic_vector(31 downto 0);
signal zero: std_logic;
signal cout: std_logic;
signal ovf: std_logic;

begin

    uut: alu port map(
        A => A,
        B => B,
        op => op,
        output => output,
        zero => zero,
        cout => cout,
        ovf => ovf
    );
    
    stim_proc: process begin
    
        -- Add numbers 3 + 9 = 12 (expected: 0000000c)
        op <= x"0";
        A <= x"00000003";
        B <= x"00000009";
        
        wait for 50 ns;
        
        -- Subtract 2 numbers (expected: 00001111)
        op <= x"1";
        A <= x"0000ffff";
        B <= x"0000eeee";
        
        wait for 50 ns;
        
        -- Bitwise and numbers 11 & 25 (expected 9)
        op <= x"2";
        A <= x"00000019";
        B <= x"0000000b";
        
        wait for 50 ns;
        
        -- Bitwise or same numbers (expected 27 = 1b)
        op <= x"3";
        
        wait for 50 ns;
        
        -- Bitwise not number A (expected ffffffe6)
        op <= x"4";
        
        wait for 50 ns;
        
        -- Bitwise nand a !& b (expected fffffff6)
        op <= x"6";
        
        wait for 50 ns;
        
        -- Arithmetic right shift number A = 89000000 (expected: c4800000)
        op <= x"8";
        A <= x"89000000";
        
        wait for 50 ns;
        
        -- Logical right shift number A (expected: 44800000)
        op <= x"9";
        
        wait for 50 ns;
        
        A <= x"89000001";
        op <= x"a";
        
        wait for 50 ns;
        
        op <= x"c";
        
        wait for 50 ns;
        
        op <= x"d";
        
        wait for 50 ns;
        
        op <= x"1";
        A <= x"00000009";
        B <= x"00000009";
        
        wait for 50 ns;
        
        wait;
    
    end process;

end Behavioral;
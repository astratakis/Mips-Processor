library ieee;
use ieee.std_logic_1164.all;

entity control_pipeline_testbench is
end control_pipeline_testbench;

architecture Behavioral of control_pipeline_testbench is

component control_pipeline is
    Port (
        instruction: in std_logic_vector(31 downto 0);
        
        branch: out std_logic;
        conditional_branch: out std_logic;
        conditional_not_branch: out std_logic;
        pc_lden: out std_logic;
        
        alu_bin_sel: out std_logic;
        alu_func: out std_logic_vector(3 downto 0);
        
        rf_wrdata_sel: out std_logic;
        rf_b_sel: out std_logic;
        rf_wren: out std_logic;
        immed_ext: out std_logic_vector(1 downto 0);
        
        byte_op: out std_logic;
        mem_wren: out std_logic
    );
end component;

signal control_signals: std_logic_vector(15 downto 0);
signal instruction: std_logic_vector(31 downto 0);

begin

    uut: control_pipeline port map(
        instruction => instruction,
        branch => control_signals(15),
        conditional_branch => control_signals(14),
        conditional_not_branch => control_signals(13),
        pc_lden => control_signals(12),
        
        alu_bin_sel => control_signals(11),
        alu_func => control_signals(10 downto 7),
        
        rf_wrdata_sel => control_signals(6),
        rf_b_sel => control_signals(5),
        rf_wren => control_signals(4),
        immed_ext => control_signals(3 downto 2),
        
        byte_op => control_signals(1),
        mem_wren => control_signals(0)
    );
    
    stim_proc: process begin
    
        instruction <= "11000000000001010000000000001000";
    
        wait;
    
    end process;

end Behavioral;
library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity control_mc_testbench is
end control_mc_testbench;

architecture Behavioral of control_mc_testbench is

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

signal active_clock: std_logic := '1';
signal clock: std_logic := '0';
signal reset: std_logic := '1';

signal alu_zero: std_logic;
signal instruction: std_logic_vector(31 downto 0);

signal immed_sel: std_logic;
signal reg_we: std_logic_vector(5 downto 0);

signal pc_lden: std_logic;
signal pc_sel: std_logic;
signal alu_bin_sel: std_logic;
signal alu_func: std_logic_vector(3 downto 0);
signal rf_wrdata_sel: std_logic;
signal rf_b_sel: std_logic;
signal rf_wren: std_logic;
signal immed_ext: std_logic_vector(1 downto 0);
signal byte_op: std_logic;
signal mem_wren: std_logic;

begin

    clock <= not clock after clock_period/2 when active_clock = '1' else '0';

    uut: control_mc port map(
        clock => clock,
        reset => reset,
        alu_zero => alu_zero,
        instruction => instruction,
        
        immed_sel => immed_sel,
        reg_we => reg_we,
        
        pc_lden => pc_lden,
        pc_sel => pc_sel,
        alu_bin_sel => alu_bin_sel,
        alu_func => alu_func,
        rf_wrdata_sel => rf_wrdata_sel,
        rf_b_sel => rf_b_sel,
        immed_ext => immed_ext,
        byte_op => byte_op,
        mem_wren => mem_wren
    );
    
    stim_proc: process begin
    
        wait for 2*clock_period;
        reset <= '0';
        alu_zero <= '-';
        
        -- addi r5 r0 8
        instruction <= x"C0050008";
        wait for 4*clock_period;
        
        -- ori r3 r0 0xabcd
        instruction <= x"CC03ABCD";
        wait for 4*clock_period;
        
        -- sw r3 4(r0)
        instruction <= x"7C030004";
        wait for 4*clock_period;
        
        -- lw r10 -4(r5)
        instruction <= x"3CAAFFFC";
        wait for 5*clock_period;
        
        -- lb r16 4(r0)
        instruction <= x"0C100004";
        wait for 5*clock_period;
        
        -- nand r4 r10 r16
        instruction <= x"81448035";
        wait for 4*clock_period;
        
        -- bne r5 r5 8
        alu_zero <= '0';
        instruction <= x"04A50008";
        wait for 3*clock_period;
        
        -- b -2
        instruction <= x"FC00FFFE";
        wait for 2*clock_period;
        
        active_clock <= '0';
        
        wait;
    
    end process;

end Behavioral;
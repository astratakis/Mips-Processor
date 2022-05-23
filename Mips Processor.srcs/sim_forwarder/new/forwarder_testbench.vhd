library ieee;
use ieee.std_logic_1164.all;

entity forwarder_testbench is
end forwarder_testbench;

architecture Behavioral of forwarder_testbench is

component forwarder is
    Port (
        rs: in std_logic_vector(4 downto 0);
        rd: in std_logic_vector(4 downto 0);
        rt: in std_logic_vector(4 downto 0);
        
        wb_rd: in std_logic_vector(4 downto 0);
        wb_rf_wren: in std_logic;
        wb_data: in std_logic_vector(31 downto 0);
        
        A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        
        ex_rd: in std_logic_vector(4 downto 0);
        ex_rf_wren: in std_logic;
        ex_rf_wrdata_sel: in std_logic;
        alu_data: in std_logic_vector(31 downto 0);
        
        mem_rd: in std_logic_vector(4 downto 0);
        mem_rf_wren: in std_logic;
        mem_rf_wrdata_sel: in std_logic;
        mem_data: in std_logic_vector(31 downto 0);
        
        forwarded_A: out std_logic_vector(31 downto 0);
        forwarded_B: out std_logic_vector(31 downto 0)
    );
end component;

signal rs: std_logic_vector(4 downto 0);
signal rd: std_logic_vector(4 downto 0);
signal rt: std_logic_vector(4 downto 0);

signal wb_rd: std_logic_vector(4 downto 0);
signal wb_rf_wren: std_logic;
signal wb_data: std_logic_vector(31 downto 0);

signal A: std_logic_vector(31 downto 0);
signal B: std_logic_vector(31 downto 0);

signal ex_rd: std_logic_vector(4 downto 0);
signal ex_rf_wren: std_logic;
signal ex_rf_wrdata_sel: std_logic;
signal alu_data: std_logic_vector(31 downto 0);

signal mem_rd: std_logic_vector(4 downto 0);
signal mem_rf_wren: std_logic;
signal mem_rf_wrdata_sel: std_logic;
signal mem_data: std_logic_vector(31 downto 0);

signal forwarded_A: std_logic_vector(31 downto 0);
signal forwarded_B: std_logic_vector(31 downto 0);

begin

    uut: forwarder port map(
        rs => rs,
        rd => rd,
        rt => rt,
        
        wb_rd => wb_rd,
        wb_rf_wren => wb_rf_wren,
        wb_data => wb_data,
        
        A => A,
        B => B,
        
        ex_rd => ex_rd,
        ex_rf_wren => ex_rf_wren,
        ex_rf_wrdata_sel => ex_rf_wrdata_sel,
        alu_data => alu_data,
        
        mem_rd => mem_rd,
        mem_rf_wren => mem_rf_wren,
        mem_rf_wrdata_sel => mem_rf_wrdata_sel,
        mem_data => mem_data,
        
        forwarded_A => forwarded_A,
        forwarded_B => forwarded_B
    );
    
    stim_proc: process begin
    
        rs <= "00110";
        rd <= "10010";
        rt <= "01011";
        
        A <= x"12340000";
        B <= x"56780000";
        
        wb_rd <= "00000";
        wb_rf_wren <= '0';
        wb_data <= x"00000000";
    
        wait;
    
    end process;

end Behavioral;
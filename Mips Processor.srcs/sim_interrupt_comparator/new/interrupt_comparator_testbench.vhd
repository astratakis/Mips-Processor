library ieee;
use ieee.std_logic_1164.all;

entity interrupt_comparator_testbench is
end interrupt_comparator_testbench;

architecture Behavioral of interrupt_comparator_testbench is

component interrupt_comparator is
    Port (
        rs: in std_logic_vector(4 downto 0);
        rt: in std_logic_vector(4 downto 0);
        
        rd_prime: in std_logic_vector(4 downto 0);
        
        rf_wrdata_sel: in std_logic;
        rf_wren: in std_logic;
        
        halt: out std_logic
    );
end component;

signal rs: std_logic_vector(4 downto 0);
signal rt: std_logic_vector(4 downto 0);

signal rd_prime: std_logic_vector(4 downto 0);
signal rf_wrdata_sel: std_logic;
signal rf_wren: std_logic;

signal halt: std_logic;

begin

    uut: interrupt_comparator port map(
        rs => rs,
        rt => rt,
        rd_prime => rd_prime,
        rf_wrdata_sel => rf_wrdata_sel,
        rf_wren => rf_wren,
        halt => halt
    );
    
    stim_proc: process begin
        
        rs <= "10010";
        rt <= "01001";
        rd_prime <= "00011";
        rf_wrdata_sel <= '-';
        rf_wren <= '-';
        
        wait for 100 ns;
        
        rs <= "00011";
        rf_wrdata_sel <= '1';
        rf_wren <= '0';
        
        wait for 100 ns;
        
        rf_wren <= '1';
        
        wait for 100 ns;
        
        wait;
    
    end process;
    

end Behavioral;
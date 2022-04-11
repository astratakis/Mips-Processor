library ieee;
use ieee.std_logic_1164.all;

entity byte_replacer_testbench is
end byte_replacer_testbench;

architecture Behavioral of byte_replacer_testbench is

component byte_replacer is
    Port (
        byte: in std_logic_vector(7 downto 0);
        ram_data: in std_logic_vector(31 downto 0);
        sel: in std_logic_vector(1 downto 0);
        
        word_out: out std_logic_vector(31 downto 0)
    );
end component;

signal byte: std_logic_vector(7 downto 0);
signal ram_data: std_logic_vector(31 downto 0);
signal sel: std_logic_vector(1 downto 0);
signal word_out: std_logic_vector(31 downto 0);

begin

    uut: byte_replacer port map(
        byte => byte,
        ram_data => ram_data,
        sel => sel,
        word_out => word_out
    );
    
    stim_proc: process begin
    
        byte <= x"01";
        ram_data <= x"89abcdef";
        
        sel <= "00";
        
        wait for 100 ns;
        
        sel <= "01";
        
        wait for 100 ns;
        
        sel <= "10";
        
        wait for 100 ns;
        
        sel <= "11";
        
        wait;
    
    end process;

end Behavioral;
library ieee;
use ieee.std_logic_1164.all;

entity ram_testbench is
end ram_testbench;

architecture Behavioral of ram_testbench is

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

signal clock: std_logic := '0';
signal inst_addr: std_logic_vector(10 downto 0);
signal inst_dout: std_logic_vector(31 downto 0);
signal data_we: std_logic;
signal data_addr: std_logic_vector(10 downto 0);
signal data_din: std_logic_vector(31 downto 0);
signal data_dout: std_logic_vector(31 downto 0);

begin

    clock <= not clock after 50 ns;

    uut: ram port map(
        clk => clock,
        inst_addr => inst_addr,
        inst_dout => inst_dout,
        data_we => data_we,
        data_addr => data_addr,
        data_din => data_din,
        data_dout => data_dout
    );
    
    stim_proc: process begin
    
        inst_addr <= "00000000000";
        data_we <= '0';
        data_addr <= "00000000000";
        
        wait;
    
    end process;

end Behavioral;
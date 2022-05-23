library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity decode_register_testbench is
end decode_register_testbench;

architecture Behavioral of decode_register_testbench is

component decode_register is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        write_enable: in std_logic;
    
        instr_in: in std_logic_vector(31 downto 0);
        instr_out: out std_logic_vector(31 downto 0);
        
        control_signals_in: in std_logic_vector(31 downto 0);
        control_signals_out: out std_logic_vector(31 downto 0);
        
        rf_a_in: in std_logic_vector(31 downto 0);
        rf_a_out: out std_logic_vector(31 downto 0);
        
        rf_b_in: in std_logic_vector(31 downto 0);
        rf_b_out: out std_logic_vector(31 downto 0);
        
        immed_in: in std_logic_vector(31 downto 0);
        immed_out: out std_logic_vector(31 downto 0);
        
        write_back_data_in: in std_logic_vector(31 downto 0);
        write_back_data_out: out std_logic_vector(31 downto 0);
        
        write_address_in: in std_logic_vector(4 downto 0);
        write_address_out: out std_logic_vector(4 downto 0);
        
        was_written_in: in std_logic;
        was_written_out: out std_logic
    );
end component;

signal clock: std_logic := '0';
signal reset: std_logic := '1';

signal instr_in: std_logic_vector(31 downto 0);
signal instr_out: std_logic_vector(31 downto 0);

signal control_signals_in: std_logic_vector(31 downto 0);
signal control_signals_out: std_logic_vector(31 downto 0);

signal rf_a_in: std_logic_vector(31 downto 0);
signal rf_a_out: std_logic_vector(31 downto 0);

signal rf_b_in: std_logic_vector(31 downto 0);
signal rf_b_out: std_logic_vector(31 downto 0);

signal immed_in: std_logic_vector(31 downto 0);
signal immed_out: std_logic_vector(31 downto 0);

signal write_back_data_in: std_logic_vector(31 downto 0);
signal write_back_data_out: std_logic_vector(31 downto 0);

signal write_address_in: std_logic_vector(4 downto 0);
signal write_address_out: std_logic_vector(4 downto 0);

signal was_written_in: std_logic;
signal was_written_out: std_logic;

begin

    clock <= not clock after clock_period/2;

    uut: decode_register port map(
        clock => clock,
        reset => reset,
        write_enable => '1',
        
        instr_in => instr_in,
        instr_out => instr_out,
        
        control_signals_in => control_signals_in,
        control_signals_out => control_signals_out,
        
        rf_a_in => rf_a_in,
        rf_a_out => rf_a_out,
        
        rf_b_in => rf_b_in,
        rf_b_out => rf_b_out,
        
        immed_in => immed_in,
        immed_out => immed_out,
        
        write_back_data_in => write_back_data_in,
        write_back_data_out => write_back_data_out,
        
        write_address_in => write_address_in,
        write_address_out => write_address_out,
        
        was_written_in => was_written_in,
        was_written_out => was_written_out
    );
    
    stim_proc: process begin
    
        wait for 2*clock_period;
        
        reset <= '0';
        
        instr_in <= x"01010101";
        control_signals_in <= x"23232323";
        rf_a_in <= x"eeee3333";
        rf_b_in <= x"ffff4444";
        immed_in <= x"67676767";
        write_back_data_in <= x"dadadada";
        write_address_in <= "10110";
        was_written_in <= '0';
        
        wait for clock_period;
        
        was_written_in <= '1';
        
        wait for clock_period;
        
        was_written_in <= '0';
        
        wait for clock_period;
        
        was_written_in <= '1';
    
        wait;
    
    end process;

end Behavioral;
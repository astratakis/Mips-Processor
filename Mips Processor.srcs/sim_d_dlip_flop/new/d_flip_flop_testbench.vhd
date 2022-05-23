library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity d_flip_flop_testbench is
end d_flip_flop_testbench;

architecture Behavioral of d_flip_flop_testbench is

component d_flip_flop is
    Port (
        clock: in std_logic;
        reset: in std_logic;
        
        datain: in std_logic;
        dataout: out std_logic
    );
end component;

signal clock: std_logic := '0';
signal reset: std_logic := '1';

signal datain: std_logic;
signal dataout: std_logic;

begin

    clock <= not clock after clock_period/2;

    uut: d_flip_flop port map(
        clock => clock,
        reset => reset,
        
        datain => datain,
        dataout => dataout
    );
    
    stim_proc: process begin
    
        wait for 3*clock_period;
        
        reset <= '0';
                
        datain <= '1';
        
        wait for clock_period;
        
        datain <= '0';
        
        wait for clock_period;
        
        datain <= '1';
        
        wait for clock_period;
    
        wait;
    
    end process;

end Behavioral;
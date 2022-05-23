----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2022 04:53:10 PM
-- Design Name: 
-- Module Name: control_mc - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_mc is
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
end control_mc;

architecture Behavioral of control_mc is

type instr_state is (
    FETCH,
    DECODE,
    EXECUTE,
    BRANCH_COMPLETION,
    COND_BRANCH_COMPLETION,
    MEM_STORE,
    MEM_LOAD,
    RF_WRITE_ALU,
    RF_WRITE_MEM
);

signal current_state: instr_state;
signal opcode: std_logic_vector(5 downto 0);

begin
    
    -- The opcode of the instruction
    -- This is input in the MEALY FSM
    opcode <= instruction(31 downto 26);
    
    -------------------------------------------------------------------------------------
    
    -- On state FETCH increment PC <= PC + 4 in order to fetch the next instruction
    -- On state BRANCH_COMPLETION PC <= PC + immediate
    -- On state COND_BRANCH_COMPLETION only if beq and alu_zero = 1 or bne and alu_zero = 0
    pc_lden <= '1' when ((current_state = FETCH) or (current_state = BRANCH_COMPLETION) or (current_state = COND_BRANCH_COMPLETION and ((alu_zero = '1' and opcode = "000000") or (alu_zero = '0' and opcode = "000001")))) else '0';
    
    -- pc_sel will be 1 only on BRANCH states.
    pc_sel <= '1' when current_state = BRANCH_COMPLETION or current_state = COND_BRANCH_COMPLETION else '0';
    
    -- immed_sel will be '1' when selecting conditional branch immed.
    immed_sel <= '1' when current_state = COND_BRANCH_COMPLETION else '0';
    
    -- Alu bin sel is 0 when the instruction does not use immed value.
    alu_bin_sel <= '-' when (current_state /= EXECUTE) else '0' when opcode = "100000" or opcode = "000000" or opcode = "000001" else '1';
    
    -- The alu function of an instruction
    alu_func <= "----" when current_state /= EXECUTE else     
                instruction(3 downto 0) when opcode = "100000"
                else x"0" when opcode = "111000" or opcode = "111001" or opcode = "110000" or (opcode(5) = '0' and opcode(1 downto 0) = "11")
                else x"1" when opcode = "000000" or opcode = "000001"
                else x"5" when opcode = "110010"
                else x"3" when opcode = "110011"
                else "----";
    
    -- This signal is for the write enable signals of the registers in datapath.
    reg_we <= "000001" when current_state = FETCH else
              "001110" when current_state = DECODE else
              "010000" when current_state = EXECUTE else
              "100000" when current_state = MEM_LOAD else "000000";
              
    -- The operation that will be performed in the immed part of the instruction
    immed_ext <= "--" when current_state /= DECODE else
                 "00" when opcode = "100000" or opcode = "111000" or opcode = "110010" or opcode = "110011" or opcode = "000011" else
                 "01" when opcode = "110000" or opcode = "000111" or opcode = "001111" or opcode = "011111" else 
                 "10" when opcode = "111001" else
                 "11";
              
    -- Choose the input in the register file (0 = ALU out, 1 = MEM out).
    rf_wrdata_sel <= '0' when current_state = RF_WRITE_ALU else '1' when current_state = RF_WRITE_MEM else '-';
    
    -- write enable should be 1 only when in states RF_WRITE...
    rf_wren <= '1' when current_state = RF_WRITE_ALU or current_state = RF_WRITE_MEM else '0';
    
    -- This is '1' only when the Register R[rd] must be read. (instructions beq, bne, sb, sw)...
    rf_b_sel <= '-' when current_state /= DECODE else '1' when opcode = "000000" or opcode = "000001" or opcode = "000111" or opcode = "011111" else '0';
    
    -- This flag is '1' only when lb and sb instrucitons are used.
    byte_op <= '-' when (current_state /= MEM_LOAD and current_state /= MEM_STORE) else '1' when opcode = "000011" or opcode = "000111" else '0';
    
    mem_wren <= '1' when current_state = MEM_STORE else '0';
    
    mealy_fsm_process: process begin
        
        wait until clock'event and clock = '1';
        
        if reset = '1' then
            current_state <= FETCH;
        else
        
            case current_state is
            
                when FETCH =>
                    current_state <= DECODE;
                
                when DECODE =>
                    if opcode /= "111111" then
                        current_state <= EXECUTE;
                    else
                        current_state <= BRANCH_COMPLETION;
                    end if;
                
                when BRANCH_COMPLETION => 
                    current_state <= FETCH;
                    
                when COND_BRANCH_COMPLETION =>
                    current_state <= FETCH;
                
                when EXECUTE =>
                    if opcode = "000000" or opcode = "000001" then 
                        current_state <= COND_BRANCH_COMPLETION;
                    elsif opcode = "000011" or opcode = "001111" then
                        current_state <= MEM_LOAD;
                    elsif opcode = "000111" or opcode = "011111" then
                        current_state <= MEM_STORE;
                    else
                        current_state <= RF_WRITE_ALU;
                    end if;
                    
                when MEM_LOAD =>
                    current_state <= RF_WRITE_MEM;
                    
                when MEM_STORE =>
                    current_state <= FETCH;
                    
                when RF_WRITE_ALU =>
                    current_state <= FETCH;
                    
                when RF_WRITE_MEM =>
                    current_state <= FETCH;
            
            end case;
        end if;
        
    end process;
    
end Behavioral;

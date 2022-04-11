@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Thu Apr 07 11:42:25 +0300 2022
REM SW Build 2902540 on Wed May 27 19:54:49 MDT 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim proc_sc_huge_test_behav -key {Behavioral:mips_text_decoder:Functional:proc_sc_huge_test} -tclbatch proc_sc_huge_test.tcl -view C:/Users/user/Mips Processor/Waveforms/decryption_test.wcfg -log simulate.log"
call xsim  proc_sc_huge_test_behav -key {Behavioral:mips_text_decoder:Functional:proc_sc_huge_test} -tclbatch proc_sc_huge_test.tcl -view C:/Users/user/Mips Processor/Waveforms/decryption_test.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0

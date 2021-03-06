@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Wed May 18 14:42:32 +0300 2022
REM SW Build 2902540 on Wed May 27 19:54:49 MDT 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim d_flip_flop_testbench_behav -key {Behavioral:sim_d_dlip_flop:Functional:d_flip_flop_testbench} -tclbatch d_flip_flop_testbench.tcl -log simulate.log"
call xsim  d_flip_flop_testbench_behav -key {Behavioral:sim_d_dlip_flop:Functional:d_flip_flop_testbench} -tclbatch d_flip_flop_testbench.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0

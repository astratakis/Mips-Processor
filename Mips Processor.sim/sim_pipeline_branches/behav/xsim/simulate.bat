@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Thu May 19 20:18:53 +0300 2022
REM SW Build 2902540 on Wed May 27 19:54:49 MDT 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim pipeline_branch_testbench_behav -key {Behavioral:sim_pipeline_branches:Functional:pipeline_branch_testbench} -tclbatch pipeline_branch_testbench.tcl -log simulate.log"
call xsim  pipeline_branch_testbench_behav -key {Behavioral:sim_pipeline_branches:Functional:pipeline_branch_testbench} -tclbatch pipeline_branch_testbench.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
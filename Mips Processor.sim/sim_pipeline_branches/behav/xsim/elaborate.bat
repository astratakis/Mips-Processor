@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.1 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Thu May 19 20:18:50 +0300 2022
REM SW Build 2902540 on Wed May 27 19:54:49 MDT 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
echo "xelab -wto e9f7f63b356b404bbc12faf9093ef50c --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot pipeline_branch_testbench_behav xil_defaultlib.pipeline_branch_testbench -log elaborate.log"
call xelab  -wto e9f7f63b356b404bbc12faf9093ef50c --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot pipeline_branch_testbench_behav xil_defaultlib.pipeline_branch_testbench -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0

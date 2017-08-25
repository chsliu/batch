@echo off
set root=%~dp0

:loop
if [%1]==[] (
	pause
	goto :EOF
)


set L=movie
set S=20
set N=%~nx1
set K=single
set F=%~nx1
set D=%~dp1


call %root%\fb.amc.bat


shift
goto loop


REM pause

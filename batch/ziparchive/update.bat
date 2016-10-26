@echo off

set SRCDIR=d:\Users\sita\Documents\tasks\batch\ziparchive

if [%SRCDIR%\] EQU [%~dp0] goto :EOF

copy /y "%SRCDIR%\*.bak" "%~dp0\*.bat"

if not exist "%~dp0\config.cmd" (
	copy /y "%SRCDIR%\config.cmd" "%~dp0\*"
)


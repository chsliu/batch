@echo off

REM =================================

move "%~dp0\config.cmd" "%~dp0\_config.cmd"
del "%~dp0\backup.bat"
del "%~dp0\backup.with.date.bat"
del "%~dp0\backup.with.date.log"
del "%~dp0\backup.with.date.v2.bat"
del "%~dp0\restore.bat"
del "%~dp0\restore.withlatest.bat"

REM =================================
set SRCDIR=%TASKS_ROOT%\batch\ziparchive

if [%SRCDIR%\] EQU [%~dp0] goto :EOF

copy /y "%SRCDIR%\*.bak" "%~dp0\*.bat"

if not exist "%~dp0\config.cmd" (
	copy /y "%SRCDIR%\config.cmd" "%~dp0\*"
)


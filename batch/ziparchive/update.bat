@echo off

REM =================================
set SRCDIR=%TASKS_ROOT%\batch\ziparchive
echo copy /y "%SRCDIR%\%~nx0" "%~f0"

REM =================================

move "%~dp0\config.cmd" "%~dp0\_config.cmd"
del "%~dp0\backup.bat"
del "%~dp0\backup.with.date.bat"
del "%~dp0\backup.with.date.log"
del "%~dp0\backup.with.date.v2.bat"
del "%~dp0\restore.bat"
del "%~dp0\restore.withlatest.bat"

REM =================================
if [%SRCDIR%\] EQU [%~dp0] goto :EOF

copy /y "%SRCDIR%\*.template" "%~dp0\*.bat"

if not exist "%~dp0\_config.cmd" (
	copy /y "%SRCDIR%\_config.cmd" "%~dp0\*"
)


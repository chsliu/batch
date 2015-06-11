REM =================================

start /min call %~dp0\update.bat

REM =================================

start /min choco upgrade all

REM =================================

start /min call %~dp0\cleanup.bat

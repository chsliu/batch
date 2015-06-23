REM =================================

start /min call %~dp0\..\utility\update.bat

REM =================================

start /min cup -y all

REM =================================

start /min call %~dp0\cleanup.bat

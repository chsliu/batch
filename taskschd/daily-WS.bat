REM =================================

w32tm /resync
w32tm /query /status

REM =================================

start /min call %~dp0\alarm.bat

REM =================================

start /min call %~dp0\gitsync.bat

REM =================================

start /min call %~dp0\backup.bat

REM =================================

start /min call %~dp0\killhale.bat

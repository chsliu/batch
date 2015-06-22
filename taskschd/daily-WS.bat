REM =================================

w32tm /resync
w32tm /query /status

REM =================================

call %~dp0\..\utility\alarm.bat

REM =================================

call %~dp0\..\utility\gitsync.bat

REM =================================

call %~dp0\..\utility\killhale.bat

REM =================================

call %~dp0\backup.bat


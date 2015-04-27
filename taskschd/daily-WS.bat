REM =================================

w32tm /resync
w32tm /query /status

REM =================================

call %~dp0\alarm.bat

REM =================================

call %~dp0\gitsync.bat

REM =================================

call %~dp0\backup.bat

REM =================================

taskkill /F /T /IM hale.exe

REM =================================

sc config WSearch start= disabled
taskkill /F /T /IM SearchIndexer.exe

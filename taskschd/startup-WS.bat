REM =================================

call %~dp0\..\utility\getdisklog.bat 1

REM =================================

taskkill /F /T /IM hale.exe

REM =================================

sc config WSearch start= disabled
taskkill /F /T /IM SearchIndexer.exe

REM =================================

start /min %~dp0\..\iperf-2.0.5-3-win32\server.bat ^&^& exit


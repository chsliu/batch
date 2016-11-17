REM =================================

call %~dp0\utility\sendemail.diskstatus.bat

REM =================================

call %~dp0\..\utility\getdisklog.bat 1

REM =================================

start /min %~dp0\..\iperf-2.0.5-3-win32\server.bat ^&^& exit


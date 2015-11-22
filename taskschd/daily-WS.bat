REM =================================

w32tm /resync
w32tm /query /status

REM =================================

call %~dp0\..\utility\sendemail.killhale.bat


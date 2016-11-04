@echo off

set ROOT=%~dp0

:main
if [%1]==[] goto :EOF

start call %ROOT%\sendemail.filebot.amc.bat "" "11" "%~nx1" "single" "%~nx1" "%~dp1 " "5" "%1" ^&^& exit

sleep 1

shift

goto :main

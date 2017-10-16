@echo off

set ROOT=%~dp0
set datapath=%~dp1
IF %datapath:~-1%==\ SET datapath=%datapath:~0,-1%

:main
if [%1]==[] goto :EOF

REM call %ROOT%\sendemail.filebot.amc.bat "" "11" "%~nx1" "single" "%~nx1" "%datapath" "5" "%1"
start call %ROOT%\sendemail.filebot.amc.bat "" "11" "%~nx1" "single" "%~nx1" "%datapath%" "5" "%1" ^&^& exit

sleep 1

shift

goto :main

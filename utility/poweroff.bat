@echo off

goto :local

set /p HOST=Hostname: 

IF [%HOST%]==[] goto :local


:remote
shutdown /m \\%HOST% /s /t 0
pause
shutdown /m \\%HOST% /a
goto :EOF


:local
shutdown /s /t 0 /c "%0"
pause
shutdown /a

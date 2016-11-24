@echo off

rundll32.exe powrprof.dll,SetSuspendState 0,1,0

goto :EOF

shutdown /h
pause
shutdown /a

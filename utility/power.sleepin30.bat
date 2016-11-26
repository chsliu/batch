@echo off

c:\Windows\System32\timeout.exe 1800

rundll32.exe powrprof.dll,SetSuspendState 0,1,0


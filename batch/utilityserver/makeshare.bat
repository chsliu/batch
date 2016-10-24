@echo off
if "%1"=="" goto exit
if "%2"=="" goto exit
mkdir %1:\Shares\%2
net share "%2=%1:\Shares\%2" "/GRANT:Users,FULL

goto :EOF

:exit
echo %0 [driveletter] [newshare]

@echo off
if "%1"=="" goto exit
mkdir e:\Shares\%1
net share "%1=e:\Shares\%1" "/GRANT:Users,FULL

:exit

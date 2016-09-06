@echo off

set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%

move "C:\Users\sita\Desktop\WindowsUpdate.log" "C:\Users\sita\Desktop\WindowsUpdate.%TODAY%.log"

powershell -command "Get-WindowsUpdateLog"

notepad "C:\Users\sita\Desktop\WindowsUpdate.log"


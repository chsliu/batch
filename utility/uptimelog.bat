@echo off

REM =================================
set path=%path%;%~dp0\..\bin

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG1=%temp%\%~n0-%TODAY%.txt
set TXT1=%temp%\%~n0.txt

echo %DATE%%TIME% 				>%LOG1%

REM =================================

powershell -command "Get-WinEvent -FilterHashtable @{logname='System'; id=6005,6006,6008}" >>%LOG1% 2>>&1

powershell -command "get-eventlog -logname system | where-object { $_.eventid -eq 6005 -or  $_.eventid -eq 6006 -or  $_.eventid -eq 6008}" >>%LOG1% 2>>&1

REM =================================

copy %0 %TXT1% >nul

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %TXT1%

del %LOG1% %TXT1%

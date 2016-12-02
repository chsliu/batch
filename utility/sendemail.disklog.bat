@echo off

REM =================================
set path=%path%;%~dp0\..\bin

REM =================================
if not defined WMIC goto :MyDateEnd

set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%

:MyDateEnd

REM =================================
set LOG1=%temp%\%~n0-%COMPUTERNAME%-%TODAY%.txt

REM =================================
call %~dp0\getdisklog.bat 1 >%LOG1%

REM =================================
sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1%

rem %LOG2% %LOG3% %LOG3CAB% %LOG4% %LOG6% %LOG6NFO% %LOG6CAB%
del %LOG1%

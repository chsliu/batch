REM =================================

rem C:\Windows\System32\PING.EXE 127.0.0.1 -n 600 -w 1000 > nul
C:\Windows\System32\timeout.exe 300
rem C:\Windows\System32\choice.exe /d y /t 600

REM =================================

set path=%path%;%~dp0\utility

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG1=%temp%\%~n0-%COMPUTERNAME%-%TODAY%.txt
set TXT1=%temp%\%~n0.txt

REM =================================

call getdisklog.bat 1 > %LOG1%

REM =================================

copy %0 %TXT1%

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %TXT1%

del %LOG1% %TXT1%

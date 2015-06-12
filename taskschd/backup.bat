set path=%path%;%~dp0\..\utility

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG1=%temp%\%~n0-%TODAY%.txt
set TXT1=%temp%\%~n0.txt
set TXT2=%temp%\daily-%COMPUTERNAME%.txt

echo %DATE%%TIME% 				>%LOG1%

REM =================================

call %~dp0\..\rsync\daily-%COMPUTERNAME%.bat 	>>%LOG1% 2>>&1

REM =================================

ping 127.0.0.1 -n 10 -w 1000 > nul

copy %0 %TXT1%
copy %~dp0\..\rsync\daily-%COMPUTERNAME%.bat %TXT2%

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %TXT1% %TXT2%

del %LOG1% %TXT1% %TXT2%
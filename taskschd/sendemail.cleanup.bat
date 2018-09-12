@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;%~dp0\..\bin

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

REM set LOG1=%~dp0\%~n0-%TODAY%.txt
set LOG1=%temp%\%~n0-%TODAY%.txt
set TXT1=%temp%\%~n0.txt
set TXT2=%temp%\cleanup-%COMPUTERNAME%.txt

REM =================================

echo %DATE%%TIME% 				>%LOG1%

REM =================================

set _=%~dp0\cleanup-%COMPUTERNAME%.bat 	
echo calling %_% ... 				>>%LOG1% 2>>&1
if exist %_% call %_%			>>%LOG1% 2>>&1

REM =================================

set _=%~dp0\..\utility\clean.bat
echo calling %_% ... 				>>%LOG1% 2>>&1
call %_% 	>>%LOG1% 2>>&1

REM =================================

copy %0 %TXT1%
copy %~dp0\cleanup-%COMPUTERNAME%.bat %TXT2%

if not exist %TXT2% set TXT2=

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %TXT1% %TXT2%

del %LOG1% %TXT1% %TXT2%


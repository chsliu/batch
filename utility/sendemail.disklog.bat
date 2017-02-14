rem @echo off

REM =================================
goto :main

REM =================================
REM call :whereis <exe> <Location Variable>
REM call :whereis wmic.exe WMIC
REM =================================
:whereis
set %2=
for %%X in (%1) do (set %2=%%~$PATH:X)

exit /b

REM =================================
:main
REM =================================
set path=%path%;%~dp0\..\bin

REM =================================
call :whereis wmic.exe WMIC
call :whereis uniq.exe UNIQ

REM =================================
if not defined WMIC goto :MyDateEnd

set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%

:MyDateEnd

REM =================================
set TEMPFILE=%temp%\%~n0-tempfile.txt
set TXT1=%temp%\%~n0.txt
set SUMMARY=%temp%\summary-%COMPUTERNAME%-%TODAY%.txt
set LOG1=%temp%\disklog-%COMPUTERNAME%-%TODAY%.txt

REM =================================
call %~dp0\getdisklog.bat 1 >%LOG1%

REM =================================
findstr /C:"Physical disk"		%LOG1%	>>%SUMMARY%
findstr /C:"Serial"				%LOG1%	>>%SUMMARY%
findstr /C:"Virtual disk" 		%LOG1%	>>%SUMMARY%
findstr /C:"PDO name" 			%LOG1%	>>%SUMMARY%

REM =================================
if not defined UNIQ goto :UNIQEnd

	type %SUMMARY% | %UNIQ% > %TEMPFILE%
	move /y %TEMPFILE% %SUMMARY% >nul

:UNIQEnd

REM =================================
copy %0 %TXT1% >nul

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %SUMMARY% %LOG1% %TXT1%

rem %LOG2% %LOG3% %LOG3CAB% %LOG4% %LOG6% %LOG6NFO% %LOG6CAB%
del %SUMMARY% %LOG1% %TXT1%

@echo off
set path=%path%;D:\Users\sita\PortableApps\FileBot-portable;%~dp0

REM goto test

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG1=%temp%\%~n0-%TODAY%.txt
set LOG2=D:\Users\sita\PortableApps\FileBot-portable\logs\suball.txt
set TXT1=%temp%\%~n0.txt

REM =================================

filebot -script fn:suball %1 -non-strict --log-file suball.txt --def maxAgeDays=7 minAgeDays=0.5

REM =================================
REM :test

echo Waiting for filebot:suball on %1 ...

call :WaitForWord %LOG2% "Done" "Failure"

echo List of newly download subtitles:	 >%LOG1%
findstr "Fetching" %LOG2%		>>%LOG1%

REM goto :EOF

copy %0 %TXT1%

for /f %%a in ('type "%LOG1%"^|find "" /v /c') do set /a cnt=%%a

if %cnt% gtr 1 (
  rem echo %LOG1% has %cnt% lines
  sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [FileBot] %~n0 %1 -m %0 %1 -a %LOG1% %LOG2% %TXT1%
) else (
  echo %LOG1% only has %cnt% lines
)

del %LOG1% %LOG2% %TXT1%

REM pause

goto :EOF

REM =================================

:WaitForWord

ping 127.0.0.1 -n 10 -w 1000 > nul

if not exist %1 goto :WaitForWord
echo Waiting for Logfile, size is %~z1

2>nul (
  >>%1 (call )
) && (
  echo Logfile %~nx1 is ready
) || (
  echo Logfile %~nx1 is not ready
  goto :WaitForWord
)

findstr %2 %1 > nul
if %ERRORLEVEL%==0 goto :EOF

findstr %3 %1 > nul
if %ERRORLEVEL%==0 goto :EOF

goto :WaitForWord


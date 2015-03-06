set path=%path%;D:\Users\sita\PortableApps\FileBot_4.5-portable

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG1=D:\Users\sita\PortableApps\FileBot_4.5-portable\logs\suball.txt

REM =================================
rem --def maxAgeDays=7 minAgeDays=0.5 

filebot -script fn:suball --log-file suball.txt -non-strict subtitles=en,zh "%~dp1"

REM =================================

echo Waiting for fb:suball to finish...

call :WaitForWord %LOG1% "Done" "Failure"

echo List of newly download subtitles:	
findstr "Fetching" %LOG1%		

del %LOG1%

pause

goto :EOF

REM =================================

:WaitForWord

echo Waiting for Logfile, size is %~z1
ping 127.0.0.1 -n 10 -w 1000 > nul

2>nul (
  >>%1 (call )
) && (
  echo Logfile %1 is ready
) || (
  echo Logfile %1 is not ready
  goto :WaitForWord
)

findstr %2 %1 > nul
if %ERRORLEVEL%==0 goto :EOF

findstr %3 %1 > nul
if %ERRORLEVEL%==0 goto :EOF

goto :WaitForWord


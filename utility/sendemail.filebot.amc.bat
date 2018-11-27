@echo off

REM =================================
goto :main

REM =================================
REM echo all args: %*
REM pause

REM call :lastarg %*
REM echo last arg: %ARG_LAST%

REM if not [%ARG_LAST%] == ["max"] start /MAX cmd /c %0 %* max & goto :EOF

REM echo all args: %*
REM pause

REM =================================
:DeQuote
for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A
REM goto :EOF
exit /b

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
if %ERRORLEVEL%==0 exit /b

findstr %3 %1 > nul
if %ERRORLEVEL%==0 exit /b

goto :WaitForWord

REM =================================
:Notify
pushd %~dp0\..\pushbullet\
python pushbullet_cmd.py UR97NWpn7i61jqO0BQkyZWQhaNmfGe8t note ufjW6eNsjAkQAk8QjQ "%3" "%~n0 Download Complete"
popd

rem pause

exit /b

REM =================================
:lastarg
set ARG_LAST="%~1"
shift
if not [%~1]==[] goto lastarg

exit /b


REM =================================
:main
REM =================================
set LOG1=D:\Download\%~n0.txt
echo %* >>%LOG1%

if %1=="other" goto :EOF

if %2 == "5" goto :Notify

if %2 neq "11" goto :EOF

REM =================================

set path=%path%;"C:\Program Files\FileBot";%~dp0\..\bin
REM set LOG1="D:\Users\sita\PortableApps\FileBot-portable\logs\%~n3.txt"
set LOG1="C:\Users\sita\AppData\Roaming\FileBot\logs\%~n3.txt"
set LOG2="%temp%\%~n3-summary.txt"
set TXT1=%temp%\%~n0.txt
set SHARE=\\lxcomv6\Library
set XBMC=w1

REM =================================
:: save original codepage
for /f "tokens=2 delims=:" %%a in ('chcp') do @set /a "cp=%%~a"
chcp 65001 >nul

REM =================================
set nofiletag=call "d:\Users\sita\Documents\tasks\util\show.no.filetag.cmd"

for /f %%i in ('%nofiletag% %8 [eztv]') do set fname=%%i
if not [%fname%]==[] move "%8" "%fname%" >nul

for /f %%i in ('%nofiletag% %5 [eztv]') do set fname=%%i
if [%fname%]==[] set fname=%5

REM =================================
REM chcp %cp% >nul

REM =================================

set L=%1
set S=%2
set N=%3
set K=%4
set F=%fname%
set D=%6

call :dequote L
call :dequote S
call :dequote N
call :dequote K
call :dequote F
call :dequote D

REM =================================

rem pushover=uCdk2gobtohF1GpECfv3YBSp73Zkgg 
rem mail=msa.hinet.net:25:chsliu@gmail.com mailto=chsliu@gmail.com reportError=y 
rem pushbullet=UR97NWpn7i61jqO0BQkyZWQhaNmfGe8t 
rem start /wait 
rem excludeList=amc-input.txt
rem --action copy
rem --conflict override
rem subtitles=en,zh 

filebot -script fn:amc --output "%SHARE%" --log-file "%~n3.txt" --action move --conflict skip -non-strict --def artwork=y extras=y unsorted=y clean=y skipExtract=y "ut_label=%L%" "ut_state=%S%" "ut_title=%N%" "ut_kind=%K%" "ut_file=%F%" "ut_dir=%D%" xbmc=%XBMC% "seriesFormat=%SHARE%/TV Shows/{n} ({y})/{\"Season ${s.pad(2)}\"}/{n} - {s00e00} - {t} - {airdate}.{vf}{'.'+source}.{vc}{'-'+group}{'.'+lang}" "movieFormat=%SHARE%/Movies/{y}/{y} {n} {audios.language}/{n.space('.')}.{y}.{vf}{'.'+source}.{vc}.{af}.{ac}{'-'+group}{'-'+\"CD$pi\"}{'.'+lang}" "animeFormat=%SHARE%/ACG/{n} ({y})/{\"Season ${s.pad(2)}\"}/{n} - {s00e00} - {t} - {airdate}.{vf}{'.'+source}.{vc}{'-'+group}{'.'+lang}" "musicFormat=%SHARE%/Music/{n}/{'['+y+'] '+album+'/'}{pi.pad(2)+'. '} {artist} - {t} {[af, audio.SamplingRateString, audio.bitRateString]}"

REM =================================

echo Waiting for filebot:amc on %N% ...

call :WaitForWord %LOG1% "Done" "Failure"

echo List of newly download files:	 >%LOG2%
findstr /C:"[COPY]" %LOG1%		>>%LOG2%
findstr /C:"[MOVE]" %LOG1%		>>%LOG2%
findstr /C:"Skipped" %LOG1%		>>%LOG2%

call %~dp0\log2download.cmd %LOG2%	>>%LOG2%

REM pause

REM =================================

copy %0 %TXT1% >nul

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [FileBot]_%N% -a %LOG2% %LOG1% %TXT1% -m "%*"

rem pause

del %LOG1% %LOG2% %TXT1%

REM =================================
chcp %cp% >nul

 

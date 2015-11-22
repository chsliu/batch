@echo off

REM =================================
goto :main

REM =================================
REM call :COUNTLINE <linefile>
REM call :COUNTLINE temp.txt
REM =================================
:COUNTLINE
for /f %%a in ('type "%1"^|find "" /v /c') do set /a cnt=%%a

exit /b


REM =================================
:main
REM =================================
set path=%path%;%~dp0\..\bin

set OKCNT=7

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG1=%temp%\%~n0-%TODAY%.txt
set TXT1=%temp%\%~n0.txt
set LINE=%temp%\%~n0-line.txt

echo %DATE%%TIME% 				>%LOG1%

REM =================================

chcp 950

REM =================================
echo.
echo Daily Hg commit...
echo.


pushd D:\cvsroot
call sync.bat					 >>%LOG1% 2>>&1
popd


REM =================================

set ALARM=

findstr /C:"nothing changed" %LOG1% >%LINE%
call :COUNTLINE %LINE%
REM echo cnt = %cnt%
REM pause
if %cnt% LSS %OKCNT% set ALARM=1

REM =================================

copy %0 %TXT1% >nul

if defined ALARM (
sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 ERROR -m %0 -a %LOG1% %TXT1%
)

del %LOG1% %TXT1% %LINE%

REM pause
C:\Windows\System32\timeout.exe 10

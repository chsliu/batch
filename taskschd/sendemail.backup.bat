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

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG1=%temp%\%~n0-%TODAY%.txt
set TXT1=%temp%\%~n0.txt
set TXT2=%temp%\daily-%COMPUTERNAME%.txt
set LINE=%temp%\%~n0-%TODAY%-line.txt

REM =================================
set _=%~dp0\..\rsync\daily-%COMPUTERNAME%.bat 	
if not exist %_% goto :EOF

REM =================================
echo %DATE%%TIME% 				>%LOG1%
call %_%									>>%LOG1% 2>>&1

REM =================================
set ALARM=
findstr /C:"error:" %LOG1% >%LINE%
call :COUNTLINE %LINE%
if %cnt% GTR 0 set ALARM=1

REM =================================

ping 127.0.0.1 -n 10 -w 1000 > nul

copy %0 %TXT1%
copy %~dp0\..\rsync\daily-%COMPUTERNAME%.bat %TXT2%

if defined ALARM (
sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 ERROR -m %0 -a %LOG1% %TXT1% %TXT2%
) else (
sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %TXT1% %TXT2%
)

del %LOG1% %TXT1% %TXT2% %LINE%

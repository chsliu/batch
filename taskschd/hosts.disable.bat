@echo off

REM =================================
REM Acquire Administrative Privileges
REM =================================
set ADMIN=%TASKS_ROOT%\utility\getadmin.bat
if /I [%1] NEQ [%ADMIN%] %ADMIN% "%~dp0\%~nx0" %*
shift

REM =================================
if [%1] == [] goto :Usage

REM =================================
set DOMAIN=%1
set HOSTS="C:\Windows\System32\drivers\etc\hosts"
set TEMPHOSTS=%TEMP%\hosts.txt
set LINEMARKER="#REMOVE THIS LINE"

goto :main

REM ================================================================
REM call :SED <old pattern> <new pattern> <input file> <output file>
REM ================================================================
:SED
cscript //NoLogo %TASKS_ROOT%\vbs\sed.vbs s/%1/%2/ < "%3" > "%4"

exit /b

:Usage
echo Domain name is required.
REM pause

goto :EOF

REM =================================
:main

REM call :SED PART.* XXX test.txt test2.txt

REM call :SED ".* dns" "" hosts hosts.txt
REM call :SED ".* dns" "9.9.9.9 dns" hosts hosts.txt

call :SED ".* %DOMAIN%" %LINEMARKER% %HOSTS% %TEMPHOSTS%
type "%TEMPHOSTS%" | findstr /v /C:%LINEMARKER% > %HOSTS%
del %TEMPHOSTS%

echo 127.0.0.1 %DOMAIN% >> %HOSTS%

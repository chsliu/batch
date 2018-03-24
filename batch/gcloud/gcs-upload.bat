@echo off

REM =================================
goto :main

REM =================================
:BASENAME
set %2=%~nx1

exit /b

REM =================================
:PATHNAME
set %2=%~p1

exit /b

REM =================================
:main
REM =================================
if [%1]==[""] goto :EOF

REM =================================
set path=%LOCALAPPDATA%\Google\Cloud SDK\google-cloud-sdk\bin;%PATH%;
set bucket=gs://creeper-tw-backup
call :PATHNAME "%0" BASE
call :BASENAME "%BASE:~0,-1%" BASE
call :BASENAME "%1" FILE

REM =================================
echo gsutil cp %1 %bucket%/%BASE%/%FILE%
gsutil cp %1 %bucket%/%BASE%/%FILE%

REM =================================
pause

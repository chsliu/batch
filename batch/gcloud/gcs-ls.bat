@echo off

REM =================================
goto :main

REM =================================
:DeQuote
for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A

exit /b

REM =================================
:BASENAME
set %2=%~nx1

exit /b

REM =================================
:UHCPATH
set _=%1
call :DeQuote _
call :BASENAME "%_%" __

REM setlocal enabledelayedexpansion
set %2=!_:%__%=!

exit /b

REM =================================
:PATHNAME
set %2=%~p1

exit /b

REM =================================
:main

REM =================================
setlocal enabledelayedexpansion

REM =================================
set path=%LOCALAPPDATA%\Google\Cloud SDK\google-cloud-sdk\bin;%PATH%;
set bucket=gs://creeper-tw-backup
call :UHCPATH %0 DST
call :PATHNAME %0 BASE
call :BASENAME %BASE:~0,-1% BASE

REM =================================
echo gsutil ls %bucket%/%BASE%/*
REM pause
gsutil ls %bucket%/%BASE%/*

REM =================================
pause

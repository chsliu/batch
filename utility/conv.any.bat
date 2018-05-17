@echo off

REM =================================
goto :main
REM =================================
:DeQuote
for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A
REM goto :EOF
exit /b

REM =================================
:main
REM =================================
if [%1]==[] goto :EOF

set filename=%1

call :DeQuote filename

echo Converting %filename%

ConvertZ.exe /o:big5 "%filename%"
ConvertZ.exe /o:utf8 "%filename%"

REM =================================
shift
goto :main

REM pause

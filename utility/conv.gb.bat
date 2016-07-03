@echo off
REM =================================
goto :main
REM =================================

REM =================================
:DeQuote
for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A
REM goto :EOF
exit /b

REM =================================
:main
REM =================================
if [%1]==[] goto :EOF

set target=%1

call :DeQuote target

echo Converting %target%

ConvertZ.exe /i:gbk /o:big5 "%target%"
ConvertZ.exe /i:big5 /o:utf8 "%target%"

shift
goto :main

REM pause

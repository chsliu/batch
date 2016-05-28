@echo off

:main
if [%1]==[] goto :EOF

echo Converting %1

ConvertZ.exe /i:big5 /o:utf8 %1

shift
goto :main

REM pause

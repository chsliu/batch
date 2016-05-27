@echo off

echo Converting %1

ConvertZ.exe /i:big5 /o:utf8 %1

REM pause

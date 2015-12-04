REM @echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
taskkill /f /im GWX.exe
taskkill /f /im GWXUX.exe

cd/d C:\Windows\System32
takeown /r /f GWX
cacls GWX /e /g everyone:f
rd/q/s GWX

REM wusa.exe /uninstall /kb:3035583 /quiet 

REM =================================
C:\Windows\System32\timeout.exe 10

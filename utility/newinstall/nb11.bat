@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

cinst -y 7zip classic-shell cmder Everything f.lux foxitreader git GoogleChrome notepadplusplus potplayer putty python2 teamviewer 

rem pause

C:\Windows\System32\timeout.exe 10

@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

cinst -y 7zip everything git GoogleChrome python2 microsoftsecurityessentials teamviewer cmder f.lux potplayer foxitreader notepadplusplus putty teracopy classic-shell 

rem pause

C:\Windows\System32\timeout.exe 10

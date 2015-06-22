@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat %0

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

cinst -y 7zip git kodi microsoftsecurityessentials teamviewer GoogleChrome python2

pause


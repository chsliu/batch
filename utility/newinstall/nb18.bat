@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat %0

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

cinst -y 7zip everything git google-chrome-x64 python2 microsoftsecurityessentials teamviewer classic-shell cmder f.lux paint.net kodi potplayer foxitreader filebot notepadplusplus putty

rem pause

C:\Windows\System32\timeout.exe 10

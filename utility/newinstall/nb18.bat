@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

cinst -y 7zip everything git google-chrome-x64 python2 microsoftsecurityessentials teamviewer classic-shell cmder f.lux paint.net kodi potplayer foxitreader filebot notepadplusplus putty

rem pause

C:\Windows\System32\timeout.exe 10

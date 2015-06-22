@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat %0

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

cinst -y 7zip emule everything filebot git google-chrome-x64 jdownloader no-ip-duc picasa python2 putty winscp

pause


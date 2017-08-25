@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

REM audacity
REM foobar2000 
REM lame-front-end 
REM mkvtoolnix
REM mpc-hc
REM splayer
REM virtualdub
REM vlc

cinst -y filebot kodi mp3tag potplayer

rem pause

C:\Windows\System32\timeout.exe 10

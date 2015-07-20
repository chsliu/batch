@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

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

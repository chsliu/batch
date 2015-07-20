@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

cinst -y 7zip classic-shell cmder cpu-z crystaldiskinfo crystaldiskmark directx dropbox everything f.lux filebot foxitreader git github google-chrome-x64 gow hg kodi line listary mp3tag netscan64 notepadplusplus paint.net potplayer putty python2 skype teamviewer teraterm windowsliveinstaller winmerge winscp wireshark

rem pause

C:\Windows\System32\timeout.exe 10

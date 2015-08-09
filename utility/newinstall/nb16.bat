@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

cinst -y 7zip cmder cpu-z crystaldiskinfo crystaldiskmark dropbox everything f.lux foxitreader git github google-chrome-x64 gow hg line listary netscan64 notepadplusplus putty python2 skype teamviewer teraterm winmerge winscp wireshark

rem pause

C:\Windows\System32\timeout.exe 10

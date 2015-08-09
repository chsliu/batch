@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

REM classic-shell
REM foxitreader
REM microsoftsecurityessentials

choco feature enable -nautoUninstaller

cinst -y 7zip cmder Everything f.lux git GoogleChrome notepadplusplus potplayer putty python2 teamviewer 

cd/d d:\Users\sita\Documents
git clone https://github.com/chsliu/batch.git

rem pause

C:\Windows\System32\timeout.exe 10

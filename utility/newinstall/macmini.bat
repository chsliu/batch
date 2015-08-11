@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

cinst -y 7zip cmder f.lux git kodi potplayer putty teamviewer python2

cd/d c:\Users\sita\Documents
git clone https://github.com/chsliu/batch.git

mkdir %appdata%\Kodi
cd/d %appdata%\Kodi
git clone https://github.com/chsliu/userdata.git

rem pause

C:\Windows\System32\timeout.exe 10

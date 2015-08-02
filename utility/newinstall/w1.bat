@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

cinst -y 7zip classic-shell cmder cpu-z crystaldiskinfo crystaldiskmark dropbox everything f.lux filebot firefox foxitreader git github google-chrome-x64 gow hg kodi line listary mp3tag netscan64 nimbletext notepadplusplus paint.net potplayer putty python2 skype teamviewer teraterm visualstudioexpress2008 windowsliveinstaller winmerge winscp wireshark

cd/d d:\Users\sita\Documents
git clone https://github.com/chsliu/batch.git

REM startup
REM d:\Users\sita\Documents\tasks\startup.bat
REM daily
REM d:\Users\sita\Documents\tasks\daily.bat
REM weekly
REM d:\Users\sita\Documents\tasks\weekly.bat
REM monthly
REM d:\Users\sita\Documents\tasks\monthly.bat

cd/d batch
git clone https://github.com/chsliu/ShooterSubPyDownloader.git

mkdir %appdata%\Kodi
cd/d %appdata%\Kodi
git clone https://github.com/chsliu/userdata.git

rem pause

C:\Windows\System32\timeout.exe 10

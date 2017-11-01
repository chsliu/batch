@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd
set DOC=c:\Users\%USERNAME%\Documents
REM set TASKS=%DOC%\tasks
set PASS=1111

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

REM git 

cinst -y 7zip cmder dropbox Everything f.lux foxitreader google-chrome-x64 imdisk-toolkit notepadplusplus potplayer python2 teamviewer

REM =================================

call %~dp0\newinstall.taskschd.bat

REM =================================

REM call %~dp0\newinstall.kodi.bat

REM =================================

rem pause

C:\Windows\System32\timeout.exe 10

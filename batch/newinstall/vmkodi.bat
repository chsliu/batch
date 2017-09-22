@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd
set DOC=d:\Users\%USERNAME%\Documents
set TASKS=%DOC%\tasks
set SCHEDULE=16:30-17:00-17:30
set DAILY=%SCHEDULE:~0,5%
set WEEKLY=%SCHEDULE:~6,5%
set MONTHLY=%SCHEDULE:~12,5%
set PASS=1

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

cinst -y git directx kodi

REM =================================

call %~dp0\newinstall.kodi.bat

REM =================================

rem pause

C:\Windows\System32\timeout.exe 10

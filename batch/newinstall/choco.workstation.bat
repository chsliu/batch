@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

REM anydvd
REM bitmessage
REM btsync
REM chocolateygui
REM dbgl
REM firefox
REM foobar2000
REM freedownloadmanager
REM freemind
REM gimp
REM googledrive
REM hddguardian
REM itunes
REM jdownloader
REM keepass
REM launchy
REM libreoffice
REM openhardwaremonitor
REM opera
REM picasa
REM pidgin
REM pushbullet
REM spacesniffer
REM stickies
REM sumatrapdf
REM teamviewer.host
REM upx
REM wincdemu
REM winsplitrevolution
REM xnview
REM zim

cinst -y 7zip classic-shell cmder dropbox everything foxitreader google-chrome-x64 line listary notepadplusplus python2 skype teamviewer git microsoftsecurityessentials f.lux gow hg paint.net windowsliveinstaller directx

rem pause

C:\Windows\System32\timeout.exe 10

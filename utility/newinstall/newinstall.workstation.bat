@echo off

REM =================================
:BatchGotAdmin
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    if '%1'=='UACdone' (shift & goto gotAdmin)
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~0", "UACdone", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

REM =================================

powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin

REM =================================

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
REM itunes
REM jdownloader
REM keepass.portable
REM launchy
REM libreoffice
REM openhardwaremonitor
REM opera
REM picasa
REM pidgin
<<<<<<< HEAD
REM pushbullet
=======
REM pushbullet 
>>>>>>> 0ba72cb27c91511596d1ff837acb674479276af0
REM spacesniffer
REM stickies
REM sumatrapdf
REM teamviewer.host
<<<<<<< HEAD
REM upx
=======
>>>>>>> 0ba72cb27c91511596d1ff837acb674479276af0
REM wincdemu
REM winsplitrevolution
REM xnview
<<<<<<< HEAD
REM zim

cinst -y 7zip.install classic-shell cmdermini.portable dropbox everything foxitreader google-chrome-x64 line listary notepadplusplus.install openhardwaremonitor python2-x86_32 skype teamviewer git.install
=======

cinst -y 7zip.install classic-shell cmdermini.portable dropbox everything foxitreader google-chrome-x64 line listary notepadplusplus.install  python2 skype teamviewer git.install

pause
>>>>>>> 0ba72cb27c91511596d1ff837acb674479276af0


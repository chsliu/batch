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

cinst -y anydvd
cinst -y bitmessage
cinst -y btsync
cinst -y chocolateygui
cinst -y dbgl
cinst -y firefox
cinst -y foobar2000
cinst -y freedownloadmanager
cinst -y gimp
cinst -y itunes
cinst -y keepass.portable
cinst -y launchy
cinst -y libreoffice
cinst -y opera
cinst -y picasa
cinst -y pidgin
cinst -y spacesniffer
cinst -y sumatrapdf
cinst -y wincdemu
cinst -y xnview
cinst -y googledrive
cinst -y teamviewer.host

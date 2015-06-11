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

cinst -y aida64-engineer
cinst -y angryip
cinst -y apple_airport_utility
cinst -y as-ssd
cinst -y cpu-z
cinst -y crystaldiskinfo
cinst -y crystaldiskmark
cinst -y disk2vhd
cinst -y easybcd
cinst -y filezilla
cinst -y hdtune
cinst -y putty.portable
cinst -y spacesniffer
cinst -y sysinternals
cinst -y tightvnc
cinst -y treesizefree
cinst -y ultravnc
cinst -y usbit
cinst -y windirstat
cinst -y winimage
cinst -y winscp
cinst -y wireshark

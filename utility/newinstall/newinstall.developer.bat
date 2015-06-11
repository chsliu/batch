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

cinst -y astyle
cinst -y atom
cinst -y dependencywalker
cinst -y fiddler
cinst -y git.install
cinst -y github
cinst -y gource
cinst -y hg
cinst -y icofx
cinst -y jenkins
cinst -y linqpad4.AnyCPU.portable
cinst -y nodejs.install
cinst -y procexp
cinst -y procmon
cinst -y pspad
cinst -y pstools
cinst -y python
cinst -y ruby
cinst -y sqliteadmin
cinst -y sqlitebrowser
cinst -y sublimetext3 
cinst -y swig
cinst -y sysinternals
cinst -y teraterm
cinst -y visualstudioexpress2008
cinst -y wink
cinst -y winmerge

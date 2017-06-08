@echo off
call :lastarg %*
if not [%ARG_LAST%] == ["max"] start /MAX cmd /c %0 %* max & goto :EOF

set static_ip=192.168.7.100
set ind=0

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

echo Setting Static IP Information...
wmic nicconfig where Index=%ind% call EnableStatic ("%static_ip%"), ("255.255.255.0") >nul
ipconfig /all
echo.
pause


echo Resetting IP Address and Subnet Mask For DHCP...
wmic nicconfig where Index=%ind% call EnableDHCP >nul
ipconfig /renew >nul
ipconfig /all
echo.
pause


goto :EOF

REM =================================
:lastarg
set ARG_LAST="%~1"
shift
if not [%~1]==[] goto lastarg

goto :EOF

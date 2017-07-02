@echo off

REM =================================
goto :main

REM =================================
:main
REM =================================
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b

set static_ip=192.168.7.100
rem nicconfig call /?

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
echo Choose: 
echo [S] Set Static IP 
echo [D] Set DHCP 
echo [R] Refresh DHCP 
echo. 

:choice 
SET /P C=[S,D,R]? 
for %%? in (S) do if /I "%C%"=="%%?" goto Static
for %%? in (D) do if /I "%C%"=="%%?" goto Dhcp
for %%? in (R) do if /I "%C%"=="%%?" goto RefreshIP
goto choice 


:Static
call :SelectInterface

echo Setting Static IP Information...
rem netsh interface ip set address "LAN" static %IP_Addr% %Sub_Mask% %D_Gate% 1 
wmic nicconfig where Index=%ind% call EnableStatic ("%static_ip%"), ("255.255.255.0") >nul

goto :ShowIP


:Dhcp
call :SelectInterface

echo Resetting IP Address and Subnet Mask For DHCP...
rem netsh int ip set address name = "LAN" source = dhcp
wmic nicconfig where Index=%ind% call EnableDHCP >nul


:RefreshIP
ipconfig /release >nul
ipconfig /renew >nul


:ShowIP
echo.
echo Here are the new settings for %computername%: 
echo.

rem netsh int ip show config
ipconfig /all
echo.

pause 
goto :EOF

:SelectInterface
wmic nic get name, index
echo Please select an interface:
set /p ind=

exit /B



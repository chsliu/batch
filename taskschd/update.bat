set path=%path%;%~dp0\..\utility

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
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG1=%temp%\%~n0-%TODAY%.txt
set TXT1=%temp%\%~n0.txt

echo %DATE%%TIME% 					>%LOG1%

REM =================================

echo ===Turn On Service: Windows Modules Installer	>>%LOG1% 2>>&1
sc config TrustedInstaller start= demand		>>%LOG1% 2>>&1
sc start TrustedInstaller				>>%LOG1% 2>>&1
sc config TrustedInstaller start= disabled		>>%LOG1% 2>>&1
REM sc queryex TrustedInstaller

call %~dp0\..\wuinstall\search.download.install.bat 	>>%LOG1% 2>>&1

REM echo Turn Off Service
REM sc stop TrustedInstaller

echo ===Kill Off Service				>>%LOG1% 2>>&1
taskkill /F /FI "SERVICES eq TrustedInstaller"		>>%LOG1% 2>>&1
taskkill /F /FI "SERVICES eq TrustedInstaller"		>>%LOG1% 2>>&1
taskkill /F /FI "SERVICES eq TrustedInstaller"		>>%LOG1% 2>>&1

REM =================================

REM c:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe executeQueuedItems >>%LOG1% 2>>&1
REM c:\Windows\Microsoft.NET\Framework64\v2.0.50727\ngen.exe executeQueuedItems >>%LOG1% 2>>&1

for /f "delims=" %%i in ('dir /b /a-d /s %SystemDrive%\Windows\Microsoft.NET\ngen.exe') do %%~fi executeQueuedItems >>%LOG1% 2>>&1

REM =================================

copy %0 %TXT1%

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %TXT1%

del %LOG1% %TXT1%


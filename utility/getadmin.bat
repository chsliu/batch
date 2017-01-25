@echo off

REM =================================
:BatchGotAdmin
	REM  --> Check for permissions
	>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

	REM --> If error flag set, we do not have admin.
	if '%errorlevel%' NEQ '0' (
		echo Requesting administrative privileges...
		goto UACPrompt
	) else ( 
		goto gotAdmin 
	)

:UACPrompt
    if '%1'=='UACdone' (shift & goto gotAdmin)
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%0", "UACdone %~s1 %2 %3 %4 %5 %6 %7 %8 %9", "", "runas", 1 >> "%temp%\getadmin.vbs"

	REM Running self again with administrative privileges
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
	REM pause
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

REM =================================
REM echo %*	
	
REM Already has administrative privileges
if [%1] NEQ [UACdone] %1 %0 %2 %3 %4 %5 %6 %7 %8 %9

REM Running from vbs to obtain administrative privileges
if [%1] == [UACdone] %2 %0 %3 %4 %5 %6 %7 %8 %9

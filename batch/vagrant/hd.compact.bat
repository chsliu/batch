@echo off

set DEFRAGZIP=http://downloads.sourceforge.net/project/ultradefrag/stable-release/7.0.2/ultradefrag-portable-7.0.2.bin.amd64.zip
set DEFRAG=C:\Windows\Temp\ultradefrag-portable-7.0.2.amd64\udefrag.exe
set SDELETEZIP=http://download.sysinternals.com/files/SDelete.zip
set SDELETE=C:\Windows\Temp\sdelete64.exe

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
goto :main


REM =================================
REM call :EMPTYDIR <dir to empty>
REM call :EMPTYDIR c:\temp
REM =================================
:EMPTYDIR
pushd %1 || exit /b
echo Emptying %1 ...
rd /q /s . >NUL 2>>&1
takeown /f . /r /D Y >NUL 2>>&1
rd /q /s . >NUL 2>>&1
popd

exit /b

REM =================================
REM call :REMOVEDIR <dir to remove>
REM call :REMOVEDIR c:\del
REM =================================
:REMOVEDIR
echo Removing %1 ...
rd /q /s %1 >NUL 2>>&1
takeown /f %1 /r /D Y >NUL 2>>&1
rd /q /s %1 >NUL 2>>&1

exit /b

REM =================================
:main
REM =================================
if not exist "C:\Windows\Temp\7z920-x64.msi" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://www.7-zip.org/a/7z920-x64.msi', 'C:\Windows\Temp\7z920-x64.msi')" <NUL
)
msiexec /qb /i C:\Windows\Temp\7z920-x64.msi

if not exist "C:\Windows\Temp\ultradefrag.zip" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%DEFRAGZIP%', 'C:\Windows\Temp\ultradefrag.zip')" <NUL
)

if not exist "%DEFRAG%" (
	cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\ultradefrag.zip -oC:\Windows\Temp"
)

if not exist "C:\Windows\Temp\SDelete.zip" (
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%SDELETEZIP%', 'C:\Windows\Temp\SDelete.zip')" <NUL
)

if not exist "%SDELETE%" (
	cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\SDelete.zip -oC:\Windows\Temp"
)

msiexec /qb /x C:\Windows\Temp\7z920-x64.msi

REM call :EMPTYDIR %temp%
REM call :EMPTYDIR %USERPROFILE%\AppData\Local\Temp

for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if [%%G] == [%1] (
  if exist %%G:\nul (
  
	attrib -s -h %%G:\*.sys
	del /f %%G:\*.sys
	del /AS %%G:\hiberfil.sys

	call :EMPTYDIR %%G:\temp

	call :REMOVEDIR %%G:\DEL
	call :REMOVEDIR %%G:\recycle

	call :EMPTYDIR %%G:\recycler
	call :EMPTYDIR %%G:\$Recycle.bin	
)))

REM cleanmgr /sageset:99
REM cleanmgr /sagerun:99

REM net stop wuauserv
REM rmdir /S /Q C:\Windows\SoftwareDistribution\Download
REM mkdir C:\Windows\SoftwareDistribution\Download
REM net start wuauserv

cmd /c %SystemRoot%\System32\reg.exe ADD HKCU\Software\Sysinternals\SDelete /v EulaAccepted /t REG_DWORD /d 1 /f

for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
REM for %%G in (C) do (
  if [%%G] == [%1] (
  if exist %%G:\nul (
	echo cmd /c %DEFRAG% --optimize --repeat %%G:
	cmd /c %DEFRAG% --optimize --repeat %%G:

	REM echo cmd /c %SDELETE% -q -z %%G:
	REM cmd /c %SDELETE% -q -z %%G:	
)))

REM call :EMPTYDIR %SystemRoot%\TEMP

REM %windir%\System32\Sysprep\Sysprep.exe /quiet /generalize /oobe /shutdown

REM shutdown /s /t 0

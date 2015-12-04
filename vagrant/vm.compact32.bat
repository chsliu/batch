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
if not exist "C:\Windows\Temp\7z920.exe" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://www.7-zip.org/a/7z920.exe', 'C:\Windows\Temp\7z920.exe')" <NUL
)
C:\Windows\Temp\7z920.exe /s

if not exist "C:\Windows\Temp\ultradefrag.zip" (
	powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://downloads.sourceforge.net/project/ultradefrag/stable-release/6.1.0/ultradefrag-portable-6.1.0.bin.i386.zip', 'C:\Windows\Temp\ultradefrag.zip')" <NUL
)

if not exist "C:\Windows\Temp\ultradefrag-portable-6.1.0.i386\udefrag.exe" (
	cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\ultradefrag.zip -oC:\Windows\Temp"
)

if not exist "C:\Windows\Temp\SDelete.zip" (
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('http://download.sysinternals.com/files/SDelete.zip', 'C:\Windows\Temp\SDelete.zip')" <NUL
)

if not exist "C:\Windows\Temp\sdelete.exe" (
	cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\SDelete.zip -oC:\Windows\Temp"
)

"C:\Program Files\7-Zip\Uninstall.exe" /s

call :EMPTYDIR %temp%
call :EMPTYDIR %USERPROFILE%\AppData\Local\Temp

for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if exist %%G:\nul (
	call :EMPTYDIR %%G:\temp

	call :REMOVEDIR %%G:\DEL

	call :EMPTYDIR %%G:\recycler
	call :EMPTYDIR %%G:\$Recycle.bin
  )
)

cleanmgr /sageset:99
cleanmgr /sagerun:99

net stop wuauserv
rmdir /S /Q C:\Windows\SoftwareDistribution\Download
mkdir C:\Windows\SoftwareDistribution\Download
net start wuauserv

cmd /c %SystemRoot%\System32\reg.exe ADD HKCU\Software\Sysinternals\SDelete /v EulaAccepted /t REG_DWORD /d 1 /f

REM for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
for %%G in (C) do (
  if exist %%G:\nul (
	
	cmd /c C:\Windows\Temp\ultradefrag-portable-6.1.0.i386\udefrag.exe --optimize --repeat %%G:

	cmd /c C:\Windows\Temp\sdelete.exe -q -z %%G:	
  )
)

call :EMPTYDIR %SystemRoot%\TEMP

%windir%\System32\Sysprep\Sysprep.exe /quiet /generalize /oobe /shutdown

shutdown /s /t 0

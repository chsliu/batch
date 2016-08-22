@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
goto :main


REM =================================
REM call :EMPTYDIR <dir to empty>
REM call :EMPTYDIR c:\temp
REM =================================
:EMPTYDIR
pushd %1 >NUL 2>>&1 || exit /b
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
:WHEREIS
set %2=
for %%X in (%1) do (set %2=%%~$PATH:X)

exit /b

REM =================================
@echo off
echo Make Sure Dropbox is not in c:
echo Cleaning . . .
pause

pushd %windir%\temp 	  			& takeown /f . /r & rd /s /q . & popd
pushd %temp% 		  			& takeown /f . /r & rd /s /q . & popd
pushd %temp% & pushd %systemdrive%\recycler	& takeown /f . /r & rd /s /q . & popd & popd
pushd %temp% & pushd c:\$Recycle.bin		& takeown /f . /r & rd /s /q . & popd & popd
pushd %temp% & pushd d:\$Recycle.bin		& takeown /f . /r & rd /s /q . & popd & popd

del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
del /f /q %userprofile%\cookies\*.*
del /f /q %userprofile%\recent\*.*
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
del /f /s /q "%userprofile%\recent\*.*"
del /f /s /q "%USERPROFILE%\AppData\Local\Temp\*.*"

echo Clean Complete !!!
echo. & pause

goto :EOF


REM =================================
:main
REM =================================

for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if exist %%G:\nul (
	call :REMOVEDIR %%G:\DEL
  )
)

REM =================================

cd /d %temp%

call :EMPTYDIR %temp%
call :EMPTYDIR %USERPROFILE%\AppData\Local\Temp
call :EMPTYDIR %SystemRoot%\TEMP
call :EMPTYDIR "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache"

for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if exist %%G:\nul (
	call :EMPTYDIR %%G:\temp

	call :EMPTYDIR %%G:\recycler
	call :EMPTYDIR %%G:\$Recycle.bin
  )
)

REM =================================
call :WHEREIS cleanmgr.exe CLEANMGR

if not defined CLEANMGR goto :CleanEnd
echo === Remember to run first, cleanmgr /sageset:99
echo.
cleanmgr /sagerun:99

:CleanEnd

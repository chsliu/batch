REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================

REM rd /s /q C:\DEL
REM rd /s /q D:\DEL

for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if exist %%G:\nul (
    REM rd /s /q %%G:\DEL
	call :REMOVEDIR %%G:\DEL
  )
)

REM =================================

cd /d %temp%

REM pushd %temp% & pushd %temp%			& rd /s /q . & takeown /f . /r & rd /s /q . & popd & popd
REM pushd %temp% & pushd %windir%\temp		& rd /s /q . & takeown /f . /r & rd /s /q . & popd & popd
call :EMPTYDIR %temp%
call :EMPTYDIR %windir%\temp
REM pushd %temp% & pushd d:\temp		& rd /s /q . & takeown /f . /r & rd /s /q . & popd & popd

REM pushd %temp% & pushd %systemdrive%\recycler	& rd /s /q . & takeown /f . /r & rd /s /q . & popd & popd
REM pushd %temp% & pushd c:\$Recycle.bin	& rd /s /q . & takeown /f . /r & rd /s /q . & popd & popd
REM pushd %temp% & pushd d:\$Recycle.bin	& rd /s /q . & takeown /f . /r & rd /s /q . & popd & popd

for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if exist %%G:\nul (
    REM pushd %temp% & pushd %%G:\temp		& rd /s /q . & takeown /f . /r & rd /s /q . & popd & popd
	call :EMPTYDIR %%G:\temp

    REM pushd %temp% & pushd %%G:\recycler		& rd /s /q . & takeown /f . /r & rd /s /q . & popd & popd
    REM pushd %temp% & pushd %%G:\$Recycle.bin	& rd /s /q . & takeown /f . /r & rd /s /q . & popd & popd
	call :EMPTYDIR %%G:\recycler
	call :EMPTYDIR %%G:\$Recycle.bin
  )
)

REM =================================

REM run below first
REM cleanmgr /sageset:99
cleanmgr /sagerun:99

REM =================================

goto :EOF

REM =================================
REM call :EMPTYDIR <dir to empty>
REM call :EMPTYDIR c:\temp
REM =================================
:EMPTYDIR
pushd %1 || exit /b
echo Emptying %1...
rd /q /s . 2>NUL
takeown /f . /r /D Y 2>NUL
rd /q /s . 2>NUL
popd

exit /b

REM =================================
REM call :REMOVEDIR <dir to remove>
REM call :REMOVEDIR c:\del
REM =================================
:REMOVEDIR
echo Removing %1...
rd /q /s %1 2>NUL
takeown /f %1 /r /D Y 2>NUL
rd /q /s %1 2>NUL

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

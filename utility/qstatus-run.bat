REM @echo off

set DSTPATH=%temp%\%~n0
set RUNFILE=%DSTPATH%\qstatus\utility\status.bat
set ZA7=%~dp07za.exe
set QSTATUS="%~dp0qstatus.7z"

goto :Main

:WaitForLockFile
echo Waiting for %1 ...
:WaitForLockFileLoop
if not exist %1 exit/b
echo .
ping 127.0.0.1 -n 10 -w 1000 > nul

goto :WaitForLockFileLoop


:Main

mkdir %DSTPATH%

if not exist %ZA7% bitsadmin.exe /transfer "Downloading 7Zip ..." https://chocolatey.org/7za.exe %ZA7%

if not exist %QSTATUS% bitsadmin.exe /transfer "Downloading qstatus ..."  https://dl.dropboxusercontent.com/u/313407/qstatus.7z %QSTATUS%

pushd %DSTPATH%

%ZA7% x -y %QSTATUS%

echo del %%0>>%RUNFILE%
call %RUNFILE%

popd

call :WaitForLockFile %RUNFILE%

rd /s /q %DSTPATH%
del %ZA7%
del %QSTATUS%

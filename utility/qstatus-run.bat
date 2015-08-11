@echo off

set DSTPATH=%~dp0\temp
set RUNFILE=%DSTPATH%\qstatus\utility\status.bat

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

bitsadmin.exe /transfer "Downloading 7Zip ..." https://chocolatey.org/7za.exe %DSTPATH%\7za.exe

bitsadmin.exe /transfer "Downloading qstatus ..."  https://dl.dropboxusercontent.com/u/313407/qstatus.7z %DSTPATH%\qstatus.7z

pushd %DSTPATH%

7za.exe x -y qstatus.7z

echo del %%0>>%RUNFILE%
call %RUNFILE%

popd

call :WaitForLockFile %RUNFILE%

rd /s /q %DSTPATH%

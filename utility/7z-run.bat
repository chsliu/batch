@echo off

REM =================================
goto :main

REM =================================
:whereis
set %2=
for %%X in (%1) do (set %2=%%~$PATH:X)

exit /b

REM =================================
:Stop
echo Stopping on %1.
pause
goto :EOF

REM =================================
:WaitForLockFile
echo Waiting for %1 ...
:WaitForLockFileLoop
if not exist %1 exit /b
echo .
ping 127.0.0.1 -n 10 -w 1000 > nul

goto :WaitForLockFileLoop


REM =================================
:main
REM =================================
set DSTPATH=%temp%\%~n0
set PROJ=%1
set RUNFILE=%DSTPATH%\%PROJ%\utility\%PROJ%.bat
set ZA7=%~dp07za.exe
set PROJ7Z="%~dp0%PROJ%.7z"

if not exist %DSTPATH% mkdir %DSTPATH%

call :whereis bitsadmin.exe BITSADMIN
if not defined BITSADMIN call :Stop "bitsadmin.exe not existed"

if not exist %ZA7% bitsadmin.exe /transfer "Downloading 7za.exe ..." https://chocolatey.org/7za.exe %ZA7%
if errorlevel 1 call :Stop "7za.exe download error"

if not exist %PROJ7Z% bitsadmin.exe /transfer "Downloading %PROJ%.7z ..."  https://dl.dropboxusercontent.com/u/313407/%PROJ%.7z %PROJ7Z%
if errorlevel 1 call :Stop "%PROJ%.7z download error"

pushd %DSTPATH%

%ZA7% x -y %PROJ7Z%

echo del %%0>>%RUNFILE%
call %RUNFILE%

popd

call :WaitForLockFile %RUNFILE%

rd /s /q %DSTPATH%
del %ZA7%
del %PROJ7Z%

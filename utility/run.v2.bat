@echo off

REM =================================
goto :main

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
set PROJ=%1
set PROJZIP="%~dp0%PROJ%.zip"
set DSTPATH=%temp%\%~n0
set RUNFILE=%DSTPATH%\utility\%PROJ%.bat

REM =================================
if exist %DSTPATH% rd /s/q %DSTPATH%

powershell -nologo -noprofile -command "(New-Object Net.WebClient).DownloadFile('https://dl.dropboxusercontent.com/u/313407/%PROJ%.zip', '%PROJZIP%')"

powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem';  [IO.Compression.ZipFile]::ExtractToDirectory('%PROJZIP%', '%DSTPATH%'); }"

REM =================================
echo del %%0>>%RUNFILE%
call %RUNFILE%

call :WaitForLockFile %RUNFILE%

REM =================================
rd /s /q %DSTPATH%
del %PROJZIP%
del %0

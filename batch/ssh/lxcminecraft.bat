@echo off

REM =================================
goto :main

REM =================================
REM call :AWK <linefile> <location>
REM call :AWK temp.txt 10
REM =================================
:AWK
set RET=
FOR /F "tokens=%2 delims= " %%G IN (%1) DO (
    set RET=%%G
)
exit /b

REM =================================
:main

REM =================================
REM call :AWK %LOCALAPPDATA%\Dropbox\info.json 3
REM echo %RET%
REM set ROOT=%RET:",="%

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

REM for /f %%i in ('call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json') do (
REM echo %%i
REM set ROOT=%%i
REM )

echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
"C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0

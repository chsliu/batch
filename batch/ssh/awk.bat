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
call :AWK %LOCALAPPDATA%\Dropbox\info.json 3
echo %RET%
set ROOT=%RET:",="%

echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
"C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0

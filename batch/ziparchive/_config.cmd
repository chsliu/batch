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
if not exist %LOCALAPPDATA%\Dropbox\info.json (

	set ZIPDIR=%USERPROFILE%
	
) else (

	call :AWK %LOCALAPPDATA%\Dropbox\info.json 3
	REM set ROOT=%RET:",="%\.python
	REM echo %ROOT%
	set ZIPDIR=%RET:",="%
	
)


REM =================================
REM set ZIPDIR=D:\Users\sita\Dropbox



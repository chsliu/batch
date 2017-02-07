@echo off

REM =================================
goto :main

REM =================================
:OkConnection
rem echo Connection OK.

REM goto :EOF
exit /b

REM =================================
:ErrorConnection
cls
echo Connection Error, Reseting Connection...
call :resetConnetion
echo %date%, %time% >> %LOG%
SET /A RESET+=1
REM goto :EOF
exit /b

REM =================================
:testConnection
ping %SERVER% -n 1 -w 1000 > nul
if errorlevel 1 goto :ErrorConnection

goto :OkConnection

REM =================================
:resetConnetion
rem netsh interface set interface "Ethernet 2" DISABLE
wmic path win32_networkadapter where index=11 call disable

rem C:\Windows\System32\PING.EXE 127.0.0.1 -n 600 -w 1000 > nul
rem C:\Windows\System32\timeout.exe 300
rem C:\Windows\System32\choice.exe /d y /t 600

rem netsh interface set interface "Ethernet 2" ENABLE
rem wmic nic get name, index
wmic path win32_networkadapter where index=11 call enable

REM goto :EOF
exit /b


REM =================================
:main
REM =================================
set LOG=%temp%\%~n0.txt
set SERVER=192.168.1.254

cls
echo Keep Network Alive
echo.
SET /A COUNT=0
SET /A RESET=0

REM =================================
:loop
rem echo Testing...
call :testConnection
C:\Windows\System32\choice.exe /d y /t 60 /M %COUNT%,%RESET%,"Run?"
if errorlevel 2 goto :EOF
SET /A COUNT+=1

goto :loop

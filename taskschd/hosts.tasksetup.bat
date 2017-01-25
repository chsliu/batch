@echo off

REM =================================
REM Acquire Administrative Privileges
REM =================================
set ADMIN=%TASKS_ROOT%\utility\getadmin.bat
if /I [%1] NEQ [%ADMIN%] %ADMIN% "%~dp0\%~nx0" %*
shift

REM =================================
if [%1] == [] goto :EOF

REM =================================
set TASKS=%CD%
set PASS=1

SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D SUN /TN "%USERNAME%-hosts.disable %1" /TR "%TASKS%\hosts.disable.bat %1" /ST 21:00
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "%USERNAME%-hosts.enable %1" /TR "%TASKS%\hosts.enable.bat %1" /ST 16:00

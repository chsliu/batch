@echo off

REM set path=%path%;C:\Program Files (x86)\Git\cmd;C:\tools\cmder\vendor\msysgit\bin

if not defined SCHEDULE	set SCHEDULE=13:30-14:00-14:30
if not defined DAILY	set DAILY=%SCHEDULE:~0,5%
if not defined WEEKLY	set WEEKLY=%SCHEDULE:~6,5%
if not defined MONTHLY	set MONTHLY=%SCHEDULE:~12,5%
if not defined DOC 		goto :EOF
if not defined PASS 	goto :EOF
if not defined TASKS_ROOT goto :EOF

REM pushd %DOC%

SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC ONSTART /TN "%USERNAME%-startup" /TR "%TASKS_ROOT%\startup.bat"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC DAILY /TN "%USERNAME%-daily" /TR "%TASKS_ROOT%\daily.bat" /ST %DAILY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "%USERNAME%-weekly" /TR "%TASKS_ROOT%\weekly.bat" /ST %WEEKLY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC MONTHLY /MO LAST /D FRI /TN "%USERNAME%-monthly" /TR "%TASKS_ROOT%\monthly.bat" /ST %MONTHLY%

REM popd

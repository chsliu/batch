REM =================================
if [%1]==[] %~dp0\..\..\utility\getadmin.bat "%~dp0\%~nx0"

set PASS=1

REM =================================
SchTasks /Delete /F /TN "startup"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC ONSTART /TN "startup-%USERNAME%" /TR "d:\Users\%USERNAME%\Documents\tasks\startup.bat"

REM =================================
SchTasks /Delete /F /TN "daily"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC DAILY /TN "daily-%USERNAME%" /TR "d:\Users\%USERNAME%\Documents\tasks\daily.bat" /ST 16:30

REM =================================
SchTasks /Delete /F /TN "weekly"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "weekly-%USERNAME%" /TR "d:\Users\%USERNAME%\Documents\tasks\weekly.bat" /ST 17:00

REM =================================
SchTasks /Delete /F /TN "monthly"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC MONTHLY /MO LAST /D FRI /TN "monthly-%USERNAME%" /TR "d:\Users\%USERNAME%\Documents\tasks\monthly.bat" /ST 17:30

pause

REM =================================
if [%1]==[] %~dp0\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set DOC=d:\Users\%USERNAME%\Documents
set TASKS=%CD%
set PASS=1

SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D SUN /TN "%USERNAME%-hosts.disable" /TR "%TASKS%\hosts.disable.bat" /ST 21:00
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "%USERNAME%-hosts.enable" /TR "%TASKS%\hosts.enable.bat" /ST 16:00

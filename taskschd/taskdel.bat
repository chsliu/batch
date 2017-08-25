REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
SchTasks /Delete /F /TN "startup"
SchTasks /Delete /F /TN "daily"
SchTasks /Delete /F /TN "weekly"
SchTasks /Delete /F /TN "monthly"

REM =================================
SchTasks /Delete /F /TN "%USERNAME%-startup"
SchTasks /Delete /F /TN "%USERNAME%-daily"
SchTasks /Delete /F /TN "%USERNAME%-weekly"
SchTasks /Delete /F /TN "%USERNAME%-monthly"

pause

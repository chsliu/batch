@echo off

REM =================================
SchTasks /Query /FO LIST /TN "startup"
SchTasks /Query /FO LIST /TN "daily"
SchTasks /Query /FO LIST /TN "weekly"
SchTasks /Query /FO LIST /TN "monthly"

REM =================================
SchTasks /Query /FO LIST /TN "%USERNAME%-startup"
SchTasks /Query /FO LIST /TN "%USERNAME%-daily"
SchTasks /Query /FO LIST /TN "%USERNAME%-weekly"
SchTasks /Query /FO LIST /TN "%USERNAME%-monthly"

pause

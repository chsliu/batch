@%TASKS_ROOT%\utility\gitsync.bat & robocopy %TASKS_ROOT%\cmder C:\tools\cmder *.bat *.cmd *.sh *.xml /S /R:0 /NDL /NJH /NJS /MT & alias /reload

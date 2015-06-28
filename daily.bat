start /min call %~dp0\utility\alarm.bat

start /min call %~dp0\utility\gitsync.bat

set _=%~dp0\taskschd\%~n0-%COMPUTERNAME%.bat
if exist %_% call %_%

start /min call %~dp0\taskschd\backup.bat

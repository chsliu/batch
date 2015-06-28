REM =================================

start /min call %~dp0\utility\alarm.bat

REM =================================

start /min call %~dp0\utility\gitsync.bat

REM =================================

set _=%~dp0\taskschd\%~n0-%COMPUTERNAME%.bat
if exist %_% call %_%

REM =================================

start /min call %~dp0\taskschd\backup.bat


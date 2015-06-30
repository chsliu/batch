REM =================================

call %~dp0\utility\gitsync.bat

REM =================================

call %~dp0\ShooterSubPyDownloader\gitsync.bat

REM =================================

call %~dp0\utility\alarm.bat

REM =================================

set _=%~dp0\taskschd\%~n0-%COMPUTERNAME%.bat
if exist %_% call %_%

REM =================================

call %~dp0\taskschd\backup.bat


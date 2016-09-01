REM =================================

start /min call %~dp0\utility\sendemail.gitsync.bat ^&^& exit

REM =================================

start /min call %~dp0\ShooterSubPyDownloader\sendemail.gitsync.bat ^&^& exit

REM =================================

start /min call %appdata%\Kodi\userdata\sendemail.gitsync.bat ^&^& exit

REM =================================

call %~dp0\utility\sendemail.alarm.bat

REM =================================

call %~dp0\utility\sendemail.chocolist.bat

REM =================================

call %~dp0\taskschd\sendemail.%~n0.bat

REM =================================

set _=%~dp0\taskschd\%~n0-%COMPUTERNAME%.bat
if exist %_% call %_%


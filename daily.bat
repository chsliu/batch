REM =================================

call %~dp0\utility\sendemail.gitsync.bat

REM =================================

call %~dp0\ShooterSubPyDownloader\sendemail.gitsync.bat

REM =================================

call %appdata%\Kodi\userdata\sendemail.gitsync.bat

REM =================================

call %~dp0\utility\sendemail.alarm.bat

REM =================================

set _=%~dp0\taskschd\%~n0-%COMPUTERNAME%.bat
if exist %_% call %_%

REM =================================

call %~dp0\taskschd\sendemail.backup.bat


REM =================================

set _=%~dp0\taskschd\%~n0-%COMPUTERNAME%.bat
if exist %_% call %_%

REM =================================

cup -y all

REM =================================

call %~dp0\taskschd\sendemail.cleanup.bat


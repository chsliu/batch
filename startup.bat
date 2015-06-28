REM =================================

call %~dp0\taskschd\%~n0.bat

REM =================================

set _=%~dp0\taskschd\%~n0-%COMPUTERNAME%.bat
if exist %_% call %_%

REM =================================

call %~dp0\..\utility\gitsync.bat


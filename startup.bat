call %~dp0\taskschd\%~n0.bat

set _=%~dp0\taskschd\%~n0-%COMPUTERNAME%.bat
if exist %_% call %_%

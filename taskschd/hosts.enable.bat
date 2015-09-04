REM =================================
if [%1]==[] %~dp0\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set SRC="\\hv4\Software\UNIX\Lubuntu\hosts"
set DST="C:\Windows\System32\drivers\etc\hosts"

copy /y %SRC% %DST%

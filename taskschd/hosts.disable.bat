REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set SRC="\\hv4\Software\UNIX\Lubuntu\hosts"
set HOSTSTEMP=%TEMP%\hosts.txt
set DST="C:\Windows\System32\drivers\etc\hosts"

REM =================================
copy /y %SRC% %HOSTSTEMP%

REM =================================
REM Blocked host list
REM =================================
echo 127.0.0.1	www.youtube.com>>%HOSTSTEMP%
REM =================================

REM =================================
move /y %HOSTSTEMP% %DST%

REM =================================
icacls %DST% /grant "NT AUTHORITY\SYSTEM":(F)
icacls %DST% /grant BUILTIN\Administrators:(F)
icacls %DST% /grant BUILTIN\Users:(RX)
icacls %DST% /grant "APPLICATION PACKAGE AUTHORITY\ALL APPLICATION PACKAGES":(RX)

REM =================================
ipconfig /flushdns

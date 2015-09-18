REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set SRC="\\hv4\Software\UNIX\Lubuntu\hosts"
set DST="C:\Windows\System32\drivers\etc\hosts"

REM =================================
copy /y %SRC% %DST%

REM =================================
icacls %DST% /grant "NT AUTHORITY\SYSTEM":(F)
icacls %DST% /grant BUILTIN\Administrators:(F)
icacls %DST% /grant BUILTIN\Users:(RX)
REM icacls %DST% /grant "APPLICATION PACKAGE AUTHORITY\ALL APPLICATION PACKAGES":(RX)

REM =================================
ipconfig /flushdns

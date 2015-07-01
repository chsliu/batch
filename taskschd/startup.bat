REM =================================

set path=%path%;%~dp0\..\bin

REM =================================

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0

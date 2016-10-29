REM =================================

set path=%path%;%~dp0\..\bin

REM =================================
set showmyip="%~dp0\..\util\showmyip.cmd"

FOR /F "tokens=* USEBACKQ" %%F IN (`%showmyip%`) DO (
SET myip=%%F
)
REM ECHO %myip%

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m "%0 from %myip%, http://www.infosniper.net/index.php?ip_address=%myip%"

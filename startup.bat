set path=%path%;%~dp0\utility

set TXT1=%temp%\%~n0.txt

copy %0 %TXT1%

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %TXT1%

del %TXT1%

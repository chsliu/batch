set path=%path%;%~dp0\..\bin

set server=msa.hinet.net
set from=egreta.su@msa.hinet.net
set to=chsliu_31@kindle.com

sendemail -s %server% -f %from% -t %to% -u "Send To Kindle" -a %1 -m %*

timeout 10

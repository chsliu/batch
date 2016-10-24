set path=%path%;%~dp0\..\bin


rem net user administrator /active:yes

rem net use \\%1\ipc$ /user:administrator 1

net use \\%1\ipc$ /user:sita 1

shutdown /s /m \\%1 /t 0 /c "%0 from %COMPUTERNAME%"

rem psshutdown -s -t 0 -f \\%1

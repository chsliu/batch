@echo off

chcp 950

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

set ROOT=D:\Users\sita\Nextcloud
REM set HOST=35.233.234.22
set HOST=35.247.69.237 

REM echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null sita@%~n0
REM "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null sita@%~n0

echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null sita@%HOST%
"C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null sita@%HOST%

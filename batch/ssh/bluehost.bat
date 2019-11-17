@echo off

chcp 950

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

set ROOT=D:\Users\sita\Nextcloud
set HOST=162.241.218.154

echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\bluehost_yoz" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null taiwanh2@%HOST%
"C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\bluehost_yoz" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null taiwanh2@%HOST%

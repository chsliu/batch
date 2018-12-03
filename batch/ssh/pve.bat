@echo off

chcp 950

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

set ROOT=D:\Users\sita\Nextcloud

echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" vagrant@%~n0
"C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" vagrant@%~n0

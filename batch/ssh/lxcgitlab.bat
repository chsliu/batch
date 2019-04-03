@echo off

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

set ROOT=D:\Users\sita\Nextcloud
set HOST=192.168.1.127

REM echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%HOST%
"C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%HOST%

@echo off

chcp 950

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

REM set ROOT=D:\Users\sita\Nextcloud
set ROOT=C:\Users\sita\Vault
set HOST=%~n0

REM echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%HOST%
REM "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%HOST%
echo "C:\Windows\System32\OpenSSH\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%HOST%
"C:\Windows\System32\OpenSSH\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%HOST%

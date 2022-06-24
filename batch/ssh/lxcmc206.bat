@echo off

chcp 950

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

REM set ROOT=D:\Users\sita\Nextcloud
set ROOT=C:\Users\sita\Vault
set SSH="C:\Windows\System32\OpenSSH\ssh.exe"

REM echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
REM "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
echo %SSH% -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
%SSH% -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0

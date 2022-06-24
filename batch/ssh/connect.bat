@echo off

if [%1]==[] (
    goto :EOF
)

chcp 950

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

REM set ROOT=D:\Users\sita\Nextcloud
set ROOT=C:\Users\sita\Vault
REM set HOST=35.194.214.154
set HOST=uhc.creeper.tw
set SSH="C:\Windows\System32\OpenSSH\ssh.exe"

echo %SSH% -i "%ROOT%\SSHKey\nb19_rsa" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null sita@%1
%SSH% -i "%ROOT%\SSHKey\nb19_rsa" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null sita@%1

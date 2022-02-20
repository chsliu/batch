@echo off

chcp 950

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

REM set ROOT=D:\Users\sita\Nextcloud
set ROOT=C:\Users\sita\Vault

REM echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
REM "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
echo "C:\Windows\System32\OpenSSH\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
"C:\Windows\System32\OpenSSH\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0

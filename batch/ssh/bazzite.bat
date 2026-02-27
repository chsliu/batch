@echo off

chcp 950

call %~dp0\getdropboxroot.cmd %LOCALAPPDATA%\Dropbox\info.json >%TEMP%\temp.txt
set /p ROOT=<%TEMP%\temp.txt
del %TEMP%\temp.txt >nul

REM set ROOT=D:\Users\sita\Nextcloud
set ROOT=C:\Users\sita\Vault

REM echo "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0
REM "C:\Program Files\Git\usr\bin\ssh.exe" -i "%ROOT%\SSHKey\nb19_rsa" sita@%~n0

echo ssh bazzite@%~n0
ssh bazzite@%~n0
REM C:\Users\sita\AppData\Roaming\MobaXterm\slash\bin\sshpass.exe -p bazzite ssh bazzite@%~n0

@echo off

REM ssh -i "D:\Users\sita\Nextcloud\SSHKey\nb19_rsa" vagrant@%~n0
REM ssh -i "D:\Users\sita\Nextcloud\SSHKey\nb19_rsa" sita@%~n0
"C:\Program Files\Git\usr\bin\ssh.exe" -i "D:\Users\sita\Nextcloud\SSHKey\nb19_rsa" sita@%~n0

@echo off


if [%2]==[] (
set user=sita
) else (
set user=%2
)


ssh -i "D:\Users\sita\Nextcloud\SSHKey\nb19_rsa" %user%@192.168.1.%1

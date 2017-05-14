@echo off

set path=C:\Program Files\Git\usr\bin;%path%

ssh -i "D:\Users\sita\Dropbox (個人)\SSHKey\nb19_rsa" sita@%~n0

@echo off

call %~dp0\backup E:\Shares\Admin
call %~dp0\backup E:\Shares\Photos
call %~dp0\backup E:\Shares\Video
call %~dp0\backup E:\Shares\Users
call %~dp0\backup E:\Shares\Music
call %~dp0\backup E:\Shares\Software
rem call %~dp0\backup E:\Shares\NetBackup

goto exit

:exit

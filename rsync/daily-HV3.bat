@echo off

call %~dp0\backup E:\Shares\Admin
call %~dp0\backup E:\Shares\Photos
rem call %~dp0\backup E:\Shares\Video
call %~dp0\backup E:\Shares\Users
rem call %~dp0\backup E:\Shares\Music
call %~dp0\backup E:\Shares\Software
rem call %~dp0\backup E:\Shares\NetBackup

goto exit

:exit

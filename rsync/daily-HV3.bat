@echo off

call %~dp0\backup E:\Shares\Admin\hv3
call %~dp0\backup E:\Shares\Photos
call %~dp0\backup E:\Shares\Software
call %~dp0\backup E:\Shares\Users
rem call %~dp0\backup E:\Shares\Music
rem call %~dp0\backup E:\Shares\NetBackup
rem call %~dp0\backup E:\Shares\Video

goto exit

:exit

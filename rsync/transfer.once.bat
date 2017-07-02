@echo off

call %~dp0\backup E:\Shares\Admin pat-empty.txt
call %~dp0\backup E:\Shares\Games pat-empty.txt
call %~dp0\backup E:\Shares\Library pat-empty.txt
call %~dp0\backup E:\Shares\NetBackup pat-empty.txt
call %~dp0\backup E:\Shares\Software pat-empty.txt

rem goto exit

:exit

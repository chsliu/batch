@echo off

call %~dp0\backup E:\Shares\Admin
call %~dp0\backup E:\Shares\Photos
<<<<<<< HEAD
call %~dp0\backup E:\Shares\Video
=======
rem call %~dp0\backup E:\Shares\Video
>>>>>>> 4ef3738574a3d7fb3f348432db7492a8779b5f32
call %~dp0\backup E:\Shares\Users
call %~dp0\backup E:\Shares\Music
call %~dp0\backup E:\Shares\Software
rem call %~dp0\backup E:\Shares\NetBackup

goto exit

:exit

@echo off

REM call %~dp0\backup C:\ProgramData pat-programdata.txt
REM call %~dp0\backup C:\Users\sita\AppData pat-appdata.txt
REM call %~dp0\backup D:\Users\sita\BTSync pat-btsync.txt
REM call %~dp0\backup D:\Users\sita\Desktop pat-desktop.txt
REM call %~dp0\backup D:\Users\sita\Documents pat-doc.txt
call %~dp0\backup "D:\Sourcery G++ Lite"

REM goto exit
:exit

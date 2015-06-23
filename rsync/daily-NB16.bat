@echo off

REM call %~dp0\backup D:\Users\sita\Documents pat-doc.txt
call %~dp0\backup "D:\Sourcery G++ Lite"
call %~dp0\backup C:\ProgramData pat-programdata.txt
call %~dp0\backup C:\Users\sita\AppData pat-appdata.txt
call %~dp0\backup D:\Users\sita\BTSync\Goodview pat-btsync.txt
call %~dp0\backup D:\Users\sita\Desktop pat-desktop.txt
call %~dp0\backup D:\cvsroot pat-cvsroot.txt

REM goto exit

:exit
echo Ready to shutdown?
REM pause
REM shutdown /s /t 0

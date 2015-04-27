@echo off

set PCNAME=%1
set ADMPASS=%2
set FIRSTUSER=%3
set FIRSTUSERPASS=%4

if [%PCNAME%]==[] goto exit
if [%ADMPASS%]==[] goto exit
if [%FIRSTUSER%]==[] goto exit
if [%FIRSTUSERPASS%]==[] goto exit


REM 降低密碼難度
call export.sec.bat
REM set PasswordComplexity = 0
notepad sec.cfg
call import.sec.bat

REM 設定電腦名稱
call computername.bat %PCNAME%

REM 更改adm密碼
call passwd.bat administrator %ADMPASS%

REM adm密碼不過期
call neverexpired.bat administrator

REM 新增firstuser
call adduser.bat %FIRSTUSER% %FIRSTUSERPASS%

REM firstuser密碼不過期
call neverexpired.bat %FIRSTUSER%

REM [第二次]給予firstuser管理權限
call addadmin.bat %FIRSTUSER%

REM 打開powerscript功能
call enablepowershellscript.bat

REM 安裝必要功能
call installfeature.bat

REM 使用HVRemote script
call server.bat %FIRSTUSER%

REM open port for rsync
call openport.bat

REM 開啟遠端桌面管理
call rdpon.bat

REM 開啟遠端管理
call remoteon2.bat

goto :EOF

:exit
echo %0 PCNAME ADMPASS FIRSTUSER FIRSTUSERPASS

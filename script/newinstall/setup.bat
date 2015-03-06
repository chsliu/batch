@echo off
if [%PCNAME%]==[] goto exit
if [%ADMPASS%]==[] goto exit
if [%FIRSTUSER%]==[] goto exit
if [%FIRSTUSERPASS%]==[] goto exit

REM set PCNAME=hv3
REM set ADMPASS=1
REM set FIRSTUSER=sita
REM set FIRSTUSERPASS=1

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

REM 給予firstuser管理權限
call addadmin.bat %FIRSTUSER%

REM 安裝必要功能
call installfeature.bat

REM open port
call openport.bat

REM 開啟遠端桌面管理
call rdpon.bat

REM 開啟遠端管理
call remoteon2.bat

:exit

@echo off

set PCNAME=%1
set ADMPASS=%2
set FIRSTUSER=%3
set FIRSTUSERPASS=%4

if [%PCNAME%]==[] goto exit
if [%ADMPASS%]==[] goto exit
if [%FIRSTUSER%]==[] goto exit
if [%FIRSTUSERPASS%]==[] goto exit


echo 降低密碼難度
echo set PasswordComplexity = 0
echo export.sec.bat
call export.sec.bat
notepad sec.cfg
echo import.sec.bat
call import.sec.bat

echo 設定電腦名稱
echo computername.bat %PCNAME%
call computername.bat %PCNAME%

echo 更改adm密碼
echo passwd.bat administrator %ADMPASS%
call passwd.bat administrator %ADMPASS%

echo adm密碼不過期
echo neverexpired.bat administrator
call neverexpired.bat administrator

echo 新增firstuser
echo adduser.bat %FIRSTUSER% %FIRSTUSERPASS%
call adduser.bat %FIRSTUSER% %FIRSTUSERPASS%

echo firstuser密碼不過期
echo neverexpired.bat %FIRSTUSER%
call neverexpired.bat %FIRSTUSER%

echo [第二次]給予firstuser管理權限
echo addadmin.bat %FIRSTUSER%
call addadmin.bat %FIRSTUSER%

echo 打開powerscript功能
echo enablepowershellscript.bat
call enablepowershellscript.bat

echo 安裝必要功能
echo installfeature.bat
call installfeature.bat

echo 使用HVRemote script
echo server.bat %FIRSTUSER%
call server.bat %FIRSTUSER%

echo open port for rsync
echo openport.bat
call openport.bat

echo 開啟遠端桌面管理
echo rdpon.bat
call rdpon.bat

echo 開啟遠端管理
echo remoteon2.bat
call remoteon2.bat

goto :EOF

:exit
echo %0 PCNAME ADMPASS FIRSTUSER FIRSTUSERPASS

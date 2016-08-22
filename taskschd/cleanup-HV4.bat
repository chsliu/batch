REM =================================
goto :main
REM =================================

REM =================================
REM call :REMOVEDIR <dir to remove>
REM call :REMOVEDIR c:\del
REM =================================
:REMOVEDIR
echo Removing %1 ...
rd /q /s %1 >NUL 2>>&1
takeown /f %1 /r /D Y >NUL 2>>&1
rd /q /s %1 >NUL 2>>&1

exit /b

REM =================================
:main
REM =================================

REM rd /s /q E:\DEL

call :REMOVEDIR E:\Shares\Admin\DEL	
call :REMOVEDIR E:\Shares\Library\DEL	
call :REMOVEDIR E:\Shares\Media\DEL
call :REMOVEDIR E:\Shares\NetBackup\DEL
call :REMOVEDIR E:\Shares\Photos\DEL
call :REMOVEDIR E:\Shares\Software\DEL
call :REMOVEDIR E:\Shares\Users\DEL

REM =================================

set path=%path%;"E:\Shares\Admin\PortableApps\Portable Python 2.7.6.1\App"

REM cleanup, keep last 3 dir, debug is 0(off)
echo call E:\Shares\NetBackup\recycle\cleanup.py.cmd 3 0 
call E:\Shares\NetBackup\recycle\cleanup.py.cmd 3 0 


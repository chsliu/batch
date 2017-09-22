REM =================================

REM rd /s /q E:\DEL	
rd /s /q E:\Shares\Admin\DEL	
rd /s /q E:\Shares\Library\DEL	
rd /s /q E:\Shares\Media\DEL
rd /s /q E:\Shares\NetBackup\DEL

REM =================================

set path=%path%;"E:\Shares\Admin\PortableApps\Portable Python 2.7.6.1\App"

REM cleanup, keep last 3 dir, debug is 0(off)
call E:\Shares\NetBackup\recycle\cleanup.py.cmd 3 0 


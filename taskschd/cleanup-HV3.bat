REM =================================

REM rd /s /q E:\DEL	
REM rd /s /q F:\DEL	
rd /s /q E:\Shares\Admin\DEL	
rd /s /q E:\Shares\Games\DEL
rd /s /q E:\Shares\Music\DEL
rd /s /q E:\Shares\NetBackup\DEL
rd /s /q E:\Shares\Photos\DEL
rd /s /q E:\Shares\Software\DEL
rd /s /q E:\Shares\Users\DEL
rd /s /q E:\Shares\Video\DEL
rd /s /q F:\Shares\Library\DEL	
rd /s /q F:\Shares\Media\DEL

REM =================================

set path=%path%;"E:\Shares\Admin\PortableApps\Portable Python 2.7.6.1\App"

REM cleanup, keep last 3 dir, debug is 0(off)
call E:\Shares\NetBackup\recycle\cleanup.py.cmd 3 0 

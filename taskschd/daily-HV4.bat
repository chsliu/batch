REM =================================

REM start /min call e:\Shares\Media\userdata\sendemail.gitsync.bat ^&^& exit

REM =================================

REM start /min call E:\Shares\Software\UNIX\Lubuntu\xbmc\userdata\sendemail.gitsync.bat ^&^& exit

REM =================================

start cmd /u /c "dir /s /b /a:d E:\Shares > E:\Shares\Admin\%COMPUTERNAME%\listdir.e.txt"
start cmd /u /c "dir /s /b  	E:\Shares > E:\Shares\Admin\%COMPUTERNAME%\listfile.e.txt"


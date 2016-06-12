set path=%path%;D:\Users\sita\Documents\tasks\rsync\DeltaCopyRaw

set dst=.

set src=rsync://sitahome.no-ip.org/NetBackup/admin/WS/M/ServerFolders/Users

set options=-avz --progress --chmod=a=rw,Da+x --fake-super --delete 

REM will restore with dir of last segment of src pathname, eg: /Users
REM rsync %options% '%src%' %dst%

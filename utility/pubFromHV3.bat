@echo off
set path=%path%;M:\ServerFolders\Users\admin\tasks\rsync\DeltaCopyRaw
REM set options=-avz --progress --chmod=a=rw,Da+x --fake-super
set options=-avz --progress

set dst=./

set src=rsync://sitahome.no-ip.org/NetBackup/pub


rsync %options% %src% '%dst%'


pause

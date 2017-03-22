@echo off
set path=%path%;M:\ServerFolders\Users\admin\tasks\rsync\DeltaCopyRaw
REM set options=-avz --progress --chmod=a=rw,Da+x --fake-super
set options=-avz --progress

set src=.

set dst=rsync://sitahome.no-ip.org/NetBackup/pub


pushd %1


echo rsync %options% %src% '%dst%'

rsync %options% %src% '%dst%'


popd
pause

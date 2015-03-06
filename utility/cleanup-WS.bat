set path=%path%;"M:\ServerFolders\Users\admin\PortableApps\Portable Python 2.7.2.1\App"

REM =================================

call %~dp0\utility\emptydir.bat M:\ServerFolders\¼È¦s°Ï

REM =================================

rd /s /q M:\DEL 				

REM =================================

pushd %temp% 					& takeown /f . /r  & rd /s /q .  & popd
pushd %temp% & pushd %systemdrive%\recycler	& takeown /f . /r  & rd /s /q .  & popd & popd
pushd %temp% & pushd c:\$Recycle.bin		& takeown /f . /r  & rd /s /q .  & popd & popd
pushd %temp% & pushd m:\$Recycle.bin		& takeown /f . /r  & rd /s /q .  & popd & popd

REM =================================

REM run below first
REM cleanmgr /sageset:99
cleanmgr /sagerun:99

REM =================================

REM cleanup, keep last 3 dir, debug is 0(off)
call M:\ServerFolders\NetBackup\recycle\cleanup.py.cmd 3 0 


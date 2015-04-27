REM =================================

rd /s /q M:\DEL 				

REM =================================

pushd %temp% & pushd M:\ServerFolders\¼È¦s°Ï	& takeown /f . /r & rd /s /q . & popd & popd

REM =================================

set path=%path%;"M:\ServerFolders\Users\admin\PortableApps\Portable Python 2.7.2.1\App"

REM cleanup, keep last 3 dir, debug is 0(off)
call M:\ServerFolders\NetBackup\recycle\cleanup.py.cmd 3 0 


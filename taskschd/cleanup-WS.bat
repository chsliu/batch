REM =================================

goto Main:

REM =================================
:EMPTYDIR
pushd %1 || exit /b
echo Emptying %1 ...
rd /q /s . >NUL 2>>&1
takeown /f . /r /D Y >NUL 2>>&1
rd /q /s . >NUL 2>>&1
popd

exit /b

REM =================================
Main:
REM =================================

REM rd /s /q M:\DEL 				

REM =================================

REM pushd %temp% & pushd M:\ServerFolders\�Ȧs��	& takeown /f . /r & rd /s /q . & popd & popd
call :EMPTYDIR M:\ServerFolders\�Ȧs��

REM =================================

set path=%path%;"M:\ServerFolders\Users\admin\PortableApps\Portable Python 2.7.2.1\App"

REM cleanup, keep last 3 dir, debug is 0(off)
call M:\ServerFolders\NetBackup\recycle\cleanup.py.cmd 3 0 


REM =================================

rd /s /q C:\DEL
rd /s /q D:\DEL

REM =================================

pushd %windir%\temp 	  			& takeown /f . /r & rd /s /q . & popd
pushd %temp% 					& takeown /f . /r & rd /s /q . & popd
pushd %temp% & pushd %systemdrive%\recycler	& takeown /f . /r & rd /s /q . & popd & popd
pushd %temp% & pushd c:\$Recycle.bin		& takeown /f . /r & rd /s /q . & popd & popd
pushd %temp% & pushd d:\$Recycle.bin		& takeown /f . /r & rd /s /q . & popd & popd

REM =================================

REM run below first
REM cleanmgr /sageset:99
cleanmgr /sagerun:99


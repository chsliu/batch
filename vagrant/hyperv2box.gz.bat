@echo off
set path=%path%;d:\Users\sita\Documents\tasks\bin

pushd %1 || exit /b


dir "Virtual Hard Disks\*.vhdx"
powershell -command "Optimize-vhd -Mode Full -path 'Virtual Hard Disks\*.vhdx'"
dir "Virtual Hard Disks\*.vhdx"


7za a -ttar "%~n1.tar" *
7za a -tgzip -r -y "..\%~n1.box" "%~n1.tar"
del "%~n1.tar"
dir "..\%~n1.box"


popd

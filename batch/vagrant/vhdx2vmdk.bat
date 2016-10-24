@echo off
set path=%path%;C:\Program Files\Oracle\VirtualBox

echo Converting %1 to vmdk format
powershell -command "Convert-VHD %~n1.vhdx disk.vhd"

dir %~n1.vhdx
REM del %~n1.vhdx
dir disk.vhd


vboxmanage clonehd disk.vhd %~n1.vmdk --format vmdk

del disk.vhd
dir %~n1.vmdk

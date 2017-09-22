@echo off
set path=%path%;C:\Program Files\Oracle\VirtualBox

echo Converting %1 to vhd format
vboxmanage clonehd %1 disk.vhd --format vhd

dir %1
dir disk.vhd

powershell -command "Convert-VHD disk.vhd disk.vhdx"

del disk.vhd
dir disk.vhdx

powershell -command "Optimize-vhd -Mode Full -path disk.vhdx"

dir disk.vhdx

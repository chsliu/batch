@echo off

Echo "Get-Volume"							
powershell -command "if (Get-Command Get-Volume -errorAction SilentlyContinue) {Get-Volume | Format-Table -Auto}"		
Echo "Get-VirtualDisk"							
powershell -command "if (Get-Command Get-VirtualDisk -errorAction SilentlyContinue) {Get-VirtualDisk | Format-Table -Auto}"	

Echo "Get-StoragePool"							
powershell -command "if (Get-Command Get-StoragePool -errorAction SilentlyContinue) {Get-StoragePool | Format-Table -Auto}"	

Echo "Get-PhysicalDisk"							
powershell -command "if (Get-Command Get-PhysicalDisk -errorAction SilentlyContinue) {Get-PhysicalDisk | Format-Table -Auto}"	


rem E:\Shares\Admin\PortableApps\OpenHardwareMonitor\OpenHardwareMonitor.exe

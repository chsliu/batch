@echo off

Echo "Get-StoragePool"
powershell -command "Get-StoragePool | Format-Table -Auto"

Echo "Get-VirtualDisk"
powershell -command "Get-VirtualDisk | Format-Table -Auto"

Echo "Get-Volume"
powershell -command "Get-Volume | Format-Table -Auto"

Echo "Get-PhysicalDisk"
powershell -command "Get-PhysicalDisk | Format-Table -Auto"


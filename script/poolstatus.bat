@echo off

Echo "Get-StoragePool"
powershell -command "Get-StoragePool"

Echo "Get-VirtualDisk"
powershell -command "Get-VirtualDisk"

Echo "Get-Volume"
powershell -command "Get-Volume"

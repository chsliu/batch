powershell -command "Repair-VirtualDisk -FriendlyName disk2"

rem powershell -command "Get-VirtualDisk | Where-Object ¡VFilterScript {$_.HealthStatus -Eq "Warning"} | Repair-VirtualDisk"


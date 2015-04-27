powershell -command "Repair-VirtualDisk -FriendlyName disk2"

rem powershell -command "Get-VirtualDisk | Where-Object -FilterScript {$_.HealthStatus -Eq "Warning"} | Repair-VirtualDisk"


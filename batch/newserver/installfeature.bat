
rem powershell -command "Get-WindowsFeature"
powershell -command "Install-WindowsFeature FS-FileServer"
rem powershell -command "Install-WindowsFeature WindowsStorageManage"
powershell -command "Remove-WindowsFeature Telnet-Client"

powershell -command "Get-WindowsFeature"

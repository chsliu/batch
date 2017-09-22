netsh advfirewall set allprofiles settings remotemanagement enable

REM RDP
netsh advfirewall firewall set rule group=遠端桌面 new enable=yes
netsh advfirewall firewall set rule group="Remote Desktop" new enable=yes

REM Event Viewer
Netsh advfirewall firewall set rule group="Remote Event Log Management" new enable=yes

REM Services
netsh advfirewall firewall set rule group=遠端服務管理 new enable=yes
netsh advfirewall firewall set rule group="Remote Services Management" new enable=yes

REM Shared Folders
Netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes

REM Task Scheduler
Netsh advfirewall firewall set rule group="Remote Scheduled Tasks Management" new enable=yes

REM Reliability and Performance
Netsh advfirewall firewall set rule group="Performance Logs and Alerts" new enable=yes

REM Disk Management
Netsh advfirewall firewall set rule group="遠端磁碟區管理" new enable=yes
Netsh advfirewall firewall set rule group="Remote Volume Management" new enable=yes

REM Windows Firewall
Netsh advfirewall firewall set rule group="Windows Firewall Remote Management" new enable=yes


REM 使用遠端桌面管理 Server Core 伺服器
cscript %windir%\system32\scregedit.wsf /AR 0
REM 舊版 Windows 上執行遠端桌面服務用戶端
cscript %windir%\system32\scregedit.wsf /CS 0 

REM 設定此電腦以接受來自其他電腦的 (WS-Management) WS-Management 要求。
winrm quickconfig -q


netsh firewall set service type=remoteadmin mode=enable
Netsh advfirewall firewall set rule group="Remote Administration" new enable=yes

netsh advfirewall firewall set rule group="Windows Remote Management" new enable=yes

netsh advfirewall firewall set rule group="Windows Management Instrumentation (WMI)" new enable=yes


REM RDP
netsh advfirewall firewall set rule group=遠端桌面 new enable=yes
netsh advfirewall firewall set rule group="Remote Desktop" new enable=yes


REM 使用遠端桌面管理 Server Core 伺服器
cscript %windir%\system32\scregedit.wsf /AR 0
REM 舊版 Windows 上執行遠端桌面服務用戶端
cscript %windir%\system32\scregedit.wsf /CS 0 

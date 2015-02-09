powershell -command "Enable-NetFirewallRule -DisplayGroup 'Windows Remote Management'"
powershell -command "Enable-NetFirewallRule -DisplayGroup 'Remote Event Log Management'"
powershell -command "Enable-NetFirewallRule -DisplayGroup 'Remote Volume Management'"
powershell -command "Set-Service VDS -StartupType Automatic"

echo.
echo Press any key to Reboot...
echo.
pause

shutdown /r /t 0

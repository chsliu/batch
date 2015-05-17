if [%1]==[] ( 
  set day=1 
) else (
  set day=%1
)

powershell -command "Get-WinEvent -LogName System | ? { ($_.Message -like '*restart*') -and ($_.TimeCreated -gt (Get-Date).AddDays(-%day%)) } | FL"

powershell -command "Get-WinEvent -LogName System | ? { ($_.Message -like '*logon*') -and ($_.TimeCreated -gt (Get-Date).AddDays(-%day%)) } | FL"

powershell -command "Get-WinEvent -LogName Microsoft-Windows-Stor* | ? { ($_.Level -lt 4) -and ($_.TimeCreated -gt (Get-Date).AddDays(-%day%)) } | FL"

powershell -command "Get-WinEvent -LogName Microsoft-Windows-Stor* | ? { ($_.Message -like '*repair*') -and ($_.TimeCreated -gt (Get-Date).AddDays(-%day%)) } | FL"

powershell -command "Get-EventLog -LogName System -Source Disk -After (Get-Date).AddDays(-%day%) | ? EntryType -ne "Information" | FL"

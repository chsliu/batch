if [%1]==[] ( 
  set day=1 
) else (
  set day=%1
)

echo ---------------------------------------------------------------
echo Get-WinEvent -LogName System -like '*restart*', AddDays(-%day%)
echo ---------------------------------------------------------------
powershell -command "Get-WinEvent -LogName System | ? { ($_.Message -like '*restart*') -and ($_.TimeCreated -gt (Get-Date).AddDays(-%day%)) } | FL"

echo -------------------------------------------------------------
echo Get-WinEvent -LogName System -like '*logon*', AddDays(-%day%)
echo -------------------------------------------------------------
powershell -command "Get-WinEvent -LogName System | ? { ($_.Message -like '*logon*') -and ($_.TimeCreated -gt (Get-Date).AddDays(-%day%)) } | FL"

echo ---------------------------------------------------------------------------
echo Get-WinEvent -LogName Microsoft-Windows-Stor*, Level -lt 4, AddDays(-%day%)
echo ---------------------------------------------------------------------------
powershell -command "Get-WinEvent -LogName Microsoft-Windows-Stor* | ? { ($_.Level -lt 4) -and ($_.TimeCreated -gt (Get-Date).AddDays(-%day%)) } | FL"

echo -------------------------------------------------------------------------------
echo Get-WinEvent -LogName Microsoft-Windows-Stor* -like '*repair*', AddDays(-%day%)
echo -------------------------------------------------------------------------------
powershell -command "Get-WinEvent -LogName Microsoft-Windows-Stor* | ? { ($_.Message -like '*repair*') -and ($_.TimeCreated -gt (Get-Date).AddDays(-%day%)) } | FL"

echo ---------------------------------------------------------------------------
echo Get-EventLog -LogName System -Source Disk, AddDays(-%day%), -ne Information
echo ---------------------------------------------------------------------------
powershell -command "Get-EventLog -LogName System -Source Disk | ? { $_.TimeCreated -gt (Get-Date).AddDays(-%day%) } | ? EntryType -ne "Information" | FL"

echo --------------------------------------------------------------------------------------------------
echo Get-WinEvent -ProviderName *Disk*,*Ntfs*,*Spaces*,*Chk*,*Defrag*, AddDays(-%day%), -ne Information
echo --------------------------------------------------------------------------------------------------
powershell -command "Get-WinEvent -ProviderName *Disk*,*Ntfs*,*Spaces*,*Chk*,*Defrag* | ? { $_.TimeCreated -gt (Get-Date).AddDays(-%day%) }  | ? EntryType -ne "Information" | FL"

wmic path win32_networkadapter where index=1 call disable

wmic path win32_networkadapter where index=1 call enable

pause

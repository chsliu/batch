netsh wlan set hostednetwork mode=allow ssid=%COMPUTERNAME% key=goodview

netsh wlan start hostednetwork

echo Press Any Key To Stop
pause

netsh wlan stop hostednetwork

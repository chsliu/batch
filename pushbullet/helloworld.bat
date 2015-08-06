@echo off
echo getdevices ...
python pushbullet_cmd.py UR97NWpn7i61jqO0BQkyZWQhaNmfGe8t getdevices

echo.
echo sending test message ...
python pushbullet_cmd.py UR97NWpn7i61jqO0BQkyZWQhaNmfGe8t note ufjW6eNsjz3KRxFVWm "Hello" "Hello World!!!"

pause

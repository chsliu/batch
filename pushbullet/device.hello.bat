@echo off

if [%1]==[] goto :EOF

python pushbullet_cmd.py UR97NWpn7i61jqO0BQkyZWQhaNmfGe8t note %1 "%~nx0" "Hello %1!!!"


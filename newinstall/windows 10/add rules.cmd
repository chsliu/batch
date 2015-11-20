@echo off
cls
echo Block Telemetry Firewall Rules 
echo Confirm the UAC prompt to continue.
echo.
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dp0.\rules.ps1""' -Verb RunAs}"
echo Rules should be included in Firewall.
echo.
pause
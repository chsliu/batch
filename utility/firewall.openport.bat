@echo off

REM =================================
REM if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
if [%1]==[] goto :EOF

REM =================================
netsh advfirewall firewall del rule name="Open Port %1"

netsh advfirewall firewall add rule name="Open Port %1" dir=in action=allow protocol=TCP localport=%1

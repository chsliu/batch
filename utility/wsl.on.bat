@echo off

Echo "Enable Windows Subsystem for Linux"
powershell -command "Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux"


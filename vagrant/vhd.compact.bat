@echo off

echo Compressing %1

dir %1

powershell -command "Optimize-vhd -Mode Full -path '%1'"

dir %1

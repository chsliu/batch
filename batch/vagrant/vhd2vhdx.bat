@echo off

echo Converting %1 to vhdx format
powershell -command "Convert-VHD '%~pn1.vhd' '%~pn1.vhdx'"

dir "%~pn1.vhd"
del "%~pn1.vhd"
dir "%~pn1.vhdx"

powershell -command "Optimize-vhd -Mode Full -path '%~pn1.vhdx'"

dir "%~pn1.vhdx"

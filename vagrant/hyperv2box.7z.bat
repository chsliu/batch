set path=%path%;d:\Users\sita\Documents\tasks\bin

pushd %1 || exit /b

REM powershell -command "Optimize-vhd -Mode Full -path 'Virtual Hard Disks\*.vhd'"

powershell -command "Optimize-vhd -Mode Full -path 'Virtual Hard Disks\*.vhdx'"

REM 7za a -tzip -r -y -mx9 -aoa ..\"%1.box" *

7za a -t7z -r -y "..\%1.box" *

popd

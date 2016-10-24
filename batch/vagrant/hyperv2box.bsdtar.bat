set path=%path%;C:\HashiCorp\Vagrant\embedded\mingw\bin\

pushd %1 || exit /b

powershell -command "Optimize-vhd -Mode Full -path 'Virtual Hard Disks\*.vhdx'"

REM bsdtar --numeric-owner -czvmf "..\%1.box" *
REM bsdtar --numeric-owner --lzma -cvmf "..\%1.box" *
bsdtar --numeric-owner --xz -cvmf "..\%1.box" *

bsdtar -tf "..\%1.box"

popd

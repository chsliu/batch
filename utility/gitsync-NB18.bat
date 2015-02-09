@echo off
pushd %~dp0
set path=%path%;D:\Users\yoz\PortableApps\GitPortable\App\Git\bin


git pull
git push


popd
pause

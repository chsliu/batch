@echo off
pushd %~dp0
set path=%path%;C:\Users\sita\PortableApps\GitPortable\App\Git\bin


git pull
git push


popd
pause

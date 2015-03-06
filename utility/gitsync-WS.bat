@echo off
pushd %~dp0
set path=%path%;M:\ServerFolders\Users\admin\PortableApps\GitPortable\App\Git\bin


git pull
git push


popd
pause

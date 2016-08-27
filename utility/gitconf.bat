REM @echo on

set _=%~dp0\..\taskschd\gitsync-%COMPUTERNAME%.bat
if exist %_% call %_%

git config --global user.email "chsliu@gmail.com"

git config --global user.name "Sita Liu"

git config --global credential.helper wincred

git config --global push.default matching

git config --global core.autocrlf false

REM @echo off

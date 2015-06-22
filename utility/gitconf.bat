call %~dp0\..\taskschd\gitsync-%COMPUTERNAME%.bat

git config --global user.email "chsliu@gmail.com"

git config --global user.name "Sita Liu"

git config --global credential.helper wincred

git config --global push.default matching

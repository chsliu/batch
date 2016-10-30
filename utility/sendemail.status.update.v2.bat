@echo off

set PROJ=sendemail.status
set TEMPPATH=%temp%\%PROJ%
set ZIP="%~dp0\%PROJ%.zip"
set DSTPATH=D:\Users\sita\Dropbox\Public

mkdir %TEMPPATH%
mkdir %TEMPPATH%\bin
copy %~dp0\..\bin\sendEmail.exe %TEMPPATH%\bin
copy %~dp0\..\bin\coreinfo.exe %TEMPPATH%\bin
copy %~dp0\..\bin\smartctl.exe %TEMPPATH%\bin
mkdir %TEMPPATH%\utility
copy %~dp0\%PROJ%.bat %TEMPPATH%\utility
copy %~dp0\getadmin.bat %TEMPPATH%\utility

powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; try { [IO.Compression.ZipFile]::CreateFromDirectory('%TEMPPATH%', '%ZIP%'); } catch { exit 1; } }" 
move /y %ZIP% %DSTPATH%
copy /y %~dp0\run.v2.bat %DSTPATH%

rd /s /q %TEMPPATH%

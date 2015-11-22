@echo off

set path=%path%;%~dp0\..\bin
set PROJ=sendemail.status
set TEMPPATH=%temp%\%PROJ%
set DSTPATH=D:\Users\sita\Dropbox\Public

mkdir %TEMPPATH%
mkdir %TEMPPATH%\bin
mkdir %TEMPPATH%\utility
copy %~dp0\%PROJ%.bat %TEMPPATH%\utility
copy %~dp0\..\bin\sendEmail.exe %TEMPPATH%\bin
copy %~dp0\getadmin.bat %TEMPPATH%\utility
copy %~dp0\..\bin\coreinfo.exe %TEMPPATH%\bin
copy %~dp0\..\bin\smartctl.exe %TEMPPATH%\bin

7za a -mx9 %~dp0\%PROJ%.7z %TEMPPATH%
move %~dp0\%PROJ%.7z %DSTPATH%
copy %~dp0\7z-run.bat %DSTPATH%

rd /s /q %TEMPPATH%

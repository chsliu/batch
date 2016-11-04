@echo off

set path=%path%;%~dp0\..\bin
set PROJ=sendemail.uptimelog
set TEMPPATH=%temp%\%PROJ%
set DSTPATH=D:\Users\sita\Dropbox\Public

mkdir %TEMPPATH%
mkdir %TEMPPATH%\bin
copy %~dp0\..\bin\sendEmail.exe %TEMPPATH%\bin
mkdir %TEMPPATH%\utility
copy %~dp0\%PROJ%.bat %TEMPPATH%\utility

7za a -mx9 %~dp0\%PROJ%.7z %TEMPPATH%
move %~dp0\%PROJ%.7z %DSTPATH%
copy %~dp0\run.bat %DSTPATH%

rd /s /q %TEMPPATH%

@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
imdisk -a -s 512M -m T: -p "/fs:ntfs /v:MemDisk /q /y"

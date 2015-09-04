@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

REM aida64-engineer 
REM apple_airport_utility
REM as-ssd
REM disk2vhd
REM easybcd
REM filezilla
REM hdtune
REM imgburn 
REM no-ip-duc
REM partitionassistant
REM spacesniffer
REM sysinternals
REM tightvnc
REM treesizefree
REM ultravnc
REM usbit
REM windirstat
REM winimage 
REM angryip

cinst -y cpu-z crystaldiskinfo crystaldiskmark netscan64 putty winscp wireshark

rem pause

C:\Windows\System32\timeout.exe 10

@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files\Git\cmd
set DOC="%USERPROFILE%\My Documents"
set TASKS=%DOC%\tasks
set SCHEDULE=16:30-17:00-17:30
set DAILY=%SCHEDULE:~0,5%
set WEEKLY=%SCHEDULE:~6,5%
set MONTHLY=%SCHEDULE:~12,5%
set PASS=1

REM =================================
REM wmic computersystem where name="%COMPUTERNAME%" call rename name=%1

REM =================================
REM net user sita %PASS% /add
REM
REM === Change user to administrator
REM
REM control userpasswords2
REM 
REM gpedit.msc

REM =================================
REM === Install powershell

REM =================================
REM === Windwos Update

REM =================================

powershell -command "set-executionpolicy remotesigned"

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

cinst -y 7zip git python2 teraterm notepadplusplus tortoisehg 

REM =================================

mkdir %DOC%
cd/d %DOC%
git clone https://github.com/chsliu/batch.git tasks

SchTasks /Create /RU %USERNAME% /RP %PASS% /SC ONSTART /TN "%USERNAME%-startup" /TR %TASKS%\startup.bat
SchTasks /Create /RU %USERNAME% /RP %PASS% /SC DAILY /TN "%USERNAME%-daily" /TR %TASKS%\daily.bat /ST %DAILY%:00
SchTasks /Create /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "%USERNAME%-weekly" /TR %TASKS%\weekly.bat /ST %WEEKLY%:00
SchTasks /Create /RU %USERNAME% /RP %PASS% /SC MONTHLY /MO LAST /D FRI /TN "%USERNAME%-monthly" /TR %TASKS%\monthly.bat /ST %MONTHLY%:00

REM =================================

rem pause

REM C:\Windows\System32\timeout.exe 10

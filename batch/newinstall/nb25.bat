@echo off

REM =================================
REM === First time run with Administrators Prompt ===
REM =================================
if exist %~dp0\..\utility\getadmin.bat (
    echo Run again with Administrators Prompt 
    if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"
) else (
    echo ========================
    echo Must run with Administrators Prompt 
    echo ========================
)

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd
set DOC=c:\Users\%USERNAME%\Downloads
set TASKS=%DOC%\tasks
set SCHEDULE=16:30-17:00-17:30
set DAILY=%SCHEDULE:~0,5%
set WEEKLY=%SCHEDULE:~6,5%
set MONTHLY=%SCHEDULE:~12,5%
set PASS=1

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

cinst -y 7zip cmder cpu-z crystaldiskinfo dropbox everything foxitreader git google-chrome-x64 Gow ImDisk-Toolkit imgburn kodi meld msysgit netscan64 notepadplusplus openhardwaremonitor potplayer python2 rsync steam teamviewer vagrant virtualbox winbox wireshark

cinst -y discord line processhacker synergy telegram ultraedit wechat

REM cinst -y openssh -params '"/SSHServerFeature"'

REM =================================

mkdir %DOC%
cd/d %DOC%
git clone https://github.com/chsliu/batch.git tasks

SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC ONSTART /TN "%USERNAME%-startup" /TR "%TASKS%\startup.bat"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC DAILY /TN "%USERNAME%-daily" /TR "%TASKS%\daily.bat" /ST %DAILY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "%USERNAME%-weekly" /TR "%TASKS%\weekly.bat" /ST %WEEKLY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC MONTHLY /MO LAST /D FRI /TN "%USERNAME%-monthly" /TR "%TASKS%\monthly.bat" /ST %MONTHLY%

REM =================================

REM cd/d tasks
REM git clone https://github.com/chsliu/ShooterSubPyDownloader.git

REM =================================

REM call %~dp0\newinstall.kodi.bat

REM =================================
setx path "%path%;C:\Users\sita\Downloads\tasks\batch\alias"

REM =================================

REM pause

C:\Windows\System32\timeout.exe 10

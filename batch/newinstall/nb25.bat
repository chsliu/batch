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

cinst -y 7zip bind-toolsonly Cmder cpu-z crystaldiskinfo crystaldiskmark discord dropbox Everything everything filezilla foxitreader git github-desktop GoogleChrome Gow ImDisk-Toolkit imgburn kodi line meld msysgit netscan64 nextcloud-client notepadplusplus openhardwaremonitor potplayer processhacker putty python2 rsync steam synergy teamviewer telegram ultraedit vagrant virtualbox VirtualBox.ExtensionPack vscode wechat winbox wireshark

REM anydesk
REM atom
REM autohotkey
REM filebot
REM Firefox
REM gitkraken
REM hugo
REM nginx
REM ngrok
REM nodejs
REM nssm
REM sourcetree
REM sublimetext3
REM teraterm
REM typora
REM wsl-ubuntu-2004

REM # Visual C++ Build Tools 2015
REM microsoft-visual-cpp-build-tools
REM # Visual C++ Build Tools 2015
REM VisualCppBuildTools
REM # Visual Studio 2017
REM microsoft-build-tools
REM # Visual C++ Build Tools 2017
REM visualcpp-build-tools
REM # Visual Studio Installer 2017 2019
REM visualstudio-installer
REM # Visual Studio 2017 Build Tools
REM visualstudio2017buildtools
REM # Visual Studio 2019 Build Tools
REM visualstudio2019buildtools

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
REM increase limit to 2048
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v Test /d 12345

REM broadcast WM_SETTINGCHANGE
setx /M USERNAME %USERNAME%

REM append to path
setx path "%path%;C:\Users\sita\Downloads\tasks\batch\alias"

REM =================================
REM enter github credential
if exist %~dp0\..\..\utility\gitsync.bat (
	call %~dp0\..\..\utility\gitsync.bat
)

REM =================================

REM pause

C:\Windows\System32\timeout.exe 10

@echo off

REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd
set DOC=%USERPROFILE%\Documents
set TASKS=%DOC%\tasks
set SCHEDULE=06:05-06:35-07:05
set DAILY=%SCHEDULE:~0,5%
set WEEKLY=%SCHEDULE:~6,5%
set MONTHLY=%SCHEDULE:~12,5%
set PASS=1

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

REM classic-shell
REM foxitreader
REM gow
REM hg
REM line
REM listary
REM mp3tag
REM netscan64
REM nimbletext
REM paint.net
REM teraterm
REM visualstudioexpress2008
REM windowsliveinstaller
REM winmerge 

cinst -y 7zip cmder cpu-z crystaldiskinfo crystaldiskmark dropbox everything f.lux filebot firefox git github google-chrome-x64 kodi notepadplusplus potplayer putty python2 skype teamviewer winscp wireshark

REM =================================

mkdir %DOC%
cd/d %DOC%
git clone https://github.com/chsliu/batch.git tasks

SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC ONSTART /TN "%USERNAME%-startup" /TR "%TASKS%\startup.bat"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC DAILY /TN "%USERNAME%-daily" /TR "%TASKS%\daily.bat" /ST %DAILY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "%USERNAME%-weekly" /TR "%TASKS%\weekly.bat" /ST %WEEKLY%
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC MONTHLY /MO LAST /D FRI /TN "%USERNAME%-monthly" /TR "%TASKS%\monthly.bat" /ST %MONTHLY%

REM =================================

cd/d tasks
git clone https://github.com/chsliu/ShooterSubPyDownloader.git

REM =================================

call %~dp0\newinstall.kodi.bat

REM =================================

rem pause

C:\Windows\System32\timeout.exe 10

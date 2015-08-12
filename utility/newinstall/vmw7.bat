@echo off

REM =================================
if [%1]==[] %~dp0\..\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;C:\Program Files (x86)\Git\cmd
set DOC=d:\Users\%USERNAME%\Documents
set TASKS=%DOC%\tasks
set PASS=1

REM =================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM =================================

choco feature enable -nautoUninstaller

cinst -y 7zip emule everything filebot git google-chrome-x64 jdownloader no-ip-duc picasa python2 putty winscp

REM =================================

mkdir %DOC%
cd/d %DOC%
git clone https://github.com/chsliu/batch.git tasks

SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC ONSTART /TN "startup-%USERNAME%" /TR "%TASKS%\startup.bat"
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC DAILY /TN "daily-%USERNAME%" /TR "%TASKS%\daily.bat" /ST 16:30
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC WEEKLY /D FRI /TN "weekly-%USERNAME%" /TR "%TASKS%\weekly.bat" /ST 17:00
SchTasks /Create /F /RL HIGHEST /RU %USERNAME% /RP %PASS% /SC MONTHLY /MO LAST /D FRI /TN "monthly-%USERNAME%" /TR "%TASKS%\monthly.bat" /ST 17:30

REM =================================

rem pause

C:\Windows\System32\timeout.exe 10

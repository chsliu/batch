@echo off

REM =================================
git config --global user.email "chsliu@gmail.com"

git config --global user.name "Sita Liu"

git config --global credential.helper wincred

git config --global push.default matching

git config --global core.autocrlf false

REM =================================
REM get date and time 

for /f "delims=" %%a in ('date/t') do set mydate=%%a 
for /f "delims=" %%a in ('time/t') do set mytime=%%a 
set var=%mydate%%mytime% 

REM =================================
pushd %~dp0

REM =================================

git add -A :/

git commit -a -m "Automated commit at %var% on %COMPUTERNAME%"

git pull	

git push	

git stash list

REM =================================
popd

REM =================================
REM Only pause if running by self
REM =================================
echo %CMDCMDLINE% | C:\Windows\System32\find.exe /I /c "%~nx0"
if "%ERRORLEVEL%" NEQ "0" goto :EOF

REM =================================
C:\Windows\System32\timeout.exe 10



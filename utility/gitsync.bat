@echo off

REM =================================

set _=%~dp0\..\taskschd\%~n0-%COMPUTERNAME%.bat
if exist %_% call %_%

REM =================================

pushd %~dp0\..

REM =================================

REM get date and time 
for /f "delims=" %%a in ('date/t') do @set mydate=%%a 
for /f "delims=" %%a in ('time/t') do @set mytime=%%a 
set var=%mydate%%mytime% 

REM =================================

call %~dp0\..\utility\gitconf.bat

REM =================================

git pull

git add . --all
git commit -a -m "Automated commit at %var% on %COMPUTERNAME%" 
git push

REM =================================

popd

REM =================================

rem pause

C:\Windows\System32\timeout.exe 10

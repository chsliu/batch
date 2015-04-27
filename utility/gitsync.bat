REM =================================
@echo off

REM =================================
pushd %~dp0

REM =================================
REM get date and time 
for /f "delims=" %%a in ('date/t') do @set mydate=%%a 
for /f "delims=" %%a in ('time/t') do @set mytime=%%a 
set var=%mydate%%mytime% 

REM =================================
git pull

git add .
call git commit -a -m "Automated commit at %var% on %COMPUTERNAME%" 
git push

REM =================================
popd

REM =================================
rem pause

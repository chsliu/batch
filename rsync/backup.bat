@echo off
set path=%path%;%~dp0

if [%1] == [] GOTO usage
if [%2] == [] (set PATTERNS=patterns.txt) else (set PATTERNS=%2)
goto main

REM =================================
:usage
echo backup [dir] [pattern files]
goto :EOF


REM =================================
:main
REM =================================
set tempbat=%~dp0\host-%COMPUTERNAME%.bat
if not exist %tempbat% (
  echo %tempbat% not found
  goto :EOF
)
call %tempbat%
set CYGWIN=nodosfilewarning
set drive=%~d1

REM =================================
REM set log="%~dp0\log\rsync.%drive:~0,1%.%~n1.txt"
REM if not exist "%~dp0\log" mkdir "%~dp0\log"
REM del %log%
set log="%temp%\rsync.%drive:~0,1%.%~n1.txt"

REM =================================
if not exist %1 (
  echo %1 not found
  goto :EOF
)

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%

REM =================================
REM u: user
REM g: group -> user
REM o: other -> user
REM a: all
REM 
REM r: read
REM w: write
REM x: execute
REM X: Execute/search
REM s: system file
REM t: temporary file
set options=-avzy --progress --chmod=a=rw,Da+x --fake-super --no-owner --no-group --omit-dir-times --delete-after --delete-excluded --exclude-from '%~dp0%PATTERNS%' --backup --backup-dir='/recycle/%MONTH%/%TODAY%/%USERNAME%/%COMPUTERNAME%/%drive:~0,1%/%~n1'

REM =================================
echo ================================
pushd %1
set src=.
if not "%local%"=="" (
echo Backing up %1 on %local%
set temppath=\\%local%\%hostpath%\%USERNAME%\%COMPUTERNAME%\%drive:~0,1%\
if not exist "%temppath%" mkdir "%temppath%"
set dst=rsync://%local%/%hostpath%/%USERNAME%/%COMPUTERNAME%/%drive:~0,1%/%~n1
) else (
echo Backing up %1 on %host%
set dst=rsync://%host%/%hostpath%/%USERNAME%/%COMPUTERNAME%/%drive:~0,1%/%~n1
)

REM =================================
echo [Backup %1 "%~f1" ] >> %log%
echo %~dp0\DeltaCopyRaw\rsync %options% %src% '%dst%' >> %log%
%~dp0\DeltaCopyRaw\rsync %options% %src% '%dst%' 2>> %log%

REM =================================
rem sendemail -s msa.hinet.net -f chsliu@gmail.com -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 %~n1 -a %log% -m %0 %1 %2

type %log%

del %log%

REM =================================
popd

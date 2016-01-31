REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
goto :main

REM =================================
REM call :whereis <exe> <Location Variable>
REM call :whereis wmic.exe WMIC
REM =================================
:whereis
set %2=
for %%X in (%1) do (set %2=%%~$PATH:X)

exit /b

REM =================================
REM call :getsize <file> <Size Variable>
REM call :getsize %LOG1% size
REM =================================
:getsize
set %2=
FOR /F "usebackq" %%A IN ('%1') DO set %2=%%~zA

exit /b

REM =================================
:main
REM =================================
set path=%path%;%~dp0\..\bin

REM =================================
call :whereis wmic.exe WMIC

REM =================================
REM set host=%1
REM if [%1]==[] set host=%COMPUTERNAME%

REM =================================
set LOG1=%temp%\%~n0-%COMPUTERNAME%.html
set LOG2=%temp%\%~n0-%COMPUTERNAME%.txt 
set TXT1=%temp%\%~n0.txt

REM =================================
if not defined WMIC goto :MyDateEnd

wmic /node:%COMPUTERNAME% computersystem get model,name,username,domain /format:htable > %LOG1%
wmic /node:%COMPUTERNAME% startup list full /format:htable >> %LOG1%
wmic /node:%COMPUTERNAME% process get description,processid,parentprocessid,commandline /format:htable >> %LOG1%
wmic /node:%COMPUTERNAME% service get name,processid,startmode,state,status,pathname /format:htable >> %LOG1%
wmic /node:%COMPUTERNAME% job list full /format:htable >> %LOG1%

:MyDateEnd

REM =================================
call :getsize %LOG1% size

if %size% EQU 0 (
set LOG1=
)

REM =================================
echo =======================>> %LOG2%
echo ipconfig /displaydns   >> %LOG2%
echo =======================>> %LOG2%
ipconfig /displaydns 		>> %LOG2%

echo ===============>> %LOG2%
echo netstat -abno  >> %LOG2%
echo ===============>> %LOG2%
netstat -abno 		>> %LOG2%

REM =================================
call :getsize %LOG2% size

if %size% EQU 0 (
set LOG2=
)

REM =================================
copy %0 %TXT1% >nul

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %LOG2% %TXT1%

del %LOG1% %LOG2% %TXT1%

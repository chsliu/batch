REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
set path=%path%;%~dp0\..\bin

REM =================================
REM set host=%1
REM if [%1]==[] set host=%COMPUTERNAME%

REM =================================
set LOG1=%temp%\%~n0-%COMPUTERNAME%.html
set LOG2=%temp%\%~n0-%COMPUTERNAME%.txt 
set TXT1=%temp%\%~n0.txt

REM =================================
wmic /node:%COMPUTERNAME% computersystem get model,name,username,domain /format:htable > %LOG1%
wmic /node:%COMPUTERNAME% startup list full /format:htable >> %LOG1%
wmic /node:%COMPUTERNAME% process get description,processid,parentprocessid,commandline /format:htable >> %LOG1%
wmic /node:%COMPUTERNAME% service get name,processid,startmode,state,status,pathname /format:htable >> %LOG1%
wmic /node:%COMPUTERNAME% job list full /format:htable >> %LOG1%

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
copy %0 %TXT1% >nul

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %LOG2% %TXT1%

del %LOG1% %LOG2% %TXT1%

REM =================================
set path=%path%;%~dp0\..\bin

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================

set LOG1=%temp%\killhale-%TODAY%.txt
set TXT1=%temp%\%~n0.txt

echo %DATE%%TIME% 				>%LOG1%

REM =================================
taskkill /F /T /IM hale.exe			>>%LOG1% 2>>&1

sc config WSearch start= disabled		>>%LOG1% 2>>&1
taskkill /F /T /IM SearchIndexer.exe		>>%LOG1% 2>>&1

REM =================================
copy %0 %TXT1% >nul

for /f %%a in ('type "%LOG1%"^|find "ERROR:" /v /c') do set /a cnt=%%a

if %cnt% lss 2 (
  rem echo %LOG1% has %cnt% lines
  sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %TXT1%
) 

del %LOG1% %TXT1%

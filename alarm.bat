set path=%path%;%~dp0\utility

REM =================================
:BatchGotAdmin
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    if '%1'=='UACdone' (shift & goto gotAdmin)
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~0", "UACdone", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

REM =================================
call :whereis wmic.exe WMIC
call :whereis winsat.exe WINSAT
call :whereis powershell.exe POWERSHELL

REM =================================
if not defined WMIC goto :MyDateEnd

set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%

:MyDateEnd

REM =================================
REM Log files
REM =================================

set LOG1=%temp%\%~n0-%COMPUTERNAME%-%TODAY%.txt
set LOG2=%temp%\systeminfo.txt
set LOG3=%temp%\dxdiag.txt
set LOG3CAB=%temp%\dxdiag-%COMPUTERNAME%.cab
set LOG4=%temp%\winsat.txt
set LOG5=%temp%\smart-%TODAY%.txt
set LOG6=%temp%\msinfo32.txt
set LOG6NFO=%temp%\msinfo32.nfo
set LOG6CAB=%temp%\msinfo32-%COMPUTERNAME%.cab
set TXT1=%temp%\%~n0.txt
set LINE=%temp%\%~n0-line.txt

REM =================================
REM Gathering System Report
REM =================================

if not exist %LOG2% systeminfo >%LOG2% 2>>&1
echo. >>%LOG2%

set UnderVM=
call :findtext %LOG2% "Virtual Machine" UnderVM
call :findtext %LOG2% "Virtual Platform" UnderVM

if not exist %LOG3% dxdiag /t %LOG3%
echo. >>%LOG3%

if exist %LOG4% goto :winsatend
if not defined WINSAT goto :winsatend
if defined UnderVM goto :winsatend

winsat features		 >%LOG4% 2>>&1
winsat cpu -compression	>>%LOG4% 2>>&1
winsat cpu -encryption	>>%LOG4% 2>>&1
winsat mem		>>%LOG4% 2>>&1
for %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if exist %%G:\nul (
    winsat disk -drive %%G			>>%LOG4% 2>>&1
    rem winsat disk -seq -read -drive %%G	>>%LOG4% 2>>&1
    winsat disk -ran -write -drive %%G		>>%LOG4% 2>>&1
  )
)
winsat dwm		>>%LOG4% 2>>&1
rem winsat dwm -normalw 8 -glassw 3 -time 6 -fullscreen >>%LOG4% 2>>&1
winsat d3d		>>%LOG4% 2>>&1

:winsatend
echo.  >>%LOG4%

for /l %%G in (0,1,11) do (
  echo ======================	>>%LOG5% 2>>&1
  echo smartctl -a /dev/pd%%G	>>%LOG5% 2>>&1
  echo ======================	>>%LOG5% 2>>&1
  smartctl -a /dev/pd%%G 	>>%LOG5% 2>>&1
)
echo.  >>%LOG5%

if not exist %LOG6NFO% msinfo32 /nfo %LOG6NFO%
if not exist %LOG6% msinfo32 /report %LOG6%

REM =================================
REM Generate Report
REM =================================
echo %DATE%%TIME% 							 >%LOG1%
findstr /B "Time of this report" %LOG3% 				>>%LOG1%

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo DISK								>>%LOG1%
echo =================================					>>%LOG1%
if defined POWERSHELL (
echo ---------------------------------					>>%LOG1%
Echo "Get-PhysicalDisk"							>>%LOG1%
powershell -command "if (Get-Command Get-PhysicalDisk -errorAction SilentlyContinue) {Get-PhysicalDisk | Format-Table -Auto}"	>>%LOG1%
powershell -command "if (Get-Command Get-PhysicalDisk -errorAction SilentlyContinue) {Get-PhysicalDisk | Format-List FriendlyName,OperationalStatus,HealthStatus,BusType,MediaType,Manufacturer,Model,Size,UniqueId}" 				>>%LOG1%
Echo "Get-VirtualDisk"							>>%LOG1%
powershell -command "if (Get-Command Get-VirtualDisk -errorAction SilentlyContinue) {Get-VirtualDisk | Format-Table -Auto}"	>>%LOG1%
Echo "Get-StoragePool"							>>%LOG1%
powershell -command "if (Get-Command Get-StoragePool -errorAction SilentlyContinue) {Get-StoragePool | Format-Table -Auto}"	>>%LOG1%
Echo "Get-Volume"							>>%LOG1%
powershell -command "if (Get-Command Get-Volume -errorAction SilentlyContinue) {Get-Volume | Format-Table -Auto}"		>>%LOG1%
)

echo ---------------------------------					>>%LOG1%
findstr /C:"overall-health" %LOG5%					>>%LOG1%
findstr /B "ID#" %LOG5%							>>%LOG1%
findstr "Reallocated_Sector_Ct" %LOG5%					>>%LOG1%
findstr "Reported_Uncorrect" %LOG5%					>>%LOG1%
findstr "Command_Timeout" %LOG5%					>>%LOG1%
findstr "Current_Pending_Sector" %LOG5%					>>%LOG1%
findstr "Offline_Uncorrectable" %LOG5%					>>%LOG1%
findstr "SSD_Life_Left" %LOG5%						>>%LOG1%
findstr "Power_On_Hours" %LOG5%						>>%LOG1%
findstr "Temperature_Celsius" %LOG5%					>>%LOG1%
findstr /C:"occurred at disk power-on lifetime" %LOG5%			>>%LOG1%

REM =================================
REM Check for Alarm Status
REM =================================

set ALARM=
findstr /C:"overall-health" %LOG5% > %LINE%
call :AWK %LINE% 6
if defined RET if [PASSED] neq [%RET%] set ALARM=1

findstr "Reallocated_Sector_Ct" %LOG5% > %LINE%
call :AWK %LINE% 10
if defined RET if [0] neq [%RET%] set ALARM=1

findstr "Reported_Uncorrect" %LOG5% > %LINE%
call :AWK %LINE% 10
if defined RET if [0] neq [%RET%] set ALARM=1

findstr "Command_Timeout" %LOG5% > %LINE%
call :AWK %LINE% 10
if defined RET if [0] neq [%RET%] set ALARM=1

findstr "Current_Pending_Sector" %LOG5% > %LINE%
call :AWK %LINE% 10
if defined RET if [0] neq [%RET%] set ALARM=1

findstr "Offline_Uncorrectable" %LOG5% > %LINE%
call :AWK %LINE% 10
if defined RET if [0] neq [%RET%] set ALARM=1

findstr "SSD_Life_Left" %LOG5% > %LINE%
call :AWK %LINE% 10
if defined RET if [0] neq [%RET%] set ALARM=1

del %LINE%

REM =================================
REM Send E-mail only if ALARM is set
REM =================================

copy %0 %TXT1%
if not exist %LOG3CAB% makecab %LOG3% %LOG3CAB%
if not exist %LOG6CAB% makecab %LOG6NFO% %LOG6CAB%

if defined ALARM (
sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %LOG2% %LOG3CAB% %LOG4% %LOG5% %LOG6CAB% %TXT1%
)

rem %LOG2% %LOG3% %LOG3CAB% %LOG4% %LOG6% %LOG6NFO% %LOG6CAB% 
del %LOG1% %LOG5% %TXT1%

goto :EOF

REM =================================
REM call :whereis <exe> <Location Variable>
REM call :whereis wmic.exe WMIC
REM =================================
:whereis
set %2=
for %%X in (%1) do (set %2=%%~$PATH:X)
exit /b

REM =================================
REM call :findtext <file> <string> <Found Boolean Variable>
REM call :findtext %LOG2% "Virtual Machine" UnderVM
REM =================================
:findtext
>nul find %2 %1 && (
  echo %2 was found.
  set %3=1
) || (
  echo %2 was NOT found.
)
exit /b

REM =================================
REM call :AWK <linefile> <location>
REM call :AWK temp.txt 10
REM =================================
:AWK
set RET=
FOR /F "tokens=%2 delims= " %%G IN (%1) DO (
    set RET=%%G
)
exit /b

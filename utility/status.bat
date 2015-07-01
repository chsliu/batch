REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat %0

REM =================================
set path=%path%;%~dp0\..\bin

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
set LOG7=%temp%\ipconfig.txt
set TXT1=%temp%\%~n0.txt

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

ipconfig /all >>%LOG7% 2>>&1

REM =================================
REM Generate Report
REM =================================
echo %DATE%%TIME% 							 >%LOG1%
findstr /B "Time of this report" %LOG3% 				>>%LOG1%

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo CPU								>>%LOG1%
echo =================================					>>%LOG1%
findstr /C:"          Processor" %LOG3% 				>>%LOG1%
echo ---------------------------------					>>%LOG1%
type %LOG6% | findstr /C:"邏輯處理器"					>>%LOG1%
type %LOG6% | findstr /C:"Logical Processor"				>>%LOG1%
echo ---------------------------------					>>%LOG1%
findstr "LZW" %LOG4%							>>%LOG1%
findstr "AES256" %LOG4%							>>%LOG1%

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo MB									>>%LOG1%
echo =================================					>>%LOG1%
if defined WMIC (
wmic BASEBOARD get Manufacturer,Product,SerialNumber,Version |more 	>>%LOG1% 2>>&1
)

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo NETWORK								>>%LOG1%
echo =================================					>>%LOG1%
findstr /C:"實體位址" %LOG7%						>>%LOG1%
findstr /C:"Physical Address" %LOG7%					>>%LOG1%
Echo "Get-NetAdapterPowerManagement"					>>%LOG1%
powershell -command "Get-NetAdapter | Get-NetAdapterPowerManagement"	>>%LOG1%

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo RAM								>>%LOG1%
echo =================================					>>%LOG1%
if defined WMIC (
wmic memorychip get BankLabel,Capacity,DataWidth,DeviceLocator,FormFactor,Manufacturer,PartNumber,SerialNumber,Speed,TotalWidth,TypeDetail |more >>%LOG1% 2>>&1
)
echo ---------------------------------					>>%LOG1%
findstr /C:"             Memory" %LOG3%					>>%LOG1%
findstr /C:"Available OS Memory" %LOG3%					>>%LOG1%
findstr /C:"Page File" %LOG3%						>>%LOG1%
echo ---------------------------------					>>%LOG1%
findstr /C:"記憶體" %LOG2%						>>%LOG1%
findstr "Memory" %LOG2%							>>%LOG1%
findstr /C:"分頁檔" %LOG2%						>>%LOG1%
findstr /C:"Page File" %LOG2%						>>%LOG1%
echo ---------------------------------					>>%LOG1%
findstr /C:"記憶體效能" %LOG4%						>>%LOG1%

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo GPU 2D								>>%LOG1%
echo =================================					>>%LOG1%
findstr /C:"Card name" %LOG3%						>>%LOG1%
findstr /C:"Display Memory" %LOG3%					>>%LOG1%
findstr /C:"Dedicated Memory" %LOG3%					>>%LOG1%
findstr /C:"Shared Memory" %LOG3%					>>%LOG1%
findstr /C:"Current Mode" %LOG3%					>>%LOG1%
findstr /C:"Monitor Model" %LOG3%					>>%LOG1%
findstr /C:"Native Mode" %LOG3%						>>%LOG1%
findstr /C:"Output Type" %LOG3%						>>%LOG1%
findstr /C:"Feature Levels" %LOG3%					>>%LOG1%
echo ---------------------------------					>>%LOG1%
type %LOG6% | findstr /C:"介面卡描述"					>>%LOG1%
type %LOG6% | findstr /C:"Adapter Description"				>>%LOG1%
echo ---------------------------------					>>%LOG1%
findstr /C:"視訊記憶體" %LOG4%						>>%LOG1%

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo GPU 3D								>>%LOG1%
echo =================================					>>%LOG1%
findstr /C:"> Direct3D" %LOG4%						>>%LOG1%

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo DISK								>>%LOG1%
echo =================================					>>%LOG1%
if not defined WMIC goto :disklog1end

wmic diskdrive get Model,Name,SerialNumber,Size,Status,StatusInfo |more >>%LOG1% 2>>&1
wmic logicaldisk get DeviceID,FileSystem,FreeSpace,MaximumComponentLength,MediaType,Size,VolumeSerialNumber |more >>%LOG1% 2>>&1

:disklog1end

if defined POWERSHELL (
echo ---------------------------------					>>%LOG1%
Echo "Get-Volume"							>>%LOG1%
powershell -command "if (Get-Command Get-Volume -errorAction SilentlyContinue) {Get-Volume | Format-Table -Auto}"		>>%LOG1%
Echo "Get-VirtualDisk"							>>%LOG1%
powershell -command "if (Get-Command Get-VirtualDisk -errorAction SilentlyContinue) {Get-VirtualDisk | Format-Table -Auto}"	>>%LOG1%
Echo "Get-StoragePool"							>>%LOG1%
powershell -command "if (Get-Command Get-StoragePool -errorAction SilentlyContinue) {Get-StoragePool | Format-Table -Auto}"	>>%LOG1%
Echo "Get-PhysicalDisk"							>>%LOG1%
powershell -command "if (Get-Command Get-PhysicalDisk -errorAction SilentlyContinue) {Get-PhysicalDisk | Format-Table -Auto}"	>>%LOG1%
powershell -command "if (Get-Command Get-PhysicalDisk -errorAction SilentlyContinue) {Get-PhysicalDisk | Format-List FriendlyName,OperationalStatus,HealthStatus,BusType,MediaType,Manufacturer,Model,Size,UniqueId}" 				>>%LOG1%
)

echo ---------------------------------					>>%LOG1%
findstr /C:"Device Model" %LOG5%					>>%LOG1%
findstr /C:"User Capacity" %LOG5%					>>%LOG1%
findstr /C:"Sector Sizes" %LOG5%					>>%LOG1%
findstr /C:"Rotation Rate" %LOG5%					>>%LOG1%
findstr /C:"Form Factor" %LOG5%						>>%LOG1%
findstr /C:"ATA Version" %LOG5%						>>%LOG1%
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
echo ---------------------------------					>>%LOG1%
findstr /C:"> Disk" %LOG4%						>>%LOG1%
findstr /C:"> 循序寫入" %LOG4%						>>%LOG1%
findstr /C:"> 延遲" %LOG4%						>>%LOG1%
findstr /C:"> 隨機寫入" %LOG4%						>>%LOG1%

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo OS									>>%LOG1%
echo =================================					>>%LOG1%
findstr /C:"Operating System" %LOG3%					>>%LOG1%
echo ---------------------------------					>>%LOG1%
findstr /C:"作業系統名稱" %LOG2% 					>>%LOG1%
findstr /C:"作業系統版本" %LOG2% 					>>%LOG1%
findstr /C:"OS Name" %LOG2% 						>>%LOG1%
findstr /B /C:"OS Version" %LOG2% 					>>%LOG1%
findstr /C:"註冊的擁有者" %LOG2% 					>>%LOG1%
findstr /C:"Registered Owner" %LOG2% 					>>%LOG1%

echo.									>>%LOG1%
echo =================================					>>%LOG1%
echo UPTIME								>>%LOG1%
echo =================================					>>%LOG1%
findstr /C:"日期" %LOG2%						>>%LOG1%
findstr /C:"時間" %LOG2%						>>%LOG1%
findstr "Date" %LOG2%							>>%LOG1%
findstr /C:"Boot Time" %LOG2%						>>%LOG1%

REM =================================
REM Send E-mail
REM =================================

copy %0 %TXT1% >nul
if not exist %LOG3CAB% makecab %LOG3% %LOG3CAB%
if not exist %LOG6CAB% makecab %LOG6NFO% %LOG6CAB%

sendemail -s msa.hinet.net -f egreta.su@msa.hinet.net -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %LOG2% %LOG3CAB% %LOG4% %LOG5% %LOG6CAB% %LOG7% %TXT1%

rem %LOG2% %LOG3% %LOG3CAB% %LOG4% %LOG6% %LOG6NFO% %LOG6CAB%
del %LOG1% %LOG5% %LOG7% %TXT1%

goto :EOF

REM =================================
:whereis
set %2=
for %%X in (%1) do (set %2=%%~$PATH:X)

REM =================================
:findtext
>nul find %2 %1 && (
  echo %2 was found.
  set %3=1
) || (
  echo %2 was NOT found.
)


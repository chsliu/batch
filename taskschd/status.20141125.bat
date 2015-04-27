set path=%path%;%~dp0\utility

REM =================================
set MyDate=
for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
set TODAY=%MyDate:~0,4%-%MyDate:~4,2%-%MyDate:~6,2%
set MONTH=%MyDate:~0,4%-%MyDate:~4,2%
REM =================================
REM Log
REM =================================

set LOG1=%temp%\%~n0-%TODAY%.txt
set LOG2=%temp%\gpu-%TODAY%.txt

echo %DATE%%TIME% 				>%LOG1%

REM =================================
REM PC Info
REM =================================

systeminfo					>>%LOG1% 2>>&1

wmic BASEBOARD get Manufacturer,Product,SerialNumber,Version |more >>%LOG1% 2>>&1

wmic memorychip get BankLabel,Capacity,DataWidth,DeviceLocator,FormFactor,Manufacturer,PartNumber,SerialNumber,Speed,TotalWidth,TypeDetail |more 		>>%LOG1% 2>>&1

dxdiag /t %LOG2%

REM =================================
REM Benchmark
REM =================================

winsat cpu -compression				>>%LOG1% 2>>&1

winsat mem					>>%LOG1% 2>>&1

winsat disk -drive C:				>>%LOG1% 2>>&1

winsat dwm					>>%LOG1% 2>>&1

winsat d3d					>>%LOG1% 2>>&1

REM =================================
REM Disk Status and Free Space
REM =================================

smartctl -H -A /dev/sda				>>%LOG1% 2>>&1

echo wmic diskdrive					   >>%LOG1% 2>>&1
wmic diskdrive get Model,Name,Size,Status,StatusInfo |more >>%LOG1% 2>>&1

wmic logicaldisk get DeviceID,FileSystem,FreeSpace,MaximumComponentLength,MediaType,Size,VolumeSerialNumber |more >>%LOG1% 2>>&1

dir C:\						>>%LOG1% 2>>&1

dir D:\						>>%LOG1% 2>>&1

REM =================================
REM Uptime
REM =================================

net stats work					>>%LOG1% 2>>&1

net stats srv					>>%LOG1% 2>>&1

REM =================================
REM Send E-mail
REM =================================

sendemail -s msa.hinet.net -f chsliu@gmail.com -t chsliu@gmail.com -u [LOG] %COMPUTERNAME% %~n0 -m %0 -a %LOG1% %LOG2%

del %LOG1% %LOG2%


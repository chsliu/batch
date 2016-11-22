@echo off

if [%1]==[] goto :usage
if [%2]==[] goto :usage


goto :main

:usage
echo %0 <drive> <swapsize(MB)>
goto :EOF


:main

DRV=%1
SIZEMB=%2

REM Get-Counter '\Paging File(*)\% Usage'

REM Get-Counter '\Paging File(*)\% Usage Peak'

REM WMIC /Output:os.html os Get * /Format:htable 

REM wmic os get * /Format:htable > os.html

REM wmic os get * /format:list

REM wmic os get TotalVisibleMemorySize

REM wmic memorychip get /VALUE |findstr "Capacity"

wmic pagefile list /format:list 

wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False

wmic pagefileset where name="%DRV%:\\pagefile.sys" set InitialSize=%SIZEMB%,MaximumSize=%SIZEMB%

wmic pagefile list /format:list 


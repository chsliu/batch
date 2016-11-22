@echo off

REM powershell -command "Get-Counter '\Paging File(*)\%% Usage'"

REM powershell -command "Get-Counter '\Paging File(*)\%% Usage Peak'"

wmic pagefile list /format:list 


REM wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False

REM wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=2048,MaximumSize=2048

REM wmic pagefile list /format:list 


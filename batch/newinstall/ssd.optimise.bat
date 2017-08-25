@echo off
REM =================================
if [%1]==[] %~dp0\..\utility\getadmin.bat "%~dp0\%~nx0"

REM =================================
echo === TRIM Enable check, DisableDeleteNotify = 0
fsutil behavior query DisableDeleteNotify

echo === Superfetch disable
sc config SysMain start= disabled
taskkill /F /FI "SERVICES eq SysMain"
taskkill /F /FI "SERVICES eq SysMain"
taskkill /F /FI "SERVICES eq SysMain"
rd /s/q c:\windows\prefetch

echo === Defragment disable
dfrgui

echo === Windows Search disable
sc config WSearch start= disabled
taskkill /F /FI "SERVICES eq WSearch"
taskkill /F /FI "SERVICES eq WSearch"
taskkill /F /FI "SERVICES eq WSearch"

echo === Heartbeat disable
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability]
echo "TimeStampInterval"=dword:00000000
regedit

echo === 停止 Windows 7 的客戶經驗改進計畫
echo 系統管理範本 - 系統 - 網際網絡通訊管理 - 網際網絡通訊設定
echo "關閉 Windows 客戶經驗改進計劃" 內勾選 "啟用"
gpedit.msc

echo === 停止 CEIP 自動排程
echo 工作排程器程式庫 - Microsoft - Windows - Customer Experience Improvement Program
echo Consolidator	diable
echo KernelCeipTask	diable
echo UsbCeip		diable
taskschd.msc

echo === 停止 RAC 自動排程每小時一次
echo 工作排程器程式庫 - Microsoft - Windows - RAC
echo RacTask 		diable
taskschd.msc

echo === 停止 ReadyBoot tracing
echo 資料搜集器集合工具 -- 啟動事件追蹤工具階段
echo ReadyBoot		diable
echo for HD optimise, defrag.exe c: -b 
perfmon
del c:\windows\prefetch\readyboot\readyboot.etl

REM echo === IPv6 disable
REM echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters]
REM echo "DisabledComponents"=dword:ffffffff
rem regedit

REM echo === IP-Helper disable
REM echo disable TCP/IPv4 in network property
REM sc config iphlpsvc start= disabled
REM taskkill /F /FI "SERVICES eq iphlpsvc"
REM taskkill /F /FI "SERVICES eq iphlpsvc"
REM taskkill /F /FI "SERVICES eq iphlpsvc"

echo === DisablePagingExecutive
echo for PC with 4GB RAM or more
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
echo "DisablePagingExecutive"=dword:00000001
regedit

echo === hiberfil.sys disable
echo for PC, not Notebook: 
echo run: powercfg -h off

echo === AHCI Enable check

echo === 4K alignment check

echo === pagefile.sys

echo === temp dir

echo === userprofile

pause

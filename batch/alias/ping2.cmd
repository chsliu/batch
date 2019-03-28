@echo off

chcp 65001

:loop

REM time /t
echo %time%
ping -n 1 %* | grep "TTL\|timed out"
sleep 1

goto loop

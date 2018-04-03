@echo off

chcp 65001

:loop

ping -n 1 %* | grep "TTL\|timed out"
sleep 10

goto loop
